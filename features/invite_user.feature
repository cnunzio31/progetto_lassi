Feature: I want to invite user
    As master
    I want to invite users
    so that I add players to my session

Scenario: Master invite player
    Given I am on Session page that I created
    Given there at least one player to invite
    When I click on "Invite people"
    And I click on one of "Invite!" link
    Then I should be on the session page again
