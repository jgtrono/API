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
${testURL}        http://apps.webcast-inc.com.ph/demo/ngt_api/1.0/

*** Test Cases ***
Auxiliary
    #time declaration
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    ${time2} =	Convert Date    ${myTime}   
    ${timeCheck} =  Subtract Time from Date	 ${time}	    5 minute	exclude_millis=yes  

    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

    ${timeCheck} =  Subtract Time from Date	 ${time}	    5 minute	exclude_millis=yes  
    ${seconds}=    set Variable    ${0}
    #Payload 
    create session    AddData    ${locationURL}
    :FOR    ${i}    IN RANGE    999999
    #dapat even number ung ==6 
    \    Exit For Loop If    ${i} == 6
    #\    ${time}=   Add Time to Date	 ${timeCheck}	    30 seconds	exclude_millis=yes
    \    ${seconds}=     Evaluate    ${seconds}+30
    \    ${seconds2}=    Evaluate    ${seconds}+5   

    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} seconds	exclude_millis=yes
    \    ${hi2}=   Add Time to Date	 ${timeCheck}	    ${seconds2} seconds	exclude_millis=yes

    \    log to console   ${time}
    \    ${auxPower}     create dictionary   gps_update    [{"alerts": ["LOCATION","AUXILIARY POWER"],"date_stamp": "${hi}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile1}","speed": 0,"longitude": ${hotspotLong},"direction": 0}]
    \    ${mainPower}    create dictionary   gps_update    [{"alerts": ["LOCATION","MAIN POWER"],"date_stamp": "${hi2}","driver": "","latitude": ${garageLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile1}","speed": 0,"longitude": ${garageLong},"direction": 0}]
    \    ${response}  post request   AddData     LocationUpdate?api_key=123    data=${auxPower}    headers=${header}   
    \    ${response2}  post request   AddData     LocationUpdate?api_key=123    data=${mainPower}    headers=${header}   

    log     ${myTime}
    Log    Exited  
    
   # Should Be Equal As Strings      ${response.status_code}     200
EmergencyBulk
    #time declaration
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    ${time2} =	Convert Date    ${myTime}   
    ${timeCheck} =  Subtract Time from Date	 ${time}	    5 minute	exclude_millis=yes  

    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

    ${timeCheck} =  Subtract Time from Date	 ${time}	    5 minute	exclude_millis=yes  
    ${seconds}=    set Variable    ${0}
    #Payload 
    create session    AddData    ${locationURL}
    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 6
    #\    ${time}=   Add Time to Date	 ${timeCheck}	    30 seconds	exclude_millis=yes
    \    ${seconds}=     Evaluate    ${seconds}+5
    \    ${seconds2}=    Evaluate    ${seconds}+5   
    \    ${seconds3}=    Evaluate    ${seconds}+5   


    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} seconds	exclude_millis=yes
    \    ${hi2}=   Add Time to Date	 ${timeCheck}	    ${seconds2} seconds	exclude_millis=yes
    \    ${hi3}=   Add Time to Date	 ${timeCheck}	    ${seconds3} seconds	exclude_millis=yes


    \    log to console   ${time}
    \    ${emer1}     create dictionary   gps_update    [{"alerts": ["LOCATION","EMERGENCY"],"date_stamp": "${hi}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile1}","speed": 0,"longitude": ${hotspotLong},"direction": 0}]
    \    ${emer2}    create dictionary   gps_update    [{"alerts": ["LOCATION","EMERGENCY"],"date_stamp": "${hi2}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile1}","speed": 0,"longitude": ${hotspotLong},"direction": 0}]
    \    ${emer3}     create dictionary   gps_update    [{"alerts": ["LOCATION","EMERGENCY"],"date_stamp": "${hi3}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile1}","speed": 0,"longitude": ${hotspotLong},"direction": 0}]

    \    ${response}  post request   AddData     LocationUpdate?api_key=123    data=${emer1}    headers=${header}   
    \    ${response2}  post request   AddData     LocationUpdate?api_key=123    data=${emer2}    headers=${header}   
    \    ${response3}  post request   AddData     LocationUpdate?api_key=123    data=${emer3}    headers=${header}   


    log     ${myTime}
    Log    Exited  
    log     ${response}
    log     ${response2}
    log     ${response3}

    
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
        ${testingtesting}=  Set Variable    ${testVechile1}
        ${moveVehicleToTerminal}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${terminalLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${terminalLong},"direction": 0}] 
        ${moveVehicleToGarage}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${garageLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${garageLong},"direction": 0}]
        ${moveVehicleToHotspot}     create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time1}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${hotspotLong},"direction": 0}]
        ${moveVehicleToTerminal1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time}","driver": "","latitude": ${terminalLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${terminalLong},"direction": 0}]   
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

timeCheck
        ${myTime}=  Get Current Date    exclude_millis=yes
        ${time} =	Convert Date    ${myTime}   
        ${timeCheck} =  Subtract Time from Date	 ${time}	    5 minute	exclude_millis=yes  
        ${seconds}=    set Variable    ${0}
        :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 6
    \    ${seconds}=     Evaluate    ${seconds}+10
    \    ${seconds2}=    Evaluate    ${seconds}+1   

    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} seconds	exclude_millis=yes
    \    ${hi2}=   Add Time to Date	 ${timeCheck}	    ${seconds2} seconds	exclude_millis=yes

    \    log to console     ${hi}   



    Log    Exited  
RSN4
    #${lat}      14.814554581949
    #${long}     121.05809211731003
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    create session    AddData    ${locationURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

        #first compute number location * number of ibabato    
        ${time3}=   Subtract Time from Date	     ${time}	    10 minute	exclude_millis=yes
        ${time2}=   Add Time to Date	    ${time3}	    5 minute	exclude_millis=yes
        ${time4}=   Add Time to Date	    ${time2}	    5 minute	exclude_millis=yes
        

        #${time1}=   Add Time to Date	     ${time2}	    5 minute	exclude_millis=yes
        ${moveVehicleToTerminal}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${salandraLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile2}","speed": 0,"longitude": ${salandraLong},"direction": 0}] 
        ${moveVehicleToTerminal1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile2}","speed": 0,"longitude": ${hotspotLong},"direction": 0}] 

        #${movetoOthers}             create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${garageLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": ${garageLong},"direction": 0}]
        ${moveVehicleToGarage}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${unionStarLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile2}","speed": 0,"longitude": ${unionStarLong},"direction": 0}]
        
        ${response}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal}    headers=${header} 
        ${respons2}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal1}    headers=${header} 
        ${response3}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToGarage}      headers=${header}
 

     


        
        #${response2}  post request   AddData     LocationUpdate?api_key=123    data=${movetoOthers}      headers=${header} 

    log    ${moveVehicleToTerminal}
    log    ${moveVehicleToTerminal1}
    log    ${moveVehicleToGarage} 
  

RSN1
    # 525182) - Salandra Area to (525179 ) - Unionstar Corporation
    #${lat}      14.814554581949
    #${long}     121.05809211731003
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    create session    AddData    ${locationURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   
    ${testingtesting}=  Set Variable    ${testVechile2}


        #first compute number location * number of ibabato    
        ${time3}=   Subtract Time from Date	     ${time}	    10 minute	exclude_millis=yes
        ${time2}=   Add Time to Date	    ${time3}	    5 minute	exclude_millis=yes
        ${time4}=   Add Time to Date	    ${time2}	    5 minute	exclude_millis=yes

        #${time1}=   Add Time to Date	     ${time2}	    5 minute	exclude_millis=yes
        ${moveVehicleToTerminal}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${riverQuarryLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile1}","speed": 0,"longitude": ${riverQuarryLong},"direction": 0}] 
        ${moveVehicleToTerminal1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${riverQuarryLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile2}","speed": 0,"longitude": ${riverQuarryLong},"direction": 0}] 
        ${moveVehicleToTerminal2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${riverQuarryLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile3}","speed": 0,"longitude": ${riverQuarryLong},"direction": 0}] 

        ${moveVehicleToOther}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile1}","speed": 0,"longitude": ${hotspotLong},"direction": 0}] 
        ${moveVehicleToOther1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile2}","speed": 0,"longitude": ${hotspotLong},"direction": 0}] 
        ${moveVehicleToOther2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile3}","speed": 0,"longitude": ${hotspotLong},"direction": 0}] 


        ${moveVehicleToGarage}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${unionStarLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile1}","speed": 0,"longitude": ${unionStarLong},"direction": 0}]
        ${moveVehicleToGarage1}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${unionStarLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile2}","speed": 0,"longitude": ${unionStarLong},"direction": 0}]
        ${moveVehicleToGarage2}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${unionStarLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile3}","speed": 0,"longitude": ${unionStarLong},"direction": 0}]

        

        ${response}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal}    headers=${header} 
        ${response1}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToOther}      headers=${header} 
        ${response2}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToGarage}      headers=${header} 

        ${respons3}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal1}    headers=${header} 
        ${response4}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToOther1}      headers=${header} 
        ${response5}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToGarage1}      headers=${header}

        ${respons6}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal2}    headers=${header} 
        ${respons7}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToOther2}    headers=${header} 
        ${response8}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToGarage2}      headers=${header} 

     


        
        #${response2}  post request   AddData     LocationUpdate?api_key=123    data=${movetoOthers}      headers=${header} 

    log    ${moveVehicleToTerminal}
    log    ${moveVehicleToOther} 
    log    ${moveVehicleToGarage} 

    log    ${moveVehicleToTerminal1}
    log    ${moveVehicleToOther1} 
    log    ${moveVehicleToGarage1} 
   
    log    ${moveVehicleToTerminal2}
    log    ${moveVehicleToOther2} 
    log    ${moveVehicleToGarage2} 
RSN2
    #river to salandra 
    #${lat}      14.814554581949
    #${long}     121.05809211731003
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    create session    AddData    ${locationURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

        #first compute number location * number of ibabato 

        ${time3}=   Subtract Time from Date	     ${time}	    10 minute	exclude_millis=yes
        ${time2}=   Add Time to Date	    ${time3}	    5 minute	exclude_millis=yes
        ${time4}=   Add Time to Date	    ${time2}	    5 minute	exclude_millis=yes

        #${time1}=   Add Time to Date	     ${time2}	    5 minute	exclude_millis=yes
        ${moveVehicleToTerminal}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${riverQuarryLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile4}","speed": 0,"longitude": ${riverQuarryLong},"direction": 0}] 
        ${moveVehicleToTerminal1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${riverQuarryLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile5}","speed": 0,"longitude": ${riverQuarryLong},"direction": 0}] 
        ${moveVehicleToTerminal2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${riverQuarryLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile6}","speed": 0,"longitude": ${riverQuarryLong},"direction": 0}] 

        ${moveVehicleToOther}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile4}","speed": 0,"longitude": ${hotspotLong},"direction": 0}] 
        ${moveVehicleToOther1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile5}","speed": 0,"longitude": ${hotspotLong},"direction": 0}] 
        ${moveVehicleToOther2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile6}","speed": 0,"longitude": ${hotspotLong},"direction": 0}] 

        
        #${movetoOthers}             create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${garageLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": ${garageLong},"direction": 0}]
        ${moveVehicleToGarage}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${unionStarLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile4}","speed": 0,"longitude": ${unionStarLong},"direction": 0}]
        ${moveVehicleToGarage1}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${unionStarLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile5}","speed": 0,"longitude": ${unionStarLong},"direction": 0}]
        ${moveVehicleToGarage2}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${unionStarLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile6}","speed": 0,"longitude": ${unionStarLong},"direction": 0}]

        ${response}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal}    headers=${header} 
        ${response1}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToOther}      headers=${header} 
        ${response2}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToGarage}      headers=${header} 

        ${respons3}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal1}    headers=${header} 
        ${response4}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToOther1}      headers=${header} 
        ${response5}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToGarage1}      headers=${header}

        ${respons6}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal2}    headers=${header} 
        ${respons7}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToOther2}    headers=${header} 
        ${response8}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToGarage2}      headers=${header} 

        #${response2}  post request   AddData     LocationUpdate?api_key=123    data=${movetoOthers}      headers=${header} 

 
    log    ${moveVehicleToTerminal}
    log    ${moveVehicleToOther} 
    log    ${moveVehicleToGarage} 

    log    ${moveVehicleToTerminal1}
    log    ${moveVehicleToOther1} 
    log    ${moveVehicleToGarage1} 
   
    log    ${moveVehicleToTerminal2}
    log    ${moveVehicleToOther2} 
    log    ${moveVehicleToGarage2}     

    
RSN3
    #RiverQuarry to Union Star
    #${lat}      14.814554581949
    #${long}     121.05809211731003
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    create session    AddData    ${locationURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

        #first compute number location 5* number of ibabato    
       
        ${time3}=   Subtract Time from Date	     ${time}	    10 minute	exclude_millis=yes
        ${time2}=   Add Time to Date	    ${time3}	    5 minute	exclude_millis=yes
        ${time4}=   Add Time to Date	    ${time2}	    5 minute	exclude_millis=yes

        ${moveVehicleToTerminal}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${riverQuarryLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile7}","speed": 0,"longitude": ${riverQuarryLong},"direction": 0}] 
        ${moveVehicleToTerminal1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${riverQuarryLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile8}","speed": 0,"longitude": ${riverQuarryLong},"direction": 0}] 
        ${moveVehicleToTerminal2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${riverQuarryLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile9}","speed": 0,"longitude": ${riverQuarryLong},"direction": 0}] 

        ${moveVehicleToOther}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${salandraLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile7}","speed": 0,"longitude": ${salandraLong},"direction": 0}] 
        ${moveVehicleToOther1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${salandraLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile8}","speed": 0,"longitude": ${salandraLong},"direction": 0}] 
        ${moveVehicleToOther2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${salandraLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile9}","speed": 0,"longitude": ${salandraLong},"direction": 0}] 


        ${moveVehicleToGarage}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${unionStarLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile7}","speed": 0,"longitude": ${unionStarLong},"direction": 0}]       
        ${moveVehicleToGarage1}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${unionStarLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile8}","speed": 0,"longitude": ${unionStarLong},"direction": 0}]       
        ${moveVehicleToGarage2}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${unionStarLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile9}","speed": 0,"longitude": ${unionStarLong},"direction": 0}]       

        
        
        ${response}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal}    headers=${header} 
        ${response1}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToOther}      headers=${header} 
        ${response2}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToGarage}      headers=${header} 

        ${respons3}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal1}    headers=${header} 
        ${response4}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToOther1}      headers=${header} 
        ${response5}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToGarage1}      headers=${header}

        ${respons6}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal2}    headers=${header} 
        ${respons7}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToOther2}    headers=${header} 
        ${response8}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToGarage2}      headers=${header} 

        #${response2}  post request   AddData     LocationUpdate?api_key=123    data=${movetoOthers}      headers=${header} 

 
    log    ${moveVehicleToTerminal}
    log    ${moveVehicleToOther} 
    log    ${moveVehicleToGarage} 

    log    ${moveVehicleToTerminal1}
    log    ${moveVehicleToOther1} 
    log    ${moveVehicleToGarage1} 
   
    log    ${moveVehicleToTerminal2}
    log    ${moveVehicleToOther2} 
    log    ${moveVehicleToGarage2}  

RSNInvalid
    #${lat}      14.814554581949
    #${long}     121.05809211731003
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    create session    AddData    ${locationURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

        #first compute number location 5* number of ibabato    
        ${time3}=   Subtract Time from Date	     ${time}	    10 minute	exclude_millis=yes
        ${time2}=   Add Time to Date	    ${time3}	    5 minute	exclude_millis=yes
        #${time1}=   Add Time to Date	     ${time2}	    5 minute	exclude_millis=yes
        ${moveVehicleToTerminal}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${hotspotLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile6}","speed": 0,"longitude": ${hotspotLong},"direction": 0}] 
        #${movetoOthers}             create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${garageLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": ${garageLong},"direction": 0}]
        ${moveVehicleToGarage}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${unionStarLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile6}","speed": 0,"longitude": ${unionStarLong},"direction": 0}]       
        ${response}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal}    headers=${header} 
        ${response1}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToGarage}      headers=${header} 
        #${response2}  post request   AddData     LocationUpdate?api_key=123    data=${movetoOthers}      headers=${header} 

 
    log    ${moveVehicleToTerminal}
    log    ${moveVehicleToGarage} 
RSNInvalid2
    #${lat}      14.814554581949
    #${long}     121.05809211731003
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    create session    AddData    ${locationURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

        #first compute number location * number of ibabato 

        ${time3}=   Subtract Time from Date	     ${time}	    10 minute	exclude_millis=yes
        ${time2}=   Add Time to Date	    ${time3}	    5 minute	exclude_millis=yes
        #${time1}=   Add Time to Date	     ${time2}	    5 minute	exclude_millis=yes
        ${moveVehicleToTerminal}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${riverQuarryLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile1}","speed": 0,"longitude": ${riverQuarryLong},"direction": 0}] 

        #${movetoOthers}             create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${garageLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": ${garageLong},"direction": 0}]
        ${moveVehicleToGarage}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile1}","speed": 0,"longitude": ${stop1Long},"direction": 0}]

        ${response}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal}    headers=${header} 
        ${response1}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToGarage}      headers=${header} 
        #${response2}  post request   AddData     LocationUpdate?api_key=123    data=${movetoOthers}      headers=${header} 

 
    log    ${moveVehicleToTerminal}
    log    ${moveVehicleToGarage}

RSNInvalid3
    #${lat}      14.814554581949
    #${long}     121.05809211731003
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    create session    AddData    ${locationURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

        #first compute number location 5* number of ibabato    
        ${time3}=   Subtract Time from Date	     ${time}	    10 minute	exclude_millis=yes
        ${time2}=   Add Time to Date	    ${time3}	    5 minute	exclude_millis=yes
        #${time1}=   Add Time to Date	     ${time2}	    5 minute	exclude_millis=yes
        ${moveVehicleToTerminal}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${terminalLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": ${terminalLong},"direction": 0}] 
        #${movetoOthers}             create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${garageLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": ${garageLong},"direction": 0}]
        ${moveVehicleToGarage}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${unionStarLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": ${unionStarLong},"direction": 0}]       
        ${response}   post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal}    headers=${header} 
        ${response1}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToGarage}      headers=${header} 
        #${response2}  post request   AddData     LocationUpdate?api_key=123    data=${movetoOthers}      headers=${header} 

 
    log    ${moveVehicleToTerminal}
    log    ${moveVehicleToGarage} 

#Emergency--> Hotspot (Emergency)
#Auxiliary--> Hotspot (Auxiliary)
#Hotspot --> Terminal-->Dropoff-->

location
    #${lat}      14.814554581949
    #${long}     121.05809211731003
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    ${time2} =	Convert Date    ${myTime}   
    create session    AddData    ${testURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   
    ${testlat} =   Set Variable     ${stop1Lat}
    ${testlong} =   Set Variable    ${stop1Long}

        ${time}=   Subtract Time from Date	 ${time}	    5 minute	exclude_millis=yes     
        ${moveVehicleToTerminal1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time}","driver": "","latitude": ${testlat},"fuel_reading": 0,"id": 1,"vehicle_id": "${local}","speed": 0,"longitude": ${testlong},"direction": 0}]           
        ${moveVehicleToTerminal2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time}","driver": "","latitude": ${testlat},"fuel_reading": 0,"id": 1,"vehicle_id": "${local1}","speed": 0,"longitude": ${testlong},"direction": 0}]  
        ${moveVehicleToTerminal3}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time}","driver": "","latitude": ${testlat},"fuel_reading": 0,"id": 1,"vehicle_id": "${local2}","speed": 0,"longitude": ${testlong},"direction": 0}]  
        ${moveVehicleToTerminal4}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time}","driver": "","latitude": ${testlat},"fuel_reading": 0,"id": 1,"vehicle_id": "${local3}","speed": 0,"longitude": ${testlong},"direction": 0}]           
        ${moveVehicleToTerminal5}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time}","driver": "","latitude": ${testlat},"fuel_reading": 0,"id": 1,"vehicle_id": "${local4}","speed": 0,"longitude": ${testlong},"direction": 0}]  
        ${moveVehicleToTerminal6}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time}","driver": "","latitude": ${testlat},"fuel_reading": 0,"id": 1,"vehicle_id": "${local5}","speed": 0,"longitude": ${testlong},"direction": 0}]  
        ${moveVehicleToTerminal7}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time}","driver": "","latitude": ${testlat},"fuel_reading": 0,"id": 1,"vehicle_id": "${local6}","speed": 0,"longitude": ${testlong},"direction": 0}]  
        ${moveVehicleToTerminal8}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time}","driver": "","latitude": ${testlat},"fuel_reading": 0,"id": 1,"vehicle_id": "${local7}","speed": 0,"longitude": ${testlong},"direction": 0}]  
        ${moveVehicleToTerminal9}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time}","driver": "","latitude": ${testlat},"fuel_reading": 0,"id": 1,"vehicle_id": "${local8}","speed": 0,"longitude": ${testlong},"direction": 0}]  
        #${moveVehicleToTerminal10}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time}","driver": "","latitude": ${testlat},"fuel_reading": 0,"id": 1,"vehicle_id": "${local1}","speed": 0,"longitude": ${testlong},"direction": 0}]  

        ${response1}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal1}   headers=${header}   
        ${response2}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal2}   headers=${header}   
        ${response3}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal3}   headers=${header}   
        ${response4}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal4}   headers=${header}   
        ${response5}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal5}   headers=${header}   
        ${response6}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal6}   headers=${header}   
        ${response7}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal7}   headers=${header}   
        ${response8}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal8}   headers=${header}   
        ${response9}  post request   AddData     LocationUpdate?api_key=123    data=${moveVehicleToTerminal9}   headers=${header}   
completeTrip
    #${lat}      14.814554581949
    #${long}     121.05809211731003
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    create session    AddData    ${testURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

        #first compute number location * number of ibabato    
        ${time3}=   Subtract Time from Date	     ${time}	    20 minute	exclude_millis=yes
        ${time2}=   Add Time to Date	    ${time3}	    5 minute	exclude_millis=yes
        ${time4}=   Add Time to Date	    ${time2}	    5 minute	exclude_millis=yes
        ${time5}=   Add Time to Date	    ${time4}	    5 minute	exclude_millis=yes
        ${time5}=   Add Time to Date	    ${time4}	    5 minute	exclude_millis=yes
   
        ${testingtesting}=  Set Variable    ${local}
        #${time1}=   Add Time to Date	     ${time2}	    5 minute	exclude_millis=yes
        ${stop1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Long},"direction": 0}] 
        ${stop2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${stop2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop2Long},"direction": 0}] 

        #${movetoOthers}             create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${garageLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": ${garageLong},"direction": 0}]
        ${stop3}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${stop5Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop5Long},"direction": 0}]
        ${stop4}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time5}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Long},"direction": 0}]

        ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop1}    headers=${header} 
        ${respons2}   post request   AddData     LocationUpdate?api_key=123    data=${stop2}    headers=${header} 
        ${response3}  post request   AddData     LocationUpdate?api_key=123    data=${stop3}      headers=${header}
        ${response4}  post request   AddData     LocationUpdate?api_key=123    data=${stop4}      headers=${header}
       
        #${response2}  post request   AddData     LocationUpdate?api_key=123    data=${movetoOthers}      headers=${header} 

    log    ${response}
    log    ${respons2}
    log    ${response3}         
    log    ${response4}     

completeTrip2
    #${lat}      14.814554581949
    #${long}     121.05809211731003
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    create session    AddData    ${testURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

        #first compute number location * number of ibabato    
        ${time1}=   Subtract Time from Date	     ${time}	    30 minute	exclude_millis=yes
        ${time2}=   Add Time to Date	    ${time1}	    5 minute	exclude_millis=yes
        ${time3}=   Add Time to Date	    ${time2}	    5 minute	exclude_millis=yes
        ${time4}=   Add Time to Date	    ${time3}	    5 minute	exclude_millis=yes
        ${time5}=   Add Time to Date	    ${time4}	    5 minute	exclude_millis=yes
        ${time6}=   Add Time to Date	    ${time5}	    5 minute	exclude_millis=yes
        ${time7}=   Add Time to Date	    ${time6}	    5 minute	exclude_millis=yes
 

        ${testingtesting}=  Set Variable    ${local3}
        ${stop1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time1}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Long},"direction": 0}] 
        ${stop2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${mrtCubaoLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtCubaoLong},"direction": 0}] 
        ${stop3}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${mrtSantolanLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtSantolanLong},"direction": 0}]
        ${stop4}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${mrtOrtigasLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtOrtigasLong},"direction": 0}]
        ${stop5}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time5}","driver": "","latitude": ${mrtShawLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtShawLong},"direction": 0}]
        ${stop6}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time6}","driver": "","latitude": ${mrtBoniLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtBoniLong},"direction": 0}]
        ${stop7}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time7}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Long},"direction": 0}]


        ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop1}    headers=${header} 
        ${respons2}   post request   AddData     LocationUpdate?api_key=123    data=${stop2}    headers=${header} 
        ${response3}  post request   AddData     LocationUpdate?api_key=123    data=${stop3}      headers=${header}
        ${response4}  post request   AddData     LocationUpdate?api_key=123    data=${stop4}      headers=${header}
        ${response5}  post request   AddData     LocationUpdate?api_key=123    data=${stop5}      headers=${header}
        ${response6}  post request   AddData     LocationUpdate?api_key=123    data=${stop6}      headers=${header}
        ${response7}  post request   AddData     LocationUpdate?api_key=123    data=${stop7}      headers=${header}

completeTrip3
    #${lat}      14.814554581949
    #${long}     121.05809211731003
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    create session    AddData    ${testURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

        #first compute number location * number of ibabato    
        ${time1}=   Subtract Time from Date	     ${time}	    30 minute	exclude_millis=yes
        ${time2}=   Add Time to Date	    ${time1}	    1 minute	exclude_millis=yes
        ${time3}=   Add Time to Date	    ${time2}	    1 minute	exclude_millis=yes
        ${time4}=   Add Time to Date	    ${time3}	    1 minute	exclude_millis=yes
        ${time5}=   Add Time to Date	    ${time4}	    1 minute	exclude_millis=yes
        ${time6}=   Add Time to Date	    ${time5}	    1 minute	exclude_millis=yes
        ${time7}=   Add Time to Date	    ${time6}	    1 minute	exclude_millis=yes

        ${time8}=   Add Time to Date	    ${time7}	    1 minute	exclude_millis=yes
        ${time9}=   Add Time to Date	    ${time8}	    1 minute	exclude_millis=yes
        ${time10}=   Add Time to Date	    ${time9}	    1 minute	exclude_millis=yes
        ${time11}=   Add Time to Date	    ${time10}	    1 minute	exclude_millis=yes
        ${time12}=   Add Time to Date	    ${time11}	    1 minute	exclude_millis=yes
        ${time13}=   Add Time to Date	    ${time12}	    1 minute	exclude_millis=yes
        ${time14}=   Add Time to Date	    ${time13}	    1 minute	exclude_millis=yes
     
        ${time15}=   Add Time to Date	    ${time14}	    1 minute	exclude_millis=yes
        ${time16}=   Add Time to Date	    ${time15}	    1 minute	exclude_millis=yes
        ${time17}=   Add Time to Date	    ${time16}	    1 minute	exclude_millis=yes
        ${time18}=   Add Time to Date	    ${time17}	    1 minute	exclude_millis=yes
        ${time19}=   Add Time to Date	    ${time18}	    1 minute	exclude_millis=yes
        ${time20}=   Add Time to Date	    ${time19}	    1 minute	exclude_millis=yes
        ${time21}=   Add Time to Date	    ${time20}	    1 minute	exclude_millis=yes 

        ${time22}=   Add Time to Date	    ${time21}	    1 minute	exclude_millis=yes
        ${time23}=   Add Time to Date	    ${time22}	    1 minute	exclude_millis=yes
        ${time24}=   Add Time to Date	    ${time23}	    1 minute	exclude_millis=yes
        ${time25}=   Add Time to Date	    ${time24}	    1 minute	exclude_millis=yes
        ${time26}=   Add Time to Date	    ${time25}	    1 minute	exclude_millis=yes
        ${time27}=   Add Time to Date	    ${time26}	    1 minute	exclude_millis=yes
        ${time28}=   Add Time to Date	    ${time27}	    1 minute	exclude_millis=yes 


        ${testingtesting}=  Set Variable    ${local2}
        ${stop1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time1}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Lat},"direction": 0}] 
        ${stop2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Lat},"direction": 0}] 
        ${stop3}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Lat},"direction": 0}]
        ${stop4}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Lat},"direction": 0}]
        ${stop5}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time5}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Lat},"direction": 0}]
        ${stop6}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time6}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Lat},"direction": 0}]
        ${stop7}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time7}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Lat},"direction": 0}]

        ${stop8}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time8}","driver": "","latitude": ${stop2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop2Long},"direction": 0}] 
        ${stop9}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time9}","driver": "","latitude": ${stop2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop2Long},"direction": 0}] 
        ${stop10}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time10}","driver": "","latitude": ${stop2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop2Long},"direction": 0}]
        ${stop11}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time11}","driver": "","latitude": ${stop2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop2Long},"direction": 0}]
        ${stop12}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time12}","driver": "","latitude": ${stop2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop2Long},"direction": 0}]
        ${stop13}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time13}","driver": "","latitude": ${stop2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop2Long},"direction": 0}]
        ${stop14}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time14}","driver": "","latitude": ${stop2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop2Long},"direction": 0}]

        ${stop15}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time15}","driver": "","latitude": ${stop5Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop5Long},"direction": 0}] 
        ${stop16}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time16}","driver": "","latitude": ${stop5Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop5Long},"direction": 0}] 
        ${stop17}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time17}","driver": "","latitude": ${stop5Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop5Long},"direction": 0}]
        ${stop18}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time18}","driver": "","latitude": ${stop5Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop5Long},"direction": 0}]
        ${stop19}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time19}","driver": "","latitude": ${stop5Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop5Long},"direction": 0}]
        ${stop20}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time20}","driver": "","latitude": ${stop5Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop5Long},"direction": 0}]
        ${stop21}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time21}","driver": "","latitude": ${stop5Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop5Long},"direction": 0}]

        ${stop22}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time22}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Lat},"direction": 0}] 
        ${stop23}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time23}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Lat},"direction": 0}] 
        ${stop24}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time24}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Lat},"direction": 0}]
        ${stop25}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time25}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Lat},"direction": 0}]
        ${stop26}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time26}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Lat},"direction": 0}]
        ${stop27}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time27}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Lat},"direction": 0}]
        ${stop28}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time28}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Lat},"direction": 0}]



        ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop1}    headers=${header} 
        ${response2}   post request   AddData     LocationUpdate?api_key=123    data=${stop2}    headers=${header} 
        ${response3}  post request   AddData     LocationUpdate?api_key=123    data=${stop3}      headers=${header}
        ${response4}  post request   AddData     LocationUpdate?api_key=123    data=${stop4}      headers=${header}
        ${response5}  post request   AddData     LocationUpdate?api_key=123    data=${stop5}      headers=${header}
        ${response6}  post request   AddData     LocationUpdate?api_key=123    data=${stop6}      headers=${header}
        ${response7}  post request   AddData     LocationUpdate?api_key=123    data=${stop7}      headers=${header}

        ${response8}   post request   AddData     LocationUpdate?api_key=123    data=${stop8}    headers=${header} 
        ${response9}   post request   AddData     LocationUpdate?api_key=123    data=${stop9}    headers=${header} 
        ${response10}  post request   AddData     LocationUpdate?api_key=123    data=${stop10}      headers=${header}
        ${response11}  post request   AddData     LocationUpdate?api_key=123    data=${stop11}      headers=${header}
        ${response12}  post request   AddData     LocationUpdate?api_key=123    data=${stop12}      headers=${header}
        ${response13}  post request   AddData     LocationUpdate?api_key=123    data=${stop13}      headers=${header}
        ${response14}  post request   AddData     LocationUpdate?api_key=123    data=${stop14}      headers=${header}

        ${response15}   post request   AddData     LocationUpdate?api_key=123    data=${stop15}    headers=${header} 
        ${response16}   post request   AddData     LocationUpdate?api_key=123    data=${stop16}    headers=${header} 
        ${response17}  post request   AddData     LocationUpdate?api_key=123    data=${stop17}      headers=${header}
        ${response18}  post request   AddData     LocationUpdate?api_key=123    data=${stop18}      headers=${header}
        ${response19}  post request   AddData     LocationUpdate?api_key=123    data=${stop19}      headers=${header}
        ${response20}  post request   AddData     LocationUpdate?api_key=123    data=${stop20}      headers=${header}
        ${response21}  post request   AddData     LocationUpdate?api_key=123    data=${stop21}      headers=${header}

        ${response22}   post request   AddData     LocationUpdate?api_key=123    data=${stop22}    headers=${header} 
        ${response23}   post request   AddData     LocationUpdate?api_key=123    data=${stop23}    headers=${header} 
        ${response24}  post request   AddData     LocationUpdate?api_key=123    data=${stop24}      headers=${header}
        ${response25}  post request   AddData     LocationUpdate?api_key=123    data=${stop25}      headers=${header}
        ${response26}  post request   AddData     LocationUpdate?api_key=123    data=${stop26}      headers=${header}
        ${response27}  post request   AddData     LocationUpdate?api_key=123    data=${stop27}      headers=${header}
        ${response28}  post request   AddData     LocationUpdate?api_key=123    data=${stop28}      headers=${header}

sendMultiple1
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    create session    AddData    ${testURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   
        #first compute number location * number of ibabato    
        ${time3}=   Subtract Time from Date	     ${time}	    20 minute	exclude_millis=yes
        ${time3}=   Subtract Time from Date	     ${time}	    20 minute	exclude_millis=yes
        ${time2}=   Add Time to Date	    ${time3}	    5 minute	exclude_millis=yes
        ${time4}=   Add Time to Date	    ${time2}	    5 minute	exclude_millis=yes
        ${time5}=   Add Time to Date	    ${time4}	    5 minute	exclude_millis=yes
        ${time} =	Convert Date    ${myTime}   
        ${seconds}=    set Variable    ${0}


        :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 7
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${vehicle}=    Catenate    SEPARATOR=      ${local}   ${seconds}
    \    ${stop1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${vehicle}","speed": 0,"longitude": ${stop1Long},"direction": 0}] 
    \    ${stop2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${stop2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${vehicle}","speed": 0,"longitude": ${stop2Long},"direction": 0}] 

        #${movetoOthers}             create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${garageLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testVechile}","speed": 0,"longitude": ${garageLong},"direction": 0}]
    \    ${stop3}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${stop5Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${vehicle}","speed": 0,"longitude": ${stop5Long},"direction": 0}]
    \    ${stop4}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time5}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${vehicle}","speed": 0,"longitude": ${stop1Long},"direction": 0}]
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop1}    headers=${header} 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop2}    headers=${header} 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop3}    headers=${header} 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop4}    headers=${header} 

         
URCDemo
    
     ${myTime}=  Get Current Date    exclude_millis=yes
     
    ${time} =	Convert Date    ${myTime}   
    ${time3}=   Subtract Time from Date	     ${time}	    1 minute	exclude_millis=yes
    create session    AddData    ${locationURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

        #first compute number location * number of ibabato    
        
        #${time1}=   Add Time to Date	     ${time2}	    5 minute	exclude_millis=yes
        ${stop1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${t1}","speed": 0,"longitude": ${URC1Long},"direction": 0}] 
        ${stop2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${t2}","speed": 0,"longitude": ${URC1Long},"direction": 0}] 
        ${stop3}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${t3}","speed": 0,"longitude": ${URC1Long},"direction": 0}] 
        ${stop4}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${t4}","speed": 0,"longitude": ${URC1Long},"direction": 0}] 
        ${stop5}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${t5}","speed": 0,"longitude": ${URC1Long},"direction": 0}] 

        ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop1}    headers=${header} 
        ${respons2}   post request   AddData     LocationUpdate?api_key=123    data=${stop2}    headers=${header} 
        ${response3}  post request   AddData     LocationUpdate?api_key=123    data=${stop3}      headers=${header}
        ${response4}  post request   AddData     LocationUpdate?api_key=123    data=${stop4}      headers=${header}
        ${response5}  post request   AddData     LocationUpdate?api_key=123    data=${stop5}      headers=${header}

URCDemo2
    
     ${myTime}=  Get Current Date    exclude_millis=yes
     
    ${time} =	Convert Date    ${myTime}   
    ${time3}=   Subtract Time from Date	     ${time}	    1 minute	exclude_millis=yes
    create session    AddData    ${locationURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

        #first compute number location * number of ibabato    
        
        #${time1}=   Add Time to Date	     ${time2}	    5 minute	exclude_millis=yes
        ${stop1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${s1}","speed": 0,"longitude": ${URC1Long},"direction": 0}] 
        ${stop2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${s2}","speed": 0,"longitude": ${URC1Long},"direction": 0}] 
        ${stop3}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${s3}","speed": 0,"longitude": ${URC2Long},"direction": 0}] 
        ${stop4}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${s4}","speed": 0,"longitude": ${URC2Long},"direction": 0}] 
        ${stop5}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${s5}","speed": 0,"longitude": ${URC2Long},"direction": 0}] 

        ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop1}    headers=${header} 
        ${respons2}   post request   AddData     LocationUpdate?api_key=123    data=${stop2}    headers=${header} 
        ${response3}  post request   AddData     LocationUpdate?api_key=123    data=${stop3}      headers=${header}
        ${response4}  post request   AddData     LocationUpdate?api_key=123    data=${stop4}      headers=${header}
        ${response5}  post request   AddData     LocationUpdate?api_key=123    data=${stop5}      headers=${header}

URCDemo3
    
     ${myTime}=  Get Current Date    exclude_millis=yes
     
    ${time} =	Convert Date    ${myTime}   
    ${time3}=   Subtract Time from Date	     ${time}	    1 minute	exclude_millis=yes
    create session    AddData    ${locationURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   

        #first compute number location * number of ibabato    
        
        #${time1}=   Add Time to Date	     ${time2}	    5 minute	exclude_millis=yes
        ${stop1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${v1}","speed": 0,"longitude": ${URC2Long},"direction": 0}] 
        ${stop2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${v2}","speed": 0,"longitude": ${URC2Long},"direction": 0}] 
        ${stop3}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC3Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${v3}","speed": 0,"longitude": ${URC3Long},"direction": 0}] 
        ${stop4}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC3Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${v4}","speed": 0,"longitude": ${URC3Long},"direction": 0}] 
        ${stop5}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${URC3Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${v5}","speed": 0,"longitude": ${URC3Long},"direction": 0}] 

        ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop1}    headers=${header} 
        ${respons2}   post request   AddData     LocationUpdate?api_key=123    data=${stop2}    headers=${header} 
        ${response3}  post request   AddData     LocationUpdate?api_key=123    data=${stop3}      headers=${header}
        ${response4}  post request   AddData     LocationUpdate?api_key=123    data=${stop4}      headers=${header}
        ${response5}  post request   AddData     LocationUpdate?api_key=123    data=${stop5}      headers=${header}

sendMultiple
    ${myTime}=  Get Current Date    exclude_millis=yes
    ${time} =	Convert Date    ${myTime}   
    create session    AddData    ${locationURL}
    ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded   
        #first compute number location * number of ibabato    
        ${time3}=   Subtract Time from Date	     ${time}	    20 minute	exclude_millis=yes
        ${time2}=   Add Time to Date	    ${time3}	    5 minute	exclude_millis=yes
        ${time4}=   Add Time to Date	    ${time2}	    5 minute	exclude_millis=yes
        ${time5}=   Add Time to Date	    ${time4}	    5 minute	exclude_millis=yes
        ${time} =	Convert Date    ${myTime}   
        ${seconds}=    set Variable    ${0}


        :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 9
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${vehicle}=    Catenate    SEPARATOR=      ${testVechile}   ${seconds}
    \    ${stop1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time3}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${vehicle}","speed": 0,"longitude": ${stop1Long},"direction": 0}] 
    #\    ${stop2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time2}","driver": "","latitude": ${stop2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${vehicle}","speed": 0,"longitude": ${stop2Long},"direction": 0}] 

    #\    ${stop3}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time4}","driver": "","latitude": ${stop5Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${vehicle}","speed": 0,"longitude": ${stop5Long},"direction": 0}]
    #\    ${stop4}      create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${time5}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${vehicle}","speed": 0,"longitude": ${stop1Long},"direction": 0}]
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop1}    headers=${header} 
    #\    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop2}    headers=${header} 
    #\    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop3}    headers=${header} 
    #\    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop4}    headers=${header} 

bulkInsert

        create session    AddData    ${locationURL}
        ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded  
        ${myTime}=  Get Current Date    exclude_millis=yes
        ${time} =	Convert Date    ${myTime}   
        #${timeCheck} =  Subtract Time from Date	 ${time}	    40 minute	exclude_millis=yes  
        ${seconds}=    set Variable    ${0}
        ${testingtesting}=  Set Variable    ${testVechile6}

        :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 7 
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${time}	    ${seconds} minute	exclude_millis=yes
    \    ${stop1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Long},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop1}    headers=${header} 
    \    Run Keyword If     ${i} == 0       log to console  ${hi}

    Log    Exited  
    
      :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 3 
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${time}	    ${seconds} minute	exclude_millis=yes
    \    ${stop2}    create dictionary   gps_update    [{"alerts": ["LOCATION","EMERGENCY"],"date_stamp": "${hi}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Long},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop2}    headers=${header} 
    \    Run Keyword If     ${i} == 0       log to console  ${hi}
    Log     Exited    

       
        :FOR    ${i}    IN RANGE    999999

    \    Exit For Loop If    ${i} == 7 
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${time}	    ${seconds} minute	exclude_millis=yes
    \    ${stop3}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${mrtCubaoLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtCubaoLong},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop3}    headers=${header} 
    \    Run Keyword If     ${i} == 0       log to console  ${hi}

    Log    Exited  

        :FOR    ${i}    IN RANGE    999999

    \    Exit For Loop If    ${i} == 3 
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${time}	    ${seconds} minute	exclude_millis=yes
    \    ${stop4}    create dictionary   gps_update    [{"alerts": ["LOCATION","EMERGENCY"],"date_stamp": "${hi}","driver": "","latitude": ${mrtCubaoLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtCubaoLong},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop4}    headers=${header} 
    \    Run Keyword If     ${i} == 0       log to console  ${hi}

    Log     Exited
 

    :FOR    ${i}    IN RANGE    999999

    \    Exit For Loop If    ${i} == 7 
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${time}	    ${seconds} minute	exclude_millis=yes
    \    ${stop5}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${mrtSantolanLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtSantolanLong},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop5}    headers=${header} 
    \    Run Keyword If     ${i} == 0       log to console  ${hi}

    Log    Exited  

        :FOR    ${i}    IN RANGE    999999

    \    Exit For Loop If    ${i} == 3 
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${time}	    ${seconds} minute	exclude_millis=yes
    \    ${stop6}    create dictionary   gps_update    [{"alerts": ["LOCATION","EMERGENCY"],"date_stamp": "${hi}","driver": "","latitude": ${mrtSantolanLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtSantolanLong},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop6}    headers=${header} 
    \    Run Keyword If     ${i} == 0       log to console  ${hi}


    Log     Exited
   
    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 7
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${time}	    ${seconds} minute	exclude_millis=yes
    \    ${stop7}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Long},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop7}    headers=${header} 
    \    Run Keyword If     ${i} == 0       log to console  ${hi}
    Log    Exited     

    


bulkInsertLF

        create session    AddData    ${testURL}
        ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded  
        ${myTime}=  Get Current Date    exclude_millis=yes
        ${time} =	Convert Date    ${myTime}   
        #${timeCheck} =  Subtract Time from Date	 ${time}	    40 minute	exclude_millis=yes  
        ${seconds}=    set Variable    ${0}
        ${testingtesting}=  Set Variable    ${local1}

        :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 7 
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${time}	    ${seconds} minute	exclude_millis=yes
    \    ${stop1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Long},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop1}    headers=${header} 
    \    log to console     ${hi}       ${stop1Lat}    
    Log    Exited  
          
        :FOR    ${i}    IN RANGE    999999

    \    Exit For Loop If    ${i} == 7 
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${time}	    ${seconds} minute	exclude_millis=yes
    \    ${stop2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${mrtCubaoLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtCubaoLong},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop2}    headers=${header} 
    \    log to console     ${hi}       ${stop2Lat}

 
    Log    Exited  
 
      :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 7 
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${time}	    ${seconds} minute	exclude_millis=yes
    \    ${stop3}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${mrtSantolanLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtSantolanLong},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop3}    headers=${header} 
    \    log to console     ${hi}       ${stop5Lat}

    Log    Exited  




bulkInsertMRT

        create session    AddData    ${testURL}
        ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded  
        ${myTime}=  Get Current Date    exclude_millis=yes
        ${time} =	Convert Date    ${myTime}   
        ${timeCheck} =  Subtract Time from Date	 ${time}	    49 minute	exclude_millis=yes  
        ${seconds}=    set Variable    ${0}
        ${testingtesting}=  Set Variable    ${local1}

        :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 7 
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} minute	exclude_millis=yes
    \    ${stop1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Long},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop1}    headers=${header} 
    \    log to console     ${hi}       ${stop1Lat}

    Log    Exited  
    
        :FOR    ${i}    IN RANGE    999999

    \    Exit For Loop If    ${i} == 7 
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} minute	exclude_millis=yes
    \    ${stop2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${mrtCubaoLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtCubaoLong},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop2}    headers=${header} 
    \    log to console     ${hi}       ${stop2Lat}

 
    Log    Exited  

  :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 7 
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} minute	exclude_millis=yes
    \    ${stop3}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${mrtSantolanLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtSantolanLong},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop3}    headers=${header} 
    \    log to console     ${hi}       ${stop5Lat}

    Log    Exited  

   :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 7
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} minute	exclude_millis=yes
    \    ${stop4}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${mrtOrtigasLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtOrtigasLong},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop4}    headers=${header} 
    \    log to console     ${hi}       ${stop1Lat}

    Log    Exited  

   :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 7
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} minute	exclude_millis=yes
    \    ${stop5}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${mrtShawLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtShawLong},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop5}    headers=${header} 
    \    log to console     ${hi}       ${stop1Lat}

    Log    Exited  

    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 7
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} minute	exclude_millis=yes
    \    ${stop6}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${mrtBoniLat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${mrtBoniLong},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop6}    headers=${header} 
    \    log to console     ${hi}       ${stop1Lat}

    Log    Exited  

    :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 7
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} minute	exclude_millis=yes
    \    ${stop7}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${testingtesting}","speed": 0,"longitude": ${stop1Long},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop7}    headers=${header} 
    \    log to console     ${hi}       ${stop1Lat}

    Log    Exited        

bulkInsertMultipleVehicles

        create session    AddData    ${testURL}
        ${header}   create dictionary   Content-Type=application/x-www-form-urlencoded  
        ${myTime}=  Get Current Date    exclude_millis=yes
        ${time} =	Convert Date    ${myTime}   
        ${timeCheck} =  Subtract Time from Date	 ${time}	    49 minute	exclude_millis=yes  
        ${seconds}=    set Variable    ${0}
        ${testingtesting}=  Set Variable    ${local}
        

        :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 2 
    \    ${vehicle}=    Catenate    SEPARATOR=      ${local}   ${seconds}
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} minute	exclude_millis=yes
    \    ${stop1}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${vehicle}","speed": 0,"longitude": ${stop1Long},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop1}    headers=${header} 
    \    log to console     ${hi}       ${stop1Lat}

    Log    Exited  
    
        :FOR    ${i}    IN RANGE    999999

    \    Exit For Loop If    ${i} == 2 
    \    ${vehicle}=    Catenate    SEPARATOR=      ${local}   ${seconds}
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} minute	exclude_millis=yes
    \    ${stop2}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${stop2Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${vehicle}","speed": 0,"longitude": ${stop2Long},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop2}    headers=${header} 
    \    log to console     ${hi}       ${stop2Lat}

 
    Log    Exited  

  :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 2 
    \    ${vehicle}=    Catenate    SEPARATOR=      ${local}   ${seconds}   
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} minute	exclude_millis=yes
    \    ${stop3}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${stop5Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${vehicle}","speed": 0,"longitude": ${stop5Long},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop3}    headers=${header} 
    \    log to console     ${hi}       ${stop5Lat}

    Log    Exited  

   :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 2
    \    ${vehicle}=    Catenate    SEPARATOR=      ${local}   ${seconds}
    \    ${seconds}=     Evaluate    ${seconds}+1
    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} minute	exclude_millis=yes
    \    ${stop4}    create dictionary   gps_update    [{"alerts": ["LOCATION"],"date_stamp": "${hi}","driver": "","latitude": ${stop1Lat},"fuel_reading": 0,"id": 1,"vehicle_id": "${vehicle}","speed": 0,"longitude": ${stop1Long},"direction": 0}] 
    \    ${response}   post request   AddData     LocationUpdate?api_key=123    data=${stop4}    headers=${header} 
    \    log to console     ${hi}       ${stop1Lat}

    Log    Exited 

ifCheck
     ${myTime}=  Get Current Date    exclude_millis=yes
        ${time} =	Convert Date    ${myTime}   
        ${timeCheck} =  Subtract Time from Date	 ${time}	    49 minute	exclude_millis=yes  
                ${seconds}=    set Variable    ${0}


        :FOR    ${i}    IN RANGE    999999
    \    Exit For Loop If    ${i} == 2
    \    ${hi}=   Add Time to Date	 ${timeCheck}	    ${seconds} minute	exclude_millis=yes
    \    Run Keyword If     ${i} == 0       log to console  ${hi}
   

    Log    Exited 


*** Keywords ***


