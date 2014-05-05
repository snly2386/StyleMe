class ChangePhoto < ActiveRecord::Migration
  def change
    # TODO
    add_column :photos, :user_id, :integer
  end
end
