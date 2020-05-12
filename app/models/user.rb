require 'rest_client'

class User < ApplicationRecord
    has_many :playlists
    has_one :spotify_account
end
