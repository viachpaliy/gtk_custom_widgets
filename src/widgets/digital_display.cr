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
        if digit.responds_to?(:bg_color=)
          digit.bg_color = bg_color
        end
        if digit.responds_to?(:on_color=)
          digit.on_color = on_color
        end
        if digit.responds_to?(:off_color=)
          digit.off_color = off_color
        end
        if digit.responds_to?(:seg_width=)
          digit.seg_width = seg_width
        end
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
      @n = num
      @digits.each do |digit|
        if digit.responds_to?(:bg_color=)
          digit.bg_color = bg_color
        end
        if digit.responds_to?(:on_color=)
          digit.on_color = on_color
        end
        if digit.responds_to?(:off_color=)
          digit.off_color = off_color
        end
        if digit.responds_to?(:seg_width=)
          digit.seg_width = seg_width
        end
      end
    end

    def bg_color=(value : Color)
      @digits.each do |digit|
        if digit.responds_to?(:bg_color=)
          digit.bg_color = value
        end
      end
      @bg_color = value
    end 

    def on_color=(value : Color)
      @digits.each do |digit|
        if digit.responds_to?(:on_color=)
          digit.on_color = value
        end
      end
      @on_color = value
    end 

    def off_color=(value : Color)
      @digits.each do |digit|
        if digit.responds_to?(:off_color=)
          digit.off_color = value
        end
      end
      @off_color = value
    end 

    def seg_width=(value : Float64)
      @digits.each do |digit|
        if digit.responds_to?(:seg_width=)
          digit.seg_width = value
        end
      end
      @seg_width = value
    end

    def print(text : String)
      i = 0
      @digits.each do |digit|
        digit.reset
        if digit.responds_to?(:dp=)
          digit.dp = false
        end
        if i < text.size
          digit.char = text[i]
        else
          digit.char = ' '
        end 
        i +=1
        if i < text.size
          if text[i]=='.'
            if digit.responds_to?(:dp=)
              digit.dp = true
              i +=1
            end
          end
        end
      end
      if mapped
        queue_draw
      end
    end

    def print(number : Int8 | Int16 | Int32 | Int64 | UInt8 | UInt16 | UInt32 | UInt64)
      if number.to_s.size < n
         str = " " * (n - number.to_s.size) + number.to_s
      else
         str = number.to_s
      end
      print str 
    end

    def print(number : Float32 | Float64)
      str = number.to_s
      if str.includes?('.')
        has_dp = false
        @digits.each do |digit|
          if digit.responds_to?(:dp=)
            has_dp = true
          end
        end
        if has_dp
          if str.size < n + 1
            str = " " * (n + 1 - str.size) + str
          end 
        else
          if str.size < n
            str = " " * (n - str.size) + str
          end
        end
      else
        if str.size < n
          str = " " * (n - str.size) + str
        end
      end
      print str
    end

    

  end


end
