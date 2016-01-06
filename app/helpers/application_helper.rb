module ApplicationHelper

 # create an autofill text input followed by a button followed by a hidden text
 # input which will contain the foreign key for a referenced object.  The
 # button is for if creation of a new object is necessary because the
 # referenced object hasn't been created yet.
 def autofill_inputs model, index, fkey
  name = "#{model}[#{index}][#{fkey}_id]"
  id = "#{model}_#{index}_#{fkey}"
  source = "/#{fkey.pluralize}.json"
  group = text_field nil, nil, :data => {source: source}, :class => "autocomplete", :id => id
  group << (text_field nil, nil, :type => "hidden", :name => name, :id => "#{id}_id")
  group << (button_tag "+", :data => {destination: id, class: fkey}, :type => "button", :title => "create new #{fkey}", :class => "plus")
  group
 end

end

