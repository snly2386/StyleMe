class AddDescriptionUrlToResults < ActiveRecord::Migration
  def change
    # TODO
    add_column :results, :description, :text
    add_column :results, :url, :text
  end
end
