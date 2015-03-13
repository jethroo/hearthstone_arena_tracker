class AddArenasToUser < ActiveRecord::Migration
  def change
    add_column :arenas, :user_id, :integer
  end
end
