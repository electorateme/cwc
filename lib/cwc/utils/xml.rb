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
        # XML data
        begin
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
          rescue NoMethodError => e
            # Get the line in the code where the error was generated
            error_line = e.backtrace[0].split(":")[1].to_i
            # Find the previous line in this file
            line = IO.readlines("lib/cwc/utils/xml.rb")[error_line]
            raise XMLSyntaxError.new("Missing value for '"+line.scan(/<([a-zA-Z]*)>/).first.first+"' in data received")
          end
      end

      def get_topics_from_data data
        topics = ""
        data[:message][:libraryofcongresstopics].each do |topic|
          topics += "<LibraryOfCongressTopic>"+topic[1]+"</LibraryOfCongressTopic>"
        end
        topics
      end

      def get_bills_from_data data
        bills = ""
        data[:message][:bills].each do |bill|
          bills += "<Bill>"
          bills += "<BillCongress>"+bill[1][:congress]+"</BillCongress>"
          bills += "<BillTypeAbbreviation>"+bill[1][:typeabbreviation]+"</BillTypeAbbreviation>"
          bills += "<BillNumber>"+bill[1][:number]+"</BillNumber>"
          bills += "</Bill>"
        end
        bills
      end
    end
  end
end