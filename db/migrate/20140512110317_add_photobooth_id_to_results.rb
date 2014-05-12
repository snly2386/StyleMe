class AddPhotoboothIdToResults < ActiveRecord::Migration
  def change
    # TODO
    add_reference :results, :photobooth, index: true
  end
end
