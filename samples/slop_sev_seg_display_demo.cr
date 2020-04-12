require "gobject/gtk/autorun"
require "cairo-gobject/cairo"
require "../src/gtk_custom_widgets"

class CairoApp
  @window : Gtk::Window
 
  delegate show_all, to: @window

  def initialize
    @window = Gtk::Window.new
    @window.title = "SlopSevSegDisplay"
    @window.resize 650,500
    @window.connect "destroy", &->Gtk.main_quit
    ssd = GtkCustomWidgets::SlopSevSegDisplay.new
    ssd.seg_width = 0.1
    hb = Gtk::Box.new :horizontal, 2
    symbols = "0123456789AbCcdEFGHhIiJLnOoPqrStUuY_-='\u{00B0}[] "
    j = 0
    bbox = Gtk::ButtonBox.new :vertical
     symbols.each_char do |ch|
      btn = Gtk::Button.new_with_label ch.to_s
      btn.on_clicked { ssd.char = ch }
      bbox.pack_start(btn, expand = true, fill = true, padding = 2)
      j = j + 1 
      if j > 10
        hb.pack_start(bbox, expand = false, fill = true, padding = 2)
        bbox = Gtk::ButtonBox.new :vertical
        j = 0
      end
    end
    hb.pack_start(bbox, expand = false, fill = true, padding = 2)
    hb.pack_start(ssd, expand = true, fill = true, padding = 2)
    @window.add hb
  end

 

end

app=CairoApp.new
app.show_all
