shared_examples "require sign in" do
  it "redirects to the signin page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to sign_in_path
  end
end