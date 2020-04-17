require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class DigitalClockDisplay < Gtk::Box

    getter bg_color : Color
    getter on_color : Color
    getter off_color : Color
    property blink : Bool
    getter time : Time
    getter seg_width : Float64

   def self.new
      super :horizontal, 0
    end

    def initialize(ptr)
      super(ptr)
      @bg_color = Color.new 0.0, 0.0, 0.0
      @on_color = Color.new 0.0, 0.85, 0.0
      @off_color = Color.new 0.05, 0.05, 0.05
      @seg_width = 0.05
      @time = Time.utc(1970, 1, 1, 0, 0, 0)
      @blink = false
      hour_display = DigitalDisplay(SevenSegmentDisplay).new 
      colon = TimerColon.new
      minute_display = DigitalDisplay(SevenSegmentDisplay).new
      pack_start(hour_display, expand = true, fill = true, padding = 0)
      pack_start(colon, expand = true, fill = true, padding = 0)
      pack_start(minute_display, expand = true, fill = true, padding = 0)
      @hour_display = hour_display.as DigitalDisplay(SevenSegmentDisplay)
      @colon = colon.as TimerColon
      @minute_display = minute_display.as DigitalDisplay(SevenSegmentDisplay)
      @hour_display.bg_color = @bg_color
      @colon.bg_color = @bg_color
      @minute_display.bg_color = @bg_color 
      @hour_display.on_color = @on_color
      @colon.on_color = @on_color
      @minute_display.on_color = @on_color
      @hour_display.off_color = @off_color
      @colon.off_color = @off_color
      @minute_display.off_color = @off_color
      @hour_display.seg_width = @seg_width
      @minute_display.seg_width = @seg_width
    end

    def bg_color=(color : Color)
      @bg_color = color
      @hour_display.bg_color = color
      @colon.bg_color = color
      @minute_display.bg_color = color
      if mapped
        queue_draw
      end   
    end

    def on_color=(color : Color)
      @on_color = color
      @hour_display.on_color = color
      @colon.on_color = color
      @minute_display.on_color = color
      if mapped
        queue_draw
      end   
    end

    def off_color=(color : Color)
      @ff_color = color
      @hour_display.off_color = color
      @colon.off_color = color
      @minute_display.off_color = color
      if mapped
        queue_draw
      end   
    end

    def seg_width(value : Float64)
      @seg_width = value
      @hour_display.seg_width = value
      @minute_display.seg_width = value
      if mapped
        queue_draw
      end   
    end

    def time=(value : Time)
      @hour_display.print value.hour
      if value.minute > 9 
        @minute_display.print value.minute 
      else
        @minute_display.print "0" + value.minute.to_s
      end
      if blink
        if value.second % 2 == 0
          @colon.active = true
        else
          @colon.active = false
        end  
      else
        @colon.active = true 
      end 
      @colon.active 
      if mapped
        queue_draw
      end   
    end

  end
end
