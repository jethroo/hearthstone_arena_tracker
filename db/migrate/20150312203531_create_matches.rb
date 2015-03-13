class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.column :opponent, :integer, default: nil
      t.column :won, :boolean, default: nil
      t.timestamps null: false
    end
  end
end
