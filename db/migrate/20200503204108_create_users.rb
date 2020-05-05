class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :spotify_id
      t.string :spotify_access_token
      t.string :spotify_refresh_token
      t.datetime :spotify_token_start_time
      t.string :username
      t.string :email

      t.timestamps
    end
  end
end
