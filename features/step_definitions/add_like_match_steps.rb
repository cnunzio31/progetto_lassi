Given("I am on that session's closed matches page") do
    @master1=create(:master1)
    @player1=create(:player1)
    visit new_user_session_path
    fill_in "Email", :with => @player1.email
    fill_in "Password", :with => @player1.password
    click_button "Log in"
    @session1=create(:session1, master_id: @master1.id)
    visit session_matches_path(@session1.id)
end

Given("There is at least one closed match in the session") do
    @match1=create(:match1, session_id: @session1.id, status: false)
    visit session_matches_path(@session1.id)
end

When /I click on "Details"/ do
    click_on("Details")
end

Given("I am on the closed match page and i have partecipated to that match") do
    @p=create(:partecipationmatch1, session_id: @session1.id, match_id: @match1.id, player_id: @player1.id)
    visit session_match_path(@session1.id,@match1.id)
end

When /I click on "Like!"/ do
    click_on("Like!")
end

Then("I should see the like counter increased by one") do
  expect(page).to have_content("Like: 1")
end
