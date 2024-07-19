# Robot Framework Test Automation Suite

## Quick Start

You can run the registrationTest.robot test case on different environments by specifying the env parameter. This allows you to test the application on production, staging, or test1 environments. Here’s how to use the parameter:

To run the test on the Production environment:
```bash
cd tagesspiegel_registrieren
robot -v env:prod tests/registrationTest.robot
```

To run the test on the Test1 environment:
```bash
cd tagesspiegel_registrieren
robot -v env:test1 tests/registrationTest.robot
```

To run the test on the Staging environment:
```bash
cd tagesspiegel_registrieren
robot -v env:staging tests/registrationTest.robot
```

## Framework Overview

This repository contains a comprehensive test automation suite using Robot Framework and Page Object Model (POM) design pattern. The suite is designed to test the registration process of a web application, including user registration, email verification, password setting, and profile verification. The framework leverages the Browser library for web interactions and RPA.Email.ImapSmtp for email operations.

### Directory Structure
```bash
tagesspiegel_registrieren/
│
├── resources/
│   ├── variables.robot         # Global variables used across tests
│
├── locators/
│   ├── basePageLocators.py     # Locators common to multiple pages
│   ├── homePageLocators.py     # Locators for the home page
│   ├── registrationPageLocators.py # Locators for the registration page
│   ├── passwordFormPageLocators.py # Locators for the password form page
│   ├── profilePageLocators.py  # Locators for the profile page
│
├── pages/
│   ├── basePage.robot          # Base page with common keywords for all pages
│   ├── homePage.robot          # Page Object for the home page
│   ├── registrationPage.robot  # Page Object for the registration page
│   ├── passwordFormPage.robot  # Page Object for the password form page
│   ├── profilePage.robot       # Page Object for the profile page
│   ├── emailPage.robot         # Page Object for handling email operations
│
├── tests/
│   ├── registrationTest.robot  # Test case for verifying the registration process

README.md                   # Documentation for the framework
```

## Supported Browsers

The test suite supports execution across the following browsers:

- **Chromium**
- **Firefox**
- **WebKit**


## Setup

Install dependencies

Ensure you have the following packages installed:

1. **Install Python:**
   - Ensure you have Python installed on your system. Robot Framework requires Python 3.6 or later.
   - You can download and install Python from the [official website](https://www.python.org/downloads/).

   - Verify the installation by running:
   python --version

2. **Install robotframework**
    ```bash
    pip install robotframework
    ```

3. **Install robotframework-browser**
    ```bash
    pip install robotframework-browser
    ```
    - After installation, initialize the library with: 
    ```bash
    rfbrowser init
    ```

4. **Install rpaframework** (for email handling)
    ```bash
    pip install rpaframework
    ```

## Test Cases

**Verify Registration Process**

The registrationTest.robot file contains a test case named "Verify Registration Process". This test case covers:

This test case ensures that the entire user registration process works as expected on the website. It tests the following:

**Browser Initialization:** Starts a new browser instance and sets it up.

**Registration:** Navigates to the home page, handles any cookie consent modals, and opens the registration form. It then fills out the registration form with a randomly generated email and user details, submits the form, and handles any subsequent modals.

**Email Verification:** Waits for a confirmation email, retrieves the verification link, and uses it to set up a password.

**Login and Logout:** Verifies that the user can log in with the new credentials, checks the profile page to confirm successful login, and finally ensures that logging out works correctly.


## Test Reports

After executing the tests, you will find the following files in the root directory:

**log.html:** This file contains detailed logs of the test execution. It provides information about the steps taken during the test run, including success and failure details, and any messages logged during the test.

**report.html:** This file is the execution report that summarizes the test results. It includes overall test statistics, such as the number of tests passed, failed, or skipped, and provides a high-level overview of the test execution.
