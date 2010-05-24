Feature: Signup
  In order to create an account for use with the application
  A user
  Should be able to sign up for an account

  Scenario: User is not signed up
    Given no user exists with an email of "email@person.com"
    When I go to the signup page
    And I fill in "Email" with "email@person.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Signup"
    Then I should see "Your account has been successfully created."
    And I should be signed in

  Scenario: User tries to signup under an existing accounts email.
    Given I signed up with "email@person.com/password"
    When I go to the signup page
    And I fill in "Email" with "email@person.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Signup"
    Then I should see "has already been taken"
    And I should be signed out