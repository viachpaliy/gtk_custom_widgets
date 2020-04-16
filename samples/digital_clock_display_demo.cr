require "gobject/gtk/autorun"
require "cairo-gobject/cairo"
require "gtk_custom_widgets"

class CairoApp
  @window : Gtk::Window
  @clock : GtkCustomWidgets::DigitalClockDisplay
 
  delegate show_all, to: @window

  def initialize
    @window = Gtk::Window.new
    @window.title = "DigitalClockDisplay demo"
    @window.resize  500,200
    @window.connect "destroy", &->Gtk.main_quit
    @clock = GtkCustomWidgets::DigitalClockDisplay.new 
    @window.add @clock
  end

  def show_time
    t = Time.utc
    @clock.time = t
  end

end

app=CairoApp.new
app.show_all
app.show_time
