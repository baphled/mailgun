module Mailgun
  class Mail

    def initialize(mailgun)
      @mailgun = mailgun
    end

    # send email
    def send_email(domain, params = {})
      url = @mailgun.base_url + '/' + domain + '/messages'
      [:to, :from, :subject].each do |attr|
        params.fetch(attr) { raise ArgumentError.new("#{attr} is a required arguement to send an email") }
      end
      raise ArgumentError.new(":text or :html is a required arguement to send an email") if params[:text].nil? or params[:html].nil?
      Mailgun.submit(:post, url, params)
    end
  end
end
