*** Settings ***
Library    RPA.Email.ImapSmtp
Library    BuiltIn
Library    String
Resource   ../resources/variables.robot


*** Keywords ***
Wait For Registration Email
    [Documentation]    Waits for Registration confirmation email
    [Arguments]    ${email}    ${email_pwd}    ${email_server}    ${port}    ${subject}

    # Brief pause to ensure email has time to arrive
    sleep    7s

    # Log email and password for debugging purposes
    Log    Email : ${EMAIL}@${EMAIL_DOMAIN}    console=True
    Log    Password: ${EMAIL_PWD}    console=True

    # Authorize IMAP connection using provided credentials
    Authorize IMAP    ${EMAILID}    ${EMAIL_PWD}    ${EMAIL_SERVER}    ${IMAP_PORT}
    
    # Wait for the email with the specified subject
    ${result}    Wait For Message  SUBJECT "${EMAIL_SUBJECT}"  timeout=300  interval=10

    Log    Received Registration email    console=True
    RETURN    ${result}


Get Registration Link From Email
    [Documentation]    Parses the Mail
    [Arguments]    ${search_result}    ${registered_email}    ${email_from}    ${url_regexp}

    # Convert registered email to lowercase
    ${lowercase_registered_email}=    Convert To Lower Case    ${registered_email}

    ${verification_link}=    Set Variable    None

    # Iterate through the search results to find the relevant email
    FOR    ${message}    IN    @{search_result}
        ${from_email}=    Get From Dictionary    ${message}    From
        ${to_email}=    Get From Dictionary    ${message}    To
        ${condition}=    Evaluate    '${from_email}' == '${email_from}' and '${to_email}' == '${lowercase_registered_email}'
        IF    ${condition}
            ${body_value}=    Get From Dictionary    ${message}    Body
            ${verification_link}=    Extract Verification Link  ${body_value}    ${url_regexp}
            IF    '${verification_link}' == 'None'
                Log    No verification link found in the email body.    console=True
            ELSE
                Log    Verification link found: ${verification_link}    console=True
            END
            Exit For Loop
        END
    END
    Run Keyword If    '${verification_link}' == 'None'    Log    No email matching the criteria was found.    console=True
    RETURN    ${verification_link}

Extract Verification Link
    [Documentation]    Extracts verification link from the Email
    [Arguments]    ${mail_body}    ${url_regexp}

    ${found_link}=    Set Variable    None

    # Use regular expression to find all matching URLs in the email body
    ${urls}=    Evaluate    re.findall(r"${url_regexp}", """${mail_body}""")

    ${urls_length}=    Get Length    ${urls}

    # Log if no matching links were found
    Run Keyword If    ${urls_length} == 0    Log    No matching links found in the email body.    console=True
    Run Keyword If    ${urls_length} > 0    Log    Matching links found: ${urls}    console=True    
    
    # If at least one link is found, store the first one
    IF    ${urls_length} > 0
        ${found_link}=    Get From List    ${urls}    0
        Log    Found link: ${found_link}    console=True
    END
    
    # Return the extracted link
    RETURN    ${found_link}