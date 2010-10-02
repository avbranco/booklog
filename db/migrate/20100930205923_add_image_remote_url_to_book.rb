class AddImageRemoteUrlToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :image_remote_url, :string
  end

  def self.down
    remove_column :books, :image_remote_url
  end
end
