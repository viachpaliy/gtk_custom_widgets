module Gtk

  class Widget

    macro gtk_widget_property(*names)
      {% for name in names %}
        {% if name.is_a?(TypeDeclaration) %}
          @{{name}}

          def {{name.var.id}} : {{name.type}}
            @{{name.var.id}}
          end

          def {{name.var.id}}=({{name.var.id}} : {{name.type}})
            @{{name.var.id}}={{name.var.id}}
            if mapped
              queue_draw
            end   
          end
        {% elsif name.is_a?(Assign) %}
          @{{name}}

          def {{name.target.id}}
            @{{name.target.id}}
          end

          def {{name.target.id}}=({{name.target.id}})
            @{{name.target.id}}={{name.target.id}}
            if mapped
              queue_draw
            end  
          end
        {% else %}
          def {{name.id}}
            {{name.id}}
          end

          def {{name.id}}=({{name.id}})
            @{{name.id}} = {{name.id}}
            if mapped
              queue_draw
            end  
          end
        {% end %}
      {% end %}
    end

  end

end
