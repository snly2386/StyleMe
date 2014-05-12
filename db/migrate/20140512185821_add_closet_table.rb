class AddClosetTable < ActiveRecord::Migration
  def change
    create_table :closets do |t|
      t.references :user
    end
  end
end
