require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class SlopSevSegDisplay < SevenSegmentDisplay
  
    def self.new
      super
    end

    def initialize(ptr)
      super(ptr)
    end

    def draw
      draw_background
      draw_seg
    end

    def draw_seg
      context = Gdk.cairo_create(@darea.window.not_nil!)
      if @seg_width > 0.15 * @darea.allocated_width / @darea.allocated_height
        s_w = 0.15 * @darea.allocated_width 
      else
        s_w = @darea.allocated_height*@seg_width
      end
      l_h = @darea.allocated_width - s_w*4.5
      l_v = @darea.allocated_height/2 - s_w*1.5
      k = (l_v - 2 * s_w)/l_v
      set_color(context, seg_a)
      context.new_path.move_to(2.25*s_w,s_w).rel_line_to(l_h + s_w , 0.0).rel_line_to(-s_w, s_w).rel_line_to(s_w - l_h, 0.0).close_path
      context.fill
      set_color(context, seg_b)
      context.new_path.move_to(l_h + 3.5 * s_w, 1.25 * s_w).rel_line_to(-0.5 * s_w, l_v).rel_line_to(-s_w, -s_w)
      context.rel_line_to(0.5 * k * s_w, 2*s_w - l_v).close_path
      context.fill
      set_color(context, seg_c)
      context.new_path.move_to(l_h + 3.0 * s_w, l_v + 1.75 * s_w).rel_line_to(-0.5 * s_w, l_v).rel_line_to(-s_w, -s_w)
      context.rel_line_to(0.5 * k * s_w, 2*s_w - l_v).close_path
      context.fill
      set_color(context, seg_d)
      context.new_path.move_to(1.25*s_w, 2 * l_v + 2 * s_w).rel_line_to(l_h + s_w, 0.0).rel_line_to(-s_w, -s_w).rel_line_to(s_w - l_h, 0.0).close_path
      context.fill
      set_color(context, seg_e)
      context.new_path.move_to(1.5 * s_w, l_v + 1.75 * s_w).rel_line_to(-0.5 * s_w, l_v).rel_line_to(s_w, -s_w)
      context.rel_line_to(0.5 * k * s_w, 2*s_w - l_v).close_path
      context.fill
      set_color(context, seg_f)
      context.new_path.move_to(2 * s_w, 1.25 * s_w).rel_line_to(-0.5 * s_w, l_v).rel_line_to(s_w, -s_w)
      context.rel_line_to(0.5 * k * s_w, 2*s_w - l_v).close_path
      context.fill
      set_color(context, seg_g)
      context.new_path.move_to(1.75 * s_w, l_v + s_w * 1.5).rel_line_to(0.75 * s_w, -0.75 * s_w).rel_line_to(l_h - 0.5 * s_w, 0.0)
      context.rel_line_to(0.75 * s_w, 0.75 * s_w).rel_line_to(-0.75 * s_w, 0.75 * s_w).rel_line_to(0.5 * s_w - l_h, 0.0).close_path
      context.fill
    end

   def set_color(context, on : Bool)
      if on
        context.set_source_rgba(@on_color.red, @on_color.green, @on_color.blue, @on_color.alfa)
      else
        context.set_source_rgba(@off_color.red, @off_color.green, @off_color.blue, @off_color.alfa)
      end
    end

  end

end
