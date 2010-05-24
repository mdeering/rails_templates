Given /^I signed up with "(.*)\/(.*)"$/ do |email, password|
  user = Factory :user,
    :admin => false,
    :email => email,
    :password => password,
    :password_confirmation => password
end

Given /^I have an admin account with "(.*)\/(.*)"$/ do |email, password|
  user = Factory :user,
    :admin => true,
    :email => email,
    :password => password,
    :password_confirmation => password
end

Given /^no user exists with an email of "(.*)"$/ do |email|
  assert_nil User.find_by_email(email)
end

Then /^I should be signed in$/ do
  controller.send(:logged_in?).should be_true
end

Then /^I should be signed out$/ do
  controller.send(:logged_in?).should be_false
end

When /^I return next time$/ do
  When %{session is cleared}
  And %{I go to the homepage}
end

When /^session is cleared$/ do
  request.reset_session
  controller.instance_variable_set(:@_current_user, nil)
end