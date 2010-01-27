module ApplicationHelper
  def flash_messages
    return unless messages = flash.keys.select{|k| [:error, :notice, :warning, :success].include?(k)}
    formatted_messages = messages.map do |type|
      message = h(flash[type])
      content_tag :div, :class => type do
        message
      end
    end
    formatted_messages.join
  end
  
  def meta_tag(name, content)
    content_for(name.to_sym) { tag :meta, :name => name, :content => content } unless content.nil? or name.nil?
  end
  
  def title(page_title)
    content_for(:title) {
      "#{page_title} &bull; #{t(:site_name)}".html_safe!
    }
  end
  
  def javascript_file(*files)
    content_for(:javascript_files) {
      javascript_include_tag(*files)
    }
  end
 
  def stylesheet(*files)
    content_for(:styesheets) {
      stylesheet_link_tag(*files)
    }
  end
  
  def timestamp(klass)
    content_tag :abbr, :class => "timestamp", :title => klass.created_at.to_s(:timestamp) do
      klass.created_at.to_s(:timestamp)
    end
  end
  
  def application_revision
    @application_revision ||= if File.exists?("#{RAILS_ROOT}/REVISION")
      File.read("#{RAILS_ROOT}/REVISION").strip
    else
      "HEAD"
    end
  end
 
  def application_last_deployed
    if File.exists?("#{Rails.root}/REVISION")
      @deployed_at ||= File.stat("#{Rails.root}/REVISION").ctime
      "#{time_ago_in_words @deployed_at} ago"
    else
      "(not deployed)"
    end
  end
  
  def markdown(post)
    return if post.nil?
    return blue_cloth(post) if post.is_a?(String)
    
    content = case [controller.controller_name, controller.action_name]
      when ['welcome', 'index'] then post.excerpt
      when ['posts', 'index'] then post.summary
      when ['posts', 'show'] then post.body
      else post.body
    end
    
    blue_cloth(content)
  end
  
  def blue_cloth(content)
    BlueCloth.new(content).to_html.html_safe!
  end
end