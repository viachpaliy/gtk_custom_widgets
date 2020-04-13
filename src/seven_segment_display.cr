require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class SevenSegmentDisplay < Gtk::ScrolledWindow

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
    property seg_width : Float64

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
      @seg_width = 0.1
      @seg_a = false
      @seg_b = false
      @seg_c = false
      @seg_d = false
      @seg_e = false
      @seg_f = false
      @seg_g = false
      @darea = Gtk::DrawingArea.new
      @darea.connect "draw",&->draw
      add @darea
    end
  
    def set_seg_without_draw(a : Bool = false, b : Bool = false, c : Bool = false, d : Bool = false, 
                e : Bool = false, f : Bool = false, g : Bool = false)
      @seg_a = a
      @seg_b = b
      @seg_c = c
      @seg_d = d
      @seg_e = e
      @seg_f = f
      @seg_g = g  
    end

    def set_seg(a : Bool = false, b : Bool = false, c : Bool = false, d : Bool = false, 
                e : Bool = false, f : Bool = false, g : Bool = false)
      set_seg_without_draw(a, b, c, d, e, f, g)
      draw     
    end

    def set_hex(value : UInt32)
      case value
      when 0
        set_seg_without_draw(true,true,true,true,true,true,false)
      when 1
        set_seg_without_draw(a=false, b = true, c = true)
      when 2
        set_seg_without_draw(true,true,false,true,true,false,true)
      when 3
        set_seg_without_draw(true,true,true,true,false,false,true)
      when 4
        set_seg_without_draw(false,true,true,false,false,true,true)
      when 5
        set_seg_without_draw(true,false,true,true,false,true,true)
      when 6
        set_seg_without_draw(true,false,true,true,true,true,true)
      when 7
        set_seg_without_draw(true,true,true) 
      when 8
        set_seg_without_draw(true,true,true,true,true,true,true)
      when 9
        set_seg_without_draw(true,true,true,true,false,true,true)
      when 10 
        set_seg_without_draw(true,true,true,false,true,true,true)
      when 11 
        set_seg_without_draw(false,false,true,true,true,true,true)
      when 12 
        set_seg_without_draw(true,false,false,true,true,true,false) 
      when 13
        set_seg(false,true,true,true,true,false,true)
      when 14
        set_seg_without_draw(true,false,false,true,true,true,true)
      when 15
        set_seg_without_draw(true,false,false,false,true,true,true)     
      end 
    end

    def hex=(value : UInt32)
      set_hex(value)
      draw
    end

    def set_char(value : Char)
       case value
      when '0'
        set_seg_without_draw(true,true,true,true,true,true,false)
      when '1'
        set_seg_without_draw(a=false, b = true, c = true)
      when '2'
        set_seg_without_draw(true,true,false,true,true,false,true)
      when '3'
        set_seg_without_draw(true,true,true,true,false,false,true)
      when '4'
        set_seg_without_draw(false,true,true,false,false,true,true)
      when '5'
        set_seg_without_draw(true,false,true,true,false,true,true)
      when '6'
        set_seg_without_draw(true,false,true,true,true,true,true)
      when '7'
        set_seg_without_draw(true,true,true) 
      when '8'
        set_seg_without_draw(true,true,true,true,true,true,true)
      when '9'
        set_seg_without_draw(true,true,true,true,false,true,true)
      when 'A' 
        set_seg_without_draw(true,true,true,false,true,true,true)
      when 'b' 
        set_seg_without_draw(false,false,true,true,true,true,true)
      when 'C' 
        set_seg_without_draw(true,false,false,true,true,true,false) 
      when 'c' 
        set_seg_without_draw(false,false,false,true,true,false,true)
      when 'd'
        set_seg(false,true,true,true,true,false,true)
      when 'E'
        set_seg_without_draw(true,false,false,true,true,true,true)
      when 'F'
        set_seg_without_draw(true,false,false,false,true,true,true)
      when 'G'
        set_seg_without_draw(true,false,true,true,true,true,false)
      when 'H'
        set_seg_without_draw(false,true,true,false,true,true,true)
      when 'h'
        set_seg_without_draw(false,false,true,false,true,true,true)
      when 'I'
        set_seg_without_draw(false,false,false,false,true,true,false)
      when 'i'
        set_seg_without_draw(false,false,true,false,false,false,false)
      when 'J'
        set_seg_without_draw(false,true,true,true,true,false,false) 
      when 'L'
        set_seg_without_draw(false,false,false,true,true,true,false)
      when 'n'
        set_seg_without_draw(false,false,true,false,true,false,true)
      when 'O'
        set_seg_without_draw(true,true,true,true,true,true,false) 
      when 'o'
        set_seg_without_draw(false,false,true,true,true,false,true)
      when 'P' 
        set_seg_without_draw(true,true,false,false,true,true,true)
      when 'q' 
        set_seg_without_draw(true,true,true,false,false,true,true)
      when 'r'
        set_seg_without_draw(false,false,false,false,true,false,true)
      when 'S'
        set_seg_without_draw(true,false,true,true,false,true,true)
      when 't' 
        set_seg_without_draw(false,false,false,true,true,true,true)
      when 'U'
        set_seg_without_draw(false,true,true,true,true,true,false) 
      when 'u'
        set_seg_without_draw(false,false,true,true,true,false,false)
      when 'Y'
        set_seg_without_draw(false,true,true,true,false,true,true)
      when '_'
        set_seg_without_draw(false,false,false,true,false,false,false)
      when '-'
        set_seg_without_draw(false,false,false,false,false,false,true)
      when '='
        set_seg_without_draw(false,false,false,true,false,false,true)
      when '\''
        set_seg_without_draw(false,false,false,false,false,true,false)
      when '"'
        set_seg_without_draw(false,true,false,false,false,true,false)
      when '\u00B0'
        set_seg_without_draw(true,true,false,false,false,true,true)
      when '[' 
        set_seg_without_draw(true,false,false,true,true,true,false) 
      when ']' 
        set_seg_without_draw(true,true,true,true,false,false,false)
      when ' ' 
        set_seg_without_draw(false,false,false,false,false,false,false)  
      end 
    end

    def char=(value : Char)
      set_char(value) 
      draw
    end

    def draw
      draw_background
      s_w = @darea.allocated_width*@seg_width
      draw_h_seg(s_w*1.5, seg_a)
      draw_h_seg(@darea.allocated_height/2, seg_g)
      draw_h_seg(@darea.allocated_height - s_w*1.5, seg_d)
      draw_v_seg(s_w*1.5, s_w*1.75, seg_f)
      draw_v_seg(s_w*1.5,@darea.allocated_height/2 + s_w*0.25, seg_e)
      draw_v_seg(@darea.allocated_width - s_w*1.5, s_w*1.75, seg_b)
      draw_v_seg(@darea.allocated_width - s_w*1.5,@darea.allocated_height/2 + s_w*0.25, seg_c)
    end

    def draw_background
      context = Gdk.cairo_create(@darea.window.not_nil!)
      context.set_source_rgb(@bg_color.red, @bg_color.green, @bg_color.blue)
      context.rectangle(0, 0, @darea.allocated_width, @darea.allocated_height)
      context.stroke_preserve
      context.fill
    end

    def draw_h_seg(y : Float64, on : Bool)
      context = Gdk.cairo_create(@darea.window.not_nil!)
      if on
        context.set_source_rgb(@on_color.red, @on_color.green, @on_color.blue)
      else
        context.set_source_rgb(@off_color.red, @off_color.green, @off_color.blue)
      end
      s_w = @darea.allocated_width*@seg_width 
      context.new_path
      context.move_to (s_w*1.75), y
      context.rel_line_to (s_w*0.5), (-s_w*0.5) 
      context.rel_line_to (@darea.allocated_width - s_w*4.5), 0.0
      context.rel_line_to (s_w*0.5), (s_w*0.5) 
      context.rel_line_to (-s_w*0.5), (s_w*0.5)
      context.rel_line_to (s_w*4.5 - @darea.allocated_width), 0.0
      context.close_path
      context.fill
    end

    def draw_v_seg(x : Float64, y : Float64, on : Bool)
      context = Gdk.cairo_create(@darea.window.not_nil!)
      if on
        context.set_source_rgb(@on_color.red, @on_color.green, @on_color.blue)
      else
        context.set_source_rgb(@off_color.red, @off_color.green, @off_color.blue)
      end
      s_w = @darea.allocated_width*@seg_width 
      context.new_path
      context.move_to x, y
      context.rel_line_to (s_w*0.5), (s_w*0.5)
      context.rel_line_to 0.0, (@darea.allocated_height/2 - s_w*3)
      context.rel_line_to (-s_w*0.5), (s_w*0.5) 
      context.rel_line_to (-s_w*0.5), (-s_w*0.5) 
      context.rel_line_to 0.0, (s_w*3 - @darea.allocated_height/2)
      context.close_path
      context.fill
    end

  end




end
