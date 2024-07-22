class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.references :account,foreign_key: true
      t.references :user,foreign_key: true
      t.string :first_name
      t.string :last_name
      t.timestamps
    end
  end
end
