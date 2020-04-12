require "gobject/gtk/autorun"
require "cairo-gobject/cairo"
require "gtk_custom_widgets"

class CairoApp
  @window : Gtk::Window
 
  delegate show_all, to: @window

  def initialize
    @window = Gtk::Window.new
    @window.title = "Eight Segment Display"
    @window.resize 500,500
    @window.connect "destroy", &->Gtk.main_quit
    ssd = GtkCustomWidgets::EightSegmentDisplay.new
    ssd.seg_width = 0.1
    ssd.on_color = GtkCustomWidgets::Color.new 1.0, 0.31, 0.0
    hb = Gtk::Box.new :horizontal, 2
    bbox1 = Gtk::ButtonBox.new :vertical
    btn0 = Gtk::Button.new_with_label "0"
    btn0.on_clicked { ssd.hex = 0 }
    bbox1.pack_start(btn0, expand = true, fill = true, padding = 2)
    btn1 = Gtk::Button.new_with_label "1"
    btn1.on_clicked { ssd.hex = 1 }
    bbox1.pack_start(btn1, expand = true, fill = true, padding = 2)
    btn2 = Gtk::Button.new_with_label "2"
    btn2.on_clicked { ssd.hex = 2 }
    bbox1.pack_start(btn2, expand = true, fill = true, padding = 2)
    btn3 = Gtk::Button.new_with_label "3"
    btn3.on_clicked { ssd.hex = 3 }
    bbox1.pack_start(btn3, expand = true, fill = true, padding = 2)
    btn4 = Gtk::Button.new_with_label "4"
    btn4.on_clicked {ssd.hex = 4 }
    bbox1.pack_start(btn4, expand = true, fill = true, padding = 2)
    btn5 = Gtk::Button.new_with_label "5"
    btn5.on_clicked { ssd.hex = 5 }
    bbox1.pack_start(btn5, expand = true, fill = true, padding = 2)
    hb.pack_start(bbox1, expand = false, fill = true, padding = 2)

    bbox2 = Gtk::ButtonBox.new :vertical
    btn6 = Gtk::Button.new_with_label "6"
    btn6.on_clicked {ssd.hex = 6 }
    bbox2.pack_start(btn6, expand = true, fill = true, padding = 2)
    btn7 = Gtk::Button.new_with_label "7"
    btn7.on_clicked { ssd.hex = 7 }
    bbox2.pack_start(btn7, expand = true, fill = true, padding = 2)
    btn8 = Gtk::Button.new_with_label "8"
    btn8.on_clicked { ssd.hex = 8 }
    bbox2.pack_start(btn8, expand = true, fill = true, padding = 2)
    btn9 = Gtk::Button.new_with_label "9"
    btn9.on_clicked { ssd.hex = 9 }
    bbox2.pack_start(btn9, expand = true, fill = true, padding = 2)
    btna = Gtk::Button.new_with_label "A"
    btna.on_clicked { ssd.hex = 10 }
    bbox2.pack_start(btna, expand = true, fill = true, padding = 2)
    btnb = Gtk::Button.new_with_label "B"
    btnb.on_clicked { ssd.hex = 11 }
    bbox2.pack_start(btnb, expand = true, fill = true, padding = 2)
    hb.pack_start(bbox2, expand = false, fill = true, padding = 2)

    bbox3 = Gtk::ButtonBox.new :vertical
    btnc = Gtk::Button.new_with_label "C"
    btnc.on_clicked { ssd.hex = 12 }
    bbox3.pack_start(btnc, expand = true, fill = true, padding = 2)
    btnd = Gtk::Button.new_with_label "D"
    btnd.on_clicked { ssd.hex = 13 }
    bbox3.pack_start(btnd, expand = true, fill = true, padding = 2)
    btne = Gtk::Button.new_with_label "E"
    btne.on_clicked { ssd.hex = 14 }
    bbox3.pack_start(btne, expand = true, fill = true, padding = 2)
    btnf = Gtk::Button.new_with_label "F"
    btnf.on_clicked { ssd.hex = 15 }
    bbox3.pack_start(btnf, expand = true, fill = true, padding = 2)
    btn_minus = Gtk::Button.new_with_label "-"
    btn_minus.on_clicked { ssd.set_seg(false, false, false, false, false, false, true) }
    bbox3.pack_start(btn_minus, expand = true, fill = true, padding = 2)
    btn_dot = Gtk::Button.new_with_label "."
    btn_dot.on_clicked { ssd.set_dot(!ssd.dot) }
    bbox3.pack_start(btn_dot, expand = true, fill = true, padding = 2)
    hb.pack_start(bbox3, expand = false, fill = true, padding = 2)
    hb.pack_start(ssd, expand = true, fill = true, padding = 2)
    @window.add hb
  end

 

end

app=CairoApp.new
app.show_all
