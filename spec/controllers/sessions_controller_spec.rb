require 'spec_helper'

describe SessionsController do
  describe "GET new" do 
    it "renders new template for unauthenticated users" do 
      get :new
      expect(response).to render_template :new
    end
    it "renders home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end
  describe "POST create" do 
    
    context "with valid credentials" do
      before do
        @alice = Fabricate(:user)
        post :create, email: @alice.email, password: @alice.password
      end
      it "sets session to the current user" do
        expect(session[:user_id]).to eql(@alice.id)
      end
      it "sucessful login redirects to home page" do 
        expect(response).to redirect_to home_path
      end
      it "sets the notice" do
        expect(flash[:notice]).not_to be_blank
      end
    end
    
    context "with invalid credentials" do
      before do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password + 'adsf'
      end
      it "expect session id to be null" do
        expect(session[:user_id]).to be_blank
      end
      it "unsucessful login renders new teplate" do 
        expect(response).to redirect_to sign_in_path
      end
      it "sets the notice" do
        expect(flash[:error]).not_to be_blank
      end
    end
  end

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "clears the session for the user" do 
      expect(session[:user_id]).to be_blank
    end

    it "redirects the user to root path" do 
      expect(response).to redirect_to root_path
    end

    it "sets notice" do 
      expect(flash[:notice]).not_to be_blank
    end
  end

end
