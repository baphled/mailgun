$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
require 'mailgun'

describe Mailgun::Mail do
  before(:each) do
      @mailgun = Mailgun::Base.new(:api_key => "some-api-key")
      @mailer = Mailgun::Mail.new @mailgun
      @params = {
        :from => 'scooby@mystery.inc',
        :to => 'scrappy@mystery.inc',
        :subject => 'hey yo',
        :text => 'Some cool email'
      }
      Mailgun.stub(:submit)
  end

  it "must have a from argument" do
    @params.delete(:from)
    expect do
      @mailer.send_email('mysteryinc.mailgun.org', @params)
    end.should raise_error ArgumentError
  end

  it "must have a 'to' argument" do
    @params.delete(:to)
    expect do
      @mailer.send_email('mysteryinc.mailgun.org', @params)
    end.should raise_error ArgumentError
  end

  it "must have a 'subject' argument" do
    @params.delete(:subject)
    expect do
      @mailer.send_email('mysteryinc.mailgun.org', @params)
    end.should raise_error ArgumentError
  end

  it "must have a 'text' or 'html' argument"
  it "can set a delayed delivery time"
  it "allows the client to set a test mode"
  it "is able to cc recipients"
  it "is able to bcc recipients"
  it "can take an attachment"
  it "can take an attachments"
  it "accepts tags to associate to the email"
  it "can be tracked"

  context "sending a successful email" do
    before(:each) do
      @email_stub = {message: "Queued. Thank you.", id: 'some-id'}
      @mailer.stub(:send_email).and_return @email_stub
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
