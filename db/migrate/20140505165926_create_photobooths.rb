class CreatePhotobooths < ActiveRecord::Migration
  def change
    create_table :photobooths do |t|
    t.references :photo
    t.references :result
    end
  end
end
