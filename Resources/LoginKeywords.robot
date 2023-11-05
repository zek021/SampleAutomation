*** Settings ***
Library             SeleniumLibrary
Library    Screenshot
Library    OperatingSystem
Variables           ../PageObject/Locators.py

*** Keywords ***
Open My Browser
    [Arguments]     ${url}  ${browser}
    Open Browser    ${url}  ${browser}
    Maximize Browser Window


Enter Username
    [Arguments]     ${email}
    Input Text    ${signin_email}    ${email}

Enter Password
    [Arguments]     ${password}
    Input Text    ${signin_password}    ${password}

Click Signin
    Click Button    ${login_button}

Click Accept All Cookies
    Click Button    //*[@id="cookie-allow-all-button"]

Click Submit Application
    Click Link    ${submit_application}

Click Submit New Application
    Click Link    ${submit_new_application}

Successful Login
    [Arguments]     ${url}  ${browser}  ${email}    ${password}
    Open My Browser     ${url}  ${browser}
    Set Selenium Speed    0.1
    ${element_exist}=  Run Keyword And Return Status    Element Should Be Visible    //*[@id="cookie-allow-all-button"]
    Run Keyword If    ${element_exist} == True
    ...    Click Accept All Cookies
    Wait Until Element Is Not Visible    //*[@id="cookie-allow-all-button"]
    Click Submit Application
    Wait Until Element Is Visible    ${signin_email}    20
    Enter Username  ${email}
    Enter Password  ${password}
    Click Signin
    Wait Until Element Is Visible   ${submit_new_application}   20
    Click Submit New Application
    Title Should Be    Fill-out all forms -

Fill Out Application Form
    [Arguments]     ${url}  ${browser}  ${email}    ${password}
    ...             ${first_name}   ${last_name}    ${unit_house_no}    ${postal_Code}      ${country}
    ...             ${file_path}    ${gender}   ${role}     ${skills}   ${objective_file}

    Successful Login     ${url}  ${browser}  ${email}    ${password}
    Input Text    ${first_name_loc}    ${first_name}
    Input Text    ${last_name_loc}    ${last_name}
    Input Text    ${house_no}    ${unit_house_no}
    Input Text    ${post_code}    ${postal_Code}
    Wait Until Element Is Visible    css:ul#ui-id-1>li>a
    Click Link    css:ul#ui-id-1>li>a
    Click Element    ${post_code}
    Select From List By Label    ${country_loc}     ${country}
    Scroll Element Into View    css:#container_e3d17f2c-51d7-5950-b6f9-32580b006c48 > fieldset > legend > span
    Choose File    ${file_input}    ${file_path}

    IF    "${gender}" == "Male"
        Click Element    css:li#container_f3fa11a5-a516-5cec-9025-b940b1b113d0
    ELSE IF     "${gender}" == "Female"
        Click Element    css:li#container_514632f0-b9ec-5946-997e-f486fcd8276c
    ELSE IF     "${gender}" == "Prefer not to answer"
        Click Element    css:li#container_f9291e23-4c53-56d3-8115-45818912be01
    ELSE
        Click Element    css:li#container_f9291e23-4c53-56d3-8115-45818912be01
    END
    Select From List By Label    ${applied_role}    ${role}
    FOR    ${skills}    IN    @{skills}
        ${selected_skill}=      Set Variable    ${${skills}}
        Scroll Element Into View    ${selected_skill}
        Click Element    ${selected_skill}
    END
    ${objective}=       Get File    ${objective_file}
    Scroll Element Into View    css:div#cke_1_contents>iframe
    Select Frame    css:div#cke_1_contents>iframe
    Input Text    css:body    ${objective}
    Unselect Frame
    Click Button    ${next_bttn}
    Wait Until Element Is Not Visible    ${next_bttn}
    Wait Until Element Is Visible    ${submit2}
    Click Button    ${submit2}
    Sleep    5
    




