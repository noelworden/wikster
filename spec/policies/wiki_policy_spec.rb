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