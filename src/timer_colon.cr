require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class TimerColon < Gtk::ScrolledWindow

    @darea : Gtk::DrawingArea
    getter bg_color : Color
    getter on_color : Color
    getter off_color : Color
    getter active : Bool
    getter dot_radius : Float64

    def self.new
      super nil, nil
    end

    def initialize(ptr)
      super(ptr)
      hexpand = true
      vexpand = true
      @bg_color = Color.new 1.0, 1.0, 1.0
      @on_color = Color.new 1.0, 0.0, 0.0
      @off_color = Color.new 0.85, 0.85, 0.85
      @active = false
      @dot_radius = 0.05
      @darea = Gtk::DrawingArea.new
      @darea.connect "draw",&->draw
      add @darea
    end

    def draw
      draw_background
      draw_dots
    end

    def draw_background
      context = Gdk.cairo_create(@darea.window.not_nil!)
      context.set_source_rgba(@bg_color.red, @bg_color.green, @bg_color.blue, @bg_color.alfa)
      context.rectangle(0, 0, @darea.allocated_width, @darea.allocated_height)
      context.stroke_preserve
      context.fill
    end

   def set_color(context, on : Bool)
      if on
        context.set_source_rgba(@on_color.red, @on_color.green, @on_color.blue, @on_color.alfa)
      else
        context.set_source_rgba(@off_color.red, @off_color.green, @off_color.blue, @off_color.alfa)
      end
    end

   def draw_dots
      context = Gdk.cairo_create(@darea.window.not_nil!)
      set_color(context, active)
      if @dot_radius > 0.95 * @darea.allocated_width / @darea.allocated_height
        radius = 0.95 * @darea.allocated_width 
      else
        radius = @darea.allocated_height*@dot_radius
      end
      x =  @darea.allocated_width / 2 
      y1 =  @darea.allocated_height / 3 
      y2 = 2 * y1 
      context.arc(x, y1, radius, 0.0, 2 * Math::PI)
      context.arc(x, y2, radius, 0.0, 2 * Math::PI)
      context.fill
    end

    def bg_color=(color : Color)
      @bg_color = color
      if mapped
        queue_draw
      end   
    end

    def on_color=(color : Color)
      @on_color = color
      if mapped
        queue_draw
      end   
    end

    def off_color=(color : Color)
      @off_color = color
      if mapped
        queue_draw
      end   
    end

    def active=(value : Bool)
      @active = value
      if mapped
        queue_draw
      end 
    end 

    def dot_radius=(value : Float64)
      @dot_radius= value
      if mapped
        queue_draw
      end 
    end

  end

end
