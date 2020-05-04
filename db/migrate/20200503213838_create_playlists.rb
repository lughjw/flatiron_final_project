class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.string :rails
      t.string :g
      t.string :model
      t.string :playlist
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.string :spotify_id

      t.timestamps
    end
  end
end
