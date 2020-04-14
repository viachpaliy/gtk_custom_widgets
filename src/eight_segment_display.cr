require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class EightSegmentDisplay < SlopSevSegDisplay

    property dot : Bool
 
    def self.new
      super 
    end

    def initialize(ptr)
      super(ptr)
      @dot = false
    end

    def set_dot(value : Bool = false)
      @dot = value
      draw
    end

    def draw
      draw_background
      draw_seg
      draw_dot
    end
 
    def draw_dot
      context = Gdk.cairo_create(@darea.window.not_nil!)
      set_color(context, dot)
      if @seg_width > 0.15 * @darea.allocated_width / @darea.allocated_height
        radius = 0.075 * @darea.allocated_width 
      else
        radius = @darea.allocated_height*@seg_width/2
      end
      x =  @darea.allocated_width - 2 * radius
      y =  @darea.allocated_height - 3 * radius 
      context.arc(x, y, radius, 0.0, 2 * Math::PI)
      context.fill
    end

  end
  

end
