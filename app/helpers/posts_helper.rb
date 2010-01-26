module PostsHelper
  def markdown(body)
    cutoff = body.split('\end')
    
    if controller.action_name == "show"
      content = body.gsub('\end', '')
    else
      content = (cutoff.length > 0) ? cutoff[0] : body
    end
    
    BlueCloth.new(content).to_html.html_safe!
  end
end
