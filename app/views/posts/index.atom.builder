atom_feed do |feed|
  feed.title "Garrett Bjerkhoel's Blog"
  feed.updated @posts.first.published_at
  
  @posts.each do |post|
    feed.entry(post) do |entry|
      entry.title post.title
      entry.content post.body, :type => 'html'
      entry.author { |author| author.name('Garrett Bjerkhoel') }
    end
  end
end