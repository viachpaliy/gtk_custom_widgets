require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class EightSegmentDisplay < Gtk::ScrolledWindow

    @darea : Gtk::DrawingArea
    property bg_color : Color
    property on_color : Color
    property off_color : Color
    property seg_a : Bool
    property seg_b : Bool
    property seg_c : Bool
    property seg_d : Bool
    property seg_e : Bool
    property seg_f : Bool
    property seg_g : Bool
    property dot : Bool
    property seg_width : Float64

    def self.new
      super nil, nil
    end

  

    def initialize(ptr)
      super(ptr)
      hexpand = true
      vexpand = true
      @darea = Gtk::DrawingArea.new
      @darea.connect "draw",&->draw
      add @darea
      @bg_color = Color.new 1.0, 1.0, 1.0
      @on_color = Color.new 1.0, 0.0, 0.0
      @off_color = Color.new 0.85, 0.85, 0.85
      @seg_width = 0.2
      @seg_a = false
      @seg_b = false
      @seg_c = false
      @seg_d = false
      @seg_e = false
      @seg_f = false
      @seg_g = false
      @dot = false
    end

    def set_seg(a : Bool = false, b : Bool = false, c : Bool = false, d : Bool = false, 
                e : Bool = false, f : Bool = false, g : Bool = false)
      @seg_a = a
      @seg_b = b
      @seg_c = c
      @seg_d = d
      @seg_e = e
      @seg_f = f
      @seg_g = g  
      draw     
    end

    def set_dot(value : Bool = false)
      @dot = value
      draw
    end

    def hex=(value : UInt32)
      case value
      when 0
        set_seg(true,true,true,true,true,true,false)
      when 1
        set_seg(a=false, b = true, c = true)
      when 2
        set_seg(true,true,false,true,true,false,true)
      when 3
        set_seg(true,true,true,true,false,false,true)
      when 4
        set_seg(false,true,true,false,false,true,true)
      when 5
        set_seg(true,false,true,true,false,true,true)
      when 6
        set_seg(true,false,true,true,true,true,true)
      when 7
        set_seg(true,true,true) 
      when 8
        set_seg(true,true,true,true,true,true,true)
      when 9
        set_seg(true,true,true,true,false,true,true)
      when 10 
        set_seg(true,true,true,false,true,true,true)
      when 11 
        set_seg(false,false,true,true,true,true,true)
      when 12 
        set_seg(true,false,false,true,true,true,false) 
      when 13
        set_seg(false,true,true,true,true,false,true)
      when 14
        set_seg(true,false,false,true,true,true,true)
      when 15
        set_seg(true,false,false,false,true,true,true)     
      end 
    end

    def draw
      draw_background
      draw_seg
      draw_dot
    end

    def draw_background
      context = Gdk.cairo_create(@darea.window.not_nil!)
      context.set_source_rgb( 1.0, 1.0, 1.0)
      context.rectangle(0, 0, @darea.allocated_width, @darea.allocated_height)
      context.stroke_preserve
      context.fill
    end

    def draw_seg
      context = Gdk.cairo_create(@darea.window.not_nil!)
      s_w = @darea.allocated_width*@seg_width
      l_h = @darea.allocated_width - s_w*4.5
      l_v = @darea.allocated_height/2 - s_w*1.5
      set_color(context, seg_a)
      context.new_path.move_to(2.25*s_w,s_w).rel_line_to(l_h + s_w , 0.0).rel_line_to(-s_w, s_w).rel_line_to(s_w - l_h, 0.0).close_path
      context.fill
      set_color(context, seg_b)
      context.new_path.move_to(l_h + 3.5 * s_w, 1.25 * s_w).rel_line_to(-0.5 * s_w, l_v).rel_line_to(-s_w, -s_w).rel_line_to(0.5 * s_w, 2*s_w - l_v).close_path
      context.fill
      set_color(context, seg_c)
      context.new_path.move_to(l_h + 3.0 * s_w, l_v + 1.75 * s_w).rel_line_to(-0.5 * s_w, l_v).rel_line_to(-s_w, -s_w).rel_line_to(0.5 * s_w, 2*s_w - l_v).close_path
      context.fill
      set_color(context, seg_d)
      context.new_path.move_to(1.25*s_w, 2 * l_v + 2 * s_w).rel_line_to(l_h + s_w, 0.0).rel_line_to(-s_w, -s_w).rel_line_to(s_w - l_h, 0.0).close_path
      context.fill
      set_color(context, seg_e)
      context.new_path.move_to(1.5 * s_w, l_v + 1.75 * s_w).rel_line_to(-0.5 * s_w, l_v).rel_line_to(s_w, -s_w).rel_line_to(0.5 * s_w, 2*s_w - l_v).close_path
      context.fill
      set_color(context, seg_f)
      context.new_path.move_to(2 * s_w, 1.25 * s_w).rel_line_to(-0.5 * s_w, l_v).rel_line_to(s_w, -s_w).rel_line_to(0.5 * s_w, 2*s_w - l_v).close_path
      context.fill
      set_color(context, seg_g)
      context.new_path.move_to(1.75 * s_w, l_v + s_w * 1.5).rel_line_to(s_w, -s_w).rel_line_to(l_h - s_w, 0.0).rel_line_to(s_w, s_w).rel_line_to(-s_w, s_w).rel_line_to(s_w - l_h, 0.0).close_path
      context.fill
    end

    def draw_dot
      context = Gdk.cairo_create(@darea.window.not_nil!)
      set_color(context, dot)
      radius = @darea.allocated_width*@seg_width/2
      x =  @darea.allocated_width - 2 * radius
      y =  @darea.allocated_height - 3 * radius 
      context.arc(x, y, radius, 0.0, 2 * Math::PI)
      context.fill
    end

    def set_color(context, on : Bool)
      if on
        context.set_source_rgb(@on_color.red, @on_color.green, @on_color.blue)
      else
        context.set_source_rgb(@off_color.red, @off_color.green, @off_color.blue)
      end
    end

    

  end




end
