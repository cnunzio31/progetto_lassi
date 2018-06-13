Given("I am an authenticated master") do
    @master1=create(:master1)
    visit new_user_session_path
    fill_in "Email", :with => @master1.email
    fill_in "Password", :with => @master1.password
    click_button "Log in"
end

Given("I am on the master home page") do
    page.has_content?("Master: "+@master1.username)
end

When /I click on "Create a new sessions"/ do
    click_on("Create a new sessions")
end

Given("I filled the form") do
    @session1=create(:session1)
    fill_in "Title", :with => @session1.title
    fill_in "Location", :with => @session1.location
    fill_in "Description", :with => @session1.description
    fill_in "Version", :with => @session1.version
end

When /I click on "Create session"/ do
    click_on("Create session")
end

Then("I should be on the created session page") do
    page.has_content?("Session: "+@session1.title)
end
