*** Settings ***
Library  Browser
Library  String
Resource   ../resources/variables.robot
Resource    basePage.robot
Variables    ../locators/profilePageLocators.py
Variables    ../locators/homePageLocators.py


*** Keywords ***
Verify User Logged In My Profile Page
    [Documentation]    Verifies if user is logged in after submitting password form
    [Arguments]    ${random_email}

    # Verify if Mein Konto is present
    Run Keyword And Continue On Failure    Verify Element Is Visible    ${MEIN_KONTO}
    ${is_visible}=    Run Keyword And Return Status    Verify Element Is Visible    ${MEIN_KONTO}
    Run Keyword If    '${is_visible}' == 'False'    Fail    "MEIN_KONTO element is not visible, user might not be logged in"

    # Convert registered email id to lower case
    ${lowercase_registered_email}=    Convert To Lower Case    ${random_email}
    ${UserName}=    Catenate    ${FIRST_NAME}    ${LAST_NAME}
    
    # Verify if the Heading Title contains First Name
    ${HeadingTitle}=    Get Text    ${HEADING_TITLE}
    ${status}=    Run Keyword And Return Status    Should Contain    ${HeadingTitle}    ${FIRST_NAME}
    Run Keyword If    '${status}' == 'False'    Fail    "Heading title does not contain the expected first name"
    Log    Verfied User Name    console=True

    # Verify if the Email address matches with the registered email
    ${email_Confirmation}=    Get Text    ${PROFILE_EMAIL}    
    ${status}=    Run Keyword And Return Status    Should Be Equal    ${email_Confirmation}    ${lowercase_registered_email}
    Run Keyword If    '${status}' == 'False'    Fail    "Email confirmation does not match the registered email"
    Log    Verified user login successfully    console=True


Verify User Logged out
    [Documentation]    CLicks on Logout link and verifies if user is logged out

    # Hover on Mein Konto
    Run Keyword And Continue On Failure    Hover    ${MEIN_KONTO}
    ${status}=    Run Keyword And Return Status    Hover    ${MEIN_KONTO}
    Run Keyword If    '${status}' == 'False'    Fail    "Failed to hover over MEIN_KONTO"

    # Click on Abmelden Link
    Run Keyword And Continue On Failure    Click    ${ABMELDEN_LINK}
    ${status}=    Run Keyword And Return Status    Click    ${ABMELDEN_LINK}
    Run Keyword If    '${status}' == 'False'    Fail    "Failed to click the ABMELDEN_LINK"

    #Verify if Anmelden button is visible
    Run Keyword And Continue On Failure    Verify Element Is Visible    ${ANMELDEN_BUTTON}
    ${is_visible}=    Run Keyword And Return Status    Verify Element Is Visible    ${ANMELDEN_BUTTON}
    Run Keyword If    '${is_visible}' == 'False'    Fail    "ANMELDEN_BUTTON element is not visible, user might not be logged out"

    Log    User logged out successfully    console=True
