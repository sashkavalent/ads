require 'spec_helper'

describe Photo do
  before do
    @ad_type = AdType.new(name: 'example')
  end
  subject { @ad_type }
  it { should respond_to(:name) }
end
