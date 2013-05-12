class MailController < ApplicationController
  def contact
    ContactMailer.contact_email(params[:message], params[:from]).deliver
  end
end
