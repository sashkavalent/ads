require 'spec_helper'

describe AdType do
  before do
    @ad_type = AdType.new(name: "example")
  end
  subject { @ad_type }
  it { should respond_to(:name) }

  describe "when user_id is not present" do
    before { @ad.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @ad.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @ad.content = "a" * 201 }
    it { should_not be_valid }
  end
end
