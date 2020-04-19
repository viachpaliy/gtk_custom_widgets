require "gobject/gtk/autorun"
require "cairo-gobject/cairo"
require "gtk_custom_widgets"

class CairoApp
  @window : Gtk::Window
 
  delegate show_all, to: @window

  def initialize
    @window = Gtk::Window.new
    @window.title = "Clock demo"
    @window.resize  500,200
    @window.connect "destroy", &->Gtk.main_quit
    hb1 = Gtk::Box.new :horizontal, 2
    clock1 = GtkCustomWidgets::Clock(GtkCustomWidgets::DigitalClockDisplay).new
    clock1.blink = true
    hb1.pack_start(clock1, expand = true, fill = true, padding = 2)
    clock2 = GtkCustomWidgets::Clock(GtkCustomWidgets::AnalogClockDisplay).new
    hb1.pack_start(clock2, expand = true, fill = true, padding = 2)
    hb2 = Gtk::Box.new :horizontal, 2
    btn0 = Gtk::Button.new_with_label "start"
    btn0.on_clicked {clock1.start
                     clock2.start }
    hb2.pack_start(btn0, expand = true, fill = false, padding = 2)
    btn1 = Gtk::Button.new_with_label "stop"
    btn1.on_clicked { clock1.stop
                      clock2.stop }
    hb2.pack_start(btn1, expand = true, fill = false, padding = 2)
    vb = Gtk::Box.new :vertical, 2
    vb.pack_start(hb1, expand = true, fill = true, padding = 2)
    vb.pack_start(hb2, expand = false, fill = true, padding = 2)
    @window.add vb
  end

end

app=CairoApp.new
app.show_all
