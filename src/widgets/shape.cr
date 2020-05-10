require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class Shape  < Gtk::ScrolledWindow
   
    @stroke : Nil | Brush
    @fill : Nil | FillBrush
    @geometry : Nil | Geometry

    def self.new
      super nil, nil
    end
 
   def initialize(ptr)
      super(ptr)
      hexpand = true
      vexpand = true
      @geometry = nil
      @stroke = nil
      @fill = nil
      connect "draw",&->draw
    end

    def geometry
      @geometry
    end

    def geometry=(value)
      if value.is_a?(Geometry)
        @geometry = Geometry.cast(value)
      end
    end 

    def fill
      @fill
    end

    def fill=(value)
      if value.is_a?(FillBrush)
        @fill = FillBrush.cast(value)
      end
    end

    def stroke
      @stroke
    end

    def stroke=(value)
      if value.is_a?(Brush)
        @stroke = Brush.cast(value)
      end 
    end

    def draw
      context = Gdk.cairo_create(window.not_nil!)
      draw(context.as Cairo::Context)
    end

    def draw_child(context : Cairo::Context)
      if c = child
        c.draw(context)
      end
    end 

    def draw(context : Cairo::Context)
      context.set_source_rgba(1.0, 1.0, 1.0, 0.0)
      context.rectangle(0, 0, allocated_width, allocated_height)
      context.stroke_preserve
      context.fill 
      if fill_brush = @fill
        if fill_brush.is_a?(FillBrush)
          if geom = @geometry 
            fill_brush.fill(context,geom) 
          end
        end
      end     
      if brush = @stroke
        if brush.is_a?(Brush)
          if geom = @geometry 
            brush.stroke(context,geom) 
          end
        end
      end 
      draw_child(context)
    end    

  end
end
