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
    vb = Gtk::Box.new :vertical, 2
    vb.pack_start(dd, expand = true, fill = true, padding = 2)
    hb = Gtk::Box.new :horizontal, 2
    label = Gtk::Label.new "Enter integer "
    hb.pack_start(label, expand = false, fill = true, padding = 2)
    entry = Gtk::Entry.new
    entry.on_activate do |entry|
      if entry.text.to_i?
        dd.on_color = GtkCustomWidgets::Color.new 0.0, 0.0, 1.0
        dd.print entry.text.to_i
      else
        dd.on_color = GtkCustomWidgets::Color.new 1.0, 0.0, 0.0
        dd.print "Error"
      end
    end
    hb.pack_start(entry, expand = false, fill = true, padding = 2)
    vb.pack_start(hb, expand = false, fill = true, padding = 2)
    hbs = Gtk::Box.new :horizontal, 2
    labels = Gtk::Label.new "Enter string "
    hbs.pack_start(labels, expand = false, fill = true, padding = 2)
    entrys = Gtk::Entry.new
    entrys.on_activate do |entry|
      dd.on_color = GtkCustomWidgets::Color.new 0.0, 1.0, 0.0
      dd.print entry.text
    end
    hbs.pack_start(entrys, expand = false, fill = true, padding = 2)
    vb.pack_start(hbs, expand = false, fill = true, padding = 2)
    @window.add vb
  end

 

end

app=CairoApp.new
app.show_all
