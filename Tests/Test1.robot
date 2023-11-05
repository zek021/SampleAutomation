*** Settings ***
Documentation       Run Command: robot -d Output -i LoginTest Tests
Resource            ../Resources/LoginKeywords.robot


*** Variables ***
${url}              https://automationinterface1.front.staging.optimy.net/en/
${browser}          chrome
${email}            optimyautomationtester@gmail.com
${Password}         yRMhojb7
${first_name}       John
${last_name}        Doe
${unit_house_no}    43' San Diego St Medford Ville
${postal_code}      1000
${Country}          Philippines
${gender}           female
${file_path}        C:\\Users\\Zek\\PycharmProjects\\AutomationExam\\Data\\sample.jpg
${role}             Manual tester
@{skills}           Java    Python      Robot Framework
${objective_file}        C:\\Users\\Zek\\PycharmProjects\\AutomationExam\\Data\\Objective.txt


*** Test Cases ***

TC1: Verify Successful Login
    [Tags]     SuccessfulLoginTest      LoginTest
    Successful Login    ${url}  ${browser}  ${email}    ${Password}

TC2: Verify Successful Form Submission
    [Tags]     FormSubmission      LoginTest
    Fill Out Application Form   ${url}  ${browser}  ${email}    ${Password}
    ...                         ${first_name}  ${last_name}  ${unit_house_no}    ${postal_code}     ${country}
    ...                         ${file_path}    ${gender}   ${role}     ${skills}   ${objective_file}


