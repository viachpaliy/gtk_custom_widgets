
module GtkCustomWidgets

  class Point
    
    property x : Float64
    property y : Float64

    def initialize( x = 0, y = 0)
      @x = x.to_f
      @y = y.to_f
    end 


  end

end
