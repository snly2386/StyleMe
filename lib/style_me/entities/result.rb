module StyleMe
  # Now the rest of our modules get that initialize method for free
  class Result < Entity
    # ...as long as we have an attr, we can set it using that style
    attr_accessor :id, :photobooth_id

   
  end
end
