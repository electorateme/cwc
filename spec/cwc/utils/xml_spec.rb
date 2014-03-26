require 'spec_helper'

class DummyClass
end

describe Cwc::Utils::XML do
  before(:all) do
    @xml = DummyClass.new
    @xml.extend(Cwc::Utils::XML)
  end
  before(:each) do
    @example_data ||= Cwc::Api::Message.example_data
  end

  context "with incomplete data" do
    it "should throw an XMLSyntaxError showing which field generated the error" do
      @example_data[:delivery] = {some: "error"}
      expect{
        @xml.parse_xml(@example_data)
      }.to raise_error Cwc::XMLSyntaxError
    end
  end

  context "with complete data" do
    it "should render it properly to XML" do
      expect(@xml.parse_xml(@example_data)).to be_a String
    end
  end

end