Given("I am an authenticated user") do
    @player1=create(:player1)
    visit new_user_session_path
    fill_in "Email", :with => @player1.email
    fill_in "Password", :with => @player1.password
    click_button "Log in"
end

Given("I am on the home page") do
    page.has_content?("Player: "+@player1.username)
end

When /I click on "Log out"/ do
    click_on("Log out")
end

Then("I should be not authenticated") do
    page.has_content?("Log in")
end
