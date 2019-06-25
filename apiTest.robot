*** Settings ***
Library           RequestsLibrary
Library           json
Library           Collections    
Library           ImapLibrary
Resource          locationScripts.robot  
Library           DateTime
*** Variable ***
${Base_URL}       https://10.0.5.144/
${locationURL}    https://services.trackme.com.ph/apis/


*** Test Cases ***
Auxiliary
    #time declaration
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    ${time2} =	Convert Date    ${myTime}   
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   


    #Payload 
    create session    AddData    ${locationURL}
    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 6
    \    ${time}=   Add Time to Date	 ${time}	    1 minute	exclude_millis=yes
    \    log to console   ${time}
    \    ${auxPower}     create dictionary   gps_update    [{"alerts": ["LOCATION","AUXILIARY POWER"],"date_stamp": "${time}","driver": "","latitude": 14.637887187864,"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": 121.04112580417495,"direction": 0}]
    \    ${mainPower}    create dictionary   gps_update    [{"alerts": ["LOCATION","MAIN POWER"],"date_stamp": "${time}","driver": "","latitude": 14.637887187864,"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": 121.04112580417495,"direction": 0}]
    \    ${response}  post request   AddData     LocationUpdate?api_key=123    data=${auxPower}    headers=${header}   
    \    ${response2}  post request   AddData     LocationUpdate?api_key=123    data=${mainPower}    headers=${header}   

    log   ${response}
    log   ${response2}  
    Log    Exited  
   # Should Be Equal As Strings      ${response.status_code}     200

Hotspot
    #${lat}      14.814554581949
    #${long}     121.05809211731003
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    ${time2} =	Convert Date    ${myTime}   
    create session    AddData    ${locationURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

        ${time}=   Subtract Time from Date	 ${time}	    5 minute	exclude_millis=yes
        ${time1}=   Subtract Time from Date	 ${time}	    5 minute	exclude_millis=yes
        ${time2}=   Subtract Time from Date	 ${time1}	    5 minute	exclude_millis=yes
        ${time3}=   Subtract Time from Date	 ${time2}	    5 minute	exclude_millis=yes
        ${moveVehicleToTerminal}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${terminalLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": ${terminalLong},"direction": 0}] 
        ${moveVehicleToGarage}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${garageLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": ${garageLong},"direction": 0}]
        ${moveVehicleToHotspot}     create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time1}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": ${hotspotLong},"direction": 0}]
        ${moveVehicleToTerminal1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time}","driver": "","latitude": ${terminalLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": ${terminalLong},"direction": 0}]   
        ${response}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal}    headers=${header} 
        ${response1}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToGarage}      headers=${header} 
        ${response2}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToHotspot}     headers=${header} 
        ${response3}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal1}   headers=${header} 
 
    log    ${moveVehicleToTerminal}
    log    ${moveVehicleToGarage} 
    log    ${moveVehicleToHotspot} 
    log    ${moveVehicleToTerminal1} 

Emergency
    #${lat}      14.814554581949
    #${long}     121.05809211731003
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    ${time2} =	Convert Date    ${myTime}   
    create session    AddData    ${locationURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

        ${time}=   Subtract Time from Date	 ${time}	    5 minute	exclude_millis=yes     
        ${moveVehicleToTerminal1}    create dictionary   gps_update    [{"alerts": ["LOCATION","EMERGENCY"],"date_stamp": "${time}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${emergency}","speed": 0,"longitude": ${hotspotLong},"direction": 0}]   
        ${response3}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal1}   headers=${header}   
    


#Emergency--> Hotspot (Emergency)
#Auxiliary--> Hotspot (Auxiliary)
#Hotspot --> Terminal-->Dropoff-->
*** Keywords ***
