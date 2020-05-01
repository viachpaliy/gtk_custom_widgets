require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class Shape(T)  < Gtk::ScrolledWindow

    property geometry : T

    def self.new
      super nil, nil
    end
 
   def initialize(ptr)
      super(ptr)
      hexpand = true
      vexpand = true
      @geometry = T.new
      connect "draw",&->draw
    end

    def draw
      context = Gdk.cairo_create(window.not_nil!)
      draw(context.as Cairo::Context)
    end

    def draw(context : Cairo::Context)
      context.set_source_rgba(1.0, 1.0, 1.0, 0.0)
      context.rectangle(0, 0, allocated_width, allocated_height)
      context.stroke_preserve
      context.fill      
      if brush = geometry.brush 
        if brush.is_a?(LineStyle)
          context.line_width = brush.width
          context.set_source_rgba(brush.color.red, brush.color.green, brush.color.blue,brush.color.alfa)
          context.line_cap = brush.cap_style
          context.line_join = brush.join_style
          context.set_dash(brush.dashes, 0.0)
          geometry.create_cairo_path(context) 
          context.stroke
        else
          geometry.create_cairo_path(context) 
          context.stroke
        end
      else
        geometry.create_cairo_path(context) 
        context.stroke
      end 
    end    

  end
end
