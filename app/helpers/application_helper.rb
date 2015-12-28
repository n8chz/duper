module ApplicationHelper

 def autofill_inputs model, index, fkey
  value ="#{fkey}_#{index}"
  # source = raw "<%= #{fkey.pluralize}_path(:json) %>"
  source = "/#{fkey.pluralize}.json"
  group =
   text_field_tag nil, nil, :data => {value: value, source: source}
  group << "\n"
  group <<
   (button_tag "+", :data => {class: "#{fkey}"}, :type => "button", :title => "create new #{fkey}")
  group << "\n"
  group << (text_field_tag "#{model}[#{index}][#{fkey}_id]", nil, :id => value, :type => "hidden")
  group
 end

end
