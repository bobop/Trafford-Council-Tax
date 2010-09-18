class CreateProperties < ActiveRecord::Migration
  def self.up
    create_table :properties do |t|
      t.string :secondary_address
      t.string :primary_address
      t.string :street
      t.string :town
      t.string :band
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end

  def self.down
    drop_table :properties
  end
end
