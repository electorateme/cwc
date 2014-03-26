require 'sinatra'

post '/v2/message' do
  content_type 'application/xml'
  "Answer XML from server"
end

post '/v2/validate' do
  content_type 'application/xml'
  "XML is valid!"
end

get '/offices' do
  '{"H1", "H2"}'
end