require "cairo-gobject/cairo"

module GtkCustomWidgets

  class PolygonGeometry < Geometry

    property points : Collection(Point)

    def self.new : self
      new(Collection(Point).new)
    end

    def initialize(points : Collection(Point))
      @points = points 
    end

    def start_point
      result = nil
      result = points[0] if points.size > 0
    end

    def create_cairo_path(cr : Cairo::Context)
      if points.size > 0
        if start_p = start_point
          cr.new_path.move_to(start_p.x, start_p.y)
          points[1..points.size - 1].each do |point|
            cr.line_to(point.x, point.y) 
          end
          cr.close_path
        end
      end
    end

    def create_cairo_sub_path(cr : Cairo::Context)
      if points.size > 0
        if start_p = start_point
          cr.new_sub_path.move_to(start_p.x, start_p.y)
          points[1..points.size - 1].each do |point|
            cr.line_to(point.x, point.y) 
          end
          cr.close_path
        end
      end
    end

    def bounds : Cairo::Rectangle
      if points.size > 0
        if start_p = start_point
          min_x = start_point.x
          max_x = start_point.x
          min_y = start_point.y
          max_y = start_point.y
        end
        points[1..points.size - 1].each do |point|
          min_x = min(min_x, point.x)
          min_y = min(min_y, point.y)
          max_x = max(max_x, point.x)
          max_y = max(max_y, point.y)
        end
        return Cairo::Rectangle.new min_x, min_y, (max_x - min_x), (max_y - min_y)
      else
        return Cairo::Rectangle.new 0.0, 0.0, 0.0, 0.0
      end
    end

  end
end
