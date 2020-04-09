
module GtkCustomWidgets
  
  class Color

    property red : Float64
    property green : Float64
    property blue : Float64

    def initialize(red : Float64, green : Float64, blue : Float64)
      @red = red
      @green = green
      @blue = blue 
    end

  end

end
