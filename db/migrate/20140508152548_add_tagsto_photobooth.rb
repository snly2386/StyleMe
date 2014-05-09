class AddTagstoPhotobooth < ActiveRecord::Migration
  def change
    # TODO
    add_column :photobooths, :tags, :text
  end
end
