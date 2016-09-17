require 'rails_helper'
 include Devise::TestHelpers
RSpec.describe WikisController, type: :controller do
let(:member_user) {create(:user, role: 0)}
let(:premium_user)  {create(:user, username: "xmember", email: "userx@factory.com", role: 1)}
let(:admin) {create(:user, username: "admin", role: 2)}
let(:new_wiki) {create(:wiki, private: false, user_id: member_user.id)}
let(:private_wiki) {create(:wiki, private: true, user_id: premium_user.id)}

  context "signed-in member user" do

    before do
      sign_in member_user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
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
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, id: new_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, id: new_wiki.id
        expect(response).to render_template :edit
      end

     it "assigns wiki to be updated to @wiki" do
        get :edit, id: new_wiki.id
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq new_wiki.id
        expect(wiki_instance.title).to eq new_wiki.title
        expect(wiki_instance.body).to eq new_wiki.body
      end
    end

    describe "PUT update" do
      it "updates new_wiki with new attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, id: new_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to [new_wiki]
      end
    end

    describe "DELETE destroy" do
      it "deletes the new_wiki" do
        delete :destroy, id: new_wiki.id
        count = Wiki.where({id: new_wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to the wiki index" do
        delete :destroy, id: new_wiki.id
        expect(response).to redirect_to :wikis
      end
    end
  end

  context "signed-in premium_user user" do

    before do
      sign_in premium_user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, id: private_wiki.id
        expect(response).to have_http_status(:success)
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
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, id: private_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, id: private_wiki.id
        expect(response).to render_template :edit
      end

     it "assigns wiki to be updated to @wiki" do
        get :edit, id: private_wiki.id
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq private_wiki.id
        expect(wiki_instance.title).to eq private_wiki.title
        expect(wiki_instance.body).to eq private_wiki.body
      end
    end

    describe "PUT update" do
      it "updates private_wiki with new attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, id: private_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to [private_wiki]
      end
    end

    describe "DELETE destroy" do
      it "deletes the new_wiki" do
        delete :destroy, id: private_wiki.id
        count = Wiki.where({id: private_wiki}).size
        expect(count).to eq 0
      end

      it "redirects to the wiki index" do
        delete :destroy, id: private_wiki.id
        expect(response).to redirect_to :wikis
      end
    end
  end

  context "signed-in admin user" do

    before do
      sign_in admin
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
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
      end
    end
    describe "GET #edit" do
      it "returns http success" do
        get :edit, id: new_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, id: new_wiki.id
        expect(response).to render_template :edit
      end

     it "assigns wiki to be updated to @wiki" do
        get :edit, id: new_wiki.id
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq new_wiki.id
        expect(wiki_instance.title).to eq new_wiki.title
        expect(wiki_instance.body).to eq new_wiki.body
      end
    end

    describe "PUT update" do
      it "updates new_wiki with new attributes" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, id: new_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to [new_wiki]
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, id: private_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, id: private_wiki.id
        expect(response).to render_template :edit
      end

     it "assigns wiki to be updated to @wiki" do
        get :edit, id: private_wiki.id
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq private_wiki.id
        expect(wiki_instance.title).to eq private_wiki.title
        expect(wiki_instance.body).to eq private_wiki.body
      end
    end

    describe "DELETE destroy" do
      it "deletes the new_wiki" do
        delete :destroy, id: private_wiki.id
        count = Wiki.where({id: private_wiki}).size
        expect(count).to eq 0
      end

      it "redirects to the wiki index" do
        delete :destroy, id: private_wiki.id
        expect(response).to redirect_to :wikis
      end

      it "deletes the new_wiki" do
        delete :destroy, id: new_wiki.id
        count = Wiki.where({id: new_wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to the wiki index" do
        delete :destroy, id: new_wiki.id
        expect(response).to redirect_to :wikis
      end
    end
  end
end