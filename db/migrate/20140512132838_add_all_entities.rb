class AddAllEntities < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :name
      t.integer :age
      t.text :about_me
      t.string :gender
      t.string :password
      t.string :password_digest
    end

    create_table :sessions do |t|
      t.references :user
    end

    create_table :photobooth do |t|
      t.string :tags
      t.text :content
      t.text :images
      t.references :user
    end

    create_table :results do |t|
      t.references :photobooth
      t.text :description
      t.string :url
    end

    create_table :photos do |t|
      t.string :file_name
      t.references :photobooth
      t.text :description
    end
  end
end
