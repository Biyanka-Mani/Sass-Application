class AddAccountIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :account, foreign_key: true
  end
end
