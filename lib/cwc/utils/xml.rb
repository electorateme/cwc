require 'nokogiri'

module Cwc
  module Utils
    module XML
      # Returns an array of the error messages thrown in the response
      def parse_errors response
        @response ||= response
        @xml_response ||= Nokogiri::XML(response.body)
        return @xml_response.css("Error").map{ |error| error.text } || ["No errors thrown by the server"]
      end

      #Parse data from @data as XML according to standard 2.0
      def parse_xml data={}
        %(<?xml version="1.0" ?>
          <CWC>
            <CWCVersion>2.0</CWCVersion>
            <Delivery>
              <DeliveryId>GHXX1236285LFVUID194HDC16452ADEE</DeliveryId>
              <DeliveryDate>20121023</DeliveryDate>
              <DeliveryAgent>Your Delivery Agent</DeliveryAgent>
              <DeliveryAgentAckEmailAddress>deliveryagent@example.com</DeliveryAgentAckEmailAddress>
              <DeliveryAgentContact>
                <DeliveryAgentContactName>John Smith</DeliveryAgentContactName>
                <DeliveryAgentContactEmail>john.smith@test.com</DeliveryAgentContactEmail>
                <DeliveryAgentContactPhone>202-000-0000</DeliveryAgentContactPhone>
              </DeliveryAgentContact>
              <Organization>Example Organization</Organization>
              <OrganizationContact>
                <OrganizationContactName>Jane Smith</OrganizationContactName>
                <OrganizationContactEmail>jane.smith@test.com</OrganizationContactEmail>
                <OrganizationContactPhone>202-000-0000</OrganizationContactPhone>
              </OrganizationContact>
              <OrganizationAbout>Describe the organization here.</OrganizationAbout>
              <CampaignId>3d968ttf6ecad3c29a3a629280e686cf0c3f5d5a86aff3cal2020c923adc4444</CampaignId>
            </Delivery>
            <Recipient>
              <MemberOffice>HVA04</MemberOffice>
              <IsResponseRequested>N</IsResponseRequested>
              <NewsletterOptIn>Y</NewsletterOptIn>
            </Recipient>
            <Constituent>
              <Prefix>Mr.</Prefix>
              <FirstName>John</FirstName>
              <MiddleName>T.</MiddleName>
              <LastName>Smith</LastName>
              <Suffix>Jr.</Suffix>
              <Title>CE0</Title>
              <ConstituentOrganization>Constituent Organization</ConstituentOrganization>
              <Address1>1100 XYZ street</Address1>
              <Address2>Room 400</Address2>
              <City>Arlington</City>
              <StateAbbreviation>VA</StateAbbreviation>
              <Zip>23233</Zip>
              <Phone>703-444-0000</Phone>
              <AddressValidation>Y</AddressValidation>
              <Email>john.smith@test.com</Email>
              <EmailValidation>Y</EmailValidation>
            </Constituent>
            <Message>
              <Subject>Example subject for demonstration</Subject>
              <LibraryOfCongressTopics>
                <LibraryOfCongressTopic>Education</LibraryOfCongressTopic>
                <LibraryOfCongressTopic>Science, Technology, Communications</LibraryOfCongressTopic>
              </LibraryOfCongressTopics>
              <Bills>
                <Bill>
                  <BillCongress>111</BillCongress>
                  <BillTypeAbbreviation>hr</BillTypeAbbreviation>
                  <BillNumber>233</BillNumber>
                </Bill>
                <Bill>
                  <BillCongress>111</BillCongress>
                  <BillTypeAbbreviation>s</BillTypeAbbreviation>
                  <BillNumber>22</BillNumber>
                </Bill>
              </Bills>
              <ProOrCon>Pro</ProOrCon>
              <OrganizationStatement>Lorem Ipsum</OrganizationStatement>
              <ConstituentMessage>Dear Congresswoman, this is a test message...</ConstituentMessage>
              <MoreInfo>http://example.com/123/</MoreInfo>
            </Message>
          </CWC>)
      end
    end
  end
end