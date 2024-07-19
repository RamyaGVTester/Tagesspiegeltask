*** Settings ***
Library  Browser
Library  String
Resource   ../resources/variables.robot
Variables  ../locators/registrationPageLocators.py
Variables  ../locators/homePageLocators.py
Resource   ../pages/basePage.robot

*** Keywords ***
Fill Registration Form
    [Documentation]    Fills the registration form with provided email, first name, and last name.
    [Arguments]    ${email}    ${first_name}    ${last_name}

    # Check and fill email
    Verify Element Is Visible    ${EMAIL_INPUT}
    Run Keyword And Return Status    Type Text    ${EMAIL_INPUT}    ${email}
    ${status}=    Run Keyword And Return Status    Log    Failed to enter email: ${email}    console=True
    Run Keyword If    ${status} == False    Log    Failed to enter email: ${email}    console=True
    Log    Entered email: ${email}    console=True

    # Check and fill first name
    Verify Element Is Visible    ${FIRST_NAME_INPUT}
    ${status}=    Run Keyword And Return Status    Type Text    ${FIRST_NAME_INPUT}    ${first_name}
    Run Keyword If    ${status} == False    Log    Failed to enter first name: ${first_name}    console=True
    Type Text    ${FIRST_NAME_INPUT}    ${first_name}
    Log    Entered first name: ${first_name}    console=True

    # Check and fill last name
    Verify Element Is Visible    ${LAST_NAME_INPUT}
    ${status}=    Run Keyword And Return Status    Type Text    ${LAST_NAME_INPUT}    ${last_name}
    Run Keyword If    ${status} == False    Log    Failed to enter last name: ${last_name}    console=True
    Log    Entered last name: ${last_name}    console=True

Close Registration Modal
    [Documentation]    Closes registration modal.

    # Verify and click close button
    Verify Element Is Visible    ${CLOSE_REGISTRATION}
    ${status}=    Run Keyword And Return Status    Click    ${CLOSE_REGISTRATION}
    Run Keyword If    ${status} == False    Log    Failed to close registration modal    console=True
    Log    Closed Registration modal    console=True

Navigate to Registration Tab
    [Documentation]    Navigates to the registration tab within an iframe.
    
    # Switch to iframe
    Log    Switching to registration window iframe    console=True
    Switch To Iframe    ${REGISTRATION_IFRAME} >>>

    # Verify and click registration tab button
    Verify Element Is Visible    ${REGISTRATION_TAB_BUTTON}
    ${element}=    Get Element    ${REGISTRATION_TAB_BUTTON}
    ${class_name}=    Get Attribute    ${element}    class

    ${status}=    Run Keyword And Return Status    Should Not Contain    ${class_name}    active
    Run Keyword If    ${status} == False    Log    Registration tab button is already active    console=True
    ${status}=    Run Keyword And Return Status    Click Button    ${REGISTRATION_TAB_BUTTON}
    Run Keyword If    ${status} == False    Log    Failed to click on Registration Tab button    console=True
    Log    Navigated to the Registration modal    console=True