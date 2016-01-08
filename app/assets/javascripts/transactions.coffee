# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

placeholder = (klass, obj) ->
  switch klass
    when "entity" then obj.name
    when "account" then obj.name
    when "item" then "#{obj.brand} #{obj.gendesc} #{obj.size} #{obj.unit}"
    else "???"

$ ->

  # Set up input elements for foreign keys as autofill, so we can see the
  # referenced objects as descriptive strings rather than abstract keys
  addAutocomplete = ->
    $(this).autocomplete
      source: $(this).data("source")
      select: (event, ui) ->
        $(this).val ui.item.label
        # following line is a kludge, assumes next input is value
        $(this).next("input").val ui.item.value
        false

  # Set up input elements for foreign keys as autofill, so we can see the
  # referenced objects as descriptive strings rather than abstract keys
  $(".autocomplete").each addAutocomplete

  # Add event listeners to the buttons which will be used to create additional
  # credit and debit entries for the transaction about to be created
  $(".replicator").click ->
    parent = $(this).parent()
    newFieldset = parent.find(".replic").last().clone()
    seek = /\[\d*\]/
    newFieldset.find("[name]").each ->
      oldName = $(this).attr("name")
      matchResult = oldName.match(seek)
      if matchResult
        index = Number(matchResult[0].slice(1, -1))+2
        [left, right] = oldName.split(seek)
        newName = left+"["+index+"]"+right
        $(this).attr("name", newName)
        $(this).removeAttr("id")
    $(this).before(newFieldset)
    newFieldset.find(".autocomplete").each addAutocomplete

  # Add event listeners to .plus buttons so their associated modal forms will be made visible.
  $(".plus").click ->
    dataClass = $(this).data "class"
    $("#"+dataClass+"_popup").show()
    dest = $(this).data "destination"
    destInput = $("#"+dest);
    $(document).ajaxSuccess (event, xhr, settings) ->
      if settings.url == (destInput.data "source")
        obj = JSON.parse xhr.responseText
        # insert "friendly description" in visible field:
        destInput.val placeholder dataClass, obj
        $("#"+dest+"_id").val obj.id

  # Make forms in popups remote,
  # see http://edgeguides.rubyonrails.org/working_with_javascript_in_rails.html#form-for
  $(".popup>form").each ->
    $(this).data "remote", "true"
    # add .json to end of action attribute
    oldAction = $(this).attr "action"
    $(this).attr "action", oldAction+".json"
    # Make popups stay up only until done entering data
    $(this).submit ->
      $(this).closest("div").hide()
    $(this).keydown (event) ->
      if event.which == 27
        $(this).closest("div").hide()

