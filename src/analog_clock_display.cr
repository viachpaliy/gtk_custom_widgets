require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class AnalogClockDisplay < Gtk::ScrolledWindow

    @darea : Gtk::DrawingArea
    getter bg_color : Color
    getter handler_color : Color
    getter border_color : Color
    getter border_width : Float64
    getter hour_line_width : Float64
    getter minute_line_width : Float64
    @radius : Float64
    getter time : Time

    def self.new
      super nil, nil
    end

    def initialize(ptr)
      super(ptr)
      hexpand = true
      vexpand = true
      @bg_color = Color.new 1.0, 1.0, 1.0
      @handler_color = Color.new 0.0, 0.0, 0.0
      @border_color = Color.new 0.0, 0.0, 0.0
      @border_width = 0.05
      @radius = 0.5
      @hour_line_width = 0.0075
      @minute_line_width = 0.005
      @time = Time.utc(1970, 1, 1, 0, 0, 0)
      @darea = Gtk::DrawingArea.new
      @darea.connect "draw",&->draw
      add @darea
    end

    def draw
      context = Gdk.cairo_create(@darea.window.not_nil!)
      context.set_source_rgba(1.0, 1.0, 1.0, 0.0)
      context.rectangle(0, 0, @darea.allocated_width, @darea.allocated_height)
      context.stroke_preserve
      context.fill
      bord_width = @darea.allocated_height * border_width
      context.line_width = bord_width
      if @darea.allocated_height > @darea.allocated_width
        radius = 0.5 * (@darea.allocated_width - @darea.allocated_height * border_width)
      else 
        radius = @radius * @darea.allocated_height - @darea.allocated_height * border_width / 2
      end
      context.set_source_rgba( border_color.red, border_color.green, border_color.blue, border_color.alfa) 
      context.arc(@darea.allocated_width / 2, @darea.allocated_height / 2, radius , 0 , 2 * Math::PI)
      context.stroke_preserve
      context.set_source_rgba( bg_color.red, bg_color.green, bg_color.blue, bg_color.alfa)
      context.fill
      context.set_source_rgba( handler_color.red, handler_color.green, handler_color.blue, handler_color.alfa)
      context.translate @darea.allocated_width / 2, @darea.allocated_height / 2
      context.line_width=@darea.allocated_height * hour_line_width
      i = 0
      i = 0
      while i < 12
        context.move_to 0, radius - 2 * bord_width
        context.line_to 0, radius - 0.5 * bord_width
        context.stroke
        context.rotate(Math::PI / 6)
        i += 1
      end
      context.line_width=@darea.allocated_height * minute_line_width
      i = 0
      while i < 60
        context.move_to 0, radius - 1.5 * bord_width
        context.line_to 0, radius - bord_width
        context.stroke
        context.rotate(Math::PI / 30)
        i += 1
      end
      w = @darea.allocated_height * hour_line_width
      b_w = bord_width
      context.rotate(time.minute * Math::PI / 30 - Math::PI / 2)
      context.new_path.move_to(-2 * b_w, 0).rel_line_to(0, 3 * w).rel_line_to(radius, - 2 * w)
      context.rel_line_to(0, - 2 * w).rel_line_to(-radius, - 2 * w).close_path.fill
      context.rotate(Math::PI / 2 - time.minute * Math::PI / 30)
      if time.hour > 12 
        hour = time.hour - 12
      else
        hour = time.hour
      end 
      context.rotate(hour * Math::PI / 6 - Math::PI / 2)
      context.new_path.move_to(-b_w, 0).rel_line_to(0, 3 * w).rel_line_to(radius - 2 * b_w, - 2 * w)
      context.rel_line_to(0, - 2 * w).rel_line_to(2 * b_w - radius, - 2 * w).close_path.fill
      context.identity_matrix
      context.translate @darea.allocated_width / 2, @darea.allocated_height / 2 
      context.rotate(time.second * Math::PI / 30)
      context.new_path.move_to(0, 2 * b_w).rel_line_to(1.25 * w, 0).rel_line_to(0, -radius).rel_line_to(-1.25 * w, 0)
      context.rel_line_to(0, radius).close_path.fill
      context.arc(0, 0, 0.35 * b_w, 0 , 2 * Math::PI)
      context.stroke_preserve
      context.set_source_rgba( bg_color.red, bg_color.green, bg_color.blue, bg_color.alfa)
      context.fill
    end

   def minute_line_width=(value : Float64)
      @minute_line_width = value
      if mapped
        queue_draw
      end 
    end 

   def hour_line_width=(value : Float64)
      @hour_line_width = value
      if mapped
        queue_draw
      end 
    end 

    def time=(value : Time)
      @time = value
      if mapped
        queue_draw
      end 
    end
  
    def radius=(value : Float64)
      @radius = value
      if mapped
        queue_draw
      end 
    end 

    def border_width=(value : Float64)
      @border_width = value
      if mapped
        queue_draw
      end 
    end 

     def border_color=(color : Color)
      @border_color = color
      if mapped
        queue_draw
      end   
    end

    def bg_color=(color : Color)
      @bg_color = color
      if mapped
        queue_draw
      end   
    end

    def handler_color=(color : Color)
      @handler_color = color
      if mapped
        queue_draw
      end   
    end
    

  end

end
