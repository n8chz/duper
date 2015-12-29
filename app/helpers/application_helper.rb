module ApplicationHelper

 # create an autofill text input followed by a button followed by a hidden text
 # input which will contain the foreign key for a referenced object.  The
 # button is for if creation of a new object is necessary because the
 # referenced object hasn't been created yet.
 def autofill_inputs model, index, fkey
  name = "#{model}[#{index}][#{fkey}_id]"
  source = "/#{fkey.pluralize}.json"
  group =
   text_field_tag nil, nil, :data => {source: source}, :class => "autocomplete"
  group << "\n"
  group << (button_tag "+", :data => {class: "#{fkey}"}, :type => "button", :title => "create new #{fkey}")
  group << "\n"
  group << (text_field_tag name, nil, :type => "hidden")
  group
 end

 def entity_form
 end

end
