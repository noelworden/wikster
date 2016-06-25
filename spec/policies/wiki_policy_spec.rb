require 'rails_helper'

describe WikiPolicy do
  subject {WikiPolicy.new(user, wiki)}
  let(:user) {User.create!(username: "testerrrr", email: "x@gmail.com", password: "xxxxxx")}
  let(:wiki) {user.wikis.create!(title: "Test wiki", body: "This is the body of the test wiki", private: false)}

  context "for a visitor" do
    let (:user) {nil}
    it {is_expected.to forbid_action(:destroy)}
  end
  context "for a user" do
    let(:userb) {User.create!(username: "b-testerrrr", email: "b-x@gmail.com", password: "xxxxxx")}

    it {is_expected.to forbid_action(:index)}
    #it {is_expected.to permit_action(:destroy)}


  end

end