
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

    def self.new(style : String) : self
      new.set_style(style) 
    end

    def set_hex_rgb(hex)
      hex = hex.floor
      red = (hex >> 16 & 255) / 255.0
      green = (hex >> 8 & 255) / 255.0
      blue = (hex & 255) / 255.0
      self
    end

    def set_hex_rgba(hex)
      hex = hex.floor
      red = (hex >> 24 & 255) / 255.0
      green = (hex >> 16 & 255) / 255.0
      blue = (hex >> 8 & 255) / 255.0
      alfa = (hex & 255) / 255.0
      self
    end

    def hue2rgb(p, q, t)
      t += 1.0 if t < 0.0
      t -= 1.0 if t > 1.0
      return p + (q - p) * 6.0 * t if t < 1.0 / 6.0
      return q if t < 1.0 / 2.0
      return p + (q - p) * 6.0 * (2.0 / 3.0 - t) if t < 2.0 / 3.0
      p
    end

    def set_hsl(h, s, l)
      # h,s,l ranges are in 0.0 - 1.0
      if s == 0.0
        red = l
        green = l
        blue = l
      else
        p = l <= 0.5 ? l * (1.0 + s) : l + s - (l * s)
        q = (2.0 * l) - p
        red = hue2rgb(q, p, h + 1.0 / 3.0)
        green = hue2rgb(q, p, h)
        blue = hue2rgb(q, p, h - 1.0 / 3.0)
      end
      self
    end

    def set_style(style)
      # rgb(255,0,0)
      if /^rgb\((\d+), ?(\d+), ?(\d+)\)$/i =~ style
        red = [255.0, $1.to_f].min / 255.0
        green = [255.0, $2.to_f].min / 255.0
        blue = [255.0, $3.to_f].min / 255.0
        return self
      end
      # rgba(255,0,0,1)
      if /^rgba\((\d+), ?(\d+), ?(\d+), ?(\d+)\)$/i =~ style
        red = [255.0, $1.to_f].min / 255.0
        green = [255.0, $2.to_f].min / 255.0
        blue = [255.0, $3.to_f].min / 255.0
        alfa = [255.0, $4.to_f].min / 255.0
        return self
      end
      # rgb(100%,0%,0%)
      if /^rgb\((\d+)\%, ?(\d+)\%, ?(\d+)\%\)$/i =~ style
        red = [100.0, $1.to_f].min / 100.0
        green = [100.0, $2.to_f].min / 100.0
        blue = [100.0, $3.to_f].min / 100.0
        return self
      end
      # rgba(100%,0%,0%,100%)
      if /^rgba\((\d+)\%, ?(\d+)\%, ?(\d+)\%, ?(\d+)\%\)$/i =~ style
        red = [100.0, $1.to_f].min / 100.0
        green = [100.0, $2.to_f].min / 100.0
        blue = [100.0, $3.to_f].min / 100.0
        alfa = [100.0, $4.to_f].min / 100.0
        return self
      end
      # #ff0000
      if /^\#([0-9a-f]{6})$/i =~ style
        hb = $1.hexbytes
        red = hb[0]
        green = hb[1]
        blue = hb[2]
        return self
      end
      # #ff0000ff
      if /^\#([0-9a-f]{8})$/i =~ style
        hb = $1.hexbytes
        red = hb[0]
        green = hb[1]
        blue = hb[2]
        alfa = hb[3]
        return self
      end
      # #f00
      if /^\#([0-9a-f])([0-9a-f])([0-9a-f])$/i =~ style
        hb = ($1 + $1 + $2 + $2 + $3 + $3).hexbytes
        red = hb[0]
        green = hb[1]
        blue = hb[2]
        return self
      end
      # #f00f
      if /^\#([0-9a-f])([0-9a-f])([0-9a-f])([0-9a-f])$/i =~ style
        hb = ($1 + $1 + $2 + $2 + $3 + $3 + $4 +$4).hexbytes
        red = hb[0]
        green = hb[1]
        blue = hb[2]
        alfa = hb[3]
        return self
      end
      # red
      if /^(\w+)$/i =~ style
        self.set_hex(ColorKeywords[style])
        return self
      end
    end

  end

end
