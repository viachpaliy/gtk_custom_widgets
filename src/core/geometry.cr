require "cairo-gobject/cairo"

module GtkCustomWidgets

  abstract class Geometry

    abstract def bounds : Cairo::Rectangle

    abstract def create_cairo_path(cr : Cairo::Context)

    abstract def create_cairo_sub_path(cr : Cairo::Context)

  end

end
