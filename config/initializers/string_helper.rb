class String
  def module_name
    self.split("::").first.sub(/Controller$/, '').underscore
  end
  
  def to_slug
    value = self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
    value.gsub!(/[']+/, '')
    value.gsub!(/\W+/, ' ')
    value.strip!
    value.downcase!
    value.gsub!(' ', '-')
    value
  end
  
  def to_md5
    Digest::MD5.hexdigest(self)
  end
  
  def extension(ext = "flv")
    original = self.split('.').reverse
    original[0] = ext
    original = original.reverse.join('.')
    return original
  end
  
  def path_convert_ext
    file_name = File.basename(self)
    folders = self.split('/')
    folders.pop
    folders = folders.join('/')
    return "#{folders}/#{file_name.extension('flv')}"
  end
end