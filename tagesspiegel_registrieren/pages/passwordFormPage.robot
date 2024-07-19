*** Settings ***
Library  Browser
Library  BuiltIn
Resource   ../resources/variables.robot
Resource   ../pages/basePage.robot
Variables    ../locators/passwordFormPageLocators.py
Variables    ../locators/profilePageLocators.py

*** Keywords ***
Open Verification Link to fill Password Form
    [Documentation]    Opens verification link in new page and fills the password form
    [Arguments]    ${verification_link}    ${password}

    Open New Page    ${verification_link}

    # Verify if Password text field is present and enter password
    Run Keyword And Continue On Failure    Verify Element Is Visible    ${PASSWORD_INPUT}
    ${is_visible}=    Run Keyword And Return Status    Verify Element Is Visible    ${PASSWORD_INPUT}
    Run Keyword If    '${is_visible}' == 'False'    Fail    Password input field is not visible
    Type Text    ${PASSWORD_INPUT}    ${password}
    Log    Entered password    console=True

    # Verify if Repeat Password text field is present and re-enter password
    Run Keyword And Continue On Failure    Verify Element Is Visible    ${CONFIRM_PASSWORD_INPUT}
    ${is_visible}=    Run Keyword And Return Status    Verify Element Is Visible    ${CONFIRM_PASSWORD_INPUT}
    Run Keyword If    '${is_visible}' == 'False'    Fail    Confirm password input field is not visible
    Type Text    ${CONFIRM_PASSWORD_INPUT}    ${password}
    Log    Reentered password    console=True
    