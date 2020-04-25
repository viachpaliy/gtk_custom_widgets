require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class Clock(T)
 
    @display : T
    @state : Bool
    @time : Time
    getter location : Time::Location

    forward_missing_to @display
    delegate to_unsafe, to: @display
 
    def initialize
      @display = T.new
      @state = false
      @time = Time.local
      @location = Time::Location.local
      @display.time = @time
      @display.connect "destroy", &-> stop 
      GLib.timeout 0.5, do
        if @state == false
          next true
        end
        if mapped
          show_time
        end
        next true
      end
    end

    def location=(loc : Time::Location)
      @location = loc
      if mapped
        queue_draw
      end 
    end 

    def location=(time_zone : String)
      @location = Time::Location.load  time_zone
      if mapped
        queue_draw
      end 
    end

    def location=(time_offset : Int32)
      @location = Time::Location.fixed  time_offset
      if mapped
        queue_draw
      end 
    end 

    def show_time
      @time = Time.local @location
      @display.time = @time
    end
    
    def start
      @state = true
    end

    def stop
      if @state
        @state = false
      end
    end

  end

end
