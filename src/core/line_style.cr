require "cairo-gobject/cairo"

module GtkCustomWidgets

  class LineStyle < Brush

    property width : Float64
    property color : Color
    property dashes : Array(Float64)
    property dash_offset : Float64
    property cap_style : Cairo::LineCap
    property join_style : Cairo::LineJoin

    def initialize
      @width = 2.0
      @color = Color.new "black"
      @dashes = Array(Float64).new
      @cap_style = Cairo::LineCap::BUTT
      @join_style = Cairo::LineJoin::MITER
      @dash_offset = 0.0
    end

    def set_active(context : Cairo::Context)
      context.line_width = width
      context.set_source_rgba(color.red, color.green, color.blue, color.alfa)
      context.line_cap = cap_style
      context.line_join = join_style
      context.set_dash(dashes, dash_offset)
    end

    def stroke(context : Cairo::Context, geometry : Geometry)
      geometry.create_cairo_path(context)
      set_active(context) 
      context.stroke
    end

  end

end
