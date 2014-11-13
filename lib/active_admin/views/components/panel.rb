module ActiveAdmin
  module Views

    class Panel < ActiveAdmin::Component
      builder_method :panel

      def build(title, attributes = {})
        icon_name = attributes.delete(:icon)
        icn = icon_name ? icon(icon_name) : "".html_safe
        super(attributes)
        add_class 'panel panel-default'
        @title = div class: 'panel-heading' do
          h3 class: 'panel-title' do
            (icn + title.to_s)
          end
        end
        @contents = div(class: 'panel-body')
      end

      def add_child(child)
        if @contents
          @contents << child
        else
          super
        end
      end

      # Override children? to only report children when the panel's
      # contents have been added to. This ensures that the panel
      # correcly appends string values, etc.
      def children?
        @contents.children?
      end

      def header_action(*args)
        action = args[0]

        @title << div(class: 'header_action') do
          action
        end
      end
    end
  end
end
