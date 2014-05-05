class AddPhotoColumns < ActiveRecord::Migration
  def change
    add_column :photos, :url, :string
    add_column :photos, :file_name, :string
  end
end
