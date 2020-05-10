module Gtk

  class Container
    
    def child_array
      childs = Array(Gtk::Widget).new
      list = LibGtk.container_get_children(@pointer.as(LibGtk::Container*)).as(LibGLib::List*)
      if !list.value.data.null?
        childs << Gtk::Widget.new list.value.data.as(LibGtk::Widget*)
        while !list.value.next_.null?
          list = list.value.next_.as(LibGLib::List*)
          if !list.value.data.null?
            childs << Gtk::Widget.new list.value.data.as(LibGtk::Widget*)
          end
        end
      end
      childs
    end

  end

end
