class CreatePartecipationsmatches < ActiveRecord::Migration[5.2]
  def change
    create_table :partecipationsmatches do |t|
      t.integer :session_id
      t.integer :match_id
      t.integer :player_id
      t.boolean :like, default: false
      t.timestamps
    end
  end
end
