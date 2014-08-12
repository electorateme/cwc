require 'sinatra'
require 'sinatra/base'

class CwcServer < Sinatra::Base
  post '/v2/message' do
    if !settings.whiny
      "Message Accepted"
    else
      content_type 'application/xml'
      %(<?xml version="1.0"?>
        <Errors>
          <Error>Extra element MiddleName in interleave</Error>
          <Error>Element Constituent failed to validate content</Error>
          <Error>Extra element ConstituentMessage in interleave</Error>
          <Error>Element Message failed to validate content</Error>
        </Errors>)
    end
  end

  post '/v2/validate' do
    if !settings.whiny
      "Message Validated"
    else
      content_type 'application/xml'
      %(<?xml version="1.0"?>
        <Errors>
          <Error>Error validating datatype token</Error>
          <Error>Element DeliveryId failed to validate content</Error>
        </Errors>)
    end
  end

  get '/offices' do
    '["HMD04","HVA01","HVA02","HVA03","HVA04","HVA05","HVA06","HVA09","HVA10","HVA07","HVA11","HVA12","HAL04"]'
  end
end