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

  describe "DELETE destroy" do
    it "redirects user to my_queueu page" do 
      alice = Fabricate(:user)
      video = Fabricate(:video)
      session[:user_id] = alice.id
      queue_item = Fabricate(:queue_item, user: alice, video: video)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end

    it "deletes the queue item" do
      alice = Fabricate(:user)
      video = Fabricate(:video)
      session[:user_id] = alice.id
      queue_item = Fabricate(:queue_item, user: alice, video: video)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end

    it "normalized the remaining queue items" do
      alice = Fabricate(:user)
      video = Fabricate(:video)
      session[:user_id] = alice.id
      queue_item1 = Fabricate(:queue_item, user: alice, video: video)
      queue_item2 = Fabricate(:queue_item, user: alice, video: video)
      queue_item3 = Fabricate(:queue_item, user: alice, video: video)
      delete :destroy, id: queue_item2.id
      expect(queue_item3.position).to eq(2)
    end

    it "only deletes queue items for the current user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      video = Fabricate(:video)
      queue_item1 = Fabricate(:queue_item, user: bob, video: video)
      session[:user_id] = alice.id
      delete :destroy, id: queue_item1.id
      expect(QueueItem.count).to eq(1)
    end

    it "redirect_to signin page for unauthenticated users" do
      delete :destroy, id: 3
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST update" do
    context "with valid input" do
      it "redirects to my queue page" do
        alice = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, video: video)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it "reorder the queue items" do
        alice = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, video: video)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video)
        queue_item3 = Fabricate(:queue_item, user: alice, video: video)
        post :update_queue, queue_items: [{id: queue_item3.id, position: 1}, {id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
        expect(alice.queue_items).to eq([queue_item3, queue_item2, queue_item1])
      end

      it "should normalize the position numbers" do
        alice = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, video: video)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video)
        queue_item3 = Fabricate(:queue_item, user: alice, video: video)
        post :update_queue, queue_items: [{id: queue_item3.id, position: 4}, {id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
        expect(alice.queue_items.map(&:position)).to eq([1, 2, 3])
      end
    end

    context "with invalid input" do
      it "redirects to the my_queue page" do
        alice = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, video: video)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.4}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it "sets the flash error message" do
        alice = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, video: video)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.4}, {id: queue_item2.id, position: 1}]
        expect(flash[:error]).not_to be_blank
      end

      it "does not change the queue items" do
        alice = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, video: video)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1.5}]
        expect(response).to redirect_to my_queue_path
      end
    end

    context "with unauthenticated users" do
      it "redirects unauth user to signin page" do
        post :update_queue, queue_items: [{id: 2, position: 3}, {id: 1, position: 1}]
        expect(response).to redirect_to sign_in_path
      end
    end


    context "with queue items that do not belong to current users" do
      it "does not change the queue items" do
        alice = Fabricate(:user)
        bob = Fabricate(:user)
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, video: video1)
        queue_item2 = Fabricate(:queue_item, user: bob, video: video2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end

  end

end
