require "cairo-gobject/cairo"

module GtkCustomWidgets

  abstract class FillBrush < Brush

    property fill_rule : Cairo::FillRule
   
    def initialize
      @fill_rule = Cairo::FillRule::WINDING
    end

    abstract def fill(context : Cairo::Context, geometry : Geometry)

  end

end
