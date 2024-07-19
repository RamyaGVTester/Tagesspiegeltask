*** Settings ***
Library    Browser
Library    OperatingSystem

Resource   ../pages/homePage.robot
Resource   ../pages/registrationPage.robot
Resource   ../pages/passwordFormPage.robot
Resource   ../pages/profilePage.robot
Resource   ../pages/emailPage.robot


*** Test Cases ***
Verify Registration Process
    [Setup]    Set Up Browser
    ${random_email}=    Generate Random Email
    Set Browser Timeout    20s   # Increase timeout to 20 seconds
    Open Home Page    ${ENV}
    Handle Modal Dialog    ${COOKIE_MODAL_IFRAME}
    Switch Back To Default Content
    Click Button    ${ANMELDEN_BUTTON}
    Navigate to Registration Tab
    Fill Registration Form    ${random_email}    ${FIRST_NAME}    ${LAST_NAME}
    Click Button    ${REGISTER_BUTTON}
    Switch Back To Default Content
    Close Registration Modal
    ${search_result}=    Wait For Registration Email    ${EMAILID}    ${EMAIL_PWD}    ${EMAIL_SERVER}    ${IMAP_PORT}    ${EMAIL_SUBJECT}
    ${registration_link}=    Get Registration Link From Email    ${search_result}    ${random_email}    ${EMAIL_FROM}    ${URL_REGEXP}
    Open Verification Link to fill Password Form    ${registration_link}    ${VERIFY_PASSWORD}
    Click Button    ${SAVE_BUTTON}
    Verify User Logged In My Profile Page    ${random_email}
    Verify User Logged out
    [Teardown]    Tear Down Browser

*** Keywords ***
Set Up Browser
    Launch Browser
    Log    Browser setup complete    console=True

Tear Down Browser
    Log    Tearing down browser    console=True
    Close Opened Browser

    