class CreateSessions < ActiveRecord::Migration
  def change
    # TODO
    create_table :sessions do |t|
    t.references :user
    end
  end
end
