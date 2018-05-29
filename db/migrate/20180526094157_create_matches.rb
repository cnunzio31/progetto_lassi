class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      #links to other tables
      t.integer :session_id
      #types' flags
      t.boolean :status, :default => true
      #informations
      t.string :title
      t.datetime :data
      t.string :summary
      t.integer :like, :default => 0
      t.timestamps
    end
  end
end
