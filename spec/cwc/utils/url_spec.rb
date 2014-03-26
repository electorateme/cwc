require 'spec_helper'

class DummyClass
end

describe Cwc::Utils::URL do
  before(:all) do
    @url = DummyClass.new
    @url.extend(Cwc::Utils::URL)
  end

  context "without trailling slash" do
    before(:each) do
      @string_before = "http://with.trailing.com"
      @string_after = "http://with.trailing.com/"
    end
    it "should add it" do
      expect(@url.add_trailing_slash(@string_before)).to eq(@string_after)
    end
  end

  context "with trailing slash" do
    before(:each) do
      @string_before = "http://with.trailing.com/"
      @string_after = "http://with.trailing.com/"
    end

    it "should do nothing" do
      expect(@url.add_trailing_slash(@string_before)).to eq(@string_after)
    end
  end

end