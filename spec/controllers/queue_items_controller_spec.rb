require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets queue items to the queue items of the logged in user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "should redirect to signin page for unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST create" do
    it "It should redirect to my_queue page" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    it "should also create a queue item" do 
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eql(1)
    end

    it "creates the queue item that is associated with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eql(video)    
    end

    it "creates the queue item that is associated with the user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eql(alice)   
    end

    it "puts the video as the last item" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: alice)
      south_park = Fabricate(:video)
      post :create, video_id: south_park.id
      south_park_queue_item = QueueItem.where(video_id: south_park.id, user_id: alice.id).first
      expect(south_park_queue_item.position).to eq(2)  
    end

    it "should not add the video if its already in the queue" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: alice)
      post :create, video_id: monk.id
      expect(QueueItem.count).to eql(1)
    end

    it "redirect to signin for unauthenticated users" do
      post :create, video_id: 3
      expect(response).to redirect_to sign_in_path
    end

  end

end