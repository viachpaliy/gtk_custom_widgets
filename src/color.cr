
module GtkCustomWidgets
  
  # Color
  class Color

    property red : Float64
    property green : Float64
    property blue : Float64

    def initialize(red : Float64 = 0.0, green : Float64 = 0.0, blue : Float64 = 0.0)
      @red = red
      @green = green
      @blue = blue 
    end

    def initialize(color : Gdk::Color)
      @red = color.red / 65535
      @green = color.green / 65535
      @blue = color.blue / 65535
    end

    def self.new_from_bytes(red : UInt8 = 0, green : UInt8 = 0, blue : UInt8 = 0) : self 
      new(Float64.new(red / 256), Float64.new(green / 256), Float64.new(blue / 256))
    end

  end

end
