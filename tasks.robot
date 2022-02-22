<<<<<<< HEAD
*** Settings ***
Documentation     Orders robots from RobotSpareBin Industries Inc.
...               Saves the order HTML receipt as a PDF file.
...               Saves the screenshot of the ordered robot.
...               Embeds the screenshot of the robot to the PDF receipt.
...               Creates ZIP archive of the receipts and the images.
Library           RPA.Browser.Selenium    auto_close=${FALSE}
Library           RPA.Excel.Files
Library           RPA.HTTP
Library           RPA.PDF
Library           RPA.Tables
Library           OperatingSystem         
Library           RPA.Archive
Library           String
Library           RPA.Robocloud.Secrets

*** Tasks ***
Order robots from RobotSpareBin Industries Inc
    Open the robot order website
    ${orders}=    Get orders
    FOR    ${row}    IN    @{orders}
        Close the annoying modal
        Fill the form    ${row}
        Preview the robot
        Submit the order
        ${pdf}=    Store the receipt as a PDF file    
        ${screenshot}=    Take a screenshot of the robot    
        Embed the robot screenshot to the receipt PDF file   
        Run Keyword And Continue On Failure    Go to order another robot   
    END
    Create a ZIP file of the receipts
    [Teardown]    

*** Keywords ***
Open the robot order website
    ${secret}=    Get Secret     Robotsparebin
    Open Available Browser       ${secret}[url]


Get orders
    [Arguments]      ${url}=https://robotsparebinindustries.com/orders.csv
         Download     ${url}      overwrite=True
         @{row}=  Read table from CSV    orders.csv     header=True
    [Return]   ${row}   

Close the annoying modal
    Click Button       xpath://html/body/div/div/div[2]/div/div/div/div/div/button[1]   

Fill the form    
    [Arguments]  ${rows}
    Select From List By Value    head      ${rows}[Head]
    Select Radio Button    body      ${rows}[Body]
    Input Text   css:.form-control      ${rows}[Legs]
    Input Text    address     ${rows}[Address]
                  
Preview the robot
    Click Button    Preview

Submit the order
    Click Button    order
    ${Status} =  Run Keyword And Return Status    Submit the order     
    Run Keyword if    ${Status} == 'False'   Submit the order 
    
Store the receipt as a PDF file   
    ${receipt_html}=    Get Element Attribute    xpath:/html/body/div/div/div[1]/div/div[1]/div   outerHTML     
    Html To Pdf   ${receipt_html}  ${OUTPUT_DIR}${/}receipt.pdf
       
Take a screenshot of the robot        
    Screenshot   id:robot-preview-image    ${OUTPUT_DIR}${/}Robo.PNG
    [Return]    ${OUTPUT_DIR}${/}Robo.PNG

Embed the robot screenshot to the receipt PDF file
    Add Watermark Image To PDF
    ...              ${OUTPUT_DIR}${/}Robo.PNG
    ...             ${OUTPUT_DIR}${/}receipt.pdf
    ...              ${OUTPUT_DIR}${/}receipt.pdf
    [Return]    receipt.pdf

Go to order another robot
    Click Button        xpath://*[@id="order-another"]
    
Create a ZIP file of the receipts
    ${RobotSpareBin}=    Set Variable   ${OUTPUT_DIR}${/}receipt.zip
    Archive Folder With Zip    ${OUTPUT_DIR}    ${RobotSpareBin}    recursive=True
    
  
=======
*** Settings ***
Documentation     Orders robots from RobotSpareBin Industries Inc.
...               Saves the order HTML receipt as a PDF file.
...               Saves the screenshot of the ordered robot.
...               Embeds the screenshot of the robot to the PDF receipt.
...               Creates ZIP archive of the receipts and the images.
Library           RPA.Browser.Selenium    auto_close=${FALSE}
Library           RPA.Excel.Files
Library           RPA.HTTP
Library           RPA.PDF
Library           RPA.Tables
Library           OperatingSystem         
Library           RPA.Archive
Library           String
Library           RPA.Robocloud.Secrets

*** Tasks ***
Order robots from RobotSpareBin Industries Inc
    Open the robot order website
    ${orders}=    Get orders
    FOR    ${row}    IN    @{orders}
        Close the annoying modal
        Fill the form    ${row}
        Preview the robot
        Submit the order
        ${pdf}=    Store the receipt as a PDF file    
        ${screenshot}=    Take a screenshot of the robot    
        Embed the robot screenshot to the receipt PDF file   
        Run Keyword And Continue On Failure    Go to order another robot   
    END
    Create a ZIP file of the receipts
    [Teardown]    

*** Keywords ***
Open the robot order website
    ${secret}=    Get Secret     Robotsparebin
    Open Available Browser       ${secret}[url]


Get orders
    [Arguments]      ${url}=https://robotsparebinindustries.com/orders.csv
         Download     ${url}      overwrite=True
         @{row}=  Read table from CSV    orders.csv     header=True
    [Return]   ${row}   

Close the annoying modal
    Click Button       xpath://html/body/div/div/div[2]/div/div/div/div/div/button[1]   

Fill the form    
    [Arguments]  ${rows}
    Select From List By Value    head      ${rows}[Head]
    Select Radio Button    body      ${rows}[Body]
    Input Text   css:.form-control      ${rows}[Legs]
    Input Text    address     ${rows}[Address]
                  
Preview the robot
    Click Button    Preview

Submit the order
    Click Button    order
    ${Status} =  Run Keyword And Return Status    Submit the order     
    Run Keyword if    ${Status} == 'False'   Submit the order 
    
Store the receipt as a PDF file   
    ${receipt_html}=    Get Element Attribute    xpath:/html/body/div/div/div[1]/div/div[1]/div   outerHTML     
    Html To Pdf   ${receipt_html}  ${OUTPUT_DIR}${/}receipt.pdf
       
Take a screenshot of the robot        
    Screenshot   id:robot-preview-image    ${OUTPUT_DIR}${/}Robo.PNG
    [Return]    ${OUTPUT_DIR}${/}Robo.PNG

Embed the robot screenshot to the receipt PDF file
    Add Watermark Image To PDF
    ...              ${OUTPUT_DIR}${/}Robo.PNG
    ...             ${OUTPUT_DIR}${/}receipt.pdf
    ...              ${OUTPUT_DIR}${/}receipt.pdf
    [Return]    receipt.pdf

Go to order another robot
    Click Button        xpath://*[@id="order-another"]
    
Create a ZIP file of the receipts
    ${RobotSpareBin}=    Set Variable   ${OUTPUT_DIR}${/}receipt.zip
    Archive Folder With Zip    ${OUTPUT_DIR}    ${RobotSpareBin}    recursive=True
    
  
>>>>>>> 68590c3 (firstcommit)
    