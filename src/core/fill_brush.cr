require "cairo-gobject/cairo"

module GtkCustomWidgets

  abstract class FillBrush < Brush

    property fill_rule : Cairo::FillRule
   
    def initialize
      @fill_rule = Cairo::FillRule::WINDING
    end

  end

end
