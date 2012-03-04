class AddImageUrlToPromotions < ActiveRecord::Migration
  def self.up
    add_column :promotions, :image_url, :string
  end

  def self.down
    remove_column :promotions, :image_url
  end
end
