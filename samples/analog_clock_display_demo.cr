require "gobject/gtk/autorun"
require "cairo-gobject/cairo"
require "gtk_custom_widgets"

class CairoApp
  @window : Gtk::Window
  @clock : GtkCustomWidgets::AnalogClockDisplay
 
  delegate show_all, to: @window

  def initialize
    @window = Gtk::Window.new
    @window.title = "AnalogClockDisplay demo"
    @window.resize  300,300
    @window.connect "destroy", &->Gtk.main_quit
    @clock = GtkCustomWidgets::AnalogClockDisplay.new 
    @window.add @clock
  end

  def show_time
    @clock.time = Time.utc
    puts Time.utc
  end

end

app=CairoApp.new
app.show_all
app.show_time
