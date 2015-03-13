require 'spec_helper'

describe User do
  let (:valid_attributes) {
  	{
	  	:first_name => "Syam",
	  	:last_name => "Palakurthy",
	  	:email => "syamp@gmail.com",
	  	:password => "testpass",
	  	:password_confirmation => "testpass"
  	}

  }

  context "validations" do
  	let (:user) {User.new(valid_attributes)}

  	before do
  		User.create(valid_attributes)
  	end

  	it "requires an email" do
  		expect(user).to validate_presence_of(:email)
  	end

  	it "requires a unique email" do
  		expect(user).to validate_uniqueness_of(:email)
  	end

  	it "requires a unique case-insensitive email" do
  		user.email = "SYAM@GMAIL.COM"
  		expect(user).to validate_uniqueness_of(:email)
  	end

  	it "requires an email to look like an email" do
  		user.email = "syam"
  		expect(user).to_not be_valid
  	end
  end

  	describe "#downcase_email" do
  		it "makes the email attribute lower case" do
  			user = User.new(valid_attributes.merge(email: "SYAM@GMAIL.COM"))
  			user.downcase_email
  			expect(user.email).to eq("syam@gmail.com")
  		end

	  	it "downcases an email before saving" do
	  		user = User.new(valid_attributes)
	  		user.email = "SYAM@GMAIL.COM"
	  		expect(user.save).to be_true
	  		expect(user.email).to eq("syam@gmail.com")
	  	end
	end
end
