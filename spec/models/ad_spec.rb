require 'spec_helper'

describe Ad do

  let(:user) { FactoryGirl.create(:user) }
  before { @ad = user.ads.build(content: "Sell a House") }

  subject { @ad }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Ad.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @ad.user_id = nil }
    it { should_not be_valid }
  end
end