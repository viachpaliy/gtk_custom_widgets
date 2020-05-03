require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class Shape(T)  < Gtk::ScrolledWindow

    property geometry : T
    property stroke : Nil | LineStyle | SolidColorBrush
    property fill : Nil

    def self.new
      super nil, nil
    end
 
   def initialize(ptr)
      super(ptr)
      hexpand = true
      vexpand = true
      @geometry = T.new
      @stroke = nil
      @fill = nil
      connect "draw",&->draw
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
      geometry.create_cairo_path(context) 
      if fill_brush = @fill
        if fill_brush.is_a?(FillBrush)
          fill_brush.set_active(context) 
          context.fill_preserve
        else
          context.fill_preserve
        end
      end     
      if brush = @stroke
        if brush.is_a?(Brush)
          brush.set_active(context) 
          context.stroke
        else
          context.stroke
        end
      end 
      draw_child(context)
    end    

  end
end
