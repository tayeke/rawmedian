class ContactMailer < ActionMailer::Base
  default from: "tayloreke@gmail.com"
  default to:   "contact@rawmedian.com"

  def contact_email(message,from)
    @from = from
    @message = message
    mail(to: Option.find_by_key(:email_address).value, from: from, subject: "Email from rawmedian.com")
  end

end
