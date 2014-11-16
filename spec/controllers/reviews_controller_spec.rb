require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    context "with authenticated users" do
      let(:current_user) {Fabricate(:user)}
      before {session[:user_id] = current_user.id}

      context "with valid input" do
        before do 
          @video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: @video.id
        end

        it "redirects user to video show page" do 
          expect(response).to redirect_to @video
        end

        it "creates a review" do 
          expect(Review.count).to eql(1)
        end

        it "creates a review associated with the video" do 
          expect(Review.first.video).to eq(@video)
        end

        it "creates a review assocaiated with the signed in user" do 
          expect(@video.reviews.first.user).to eq(current_user)
        end
      end

      context "with invalid inputs" do
        before do 
          @video = Fabricate(:video)
          post :create, review: {rating: 4}, video_id: @video.id
        end
        it "does not create a review" do
          expect(Review.count).to eql(0)
        end
        it "renders the video/show template" do
          expect(response).to render_template "videos/show"
       end
        it "sets @videos" do 
          expect(assigns(:video)).to eq(@video)
        end
      end

      context "with invalid inputs" do
        it "sets @review" do
          @video = Fabricate(:video)
          review = Fabricate(:review, video: @video)
          post :create, review: {rating: 4}, video_id: @video.id
          expect(assigns(:reviews)).to match_array([review])
        end
      end
    end

    context "with unauthenticated users" do
      it "redirects to the signin path" do
         @video = Fabricate(:video)
         post :create, review: Fabricate.attributes_for(:review), video_id: @video.id
         expect(response).to redirect_to sign_in_path
      end

    end

  end
end
