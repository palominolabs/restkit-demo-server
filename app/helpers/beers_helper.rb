module BeersHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "beer-index-current #{current_sort_class(sort_direction)}" : nil
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, {sort: column, direction: direction}, {class: css_class}
  end

  def current_sort_class(sort_direction)
    (sort_direction == 'desc') ? 'glyphicon glyphicon-arrow-down' : 'glyphicon glyphicon-arrow-up'
  end
end
