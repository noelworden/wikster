require 'rails_helper'

describe WikiPolicy do
  subject {WikiPolicy.new(user, wiki)}

  let(:wiki) {FactoryGirl.create(:wiki)}

  context "for a visitor" do
    let (:user) {nil}
    it {is_expected.to permit_action(:index)}
    it {is_expected.to permit_action(:show)}
    it {is_expected.to forbid_action(:edit)}
    it {is_expected.to forbid_action(:update)}
    it {is_expected.to forbid_action(:destroy)}
  end
  context "for a user on random wiki" do
    let(:user) {FactoryGirl.create(:user)}

    it {is_expected.to permit_action(:index)}
    it {is_expected.to permit_action(:show)}
    it {is_expected.to forbid_action(:edit)}
    it {is_expected.to forbid_action(:update)}
    it {is_expected.to forbid_action(:destroy)}
  end

  context "for a user on their wikis" do
    let(:user) {FactoryGirl.create(:user)}
    let(:wiki) {user.wikis.create!(title: "Test wiki", body: "This is the body of the test wiki", private: false)}

    it {is_expected.to permit_action(:index)}
    it {is_expected.to permit_action(:show)}
    it {is_expected.to permit_action(:edit)}
    it {is_expected.to permit_action(:update)}
    it {is_expected.to permit_action(:destroy)}
  end

  #### attempting to test for user on others private wiki, but its not a pundit issue, because it is scoped
  # context "for a user on other user private wiki" do
  #   let(:user) {FactoryGirl.create(:user)}
  #   let(:wiki) {Wiki.create!(title: "Test wiki", body: "This is the body of the test wiki", private: true)}

  #   it {is_expected.to permit_action(:index)}
  #   it {is_expected.to forbid_action(:show)} #this should be forbid
  #   it {is_expected.to forbid_action(:edit)}
  #   it {is_expected.to forbid_action(:update)}
  #   it {is_expected.to forbid_action(:destroy)}
  # end

  context "for an admin on any wiki" do
    let(:user) {FactoryGirl.create(:user)}
    before do
      user.admin!
    end
    it {is_expected.to permit_action(:index)}
    it {is_expected.to permit_action(:show)}
    it {is_expected.to permit_action(:edit)}
    it {is_expected.to permit_action(:update)}
    it {is_expected.to permit_action(:destroy)}
  end
end