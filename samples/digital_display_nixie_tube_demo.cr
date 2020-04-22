require "gobject/gtk/autorun"
require "cairo-gobject/cairo"
require "gtk_custom_widgets"

class CairoApp
  @window : Gtk::Window
 
  delegate show_all, to: @window

  def initialize
    @window = Gtk::Window.new
    @window.title = "DigitalDisplay with NixieTube demo"
    @window.resize  550,200
    @window.connect "destroy", &->Gtk.main_quit
    dd = GtkCustomWidgets::DigitalDisplay(GtkCustomWidgets::NixieTube).new 
    dd.n = 10
    vb = Gtk::Box.new :vertical, 2
    vb.pack_start(dd, expand = true, fill = true, padding = 2)
    hb = Gtk::Box.new :horizontal, 2
    label = Gtk::Label.new "Enter integer "
    hb.pack_start(label, expand = false, fill = true, padding = 2)
    entry = Gtk::Entry.new
    entry.on_activate do |entry|
      if entry.text.to_i?
         dd.print entry.text.to_i
      else
        dd.print 0.0
      end
    end
    hb.pack_start(entry, expand = false, fill = true, padding = 2)
    vb.pack_start(hb, expand = false, fill = true, padding = 2)
    hbf = Gtk::Box.new :horizontal, 2
    labelfl = Gtk::Label.new "Enter float "
    hbf.pack_start(labelfl, expand = false, fill = true, padding = 2)
    entryfl = Gtk::Entry.new
    entryfl.on_activate do |entry|
      if entry.text.to_f?
        dd.print entry.text.to_f
      else
        dd.print 0.0
      end
    end
    hbf.pack_start(entryfl, expand = false, fill = true, padding = 2)
    labelfe = Gtk::Label.new "for example : 12345e-2"
    hbf.pack_start(labelfe, expand = false, fill = true, padding = 2)
    vb.pack_start(hbf, expand = false, fill = true, padding = 2)
    @window.add vb
  end

 

end

app=CairoApp.new
app.show_all
