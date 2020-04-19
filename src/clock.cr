require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class Clock(T)
 
    @display : T
    @run : Bool
    @time : Time
    getter location : Time::Location

    forward_missing_to @display
    delegate to_unsafe, to: @display
 
    def initialize
      @display = T.new
      @run = false
      @time = Time.local
      @location = Time::Location.local
      @display.time = @time
      @display.connect "destroy", &-> stop 
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
    
    def start
      @run = true
      spawn do
        loop do
          @time = Time.local @location
          @display.time = @time
          sleep(1.seconds)
        end
      end
      while @run
        if mapped
          Fiber.yield
          @run = false
        end
      end 
    end

    def stop
      if @run
        @run = false
      end
    end

  end

end
