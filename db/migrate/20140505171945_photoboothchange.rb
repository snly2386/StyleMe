class Photoboothchange < ActiveRecord::Migration
  def change
    # TODO
    add_column :photobooths, :closet_id, :integer
  end
end
