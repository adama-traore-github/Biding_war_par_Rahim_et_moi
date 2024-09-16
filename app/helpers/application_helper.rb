module ApplicationHelper
    def active_class(controller_name)
      'active' if current_page?(controller: controller_name)
    end
  end
  