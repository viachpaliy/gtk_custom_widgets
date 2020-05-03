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

  end

end
