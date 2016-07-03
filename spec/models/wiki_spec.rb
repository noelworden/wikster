require 'rails_helper'

# include SessionsHelper

RSpec.describe Wiki, type: :model do
  let(:user) {User.create!(username: "testerrrr", email: "x@gmail.com", password: "xxxxxx")}
  let(:wiki) {user.wikis.create!(title: "Test wiki", body: "This is the body of the test wiki", private: false)}

  # it {is_expected.to belong_to(:user)}

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
    # describe "visible_to(admin)" do
    #   it "returns all wikis for the admin" do
    #     user = User.new
    #     user.update_attribute(:role, 2)
    #     expect(Wiki.visible_to(admin)).to eq (Wiki.all)
    #   end
    # end
  end
end
