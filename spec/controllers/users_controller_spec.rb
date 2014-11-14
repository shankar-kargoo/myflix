require 'spec_helper'
describe UsersController do
  describe "GET new" do 
    it "Set @user for new users" do 
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
  describe "POST create" do 
    context "with valid input" do
      before {post :create, user: Fabricate.attributes_for(:user)}
      it "create the user" do 
        expect(User.count).to eq(1)
      end
      it "redirect to the sign in page" do 
        expect(response).to redirect_to home_path
      end
    end
    context "invalid input" do 
      before {post :create, user: {password: "password", full_name: "User ten"}}
      it "does not create user" do
        expect(User.count).to eq(0)
      end
      it "renders the new page again" do 
        expect(response).to render_template :new
      end
      it "sets the @user variable" do 
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end

