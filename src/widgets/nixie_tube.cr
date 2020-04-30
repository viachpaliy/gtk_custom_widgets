require "gobject/gtk"
require "cairo-gobject/cairo"

module GtkCustomWidgets

  class NixieTube < Gtk::ScrolledWindow

    gtk_widget_property char : Char

    def self.new
      super nil, nil
    end  

    def initialize(ptr)
      super(ptr)
      hexpand = true
      vexpand = true
      @char = ' '
      connect "draw",&->draw
    end

    def reset
      char = ' '
    end

    def draw
      context = Gdk.cairo_create(window.not_nil!)
      draw(context.as Cairo::Context)
    end 

    def draw(context : Cairo::Context)
      image = Cairo::Surface.create_from_png("images/NixieTube195x244.png")
      x = 0
      y = 0
      case char
      when '0' 
            x = 0
            y = 0 
      when '1' 
            x = 53
            y = 0 
      when '2' 
            x = 105
            y = 0 
      when '3' 
            x = 157
            y = 0 
       when '4' 
            x = 0
            y = 87 
      when '5' 
            x = 53
            y = 87 
      when '6' 
            x = 105
            y = 87 
      when '7' 
            x = 157
            y = 87  
      when '8' 
            x = 0
            y = 174 
      when '9' 
            x = 53
            y = 174 
      when '.' 
            x = 105
            y = 174 
      when ' ' 
            x = 157
            y = 174  
      end
      w = 37
      h = 70
     tube_image = image.create_for_rectangle(Float64.new(x), Float64.new(y), Float64.new(w), Float64.new(h)) 
     context.scale(Float64.new(allocated_width / w),Float64.new(allocated_height / h))
     context.set_source_surface(tube_image, 0, 0)
     context.paint    
    end


  end

end 
