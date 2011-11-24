module Mailgun
  class Mail

    def initialize(mailgun)
      @mailgun = mailgun
    end

    # send email
    def send_email(domain, params = {})
      url = @mailgun.base_url + '/' + domain + '/messages'
      params.fetch(:to) { raise ArgumentError.new(":to is a required arguement to send an email") }
      params.fetch(:from) { raise ArgumentError.new(":from is a required arguement to send an email") }
      Mailgun.submit(:post, url, params)
    end
  end
end
