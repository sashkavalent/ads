require 'spec_helper'

describe Ad do

  let(:user) { FactoryGirl.create(:user) }
  before { @ad = user.ads.build(content: 'Sell a House', ad_type_id: 1) }

  subject { @ad }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:ad_type_id) }
  it { should respond_to(:user) }
  it { should respond_to(:state) }
  its(:user) { should == user }

  it { should be_valid }

  describe 'accessible attributes' do
    it 'should not allow access to user_id' do
      expect do
        Ad.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe 'when user_id is not present' do
    before { @ad.user_id = nil }
    it { should_not be_valid }
  end

  describe 'with blank content' do
    before { @ad.content = ' ' }
    it { should_not be_valid }
  end

  describe 'with content that is too long' do
    before { @ad.content = 'a' * 201 }
    it { should_not be_valid }
  end

  describe 'with content that is not set of words' do
    before { @ad.content = 'Sf$# fds%' }
    it { should_not be_valid }
  end
end
