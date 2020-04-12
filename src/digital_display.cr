require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class DigitalDisplay(T) < Gtk::Box

    @n : Int32
    @digits : Array(T) 

    def self.new
      super :horizontal, 0
    end

    def initialize(ptr)
      super(ptr)
      @digits = Array(T).new
      @n = 2
      (0...@n).each do |i|
        d = T.new
         pack_start(d,expand = true, fill = true, padding = 0)
        @digits << d
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
    end

  end


end
