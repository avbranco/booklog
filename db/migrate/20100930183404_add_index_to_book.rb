class AddIndexToBook < ActiveRecord::Migration
  def self.up
    add_index :books, :isbn
  end

  def self.down
    remove_index :books, :isbn
  end
end
