require 'sinatra'

post '/v2/message' do
  content_type 'application/xml'
  "Message Accepted"
end

post '/v2/validate' do
  content_type 'application/xml'
  "Message Validated"
  #<?xml version="1.0"?>
  #<Errors>
  #  <Error>Error validating datatype token</Error>
  #  <Error>Element DeliveryId failed to validate content</Error>
  #</Errors>
end

get '/offices' do
  '["HMD04","HVA01","HVA02","HVA03","HVA04","HVA05","HVA06","HVA09","HVA10","HVA07","HVA11","HVA12","HAL04"]'
end