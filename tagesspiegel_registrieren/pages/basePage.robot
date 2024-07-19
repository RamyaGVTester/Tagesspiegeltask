** Settings ***
Library    Browser
Library    BuiltIn
Library    String
Library    Collections
Library    re
Variables  ../locators/basePageLocators.py
Resource   ../resources/variables.robot
Variables   ../locators/registrationPageLocators.py
Variables   ../locators/homePageLocators.py

*** Keywords ***
Generate Random Email
    [Documentation]    Generates random email id for testing purpose
    [Arguments]    ${email_prefix}=${EMAIL}    ${email_domain}=${EMAIL_DOMAIN}
    ${random_string}=    Generate Random String    10    [LETTERS][NUMBERS]
    ${email}=    Set Variable    ${email_prefix}+${random_string}@${email_domain}
    Log    Generated Email: ${email}    console=True
    RETURN    ${email}

Handle Modal Dialog
    [Documentation]    
    ...    Handles a modal dialog, such as an accept cookies popup, within a specified iframe.
    ...    This keyword is used to interact with and accept a modal dialog that might appear within an iframe.
    ...    It uses a retry mechanism to attempt handling the modal multiple times if it is not immediately available.
    [Arguments]    ${iframe_num}
    Wait Until Keyword Succeeds    3x   2s   Check Cookie Frame    ${iframe_num}    

Switch To Iframe
    [Documentation]    Switches to frame
    [Arguments]    ${iframe_selector}

    # Set the selector prefix for the iframe
    Set Selector Prefix    ${iframe_selector}
    Log    Switched to iframe: ${iframe_selector}

Switch Back To Default Content
    [Documentation]    Returns focus from frame back to the main content of the webpage.

    # Clear the selector prefix to focus on the main content
    Set Selector Prefix    ${None}
    Log    Switched back to default content

Set Environment URL
    [Documentation]    
    ...    Determines and sets the URL based on the provided environment.
    ...    If the environment is 'prod', it sets the URL to the production URL.
    ...    If the environment is 'staging', it sets the URL to the staging URL.
    ...    If the environment is 'test1', it sets the URL to the test1 URL.
    ...    For any other environment, it constructs a URL based on the provided environment identifier.
    [Arguments]    ${env}
    ${url}=    Run Keyword If    '${env}' == 'prod'    Set Variable    ${PRODUCTION_URL}
    ...         ELSE IF    '${env}' == 'staging'    Set Variable    ${STAGING_URL}
    ...         ELSE IF    '${env}' == 'test1'    Set Variable    ${TEST1_URL}
    ...         ELSE    Set Variable    https://${env}.tagesspiegel.de
    RETURN    ${url}

Launch Browser
    [Documentation]    
    ...    Launches a new browser instance with the specified configuration.This keyword iterates over a list of browsers defined in the `@{BROWSERS}` variable, and for each browser:
    ...    Opens a new browser instance using the `New Browser` keyword.
    ...    Sets up a new browser context with a specified viewport size.
 
    ${status}=    Run Keyword And Return Status    New Browser    ${DEFAULT_BROWSER}    headless=No
    Run Keyword If    ${status} == False    Log    Failed to launch the browser    console=True

    # Set up a new browser context with a specific viewport size
    New Context    viewport={'width': 1536, 'height': 729.60}

    Log    Browser launched    console=True
    

Open New Page
    [Documentation]
    ...   Opens a new browser page with the specified URL.
    ...   This keyword creates a new page in the browser and navigates to the provided URL.
    [Arguments]    ${url}

    ${status}=    Run Keyword And Return Status    New Page    ${url}
    Run Keyword If    ${status} == False    Log    Failed to open page with URL: ${url}    console=True

    Log    New page opened with URL: ${url}    console=True
    

Close Opened Browser
    [Documentation]    Closes opened browser

    # Close the browser
    ${status}=    Run Keyword And Return Status    Close Browser
    Run Keyword If    ${status} == False    Log    Failed to close the browser    console=True

    Log    Browser closed    console=True

Click Button
    [Documentation]    Clicks button based on the provided locator
    [Arguments]    ${button}
    
    # Click the button specified by the locator
    ${status}=    Run Keyword And Return Status    Click    ${button}
    Run Keyword If    ${status} == False    Log    Failed to click on ${button}    console=True

    Log    Clicked on ${button}    console=True

Verify Element Is Visible
    [Documentation]
    ...    This keyword checks whether the element identified by the provided locator is visible within the specified timeout period. 
    ...    If the element is not visible within the timeout, the keyword will fail, indicating that the element is not present or not visible.
    [Arguments]    ${element}

    # Wait for the element to become visible
    ${status}=    Run Keyword And Return Status    Wait For Elements State       ${element}    visible    timeout=15s
    Run Keyword If    ${status} == False    Log    Element ${element} not visible within timeout    console=True

    Log    Verified visibility of element: ${element}    console=True
    
Check Cookie Frame
    [Documentation]    Accepts cookie modal
    [Arguments]    ${iframe_selector}

    # Check if cookie modal iframe is present
    ${iframe_present}=  Run Keyword And Return Status  Get Element  ${iframe_selector}
    Run Keyword If  ${iframe_present}      Wait For Elements State      ${iframe_selector}  visible  20s

    # If cookie modal iframe is present, call accept and verify cookies keyword
    Run Keyword If  ${iframe_present}  Accept And Verify Cookies    ${iframe_selector}
    Run Keyword Unless  ${iframe_present}  Log  Iframe not found or not visible  console=True

Accept And Verify Cookies
    [Documentation]  Accepts the cookie modal and verifies the next element is visible.
    [Arguments]    ${iframe_num}

     # Switch to the iframe where the cookie modal is located
    Switch To Iframe    ${iframe_num} >>>
    
    # Click the accept button to handle the cookie modal
    ${element}=    Get Element    ${COOKIE_MODAL_ACCEPT_BUTTON}
    Click    ${element}

    Log    Cookies accepted    console=True