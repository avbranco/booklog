class CreateReadings < ActiveRecord::Migration
  def self.up
    create_table :readings do |t|
      t.integer :book_id
      t.integer :user_id
      t.timestamps
    end
    remove_column :books, :user_id
  end

  def self.down
    add_column :books, :user_id, :integer
    drop_table :readings
  end
end
