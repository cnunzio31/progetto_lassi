class CreatePartecipations < ActiveRecord::Migration[5.2]
  def change
    create_table :partecipations do |t|
      #links to other tables
      t.integer :session_id
      t.integer :player_id
      t.timestamps
    end
  end
end
