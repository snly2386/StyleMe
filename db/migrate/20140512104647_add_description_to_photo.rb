class AddDescriptionToPhoto < ActiveRecord::Migration
  def change
    # TODO
    add_column :photos, :description, :text
  end
end
