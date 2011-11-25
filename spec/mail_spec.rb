$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
require 'mailgun'

describe Mailgun::Mail do
  before(:each) do
    @mailgun = Mailgun(:api_key => "some-api-key")
  end

  describe "#send_email" do
    before(:each) do
      @params = {
        :from => 'scooby@mystery.inc',
        :to => 'scrappy@mystery.inc',
        :subject => 'hey yo',
        :text => 'Some cool email',
        :html => '<b>Some cool</b> email'
      }
    end

    context "a valid call" do
      before(:each) do
        Mailgun.stub(:submit)
      end

      it "must have a 'from' argument" do
        @params.delete(:from)
        expect do
          @mailgun.send_email('mysteryinc.mailgun.org', @params)
        end.should raise_error ArgumentError
      end

      it "must have a 'to' argument" do
        @params.delete(:to)
        expect do
          @mailgun.send_email('mysteryinc.mailgun.org', @params)
        end.should raise_error ArgumentError
      end

      it "must have a 'subject' argument" do
        @params.delete(:subject)
        expect do
          @mailgun.send_email('mysteryinc.mailgun.org', @params)
        end.should raise_error ArgumentError
      end

      it "must have a 'text' or 'html' argument" do
        @params.delete(:text)
        @params.delete(:html)
        expect do
          @mailgun.send_email('mysteryinc.mailgun.org', @params)
        end.should raise_error ArgumentError
      end

      it "only needs html or text format" do
        @params.delete(:html)
        expect do
          @mailgun.send_email('mysteryinc.mailgun.org', @params)
        end.should_not raise_error ArgumentError
      end
    end

    context "sending a successful email" do
      before(:each) do
        @email_stub = {message: "Queued. Thank you.", id: 'some-id'}
        @mailgun.stub(:send_email).and_return @email_stub
      end

      it "must have the necessary email data to send an email" do
        expected = @mailgun.send_email('mysteryinc.mailgun.org', @params)
        expected.should be_kind_of Hash
      end

      it "must returns a successful message a message" do
        expected = @mailgun.send_email('mysteryinc.mailgun.org', @params)
        expected[:message].should eql @email_stub[:message]
      end

      it "returns the id of the queued" do
        expected = @mailgun.send_email('mysteryinc.mailgun.org', @params)
        expected[:id].should_not be_nil
      end
    end
  end
end
