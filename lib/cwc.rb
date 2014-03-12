class Cwc
  def self.hi
    puts "Hello world!"
  end

  def request_url(url)
    uri = URI.parse(url)

    client = Net::HTTP.new(uri.host, uri.port)

    if uri.scheme == "https"
      client.use_ssl = true
      if !Redzirra.options[:ca_file].nil?
        client.verify_mode = OpenSSL::SSL::VERIFY_PEER
        client.ca_file = Redzirra.options[:ca_file]
      else
        client.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
    end

    client.read_timeout = 5*60 #let's wait 5minutes before a timeout.
    client.request_get(uri.request_uri)
  end
end