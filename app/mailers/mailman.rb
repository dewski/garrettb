class Mailman < ActionMailer::Base
  default :from => "no-reply@clientend.com"
  
  def contact(info)
    @email = info
    mail(:subject => 'Contact from GB.com', :to => 'xhtmlthis@me.com', :from => info[:email])
  end
end