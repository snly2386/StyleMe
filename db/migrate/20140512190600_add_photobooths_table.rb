class AddPhotoboothsTable < ActiveRecord::Migration
    def change
      drop_table :photobooth

      create_table :photobooths do |t|
        t.string :tags
        t.text :content
        t.text :images
        t.references :user

    end
  end
end
