require 'spec_helper'

describe AdType do
  before do
    @ad_type = AdType.new(name: "example")
  end
  subject { @ad_type }
  it { should respond_to(:name) }

  describe "with blank content" do
    before { @ad_type.name = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @ad_type.name = "a" * 201 }
    it { should_not be_valid }
  end
end
