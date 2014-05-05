class ChangeCloset < ActiveRecord::Migration
  def change
    # TODO
     add_column :closets, :user_id, :integer 
  end
end
