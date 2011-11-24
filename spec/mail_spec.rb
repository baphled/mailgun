$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
require 'mailgun'

describe Mailgun::Mail do

  context "sending a successful email" do
    before(:each) do
      @mailgun = Mailgun::Base.new(:api_key => "some-api-key")
      @mailer = Mailgun::Mail.new @mailgun
      @email_stub = {message: "Queued. Thank you.", id: 'some-id'}
      @mailer.stub(:send_email).and_return @email_stub
      @params = {
        :from => 'scooby@mystery.inc',
        :to => 'scrappy@mystery.inc',
        :subject => 'hey yo',
        :text => 'Some cool email'
      }
    end

    it "must have the necessary email data to send an email" do
      expected = @mailer.send_email('mysteryinc.mailgun.org', @params)
      expected.should be_kind_of Hash
    end

    it "must returns a successful message a message" do
      expected = @mailer.send_email('mysteryinc.mailgun.org', @params)
      expected[:message].should eql @email_stub[:message]
    end

    it "returns the id of the queued" do
      expected = @mailer.send_email('mysteryinc.mailgun.org', @params)
      expected[:id].should_not be_nil
    end
  end
end
