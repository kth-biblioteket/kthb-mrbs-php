<?php
//191003
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
                break;
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
    if($environment == 'development') {
        error_log(json_encode($result));
    }
    return $result;    
}

function updateappointment($id, $subject, $email_attendee, $email_attendee_name, $location, $start, $end, $host, $username, $password) {
    
    global $environment;

    $version = Client::VERSION_2013;
    $client = new Client($host, $username, $password, $version);

    $result = array();
    $event_updates = array(
        array(
            'id' => $id,
            'start' => $start,
            'end' => $end,
            'subject' => $subject,
            'location' => $location
        )
    );
    $attendees = array(
        array(
            'name' => $email_attendee_name,
            'email' => $email_attendee
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

        $field = new SetItemFieldType();
        $field->FieldURI = new PathToUnindexedFieldType();
        $field->FieldURI->FieldURI = UnindexedFieldURIType::CALENDAR_LOCATION;
        $field->CalendarItem = new CalendarItemType();
        $field->CalendarItem->Location = $update['location'];
        $change->Updates->SetItemField[] = $field;

        
        //update attendees
        $ra = 0;
        $field = new SetItemFieldType();
        $field->FieldURI = new PathToUnindexedFieldType();
        $field->FieldURI->FieldURI = UnindexedFieldURIType::CALENDAR_REQUIRED_ATTENDEES;

        foreach ($attendees as $guest) {
            $field->CalendarItem->RequiredAttendees->Attendee[$ra]->Mailbox->EmailAddress = $guest['email'];
            $field->CalendarItem->RequiredAttendees->Attendee[$ra]->Mailbox->Name = $guest['name'];
            $field->CalendarItem->RequiredAttendees->Attendee[$ra]->Mailbox->RoutingType = RoutingType::SMTP;
            $ra++;
        }
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
                $result['change_key'] = $item->ItemId->ChangeKey;
            }
        }
    }
    return $result;  
}

/**
 * 
 * Funktion som skapar händelse i outlook-kalender
 * Parametrar
 * email_calendar: kalender att boka i
 * subject
 * email_attandee, handledarens email
 * email_attendee_name, handledarens namn
 */
function createappointment($email_calendar, $email_calendar_name, $subject, $email_attendee, $email_attendee_name, $start, $end, $host, $username, $password) {
    
    $version = Client::VERSION_2013;
    $client = new Client($host, $username, $password, $version);

    $result = array();
    $attendees = array(
        array(
            'name' => $email_attendee_name,
            'email' => $email_attendee
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
        $event->Subject = $subject;
        $event->Location = '';

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

        //Skapa i annan kalender(som systemkonto har tillgång till)
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
}