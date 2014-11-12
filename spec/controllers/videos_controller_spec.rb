require 'spec_helper'

describe VideosController do

  describe "GET show" do
    it "sets @video for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eql(video)
    end

    # it "renders the show template" do 
    #   video = Fabricate(:video)
    #   get :show, id: video.id
    #   expect(response).to render_template :show
    # end

    it "redirects users to sign in page for unauthenticated users" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST search" do
    it "sets @results for authenticated users" do 
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: 'Futurama')
      futurama2 = Fabricate(:video, title: 'Futurama')
      post :search, search_term: 'rama'
      expect(assigns(:results)).to  match_array([futurama2, futurama])
    end

    it "redirects to sign in page for unauthenticated users" do
      futurama = Fabricate(:video, title: "Futurama")
      post :search, search_term: 'rama'
      expect(response).to redirect_to sign_in_path 
    end
  end

end
