Feature: I want to add like to a closed match
    As player
    I want to add like to a closed match
    so that it increases its like counter

Scenario: like a closed match
    Given I am on that session's closed matches page
    And There is at least one closed match in the session
    When I click on "Details"
    Given I am on the closed match page
    When I click on "Like!"
    Then I should see the like counter increased by one
