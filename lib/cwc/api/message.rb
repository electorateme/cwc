require 'cwc/api/client'
require "securerandom"

module Cwc
  module Api
    class Message < Client
      attr_accessor :data, :message_url

      @@message_url = Cwc.api_version+'/message'
      @@validate_url = Cwc.api_version+'/validate'

      def initialize
        super()
        if block_given?
          yield self
        end
      end

      def data= data
        # Default values
        if data.has_key? :delivery
          data[:delivery][:agent] = "ElectorateMe" unless data[:delivery].has_key? :agent
          data[:delivery][:ackemailaddress] = "email_acknowledge@electorate.me" unless data[:delivery].has_key? :ackemailaddress
          unless data[:delivery].has_key? :agentcontact
            data[:delivery][:agentcontact] = {
              name: "Dan Haecker",
              email: "dan@electorate.me",
              phone: "703-594-1360"
            }
          end
        else
          data[:delivery] = {
            agent: "ElectorateMe",
            ackemailaddress: "email_acknowledge@electorate.me",
            agentcontact: {
              name: "Dan Haecker",
              email: "dan@electorate.me",
              phone: "703-594-1360"
            }
          }
        end
        @data = data
      end

      def send! options = {}
        options[:ssl] = true unless options.has_key? :ssl
        options[:verbose] = true unless options.has_key? :verbose
        options[:body] = get_data_xml
        response = request(:post, @@message_url, options)
        if handle_response(response, options[:verbose])
          # Request was successful
          puts "Response:\n"+ANSI.yellow(response.body) if options[:verbose]
          JSON.parse(response.body) rescue response.body
        end
      end

      def validate! options = {}
        options[:ssl] = true unless options.has_key? :ssl
        options[:verbose] = true unless options.has_key? :verbose
        options[:body] = get_data_xml
        # Prepare data for request
        response = request(:post, @@validate_url, options)
        if handle_response(response, options[:verbose])
          # Request was successful
          puts "Response:\n"+ANSI.yellow(response.body) if options[:verbose]
          true
        end
      end

      def self.example_data
        {
          delivery: {
            id: SecureRandom.uuid.gsub("-", ""),
            date: Time.now.strftime("%Y%m%d"), #Example time
            organization: "Example Organization",
            organizationcontact: {
              name: "Jane Smith",
              email: "jane.smith@test.com",
              phone: "202-000-0000"
            },
            organizationabout: "Describe the organization here.",
            campaignid: "3d968ttf6ecad3c29a3a629280e686cf0c3f5d5a86aff3cal2020c923adc4444"
          },
          recipient: {
            memberoffice: "HVA04",
            isresponserequested: "N",
            newsletteroptin: "Y"
          },
          constituent: {
            prefix: "Mr.",
            firstname: "John",
            middlename: "T.",
            lastname: "Smith",
            suffix: "Jr.",
            title: "CEO",
            constituentorganization: "Constituent Organization",
            address1: "1100 XYZ street",
            address2: "Room 400",
            city: "Arlington",
            stateabbreviation: "VA",
            zip: "23233",
            phone: "703-444-0000",
            addressvalidation: "Y",
            email: "john.smith@test.com",
            emailvalidation: "Y"
          },
          message: {
            subject: "Example subject for demonstration",
            libraryofcongresstopics: {
              libraryofcongresstopic: "Congress"
            },
            bills: {
              #Empty
            },
            proorcon: "Pro",
            organizationstatement: "Lorem Ipsum",
            constituentmessage: "Dear Congresswoman, this is a test message...",
            moreinfo: "http://example.com/123/"
          }
        }
      end

      def get_data_xml
        # Get XML from Cwc::Utils::XML
        parse_xml @data
      end
    end
  end
end