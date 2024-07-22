class RemoveUserIdFromAccounts < ActiveRecord::Migration[7.1]
  def change
    remove_column :accounts, :user_id, :bigint
  end
end
