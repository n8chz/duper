# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Click listener for + buttons
plusClick = ->
  dataClass = $(this).data "class"
  popup = $("#"+dataClass+"_popup")
  popup.show()
  popup.find("[autofocus]").focus()
  dest = $(this).data "destination"
  destInput = $("#"+dest);
  $(document).ajaxSuccess (event, xhr, settings) ->
    if settings.url == (destInput.data "source")
      obj = JSON.parse xhr.responseText
      # insert "friendly description" in visible field:
      destInput.val placeholder dataClass, obj
      $("#"+dest+"_id").val obj.id

# Generate friendly display strings for result of create.json
# so newly created objects can look like previously existing
# ones selected via autocomplete:
placeholder = (klass, obj) ->
  switch klass
    when "entity" then obj.name
    when "account" then obj.name
    when "item" then "#{obj.brand} #{obj.gendesc} #{obj.size} #{obj.unit}"
    else "???"

# Increment integer substrings of id and name attributes by 2
incrementIndex = (fieldset) ->
  # Clear text entered on previous line
  fieldset.find("input").val ""
  ["name", "id", "data-destination"].forEach (attrName) ->
    fieldset.find("[#{attrName}]").each ->
      old = $(this).attr(attrName)
      # oldIndex = old.match /\d?/g
      oldIndex = /\d+/.exec old
      if oldIndex
        newIndex = Number(oldIndex[0])+2
        [left, right] = old.split(oldIndex)
        $(this).attr(attrName, left+newIndex+right)
  fieldset

ready = -> # h/t http://stackoverflow.com/a/18770589/948073

  $("#date").datepicker
    changeMonth: true
    changeYear: true
    dateFormat: "yy-mm-dd"

  # Set up input elements for foreign keys as autofill, so we can see the
  # referenced objects as descriptive strings rather than abstract keys
  addAutocomplete = ->
    $(this).autocomplete
      source: $(this).data("source")
      select: (event, ui) ->
        $(this).val ui.item.label
        # following line is a kludge, assumes next input is value
        $("##{$(this).attr "id"}_id").val ui.item.value
        $($(this).attr("id")).val ui.item.value
        # $(this).next("input").val ui.item.value
        false

  # Set up input elements for foreign keys as autofill, so we can see the
  # referenced objects as descriptive strings rather than abstract keys
  $(".autocomplete").each addAutocomplete

  # Add event listeners to the buttons which will be used to create additional
  # credit and debit entries for the transaktion about to be created
  $(".replicator").click ->
    parent = $(this).parent()
    newFieldset = incrementIndex(parent.find(".replic").last().clone())
    $(this).before(newFieldset)
    newFieldset.find(".autocomplete").each addAutocomplete
    # add same click listener that was added to original copy
    newFieldset.find(".plus").click plusClick

  # Add event listeners to .plus buttons so their associated modal forms will be made visible.
  $(".plus").click ->
    dataClass = $(this).data "class"
    popup = $("#"+dataClass+"_popup")
    popup.show()
    popup.find("[autofocus]").focus()
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

$(document).ready(ready);
$(document).on('page:load', ready);

