require "gobject/gtk/autorun"
require "cairo-gobject/cairo"
require "gtk_custom_widgets"

alias GCW = GtkCustomWidgets

window = Gtk::Window.new(title: "DataBar demo", border_width: 10)
window.connect "destroy", &->Gtk.main_quit
window.resize 500,300
s_p = GCW::Point.new 10, 20
e_p = GCW::Point.new 480, 280
lg = GCW::LineGeometry.new s_p, e_p
br = GCW::LineStyle.new
br.color = GCW::Color.new "darkcyan"
br.width = 10
lg.brush = br
line = GCW::Shape(GCW::LineGeometry).new
line.geometry = lg
l2 = GCW::LineGeometry.new GCW::Point.new(10, 80), GCW::Point.new(450, 80)
l2.brush = br
line2 = GCW::Shape(GCW::LineGeometry).new
line2.geometry = l2
line2.add line
window.add line2

window.show_all

