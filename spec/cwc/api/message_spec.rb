require 'spec_helper'

describe Cwc::Api::Message do
  #Configure initial values
  before(:all) do
    Cwc.test_settings false
    @example_data ||= Cwc::Api::Message.example_data
  end

  context "when creating" do
    it "should receive data as a hash" do
      message = Cwc::Api::Message.new
      message.data = @example_data
      expect(message.data).to eq(@example_data)
    end

    it "should accept initialization as a block" do
      message = Cwc::Api::Message.new do |m|
        m.data = @example_data
      end
      expect(message.data).to eq(@example_data)
    end
  end

  context "with complete data" do
    before(:all) do
      @message = Cwc::Api::Message.new(@example_data)
    end

    it "should be able to convert data into XML" do
      xml = @message.get_data_xml
      expect(xml).not_to be_nil
    end
  end

  context "with incomplete data" do
    before(:all) do
      @message = Cwc::Api::Message.new(@example_data)
      @message.data[:delivery] = { incomplete: "it is" }
    end

    it "should throw an error when obtaining the XML" do
      expect{ @message.get_xml }.to raise_error
    end
  end
  
end
