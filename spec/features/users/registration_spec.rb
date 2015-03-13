require "spec_helper"

describe "Signing up" do
	it "allows a user to sign up for the site and creates the object in the database" do
		expect(User.count).to eq(0)

		visit "/"
		expect(page).to have_content("Sign Up")
		click_link "Sign Up"

		fill_in "First name", with: "Syam"
		fill_in "Last name", with: "Palakurthy"
		fill_in "Email", with: "syamp@gmail.com"
		fill_in "Password", with: "check1234"
		fill_in "Password confirmation", with: "check1234"
		click_button "Sign Up"

		expect(User.count).to eq(1)

	end
end