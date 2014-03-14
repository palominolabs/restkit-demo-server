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
end
