module ApplicationHelper
  def flash_class(level)
    'alert alert-dismissable ' + case level
                                   when :notice then
                                     'alert-info'
                                   when :success then
                                     'alert-success'
                                   when :error then
                                     'alert-danger'
                                   when :alert then
                                     'alert-danger'
                                   else
                                     ''
                                 end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? current_sort_class(sort_direction) : nil
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to({sort: column, direction: direction}) do
      content_tag(:div, title << ' ', style: 'display: inline;') +
      if css_class
        content_tag(:span, nil, class: css_class)
      end
    end
  end

  def current_sort_class(sort_direction)
    (sort_direction == 'desc') ? 'glyphicon glyphicon-chevron-down' : 'glyphicon glyphicon-chevron-up'
  end

end
