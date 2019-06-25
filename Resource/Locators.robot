*** Variables ***
${username}  //input[@id='UserUsername']
${next}  //button[contains(text(),'NEXT')]
${password}  //input[@id='UserPassword']
${signIn}  //button[contains(text(),'testtest')]
${invalidUserName}  //input[@id='UserUsername']/following::label[1]

${dispatchFile}  //input[@name='dispatchfile[]']
${blankFile}  D:/Downloads/Omni Test Data/blank.xlsx
${uploadRequestButton}  //a[@id='upload-requests']
${save}  //button[@id='save']
${clickLabel}  //div[@class='collapsible-header red']
${blankErrorMessage}  //span[contains(text(),'You uploaded a blank file. Please try again.')]
${blankClient}  D:/Downloads/Omni Test Data/blankclient_omni.xlsx
${clientErrorMessage}   //td[contains(text(),'Client not recognized')]


#Filter
${filterButton}         //a[@href='#filter-modal']
${clickTypeOfService}   //body/div[@class='row clearfix']/div[@id='filter-modal']/div[@class='modal-content']/div[2]/div[1]/input[1]
${typeOfServiceAll}        //ul[@id='select-options-46ef27e9-1d63-ca9f-199b-9d9119437ca3']//span[contains(text(),'All')]
${typeOfServiceGeneralCargo}    //ul[@id='select-options-46ef27e9-1d63-ca9f-199b-9d9119437ca3']//span[contains(text(),'All')]/following::span[1]

#ManualBooking 
#: FOR  ${test}   IN RANGE  1   5
 #   ${forLoop}          'tbl-item-record tbl-record-${test}'
 #\    ... AND EXIT For Loop

${manualBooking}    //i[@class='large material-icons']
${clientTextbox}    //input[@name='clientname']
${clientDropdown}   HAIER PHILIPPINES INC.
${clientDropdown2}  //*[text()='HAIER PHILIPPINES INC.']
${nextButton}       //div[@id='step1']//button[@type='button'][contains(text(),'Next')]
${emptyToast}       Please fill required fields/Invalid Quantity
${clientDropdown2}  //*[text()='HAIER PHILIPPINES INC.']
${reference}        //input[@name='free_text_field']
${selectItemDesc}   //tr[@class='tbl-item-record tbl-record-1']//a[@id='add-item-modal-trigger']//i[@class='material-icons'][contains(text(),'playlist_add_check')]
${addItem}          //a[@class='add-goods-btn']