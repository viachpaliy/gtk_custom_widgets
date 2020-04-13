require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class DigitalDisplay(T) < Gtk::Box

    @n : Int32
    @digits : Array(T) 
    getter bg_color : Color
    getter on_color : Color
    getter off_color : Color
    getter seg_width : Float64

    def self.new
      super :horizontal, 0
    end

    def initialize(ptr)
      super(ptr)
      @digits = Array(T).new
      @n = 2
      @bg_color = Color.new 1.0, 1.0, 1.0
      @on_color = Color.new 1.0, 0.0, 0.0
      @off_color = Color.new 0.85, 0.85, 0.85
      @seg_width = 0.1
      (0...@n).each do |i|
        d = T.new
         pack_start(d,expand = true, fill = true, padding = 0)
        @digits << d
      end 
      @digits.each do |digit|
        digit.bg_color = @bg_color
        digit.on_color = @on_color
        digit.off_color = @off_color
      end
    end

    def n
      @n
    end

    def n=(num : Int32)
      if num > @n
        (0...num - @n).each do |i|
          d = T.new
          pack_start(d,expand = true, fill = true, padding = 0)
          @digits << d
         end 
      elsif num < @n
        @digits.last(@n - num).each do |digit|
          remove digit
        end
        @digits.delete_at(num...@n)
      end
      @n = n
      @digits.each do |digit|
        digit.bg_color = bg_color
        digit.on_color = on_color
        digit.off_color = off_color
      end
    end

    def bg_color=(value : Color)
      @digits.each do |digit|
        digit.bg_color = value
      end
      @bg_color = value
    end 

    def on_color=(value : Color)
      @digits.each do |digit|
        digit.on_color = value
      end
      @on_color = value
    end 

    def off_color=(value : Color)
      @digits.each do |digit|
        digit.off_color = value
      end
      @off_color = value
    end 

    def seg_width=(value : Float64)
      @digits.each do |digit|
        digit.seg_width = value
      end
      @seg_width = value
    end

  end


end
