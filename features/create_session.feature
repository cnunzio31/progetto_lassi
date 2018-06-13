Feature: I want to create a new Session
    As master
    I want to create a new session
    so that I play with other players

Scenario: Create Session
    Given I am an authenticated master
    And I am on the master home page
    When I click on "Create a new sessions"
    Given I filled the form
    When I click on "Create session"
    Given I am again on the master home page
    When I click on "Created sessions"
    Then I should see the created session
