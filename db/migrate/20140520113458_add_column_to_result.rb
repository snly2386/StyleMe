class AddColumnToResult < ActiveRecord::Migration
  def change
    # TODO
    add_column :results, :shopping_url, :string
  end
end
