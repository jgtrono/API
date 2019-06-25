*** Settings ***
Library           ExtendedSelenium2Library
Resource          Locators.robot
Library           String

*** Variables ***

*** Keywords ***
Open and Maximize Browser
    [Arguments]    ${url}    ${browser}=firefox
    Open Browser    ${urlOmni}    ${browser}
    Maximize Browser Window

Login
    Input Text    ${username}    ${test3}
    Click Button    ${next}
    Input Text    ${password}    ${test6}
    Click Button    ${signIn}

ManualBookingValidation1
    Run Keyword and Ignore Error    Wait Until Element Is Visible    ${manualBooking}
    Click Element    ${manualBooking}
    Click Element    ${nextButton}
    Wait Until Page Contains    ${emptyToast}
    Input Text    ${clientTextbox}    ${client}
    Run Keyword and Ignore Error    Wait Until Page Contains    ${clientDropDown} timeout=1 error=false
    Press Key    ${clientTextbox}    \\13
    Click Element    ${nextButton}
    Wait Until Page Contains    ${emptyToast}
    Input Text    ${reference}    ${refNo}
    Click Element    ${nextButton}
    Sleep    10

ManualBookingAddItem
    Click Element    ${addItem}
    Click Element    ${selectItemDesc}

ManualBooking1
    Run Keyword and Ignore Error    Wait Until Element Is Visible    ${manualBooking}
    Click Element    ${manualBooking}
    Input Text    ${clientTextbox}    ${client}
    Run Keyword and Ignore Error    Wait Until Page Contains    ${clientDropDown} timeout=1 error=false
    Press Key    ${clientTextbox}    \\13
    Input Text    ${reference}    ${refNo}
    Run Keyword and Ignore Error    Wait Until Page Contains    ${selectItemDesc} timeout=1 error=false
    ManualBookingAddItem
    Click Element    //a[contains(text(),'omni test item')]
    #addItem1
    Click Element    ${addItem}
    Click Element    ${selectItemDesc}
    Input Text    //input[@type='search']    wmb
    Click Element    //a[contains(text(),'WMB231')]
    Click Element    ${addItem}
    Sleep    10
    #addItem

addItemButton
    Click Element    ${addItem}
    Click Element    ${selectItemDesc}

forLoop
    #: FOR    ${forLoop}    1    6
    #\    Log    ${forLoop}
    #\    Log    /tr[@class='tbl-item-record tbl-record-'${forLoop}]
    #\    Run Keyword If    ${forLoop}==50    Run Keywords    Log    Stop
    #\    ...
    # AND    Exit For Loop
    #${randomNumber}    Evaluate    random.sample(range(1, 10), 1)    random
    #Log    ${randomNumber}
