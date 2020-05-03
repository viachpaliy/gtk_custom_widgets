require "cairo-gobject/cairo"

module GtkCustomWidgets

  abstract class Brush

    abstract def set_active(context : Cairo::Context)

  end

end
