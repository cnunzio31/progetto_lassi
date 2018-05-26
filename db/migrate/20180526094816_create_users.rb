class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      #roles_mask is added by canard
      #informations
      t.string :email
      t.string :username
      t.boolean :invitation_flag
    end
  end
end
