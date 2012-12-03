module ApplicationHelper

  def body_id
    "#{params[:controller]}-#{params[:action]}"
  end

  def uri_encode(text)
    URI.escape(text, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  end

end
