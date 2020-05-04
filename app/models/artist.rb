class Artist < ApplicationRecord
    has_many :artist_songs
    has_many :songs, through: :artist_songs
end
