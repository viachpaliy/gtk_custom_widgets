require "gobject/gtk/autorun"
require "cairo-gobject/cairo"
require "gtk_custom_widgets"

class CairoApp
  @window : Gtk::Window
  @bbox : Gtk::ButtonBox
 
  delegate show_all, to: @window

  def initialize
    @window = Gtk::Window.new
    @window.title = "Gtk::Container extension demo"
    @window.resize 750,100
    @window.connect "destroy", &->Gtk.main_quit
    vbox = Gtk::Box.new :vertical, 2
    bbox = Gtk::ButtonBox.new :horizontal
    (1..9).each do |i|
      btn = Gtk::Button.new_with_label i.to_s
      btn.name = "btn" + i.to_s
      btn.on_clicked { puts btn.name }
      bbox.pack_start(btn, expand = true, fill = true, padding = 2)
    end
    vbox.pack_start(bbox, expand = false, fill = true, padding = 2)
    hbox = Gtk::Box.new :horizontal, 2
    hide_btn = Gtk::Button.new_with_label "hide buttons"
    hide_btn.on_clicked {hide_buttons}
    hbox.pack_start(hide_btn, expand = true, fill = true, padding = 2) 
    show_btn = Gtk::Button.new_with_label "show buttons"
    show_btn.on_clicked {show_buttons} 
    hbox.pack_start(show_btn, expand = true, fill = true, padding = 2)
    @bbox = bbox.as Gtk::ButtonBox
    vbox.pack_start(hbox, expand = false, fill = true, padding = 2)
    @window.add vbox
  end

  def hide_buttons
    @bbox.child_array.each do |widget|
      widget.hide
    end
    
  end

  def show_buttons
    @bbox.child_array.each do |widget|
      widget.show
    end
  end 
 
 
end

app=CairoApp.new
app.show_all
