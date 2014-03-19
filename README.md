# Cwc

Gem for connecting with CWC API

## Installation

Add this line to your application's Gemfile:

    gem 'cwc', git: 'git@bitbucket.org:hepu/cwc.git'

Or install it yourself as:

    $ gem install cwc

## Usage

You can enter the gem's console to try outside a Rails app:

    $ bundle console cwc

Configure it in the app like this:

# config/cwc.yml
    defaults: &defaults
      api_key: "YOUR-API-KEY"
      api_version: "v2"
      base_uri: "https://test-cwc.house.gov"

    development:
      <<: *defaults
      # add stuff here to override defaults.

    test:
      <<: *defaults
      # add stuff here to override defaults.

    production:
      <<: *defaults
      # add stuff here to override defaults.
      base_uri: "https://cwc.house.gov"

# initializers/cwc.rb
    cwc_file = Rails.root.join("config/cwc.yml")
    settings = YAML.load(File.read(config.cwc_file))[Rails.env]
    Cwc.api_key = settings["api_key"]
    Cwc.api_version = settings["api_version"]
    Cwc.api_base = settings["api_base"]

Then you can use it in the project, for example, to send a message:

    data = {} #Hash containing the information to generate the XML
    message = Cwc::Api::Message.new(data)
    message.send


## Contributing

1. Fork it ( http://github.com/<my-github-username>/cwc/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
