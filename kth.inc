<?php
/*
Funktion som hämtar utbildningsprogram från KTH's api
*/
function getkthprograms() {
	global $kth_programs_api_Ocp_Apim_Subscription_Key, $kth_programs_api_url;
	$ch = curl_init();
	$url = $kth_programs_api_url;
	$queryParams = '';
	curl_setopt($ch, CURLOPT_URL, $url . $queryParams);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
	curl_setopt($ch, CURLOPT_HEADER, FALSE);
	curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'GET');
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
    $headers = [
        'Ocp-Apim-Subscription-Key:' . $kth_programs_api_Ocp_Apim_Subscription_Key
    ];
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
	$response = curl_exec($ch);
	if(curl_errno($ch)) {
        $error = '{"error" : "unknown"}';
        curl_close($ch);
		return $error;
	}
	curl_close($ch);
    return $response;
}

function getkthprogram($code) {
	global $kth_programs_api_Ocp_Apim_Subscription_Key, $kth_programs_api_url;
	$ch = curl_init();
	$url = $kth_programs_api_url . $code;
	$queryParams = '';
	curl_setopt($ch, CURLOPT_URL, $url . $queryParams);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
	curl_setopt($ch, CURLOPT_HEADER, FALSE);
	curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'GET');
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
    $headers = [
        'Ocp-Apim-Subscription-Key:' . $kth_programs_api_Ocp_Apim_Subscription_Key
    ];
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
	$response = curl_exec($ch);
	if(curl_errno($ch)) {
        $error = '{"error" : "unknown"}';
        curl_close($ch);
		return $error;
	}
	curl_close($ch);
    return json_decode($response);
}