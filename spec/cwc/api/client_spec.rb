require 'spec_helper'

describe Cwc::Api::Client do
  #Configure initial values
  before(:all) do
    Cwc.test_settings false
    @client = Cwc::Api::Client.new
    @testing_options = {
      ssl: false,
      verbose: false,
    }
  end

  context "with server responding correctly" do
    before(:all) do
      @url = "http://www.google.com"
    end
    it "should be able to request GET" do
      expect(@client.request :get, @url, @testing_options).to be_true
    end
    it "should be able to request POST" do
      expect(@client.request :post, @url, @testing_options).to be_true
    end
  end

  context "with URL broken" do
    before(:all) do
      @url = "not/working/domain"
    end
    it "should detect that server has an error" do
      response = @client.request :get, @url, @testing_options
      expect(response.code).to eq("404")
    end
  end

end