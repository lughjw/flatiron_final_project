class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs

  # def add_song(song_id)
  
  # end
end
