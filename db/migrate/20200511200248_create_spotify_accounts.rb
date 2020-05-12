class CreateSpotifyAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :spotify_accounts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :email
      t.string :href
      t.string :spotify_id
      t.string :display_name
      t.string :access_token
      t.string :refresh_token
      t.datetime :token_expiration_time

      t.timestamps
    end
  end
end
