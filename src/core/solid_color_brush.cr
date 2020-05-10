require "cairo-gobject/cairo"

module GtkCustomWidgets

  class SolidColorBrush < FillBrush
    
    property color : Color
 
    def initialize(color : Color)
      @fill_rule = Cairo::FillRule::WINDING
      @color = color
    end

    def set_active(context : Cairo::Context)
      context.set_source_rgba(color.red, color.green, color.blue, color.alfa)
      context.fill_rule = fill_rule
    end

    def stroke(context : Cairo::Context, geometry : Geometry)
      geometry.create_cairo_path(context)
      set_active(context) 
      context.stroke
    end

    def fill(context : Cairo::Context, geometry : Geometry)
      geometry.create_cairo_path(context)
      set_active(context) 
      context.fill
    end

  end

end
