require "cairo-gobject/cairo"

module GtkCustomWidgets

  abstract class Geometry

    property brush : Nil | LineStyle

    abstract def bounds : Cairo::Rectangle

    abstract def create_cairo_path(cr : Cairo::Context)

  end

end
