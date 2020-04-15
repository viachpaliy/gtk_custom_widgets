require "gobject/gtk/autorun"
require "cairo-gobject/cairo"
require "gtk_custom_widgets"

class CairoApp
  @window : Gtk::Window
 
  delegate show_all, to: @window

  def initialize
    @window = Gtk::Window.new
    @window.title = "TimerColon demo"
    @window.resize  500,200
    @window.connect "destroy", &->Gtk.main_quit
    dh = GtkCustomWidgets::DigitalDisplay(GtkCustomWidgets::SevenSegmentDisplay).new 
    td = GtkCustomWidgets::TimerColon.new
    dm = GtkCustomWidgets::DigitalDisplay(GtkCustomWidgets::SevenSegmentDisplay).new 
    td2 = GtkCustomWidgets::TimerColon.new
    ds = GtkCustomWidgets::DigitalDisplay(GtkCustomWidgets::SevenSegmentDisplay).new 
    hb = Gtk::Box.new :horizontal, 0
    hb.pack_start(dh, expand = true, fill = true, padding = 0)
    hb.pack_start(td, expand = true, fill = true, padding = 0)
    hb.pack_start(dm, expand = true, fill = true, padding = 0)
    hb.pack_start(td2, expand = true, fill = true, padding = 0)
    hb.pack_start(ds, expand = true, fill = true, padding = 0)
    dh.print Time.utc.hour
    dm.print Time.utc.minute
    ds.print Time.utc.second
    td.active = true
    td2.active = true 
    @window.add hb
  end

end

app=CairoApp.new
app.show_all
