require 'rails_helper'
 include Devise::TestHelpers
RSpec.describe WikisController, type: :controller do
let(:new_wiki) {Wiki.create!(title: "New Title", body: "Body of the new test wiki.")}
let(:user) {User.create!(username: "noemm", email: "noemm@noel.com", password: "password", password_confirmation: "password", confirmed_at: Time.now)}


  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      # sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns new_wiki to @wikis" do
      get :index
      expect(assigns(:wikis)).to eq([new_wiki])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: new_wiki.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "increases the number of Wiki by 1" do
      expect{ post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Wiki,:count).by(1)
      p Wiki.last
    end
  end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
