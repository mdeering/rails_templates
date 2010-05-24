Feature: Dashboard
  In order to administer the application
  A administrator
  Should be able access the dashboard

  Scenario: Admins should be taken to the dashboard after login
    Given I have an admin account with "email@person.com/password"
    When I go to the login page
    And I fill in "Email" with "email@person.com"
    And I fill in "Password" with "password"
    And I press "Login"
    Then I should see "You have been successfully logged in"
    And I should be signed in
    And I should see "Nervecenter"

  Scenario: Only admins should be allowed to access the nervecenter
    Given I signed up with "email@person.com/password"
    When I go to the login page
    And I fill in "Email" with "email@person.com"
    And I fill in "Password" with "password"
    And I press "Login"
    And I should be signed in
    When I go to the nervecenter
    And I should not see "Nervecenter"