class CreateArenas < ActiveRecord::Migration
  def change
    create_table :arenas do |t|
      t.column :hero, :integer, default: nil
      t.column :paid, :boolean, default: false
      t.column :finished_at, :datetime
      t.column :packs, :integer
      t.column :dust, :integer
      t.column :gold, :integer
      t.column :cards, :integer
      t.column :gold_cards, :integer
      t.timestamps null: false
    end
  end
end
