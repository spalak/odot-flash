require 'spec_helper'

describe UserSessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "shows the correct template" do
      get 'new'
      expect(response).to render_template('new')
    end
  end


  describe "POST 'create'" do
    context "with correct credentials" do
      let!(:user){User.create(first_name: "Syam",
                           last_name: "Palakurthy",
                           email: "syam@gmail.com",
                           password: "password", 
                           password_confirmation: "password")}
      it "redirects to the todo list path" do
        post :create, email: "syam@gmail.com", password: "password"
        expect(response).to be_redirect
        expect(response).to redirect_to(todo_lists_path)
      end

      it "finds the user" do
        expect(User).to receive(:find_by).with({:email => "syam@gmail.com"}).and_return(user)
        post :create, email: "syam@gmail.com", password: "password"
      end

      it "authenticates the user" do
        User.stub(:find_by).and_return(user)
        expect(user).to receive(:authenticate)
        post :create, email: "syam@gmail.com", password: "password"
      end

      it "sets the user_id in the session" do
        post :create, email: "syam@gmail.com", password: "password"
        expect(session[:user_id]).to eq(user.id)
      end

      it "thanks people for logging in" do
        post :create, email: "syam@gmail.com", password: "password"
        expect(flash[:success]).to eq("Thanks for logging in")
      end
    end

    context "with blank credentials" do
      it "renders the blank template" do
        post :create
        expect(response).to render_template('new')
      end

      it "show the error message if the login was not successful" do
        post :create
        expect(flash[:error]).to eq("There was a problem logging in.  Please check your password and username")
      end  
    end

  end

end
