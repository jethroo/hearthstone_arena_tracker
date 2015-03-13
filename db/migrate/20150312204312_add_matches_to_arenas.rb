class AddMatchesToArenas < ActiveRecord::Migration
  def change
    add_column :matches, :arena_id, :integer
  end
end
