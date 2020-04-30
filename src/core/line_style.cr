module GtkCustomWidgets

  class LineStyle

    property width : Float64
    property color : Color
    property dashes : Array(Float64)
    property cap_style : Cairo::LineCap
    property join_style : Cairo::LineJoin

    def initialize
      @width = 2.0
      @color = Color.new "black"
      @dashes = Array(Float64).new
      @cap_style = Cairo::LineCap::BUTT
      @join_style = Cairo::LineJoin::MITER
    end

  end

end
