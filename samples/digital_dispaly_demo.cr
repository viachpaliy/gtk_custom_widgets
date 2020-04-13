require "gobject/gtk/autorun"
require "cairo-gobject/cairo"
require "gtk_custom_widgets"

class CairoApp
  @window : Gtk::Window
 
  delegate show_all, to: @window

  def initialize
    @window = Gtk::Window.new
    @window.title = "DigitalDisplay demo"
    @window.resize  500,200
    @window.connect "destroy", &->Gtk.main_quit
    dd = GtkCustomWidgets::DigitalDisplay(GtkCustomWidgets::EightSegmentDisplay).new 
    dd.n = 7
    dd.bg_color = GtkCustomWidgets::Color.new_from_bytes 0xCE, 0xCE, 0xCE
    dd.off_color = GtkCustomWidgets::Color.new 1.0, 1.0, 1.0
    dd.on_color = GtkCustomWidgets::Color.new 0.0, 0.0, 1.0
    #dd.print "HELLO"
    dd.print -123.45 
    @window.add dd
  end

 

end

app=CairoApp.new
app.show_all
