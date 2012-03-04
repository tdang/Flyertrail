class CreatePromotions < ActiveRecord::Migration
  def self.up
    create_table :promotions do |t|
      t.string :content
      t.integer :user_id
      t.timestamps
    end
    add_index :promotions, [:user_id, :created_at]
  end

  def self.down
    drop_table :promotions
  end
end
