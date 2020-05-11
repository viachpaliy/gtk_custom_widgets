
module GtkCustomWidgets

  class Collection(T) 
 
    @collection : Array(T)

    forward_missing_to @collection

    def initialize
      @collection = Array(T).new
    end

    def [](index : Int32)
      result = nil
      i = 0
      @collection.each do |item|
        if i == index
          result = item
        end
        i += 1
      end
      result
    end

  end
end
