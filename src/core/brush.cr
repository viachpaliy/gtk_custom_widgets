require "cairo-gobject/cairo"

module GtkCustomWidgets

  abstract class Brush

    abstract def stroke(context : Cairo::Context, geometry : Geometry)

  end

end
