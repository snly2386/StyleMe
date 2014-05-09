class AddContentImagesToPhotoBooth < ActiveRecord::Migration
  def change
    # TODO
    add_column :photobooths, :content, :text
    add_column :photobooths, :images, :text
  end
end
