Given("I am on Session page that I created") do
    @master1=create(:master1)
    visit new_user_session_path
    fill_in "Email", :with => @master1.email
    fill_in "Password", :with => @master1.password
    click_button "Log in"
    @session1=create(:session1, master_id: @master1.id)
    visit session_path(@session1.id)
end
Given("there at least one player to invite") do
    @player1=create(:player1)
end

When /I click on "Invite people"/ do
    click_on("Invite people")
end

When /I click on one of "Invite!" link/ do
    click_on("Invite!")
end

Then("I should be on the session page again") do
    page.has_content?("Session: "+@session1.title)
end
