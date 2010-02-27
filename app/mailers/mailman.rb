class Mailman < ActionMailer::Base
  delivers_from 'no-reply@garrettbjerkhoel.com'
  
  def contact(info)
    @email = info
    mail(:subject => 'Contact from GB.com', :to => 'xhtmlthis@me.com', :from => info[:email])
  end
end