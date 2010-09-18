class CreateTaxbands < ActiveRecord::Migration
  def self.up
    create_table :taxbands do |t|
      t.string :name
      t.integer :lower_limit
      t.integer :upper_limit
      t.decimal :charge, :precision => 9, :scale => 2
      t.date :start_date
      t.date :end_date
      t.date :market_value_date

      t.timestamps
    end
  end

  def self.down
    drop_table :taxbands
  end
end
