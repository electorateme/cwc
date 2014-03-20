require 'nokogiri'

module Cwc
  module Utils
    module XML
      # Returns an array of the error messages thrown in the response
      def parse_errors response
        @response ||= response
        @xml_response ||= Nokogiri::XML(response.body)
        return @xml_response.css("Error").map{ |error| error.text }
      end

      #Parse data from @data as XML according to standard 2.0
      def parse_xml data={}
        # Static fields
        data = {
          delivery: {
            id: "GHXX1236285LFVUID194HDC16452ADEE",
            date: "20121023",
            agent: "Electorate.me, LLC",
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
        # XML data
        %(<?xml version="1.0" ?>
          <CWC>
            <CWCVersion>#{Cwc.api_version_number}</CWCVersion>
            <Delivery>
              <DeliveryId>#{data[:delivery][:id]}</DeliveryId>
              <DeliveryDate>#{data[:delivery][:date]}</DeliveryDate>
              <DeliveryAgent>#{data[:delivery][:agent]}</DeliveryAgent>
              <DeliveryAgentAckEmailAddress>#{data[:delivery][:ackemailaddress]}</DeliveryAgentAckEmailAddress>
              <DeliveryAgentContact>
                <DeliveryAgentContactName>#{data[:delivery][:agentcontact][:name]}</DeliveryAgentContactName>
                <DeliveryAgentContactEmail>#{data[:delivery][:agentcontact][:email]}</DeliveryAgentContactEmail>
                <DeliveryAgentContactPhone>#{data[:delivery][:agentcontact][:phone]}</DeliveryAgentContactPhone>
              </DeliveryAgentContact>
              <Organization>#{data[:delivery][:organization]}</Organization>
              <OrganizationContact>
                <OrganizationContactName>#{data[:delivery][:organizationcontact][:name]}</OrganizationContactName>
                <OrganizationContactEmail>#{data[:delivery][:organizationcontact][:email]}/OrganizationContactEmail>
                <OrganizationContactPhone>#{data[:delivery][:organizationcontact][:phone]}</OrganizationContactPhone>
              </OrganizationContact>
              <OrganizationAbout>#{data[:delivery][:organizationabout]}</OrganizationAbout>
              <CampaignId>#{data[:delivery][:campaignid]}</CampaignId>
            </Delivery>
            <Recipient>
              <MemberOffice>#{data[:recipient][:memberoffice]}</MemberOffice>
              <IsResponseRequested>#{data[:recipient][:isresponserequested]}</IsResponseRequested>
              <NewsletterOptIn>#{data[:recipient][:newsletteroptin]}</NewsletterOptIn>
            </Recipient>
            <Constituent>
              <Prefix>#{data[:constituent][:prefix]}</Prefix>
              <FirstName>#{data[:constituent][:firstname]}</FirstName>
              <MiddleName>#{data[:constituent][:middlename]}</MiddleName>
              <LastName>#{data[:constituent][:lastname]}</LastName>
              <Suffix>#{data[:constituent][:suffix]}</Suffix>
              <Title>#{data[:constituent][:title]}</Title>
              <ConstituentOrganization>#{data[:constituent][:constituentorganization]}</ConstituentOrganization>
              <Address1>#{data[:constituent][:address1]}</Address1>
              <Address2>#{data[:constituent][:address2]}</Address2>
              <City>#{data[:constituent][:city]}</City>
              <StateAbbreviation>#{data[:constituent][:stateabbreviation]}</StateAbbreviation>
              <Zip>#{data[:constituent][:zip]}</Zip>
              <Phone>#{data[:constituent][:phone]}</Phone>
              <AddressValidation>#{data[:constituent][:addressvalidation]}</AddressValidation>
              <Email>#{data[:constituent][:email]}</Email>
              <EmailValidation>#{data[:constituent][:emailvalidation]}</EmailValidation>
            </Constituent>
            <Message>
              <Subject>#{data[:message][:subject]}</Subject>
              <LibraryOfCongressTopics>
                #{ get_topics_from_data data }
              </LibraryOfCongressTopics>
              <Bills>
                #{ get_bills_from_data data }
              </Bills>
              <ProOrCon>#{data[:message][:proorcon]}</ProOrCon>
              <OrganizationStatement>#{data[:message][:organizationstatement]}</OrganizationStatement>
              <ConstituentMessage>#{data[:message][:constituentmessage]}</ConstituentMessage>
              <MoreInfo>#{data[:message][:moreinfo]}</MoreInfo>
            </Message>
          </CWC>)
      end

      def get_topics_from_data data
        topics = ""
        data[:message][:libraryofcongresstopics].each do |topic|
          topics += "<LibraryOfCongressTopic>"+topic+"</LibraryOfCongressTopic>"
        end
        topics
      end

      def get_bills_from_data data
        bills = ""
        data[:message][:bills].each do |bill|
          bills += "<Bill>"
          bills += "<BillCongress>"+bill[:congress]+"</BillCongress>"
          bills += "<BillTypeAbbreviation>"+bill[:typeabbreviation]+"</BillTypeAbbreviation>"
          bills += "<BillNumber>"+bill[:number]+"</BillNumber>"
          bills += "</Bill>"
        end
        bills
      end
    end
  end
end