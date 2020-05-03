module Gtk

  class Container
 
    alias GtkCallback = Gtk::Widget, Void* ->

    def foreach(&__block : GtkCallback)
      __callback = ->(_arg0 : LibGtk::Widget*, _arg1 : Pointer(Void)){
       __return_value = __block.call(Widget.new(_arg0), _arg1)
       __return_value
      }
      foreach(__callback, nil)      
    end

  end

end
