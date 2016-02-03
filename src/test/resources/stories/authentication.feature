Feature: Authentication
  In order to protect sensitive user data
  As an application owner
  I want to have a robust authentication system

  @cwe-178-auth @id-auth_case
  Scenario: Passwords should be case sensitive
    Given a new browser or client instance
    When the default user logs in
    Then the user is logged in
    When the case of the password is changed
    And the authentication tokens on the client are deleted
    And the login page is displayed
    And the user logs in
    Then login fails

  @browser_only @cwe-295-auth @id-auth_login_form_over_ssl
  Scenario: Present the login form itself over an HTTPS connection
    Given a new browser instance
    And the client/browser is configured to use an intercepting proxy
    And the proxy logs are cleared
    And the HTTP request-response containing the login form
    Then the protocol should be HTTPS

  @cwe-319-auth @id-auth_https
  Scenario: Transmit authentication credentials over HTTPS
    Given a new browser or client instance
    And the client/browser is configured to use an intercepting proxy
    And the proxy logs are cleared
    When the default user logs in with default credentials
    And the HTTP request-response containing the default credentials is selected
    Then the protocol should be HTTPS

  @browser_only @cwe-525-repost @id-auth_return_redirect
  Scenario: When authentication credentials are sent to the server, it should respond with a 3xx status code.
    Given a new browser instance
    And the client/browser is configured to use an intercepting proxy
    And the proxy logs are cleared
    When the default user logs in with default credentials
    And the HTTP request-response containing the default credentials is selected
    Then the response status code should start with 3

  @browser_only @cwe-525-autocomplete-form @id-auth_autocomplete_login_form
  Scenario: Disable browser auto-completion on the login form
    Given a new browser instance
    And the login page is displayed
    When the login form is inspected
    Then it should have the autocomplete attribute set to 'off'

  @browser_only @cwe-525 @id-auth_autocomplete_password @skip
  Scenario: Disable browser auto-completion on the password field
    Given a new browser instance
    And the login page is displayed
    When the password field is inspected
    Then it should have the autocomplete attribute set to 'off'

  @id-auth_lockout @skip
  Scenario: Lock the user account out after 4 incorrect authentication attempts
    Given a new browser or client instance
    And the default username from: auto-generated/users.table
    And an incorrect password
    And the user logs in from a fresh login page 4 times
    When the default password is used from: auto-generated/users.table
    And the user logs in from a fresh login page
    Then the user is not logged in

  @browser_only @id-auth_login_captcha @skip
  Scenario: Display a Captcha after 4 failed authentication attempts
    Given a new browser instance
    And the default username from: auto-generated/users.table
    And an incorrect password
    And the user logs in from a fresh login page 4 times
    When the login page is displayed
    Then the CAPTCHA is displayed