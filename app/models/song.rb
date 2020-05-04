class Song < ApplicationRecord
    has_many :artist_songs
    has_many :artists, through: :artist_songs
end
