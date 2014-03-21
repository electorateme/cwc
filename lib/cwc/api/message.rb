require 'cwc/api/client'

module Cwc
  module Api
    class Message < Client
      attr_accessor :data

      def initialize(data={}, autosend = false)
        super()
        @data = data
        if autosend === true
          self.send
        end
      end

      def send ssl = true, verbose = false
        # Prepare data for request
        request_data = parse_xml @data
        response = request(:post, Cwc.api_version+'/message', request_data, ssl, verbose)
        if handle_response(response)
          # Request was successful
          puts "Response:\n"+ANSI.yellow(response.body)
          true
        end
      end

      def validate ssl = true, verbose=false
        # Prepare data for request
        request_data = parse_xml
        response = request(:post, Cwc.api_version+'/validate', request_data, ssl, verbose)
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
    end
  end
end