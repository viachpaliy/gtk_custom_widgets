require "gobject/gtk/autorun"
require "cairo-gobject/cairo"
require "gtk_custom_widgets"

alias GCW = GtkCustomWidgets

window = Gtk::Window.new(title: "Shape demo", border_width: 10)
window.connect "destroy", &->Gtk.main_quit
window.resize 500,300
s_p = GCW::Point.new 10, 20
e_p = GCW::Point.new 470, 270
lg = GCW::LineGeometry.new s_p, e_p
br = GCW::LineStyle.new
br.color = GCW::Color.new "darkcyan"
br.width = 10
line = GCW::Shape.new
line.geometry = lg
line.stroke = br
line2 = GCW::Shape.new
line2.geometry = GCW::LineGeometry.new GCW::Point.new(10, 270), GCW::Point.new(470, 20)
line2.stroke = GCW::SolidColorBrush.new GCW::Color.new("blue")
line3 = GCW::Shape.new
line3.geometry = GCW::LineGeometry.new GCW::Point.new(250, 20), GCW::Point.new(250, 270)
line3.stroke = GCW::SolidColorBrush.new GCW::Color.new("darkgreen")
line2.add line3
line.add line2
geo = GCW::PolygonGeometry.new
[GCW::Point.new(50, 20), GCW::Point.new(250, 120), GCW::Point.new(50, 220)].each do |point|
  geo.points << point
end 
polygon = GCW::Shape.new 
polygon.geometry = geo
polygon.stroke = GCW::SolidColorBrush.new GCW::Color.new("bisque")
polygon.fill = GCW::SolidColorBrush.new GCW::Color.new("darkgoldenrod")
line3.add polygon
window.add line

window.show_all

