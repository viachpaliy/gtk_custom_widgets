
module GtkCustomWidgets
  
  # Color
  class Color

    property red : Float64
    property green : Float64
    property blue : Float64
    property alfa : Float64

    def initialize(red : Float64 = 0.0, green : Float64 = 0.0, blue : Float64 = 0.0, alfa : Float64 = 1.0)
      @red = red
      @green = green
      @blue = blue 
      @alfa = alfa
    end

    def initialize(color : Gdk::Color)
      initialize(color.red / 65535, color.green / 65535, color.blue / 65535)
    end

    def self.new_from_bytes(red : UInt8 = 0, green : UInt8 = 0, blue : UInt8 = 0, alfa : UInt8 = 255) : self 
      new(Float64.new(red / 255), Float64.new(green / 255), Float64.new(blue / 255), Float64.new(alfa / 255))
    end

  end

end
