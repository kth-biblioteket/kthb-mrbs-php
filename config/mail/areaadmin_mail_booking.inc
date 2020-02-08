<?php
$html_body['content'] = '
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title></title>
    <style type="text/css">
        body#mrbs {
            background-color: #e7ebee;
            color: #0B263B;
            font-family: "Arial, Verdana, sans-serif";
            margin: 0;
            padding: 0
        }

        div#header {
            width: 100%;
            background-color: #4b667b;
            color: #ffffff;
            margin: 0;
            padding: 10px
        }

        div#contents {
            width: 100%;
            padding: 10px;
            margin-bottom: 1em
        }

        #mrbs a:link {
            color: #0B263B;
            text-decoration: none;
            font-weight: bold
        }

        #mrbs a:visited {
            color: #0B263B;
            text-decoration: none;
            font-weight: bold
        }

        #mrbs a:hover {
            color: #ff0066;
            text-decoration: underline;
            font-weight: bold
        }

        #mrbs tr {
            padding: 0;
            margin: 0
        }

        #mrbs th,
        #mrbs td {
            text-align: left;
            padding: 1px 1em;
            margin 0
        }
    </style>
</head>

<body id="mrbs">
    <div id="contents">
        <p>New booking</p>
        <p>Länk till bokningen: <a style="padding: 15px 25px; border-radius: 30px; border: 1px solid #B0C92B; border-image: none; color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-weight: bold;font-size: 16px; text-decoration: none; display: inline-block;" href="https://' . dirname($_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF']) . '/edit_entry.php?id=' . $data["id"] . '&lang=sv">' . 'Gå till din bokning' . '</a></p>
        <table>
            <tbody>
                <tr>
                    <td>@@name: </td>
                    <td>' . $data['name'] . '</td>
                </tr>
                <tr>
                    <td>Resource: </td>
                    <td>Handledning</td>
                </tr>
                <tr>
                    <td>Bokning: </td>
                    <td>' . date("H:i",$data['start_time']) . ' till ' . date("H:i",$data['end_time']) . ', ' . date("l d F",$data['start_time']) . '</td>
                </tr>
                <tr>
                    <td>Type: </td>
                    <td>' . get_type_vocab($data['type']) . '</td>
                </tr>
                <tr>
                    <td>Created by: </td>
                    <td>' . get_type_vocab($data['create_by']) . '</td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
'
;