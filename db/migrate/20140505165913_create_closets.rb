class CreateClosets < ActiveRecord::Migration
  def change
    create_table :closets do |t|
    t.references :photobooths
  end
end
end
