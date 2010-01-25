module PostsHelper
  def markdown(body)
    cutoff = body.split('\end')
    content = (cutoff.length > 0 && controller.action_name != "show") ? cutoff[0] : body.gsub('\end', '')
    BlueCloth.new(content).to_html.html_safe!
  end
end
