module Mailgun
  class Mail

    def initialize(mailgun)
      @mailgun = mailgun
    end

    # send email
    def send_email(domain, params = {})
      url = @mailgun.base_url + '/' + domain + '/messages'

      # TODO with the following options
      # :from, :to, :cc, :bcc, :subject, :text, :html 
      # :with_attachment
      # :with_attachments
      # :at for delayed delivery time option
      # :in_test_mode BOOL. override the @use_test_mode setting
      # :tags to add tags to the email
      # :track BOOL
      Mailgun.submit(:post, url, params)
    end
  end
end
