module TripsHelper
  def last_fm_link(track)
    link_to "(#{track.playcount}) #{track.name} - #{track.artist}", track.url
  end
end
