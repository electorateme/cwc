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
        xml = ""
        begin
          xml += '<?xml version="1.0" ?>'
          xml += "<CWC>"
          xml += "<CWCVersion>#{Cwc.api_version_number}</CWCVersion>"
          xml += "<Delivery>"
          xml += "<DeliveryId>#{data[:delivery][:id]}</DeliveryId>"
          xml += "<DeliveryDate>#{data[:delivery][:date]}</DeliveryDate>"
          xml += "<DeliveryAgent>#{data[:delivery][:agent]}</DeliveryAgent>"
          xml += "<DeliveryAgentAckEmailAddress>#{data[:delivery][:ackemailaddress]}</DeliveryAgentAckEmailAddress>"
          xml += "<DeliveryAgentContact>"
          xml += "<DeliveryAgentContactName>#{data[:delivery][:agentcontact][:name]}</DeliveryAgentContactName>"
          xml += "<DeliveryAgentContactEmail>#{data[:delivery][:agentcontact][:email]}</DeliveryAgentContactEmail>"
          xml += "<DeliveryAgentContactPhone>#{data[:delivery][:agentcontact][:phone]}</DeliveryAgentContactPhone>"
          xml += "</DeliveryAgentContact>"
          if data[:delivery][:organization]
            xml += "<Organization>#{data[:delivery][:organization]}</Organization>"
          end
          if data[:delivery][:organizationcontact]
            xml += "<OrganizationContact>"
            xml += "<OrganizationContactName>#{data[:delivery][:organizationcontact][:name]}</OrganizationContactName>"
            xml += "<OrganizationContactEmail>#{data[:delivery][:organizationcontact][:email]}</OrganizationContactEmail>"
            xml += "<OrganizationContactPhone>#{data[:delivery][:organizationcontact][:phone]}</OrganizationContactPhone>"
            xml += "</OrganizationContact>"
          end
          xml += "<OrganizationAbout>#{data[:delivery][:organizationabout]}</OrganizationAbout>" if data[:delivery][:organizationabout]
          xml += "<CampaignId>#{data[:delivery][:campaignid]}</CampaignId>"
          xml += "</Delivery>"
          xml += "<Recipient>"
          xml += "<MemberOffice>#{data[:recipient][:memberoffice]}</MemberOffice>"
          xml += "<IsResponseRequested>#{data[:recipient][:isresponserequested]}</IsResponseRequested>" if data[:recipient][:isresponserequested]
          xml += "<NewsletterOptIn>#{data[:recipient][:newsletteroptin]}</NewsletterOptIn>" if data[:recipient][:newsletteroptin]
          xml += "</Recipient>"
          xml += "<Constituent>"
          xml += "<Prefix>#{data[:constituent][:prefix]}</Prefix>"
          xml += "<FirstName>#{data[:constituent][:firstname]}</FirstName>"
          xml += "<MiddleName>#{data[:constituent][:middlename]}</MiddleName>" if data[:constituent][:middlename]
          xml += "<LastName>#{data[:constituent][:lastname]}</LastName>"
          xml += "<Suffix>#{data[:constituent][:suffix]}</Suffix>" if data[:constituent][:suffix]
          xml += "<Title>#{data[:constituent][:title]}</Title>" if data[:constituent][:title]
          xml += "<ConstituentOrganization>#{data[:constituent][:constituentorganization]}</ConstituentOrganization>" if data[:constituent][:constituentorganization]
          xml += "<Address1>#{data[:constituent][:address1]}</Address1>"
          xml += "<Address2>#{data[:constituent][:address2]}</Address2>" if data[:constituent][:address2]
          xml += "<City>#{data[:constituent][:city]}</City>"
          xml += "<StateAbbreviation>#{data[:constituent][:stateabbreviation]}</StateAbbreviation>"
          xml += "<Zip>#{data[:constituent][:zip]}</Zip>"
          xml += "<Phone>#{data[:constituent][:phone]}</Phone>" if data[:constituent][:phone]
          xml += "<AddressValidation>#{data[:constituent][:addressvalidation]}</AddressValidation>" if data[:constituent][:addressvalidation]
          xml += "<Email>#{data[:constituent][:email]}</Email>"
          xml += "<EmailValidation>#{data[:constituent][:emailvalidation]}</EmailValidation>" if data[:constituent][:emailvalidation]
          xml += "</Constituent>"
          xml += "<Message>"
          xml += "<Subject>#{data[:message][:subject]}</Subject>"
          xml += "<LibraryOfCongressTopics>"
          xml += "#{ get_topics_from_data data }"
          xml += "</LibraryOfCongressTopics>"
          if data[:message][:bills]
            xml += "<Bills>"
            xml += "#{ get_bills_from_data data }"
            xml += "</Bills>"
          end
          xml += "<ProOrCon>#{data[:message][:proorcon]}</ProOrCon>" if data[:message][:proorcon]
          xml += "<OrganizationStatement>#{data[:message][:organizationstatement]}</OrganizationStatement>" if data[:message][:organizationstatement]
          xml += "<ConstituentMessage>#{data[:message][:constituentmessage]}</ConstituentMessage>" if data[:message][:constituentmessage]
          xml += "<MoreInfo>#{data[:message][:moreinfo]}</MoreInfo>" if data[:message][:moreinfo]
          xml += "</Message>"
          xml += "</CWC>"
          rescue StandardError => e
            # Get the line in the code where the error was generated
            error_line = e.backtrace[0].split(":")[1].to_i
            # Find the previous line in this file
            begin
              line = IO.readlines(File.dirname(__FILE__)+"/lib/cwc/utils/xml.rb")[error_line]
              raise XMLSyntaxError.new("Missing value for '"+line.scan(/<([a-zA-Z]*)>/).first.first+"' in data received")
            rescue
              raise XMLSyntaxError.new("Error in XML in line: #{error_line.to_s}")
            end
          end
          xml
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