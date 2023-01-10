class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :friend, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
