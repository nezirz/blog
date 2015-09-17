class AddUserIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer
    add_column :posts, :like, :boolean
  end
end
