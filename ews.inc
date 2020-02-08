<?php
//191003
//error_reporting(E_ALL);
//ini_set('display_errors', 'on');

//inkluderar hjälpklass för mailfunktioner
//require_once($_SERVER['DOCUMENT_ROOT'] . '/PHPMailer/PHPMailerAutoload.php');
require_once($_SERVER['DOCUMENT_ROOT'] . '/ews/vendor/autoload.php');

use \jamesiarmes\PhpEws\Client;
use \jamesiarmes\PhpEws\Request\CreateItemType;
use \jamesiarmes\PhpEws\Request\UpdateItemType;

use \jamesiarmes\PhpEws\ArrayType\NonEmptyArrayOfAllItemsType;
use \jamesiarmes\PhpEws\ArrayType\NonEmptyArrayOfAttendeesType;
use \jamesiarmes\PhpEws\ArrayType\NonEmptyArrayOfItemChangeDescriptionsType;

use \jamesiarmes\PhpEws\Enumeration\CalendarItemUpdateOperationType;
use \jamesiarmes\PhpEws\Enumeration\ConflictResolutionType;

use \jamesiarmes\PhpEws\Enumeration\BodyTypeType;
use \jamesiarmes\PhpEws\Enumeration\CalendarItemCreateOrDeleteOperationType;
use \jamesiarmes\PhpEws\Enumeration\ResponseClassType;
use \jamesiarmes\PhpEws\Enumeration\RoutingType;
use \jamesiarmes\PhpEws\Enumeration\UnindexedFieldURIType;

use \jamesiarmes\PhpEws\Type\ItemChangeType;
use \jamesiarmes\PhpEws\Type\ItemIdType;
use \jamesiarmes\PhpEws\Type\PathToUnindexedFieldType;
use \jamesiarmes\PhpEws\Type\SetItemFieldType;

use \jamesiarmes\PhpEws\Type\AttendeeType;
use \jamesiarmes\PhpEws\Type\BodyType;
use \jamesiarmes\PhpEws\Type\CalendarItemType;
use \jamesiarmes\PhpEws\Type\EmailAddressType;

use \jamesiarmes\PhpEws\Request\FindItemType;
use \jamesiarmes\PhpEws\Enumeration\ItemQueryTraversalType;
use \jamesiarmes\PhpEws\Type\ItemResponseShapeType;
use \jamesiarmes\PhpEws\Type\CalendarViewType;
use \jamesiarmes\PhpEws\Enumeration\DefaultShapeNamesType;
use \jamesiarmes\PhpEws\Type\DistinguishedFolderIdType;
use \jamesiarmes\PhpEws\Enumeration\DistinguishedFolderIdNameType;

use \jamesiarmes\PhpEws\Type\CancelCalendarItemType;
use \jamesiarmes\PhpEws\Enumeration\MessageDispositionType;

use \jamesiarmes\PhpEws\ArrayType\NonEmptyArrayOfBaseFolderIdsType;
use \jamesiarmes\PhpEws\Type\TargetFolderIdType;


function exchangeconnect() {
    global $ews_host, $ews_user, $ews_password;
    $version = Client::VERSION_2013;
    $client = new Client($host, $username, $password, $version);
}

function checkavailability($email, $start_date, $end_date, $client) {
    $timezone = 'W. Europe Standard Time';
    $start_date->add(new DateInterval('PT1S'));
    $client->setTimezone($timezone);
    $request = new FindItemType();
    $request->Traversal = ItemQueryTraversalType::SHALLOW;
    $request->ItemShape = new ItemResponseShapeType();
    $request->ItemShape->BaseShape = DefaultShapeNamesType::ALL_PROPERTIES;

    $request->CalendarView = new CalendarViewType();
    $request->CalendarView->StartDate = $start_date->format('c');
    $request->CalendarView->EndDate = $end_date->format('c');
    $folder_id = new DistinguishedFolderIdType();
    $folder_id->Id = DistinguishedFolderIdNameType::CALENDAR;
    $folder_id->Mailbox = new EmailAddressType();
    $folder_id->Mailbox->EmailAddress = $email;
    $request->ParentFolderIds->DistinguishedFolderId[] = $folder_id;
    $response = $client->FindItem($request);
    $response_messages = $response->ResponseMessages->FindItemResponseMessage;
    foreach ($response_messages as $response_message) {
        if ($response_message->ResponseClass != ResponseClassType::SUCCESS) {
            $code = $response_message->ResponseCode;
            $message = $response_message->MessageText;
            return "Failed to search for events with \"$code: $message\"";
        }
        $items = $response_message->RootFolder->Items->CalendarItem;
        if (count($items)>0) {
            $available = false;
            foreach ($items as $item) { 
                if (strpos($item->Start,"00:00:00")){
                    $available = true;
                } else {
                    $available = false;
                    break;
                }
            }
            return $available;
            //echo $available;
        } else {
            return true;
        }
    }
}

function getChangeKey($email, $start_date, $end_date, $event_id, $client) {
    $timezone = 'W. Europe Standard Time';
    $start_date->add(new DateInterval('PT1S'));
    $client->setTimezone($timezone);
    $request = new FindItemType();
    $request->Traversal = ItemQueryTraversalType::SHALLOW;
    $request->ItemShape = new ItemResponseShapeType();
    $request->ItemShape->BaseShape = DefaultShapeNamesType::ALL_PROPERTIES;

    $request->CalendarView = new CalendarViewType();
    $request->CalendarView->StartDate = $start_date->format('c');
    $request->CalendarView->EndDate = $end_date->format('c');
    $folder_id = new DistinguishedFolderIdType();
    $folder_id->Id = DistinguishedFolderIdNameType::CALENDAR;
    $folder_id->Mailbox = new EmailAddressType();
    $folder_id->Mailbox->EmailAddress = $email;
    $request->ParentFolderIds->DistinguishedFolderId[] = $folder_id;
    $response = $client->FindItem($request);
    $events_result = array();
    $response_messages = $response->ResponseMessages->FindItemResponseMessage;
    foreach ($response_messages as $response_message) {
        if ($response_message->ResponseClass != ResponseClassType::SUCCESS) {
            $code = $response_message->ResponseCode;
            $message = $response_message->MessageText;
            return "";
        }
        $items = $response_message->RootFolder->Items->CalendarItem;
        foreach ($items as $item) {
            $id = $item->ItemId->Id;
            if($id==$event_id) {
                $events_result = $item->ItemId->ChangeKey;
            } else {
                $events_result = "";
            }
        }
    }
    return $events_result;
}

function cancelappointment($email_calendar, $event_id, $change_key, $start_date, $end_date, $host, $username, $password) {
    
    $version = Client::VERSION_2013;
    $client = new Client($host, $username, $password, $version);

    $change_key = getChangeKey($email_calendar, $start_date, $end_date, $event_id, $client);
    $result = array();

    if ($change_key != "") {
        $request = new CreateItemType();
        $request->MessageDisposition = MessageDispositionType::SEND_AND_SAVE_COPY;
        $request->Items = new NonEmptyArrayOfAllItemsType();

        $cancellation = new CancelCalendarItemType();
        $cancellation->ReferenceItemId = new ItemIdType();
        $cancellation->ReferenceItemId->Id = $event_id;
        $cancellation->ReferenceItemId->ChangeKey = $change_key;
        $request->Items->CancelCalendarItem[] = $cancellation;

        $response = $client->CreateItem($request);
        $response_messages = $response->ResponseMessages->CreateItemResponseMessage;
        foreach ($response_messages as $response_message) {
            if ($response_message->ResponseClass != ResponseClassType::SUCCESS) {
                $code = $response_message->ResponseCode;
                $message = $response_message->MessageText;
                $result['status'] = 'Error';
                $result['message'] = $message;
            } else {
                $result['status'] = 'OK';
                $result['message'] = 'Event Cancelled';
            }
        }
    }
    else {
        $result['status'] = 'Error';
        $result['message'] = 'Kunde inte avboka!';
    }
    error_log(json_encode($result));
    return $result;    
}

function updateappointment($id, $subject, $start, $end, $host, $username, $password) {
    
    $version = Client::VERSION_2013;
    $client = new Client($host, $username, $password, $version);

    $result = array();
    $event_updates = array(
        array(
            'id' => $id,
            'start' => $start,
            'end' => $end,
            'subject' => 'Handledning ' . $subject,
        )
    );
    $request = new UpdateItemType();
    $request->ConflictResolution = ConflictResolutionType::ALWAYS_OVERWRITE;
    $request->SendMeetingInvitationsOrCancellations = CalendarItemUpdateOperationType::SEND_TO_ALL_AND_SAVE_COPY;
    
    foreach ($event_updates as $update) {
        $change = new ItemChangeType();
        $change->ItemId = new ItemIdType();
        $change->ItemId->Id = $update['id'];
        $change->Updates = new NonEmptyArrayOfItemChangeDescriptionsType();
   
        $field = new SetItemFieldType();
        $field->FieldURI = new PathToUnindexedFieldType();
        $field->FieldURI->FieldURI = UnindexedFieldURIType::CALENDAR_START;
        $field->CalendarItem = new CalendarItemType();
        $field->CalendarItem->Start = $update['start']->format('c');
        $change->Updates->SetItemField[] = $field;

        $field = new SetItemFieldType();
        $field->FieldURI = new PathToUnindexedFieldType();
        $field->FieldURI->FieldURI = UnindexedFieldURIType::CALENDAR_END;
        $field->CalendarItem = new CalendarItemType();
        $field->CalendarItem->End = $update['end']->format('c');
        $change->Updates->SetItemField[] = $field;

        $field = new SetItemFieldType();
        $field->FieldURI = new PathToUnindexedFieldType();
        $field->FieldURI->FieldURI = UnindexedFieldURIType::ITEM_SUBJECT;
        $field->CalendarItem = new CalendarItemType();
        $field->CalendarItem->Subject = $update['subject'];
        $change->Updates->SetItemField[] = $field;

        $request->ItemChanges[] = $change;
    }
    
    $response = $client->UpdateItem($request);

    $response_messages = $response->ResponseMessages->UpdateItemResponseMessage;
    foreach ($response_messages as $response_message) {
        if ($response_message->ResponseClass != ResponseClassType::SUCCESS) {
            $code = $response_message->ResponseCode;
            $message = $response_message->MessageText;
            $result['status'] = 'Error';
            $result['message'] = $message;
        } else {
            foreach ($response_message->Items->CalendarItem as $item) {
                $id = $item->ItemId->Id;
                $result['status'] = 'OK';
                $result['message'] = 'Event Updated';
                $result['event_id'] = $id;
            }
        }
    }
    return $result;  
}

function createappointment($email_calendar, $email_calendar_name, $email_booker, $email_booker_name, $start, $end, $host, $username, $password) {
    
    $version = Client::VERSION_2013;
    $client = new Client($host, $username, $password, $version);

    $result = array();
    $attendees = array(
        array(
            'name' => $email_booker_name,
            'email' => $email_booker
        )
    );
    $roomavailability = true;

    if($roomavailability) {
        $request = new CreateItemType();
        $request->SendMeetingInvitations = CalendarItemCreateOrDeleteOperationType::SEND_ONLY_TO_ALL;
        $request->Items = new NonEmptyArrayOfAllItemsType();

        $event = new CalendarItemType();
        $event->RequiredAttendees = new NonEmptyArrayOfAttendeesType();
        $event->Start = $start->format('c');
        $event->End = $end->format('c');
        $event->Subject = 'Handledning ledig';
        $event->Location = $email_room_name;

        $event->Body = new BodyType();
        $event->Body->_ = '';
        $event->Body->BodyType = BodyTypeType::TEXT;

        foreach ($attendees as $guest) {
            $attendee = new AttendeeType();
            $attendee->Mailbox = new EmailAddressType();
            $attendee->Mailbox->EmailAddress = $guest['email'];
            $attendee->Mailbox->Name = $guest['name'];
            $attendee->Mailbox->RoutingType = RoutingType::SMTP;
            $event->RequiredAttendees->Attendee[] = $attendee;
        }

        $request->Items->CalendarItem[] = $event;

        //Skapa i annan kalender(som inloggad har tillgång till)
        $request->SavedItemFolderId = new TargetFolderIdType();
        $request->SavedItemFolderId->DistinguishedFolderId = new DistinguishedFolderIdType();
        $request->SavedItemFolderId->DistinguishedFolderId->Id=DistinguishedFolderIdNameType::CALENDAR;
        $request->SavedItemFolderId->DistinguishedFolderId->Mailbox = new stdClass();
        $request->SavedItemFolderId->DistinguishedFolderId->Mailbox->EmailAddress = $email_calendar;

        $response = $client->CreateItem($request);
        $response_messages = $response->ResponseMessages->CreateItemResponseMessage;
        foreach ($response_messages as $response_message) {
            if ($response_message->ResponseClass != ResponseClassType::SUCCESS) {
                $code = $response_message->ResponseCode;
                $message = $response_message->MessageText;
                $result['status'] = 'Error';
                $result['message'] = $message;
                return $result;
            }

            foreach ($response_message->Items->CalendarItem as $item) {
                $id = $item->ItemId->Id;
                $result['status'] = 'OK';
                $result['message'] = 'Event created in ' . $email_calendar. ". Location: " . $email_room . ". Attendee: " . $email_booker;
                $result['event_id'] = $id;
                $result['change_key'] = $item->ItemId->ChangeKey;
            }
        }
        return $result;
    } else {
        $result['status'] = 'Error';
        $result['message'] = 'Room not available';
        return $result;
    }


    /*
    $mail = new PHPMailer;
    $mail->isSMTP();
    $mail->Host ='smtp.kth.se';
    $mail->SMTPAuth   = FALSE;
    $mail->SMTPSecure = "tls";
    $mail->CharSet = 'UTF-8';

    // event params
    $event_id = 1234;
    $sequence = 0;
    $status = 'TENTATIVE';

    $summary = 'Summary';
    $venue = 'KTHB ';
    $start = '20191008';
    $start_time = '170000';
    $end = '20191008';
    $end_time = '180000';

    //PHPMailer
    $mail->IsHTML(false);
    $mail->setFrom('tholind@kth.se', 'Thomas Lind');
    $mail->addReplyTo('tholind@kth.se', 'Thomas Lind');
    $mail->addAddress('tholind@kth.se','T L');
    $mail->ContentType = 'text/calendar';

    $mail->Subject = "Outlooked Event";
    $mail->addCustomHeader('MIME-version',"1.0");
    $mail->addCustomHeader('Content-type',"text/calendar; method=REQUEST; charset=UTF-8");
    $mail->addCustomHeader('Content-Transfer-Encoding',"7bit");
    $mail->addCustomHeader('X-Mailer',"Microsoft Office Outlook 12.0");
    $mail->addCustomHeader("Content-class: urn:content-classes:calendarmessage");

    $ical = "BEGIN:VCALENDAR\r\n";
    $ical .= "VERSION:2.0\r\n";
    $ical .= "PRODID:-KTHB\r\n";
    $ical .= "METHOD:REQUEST\r\n";
    $ical .= "BEGIN:VEVENT\r\n";
    $ical .= "ORGANIZER;SENT-BY=\"MAILTO:tholind@kth.se\":MAILTO:tholind@kth.se\r\n";
    $ical .= "ATTENDEE;CN=tholind@kth.se;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE:mailto:tholind@kth.se\r\n";
    $ical .= "ATTENDEE;CN=uf_kthb_geisendorf@ug.kth.se;ROLE=REQ-PARTICIPANT;PARTSTAT=ACCEPTED;RSVP=TRUE:uf_kthb_geisendorf@ug.kth.se\r\n";
    $ical .= "UID:".strtoupper(md5($event_id))."-lib.kth.se\r\n";
    $ical .= "SEQUENCE:".$sequence."\r\n";
    $ical .= "STATUS:".$status."\r\n";
    $ical .= "DTSTAMPTZID=Europe/Stockholm:".date('Ymd').'T'.date('His')."\r\n";
    $ical .= "DTSTART:".$start."T".$start_time."\r\n";
    $ical .= "DTEND:".$end."T".$end_time."\r\n";
    $ical .= "LOCATION:".$venue."\r\n";
    $ical .= "SUMMARY:".$summary."\r\n";
    $ical .= "DESCRIPTION:"."TEST!"."\r\n";
    $ical .= "BEGIN:VALARM\r\n";
    $ical .= "TRIGGER:-PT15M\r\n";
    $ical .= "ACTION:DISPLAY\r\n";
    $ical .= "DESCRIPTION:Reminder\r\n";
    $ical .= "END:VALARM\r\n";
    $ical .= "END:VEVENT\r\n";
    $ical .= "END:VCALENDAR\r\n";

    $mail->Body = $ical;

    if($mail->Send()){
        echo 'Success';
    }else{
        echo $mail->ErrorInfo;
    }
    */
}