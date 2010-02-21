class TripsController < ApplicationController
  layout 'map'
  
  def show
    @stops = get_tweets
  end
  
  private
    # Gather all tweets by me that are tagged #gbnyc
    def get_tweets
      Rails.cache.fetch('stops', :expires_in => 60) {
        results = []
        
        Twitter::Search.new('#gbnyc').from('garrettb').fetch().results.each do |result|
          results << {
            :text => result.text,
            :created_at => result.created_at,
            :lat => result.geo.coordinates[0],
            :lng => result.geo.coordinates[1]
          }
        end
        
        results
      }
    end
end
