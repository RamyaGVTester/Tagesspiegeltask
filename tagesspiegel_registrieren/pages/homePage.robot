*** Settings ***
Library    Browser
Library    BuiltIn
Resource   ../pages/basePage.robot
Variables  ../locators/homePageLocators.py

*** Keywords ***
Open Home Page
    [Documentation]    Calls Set Environment URL and Open New Page keywords 
    [Arguments]    ${env}
    Log    Environment: ${env}
    ${url}=    Set Environment URL    ${env}
    Log    Trying to open URL: ${url}
    Open New Page    ${url}

    
