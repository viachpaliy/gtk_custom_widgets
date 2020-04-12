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
    @window.add dd
  end

 

end

app=CairoApp.new
app.show_all
