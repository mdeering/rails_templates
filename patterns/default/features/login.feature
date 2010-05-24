Feature: Login
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

  Scenario: User is not signed up
    Given no user exists with an email of "email@person.com"
    When I go to the login page
    And I fill in "Email" with "email@person.com"
    And I fill in "Password" with "password"
    And I press "Login"
    Then I should see "Invalid email and password combination"
    And I should be signed out

  Scenario: User enters wrong password
    Given a user exists with email: "email@person.com", password: "password"
    When I go to the login page
    And I fill in "Email" with "email@person.com"
    And I fill in "Password" with "bad-password"
    And I press "Login"
    Then I should see "Invalid email and password combination"
    And I should be signed out

  Scenario: User signs in successfully
    Given a user exists with email: "email@person.com", password: "password"
    When I go to the login page
    And I fill in "Email" with "email@person.com"
    And I fill in "Password" with "password"
    And I press "Login"
    Then I should see "You have been successfully logged in"
    And I should be signed in
    And I should see "email@person.com"
    When I return next time
    Then I should be signed in

  Scenario: User submits the form blank.
    When I go to the login page
    And I press "Login"
    Then I should see "Invalid email and password combination"
    And I should be signed out

  Scenario: User submits the form blank.
    When I go to the login page
    And I fill in "Email" with "email@person.com"
    And I press "Login"
    Then I should see "Invalid email and password combination"
    And I should see "cannot be blank"
    And I should be signed out