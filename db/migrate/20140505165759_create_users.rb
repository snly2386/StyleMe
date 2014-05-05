class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    t.references :closet
    t.string :username
    t.string :name
    t.integer :age
    t.text :about_me
    t.string :gender
    t.integer :password
    t.timestamps
    end
end
end
