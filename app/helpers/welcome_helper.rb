module WelcomeHelper
  def markdown(body)
    cutoff = body.split('\end')
    content = (cutoff.length > 0) ? cutoff[0] : truncate(body, 25)
    BlueCloth.new(content).to_html.html_safe!
  end
end
