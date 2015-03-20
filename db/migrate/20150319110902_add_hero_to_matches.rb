class AddHeroToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :hero, :integer, default: nil
  end
end
