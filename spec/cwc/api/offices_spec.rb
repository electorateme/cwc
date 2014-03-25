require 'spec_helper'

describe Cwc::Api::Offices do
  #Configure initial values
  before(:all) do
    Cwc.test_settings false
    @offices = Cwc::Api::Offices.new
  end

  context "with working URL" do
    it "should request to the server" do
      response = @offices.send false, false
      expect(response).to be_true
    end
  end

end