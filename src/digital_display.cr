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
      @n = num
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

    def print(text : String)
      i = 0
      @digits.each do |digit|
        if i < text.size
          digit.set_char  text[i]
        else
          digit.set_char ' '
        end 
        i +=1
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
      has_dp = false
      if number.to_s.includes?('.')
        has_dp = true
        index_dp = number.to_s.index '.'
        str = number.to_s.delete '.'
      else
        str = number.to_s     
      end 
      if str.size < n
        if has_dp 
          if index_dp
            index_dp = index_dp + n - str.size
          end
        end
        str = " " * (n - str.size) + str
      end
      print str
      if has_dp
        i = 1
        @digits.each do |digit|
          if i == index_dp
            if digit.responds_to?(:dp=)
              digit.dp = true
            end
          end 
          i += 1
        end
      end
    end

  end


end
