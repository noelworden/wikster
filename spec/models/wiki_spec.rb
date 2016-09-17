require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) {User.create!(username: "testerrrr", email: "x@gmail.com", password: "xxxxxx")}
  let(:wiki) {user.wikis.create!(title: "Test wiki", body: "This is the body of the test wiki", private: false)}


  describe "attributes" do
    it "has title and body attributes" do
      expect(wiki).to have_attributes(title: "Test wiki", body: "This is the body of the test wiki")
    end
  end

  describe "scopes" do
    before do

      @public_wiki = Wiki.create!(title: "public wiki", body: "This is the body of the public wiki")
      @private_wiki = Wiki.create!(title: "private wiki", body: "This is the body of the private wiki", private: true)
    end

    describe "visible_to(user)" do
      it "returns all wikis if the user is present" do
        user = User.new

        expect(Wiki.visible_to(user)).to eq (Wiki.all)
      end
    end
    describe "visible_to(nil)" do
      it "returns all public wikis if the no user is signed in" do
        user = nil
        expect(Wiki.visible_to(nil)).to eq ([@public_wiki])
      end
    end
  end
end
