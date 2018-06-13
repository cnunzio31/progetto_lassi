class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      #links to other tables
      t.integer :master_id
      #types' flags
      t.integer :status
      t.string :session_type
      t.boolean :private_flag, :default => false
      #informations
      t.string :title
      t.string :description
      t.datetime :date
      t.string :version
      t.integer :reported_counter, :default => 0
      t.string :location
      t.timestamps
    end
  end
end
