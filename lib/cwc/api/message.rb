require 'cwc/api/client'

module Cwc
  module Api
    class Message < Client
      attr_accessor :data

      default_parameter :message_url, Cwc.api_version+'/message'
      default_parameter :validate_url, Cwc.api_version+'/validate'

      def initialize(data={}, autosend = false)
        super()
        if block_given?
          yield self 
        else
          @data = data
          if autosend === true
            self.send
          end
        end
      end

      def send ssl = true, verbose = false
        response = request(:post, get(:message_url), get_data_xml, ssl, verbose)
        if handle_response(response)
          # Request was successful
          puts "Response:\n"+ANSI.yellow(response.body)
          true
        end
      end

      def validate ssl = true, verbose=false
        # Prepare data for request
        response = request(:post, get(:validate_url), get_data_xml, ssl, verbose)
        if handle_response(response)
          # Request was successful
          puts "Response:\n"+ANSI.yellow(response.body)
          true
        end
      end

      def self.example_data
        {
          delivery: {
            id: "GHXX1236285LFVUID194HDC16452ADEE",
            date: "20121023",
            agent: "Electorate.me",
            agentackemailaddress: "deliveryagent@example.com",
            agentcontact: {
              name: "John Smith",
              email: "john.smith@test.com",
              phone: "202-000-0000"
            },
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
              libraryofcongresstopic: "Education",
              libraryofcongresstopic: "Science, Technology, Communications"
            },
            bills: {
              bill: {
                congress: "111",
                typeabbreviation: "hr",
                number: "233"
              },
              bill: {
                congress: "111",
                typeabbreviation: "s",
                number: "22"
              }
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