require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "Automatic Authentication at Signup" do

  it "automatically authenticates a new user upon signup" do
    valid_user = FactoryGirl.build(:user)
    expect(logged_in?).to be_falsy
    post :create, user: { email: valid_user.email, password: valid_user.password, password_confirmation: valid_user.password_confirmation }    
    expect(logged_in?).to be_truthy
  end

  end

  describe "User Updating" do

    it "does not allow an unauthenticated user to send a PATCH or PUT request to users#update" do
      expect(logged_in?).to be_falsy
      patch :update, { id: 1 , user: { email: "updated_email_attempt@gmail.com", password: "updated_password_attempt", password_confirmation: "updated_password_attempt" } } 
      expect(response).to redirect_to(login_path)    
      put :update, { id: 1 , user: { email: "updated_email_attempt@gmail.com", password: "updated_password_attempt", password_confirmation: "updated_password_attempt" } }
      expect(response).to redirect_to(login_path)   
    end

  end

  describe "User Deleting" do

    it "does not allow an unauthenticated user to send a DELETE request to users#destroy" do
      expect(logged_in?).to be_falsy
      delete :destroy, { id: 1 } 
      expect(response).to redirect_to(login_path) 
    end

  end

end
