require "gobject/gtk/autorun"
require "cairo-gobject/cairo"
require "gtk_custom_widgets"

window = Gtk::Window.new(title: "DataBar demo", border_width: 10)
window.connect "destroy", &->Gtk.main_quit
window.resize 500,300
s_p = GtkCustomWidgets::Point.new 10, 20
e_p = GtkCustomWidgets::Point.new 480, 280
lg = GtkCustomWidgets::LineGeometry.new s_p, e_p
br = GtkCustomWidgets::LineStyle.new
br.color = GtkCustomWidgets::Color.new 0.0, 0.0, 1.0
lg.brush = br
line = GtkCustomWidgets::Shape(GtkCustomWidgets::LineGeometry).new
line.geometry = lg
window.add line

window.show_all

