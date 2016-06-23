require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) {User.create!(username: "testerrrr", email: "x@gmail.com", password: "xxxxxx")}
  let(:wiki) {user.wikis.create!(title: "Test wiki", body: "This is the body of the test wiki", private: false)}

  it{is_expected.to belong_to(:user)}

  describe "attributes" do
    it "has title and body attributes" do
      expect(wiki).to have_attributes(title: "Test wiki", body: "This is the body of the test wiki")
    end
  end
end

