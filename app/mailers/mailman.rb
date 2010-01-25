class Mailman < ActionMailer::Base
  def contact(info)
    subject     "Contact from GB.com"
    recipients  "xhtmlthis@me.com"
    from        info[:email]
    @email    = info
  end
end