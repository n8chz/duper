# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Click listener for + buttons
plusClick = ->
  dataClass = $(this).data "class"
  dest = $(this).data "destination"
  popup = $("#"+dataClass+"_popup")
  popup.find("input[type!=submit]").val ""
  popup.find("input[name=input]").remove()
  popup.find("form").append($("<input>").attr("name", "input").attr("type", "hidden").val(dest))
  popup.show()
  popup.find("[autofocus]").focus()
  placeholderInput = $("#"+dest)
  idInput = $("##{dest}_id")
  # $(document).off "ajaxSuccess" # h/t http://stackoverflow.com/a/34929325/948073
  $(document).ajaxSuccess (event, xhr, settings) ->
    console.log xhr.responseText
    obj = JSON.parse xhr.responseText
    if obj.input == dest
      # insert "friendly description" in visible field:
      placeholderInput.val obj.friendlyName
      idInput.val obj.id
      placeholderInput.focus()

# Function for adding up debits or credits
# Function for adding up debits or credits
columnTotal = (columnClass) ->
  $(columnClass).get().map (e) ->
    Number e.value
  .reduce (x, y) -> x+y

checkBalance = ->
  # enable form submission only if debits == credits
  totalDebits = columnTotal ".debit"
  $("#total_debits").text totalDebits.toFixed(2)
  totalCredits = columnTotal ".credit"
  $("#total_credits").text totalCredits.toFixed(2)
  difference = Math.abs(totalDebits - totalCredits)
  $("#imbalance").text difference.toFixed(2)
  imbalance = (difference > 0.015)
  # Make sure all entries are tied to an account!
  console.log "\nimbalance(0): "+imbalance
  if !imbalance
    imbalance = $(".entry_account").is ->
      console.log "account number: "+$(this).val()
      $(this).val() == "" 
  console.log "imbalance(1): "+imbalance
  $("#post").attr "disabled", imbalance

multiplicandBlur = ->
  console.log "element blurred"
  terms = ($(this).attr "name").split /\]?\[/
  base = "##{terms[0]}_#{terms[1]}_"
  price = Number($(base+"price").val())
  qty = Number($(base+"qty").val())
  $(base+"debit").val Math.floor(100*price*qty+0.5)/100.0
  checkBalance()

# Increment integer substrings of id and name attributes by 2
incrementIndex = (fieldset) ->
  # Clear text entered on previous line
  fieldset.find("input[value!='1']").val "" 
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
        $("##{$(this).attr "id"}_id").val ui.item.value
        checkBalance() # because apparently .autocomplete overrides element events
        console.log "foo"
        false

  # Set up input elements for foreign keys as autofill, so we can see the
  # referenced objects as descriptive strings rather than abstract keys
  $(".autocomplete").each addAutocomplete

  # Add event listeners to the buttons which will be used to create additional
  # credit and debit entries for the transaktion about to be created
  $(".replicator").click ->
    parent = $(this).parent()
    newFieldset = incrementIndex(parent.find(".replic").last().clone())
    $(this).prev().append(newFieldset)
    # $(this).before(newFieldset)
    newFieldset.find(".autocomplete").each addAutocomplete
    # add same click listener that was added to original copy
    newFieldset.find(".plus").click plusClick
    newFieldset.find(".multiplicand").blur multiplicandBlur
    newFieldset.find("input").first().focus()

  # Add event listeners to .plus buttons so their associated modal forms will be made visible.
  $(".plus").click plusClick

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
      multiplicandBlur()
    $(this).keydown (event) ->
      if event.which == 27
        $(this).closest("div").hide()

  $(".multiplicand").blur multiplicandBlur

  $(".money").blur ->
    $(this).val Number($(this).val()).toFixed 2

$(document).ready(ready);
$(document).on('page:load', ready);

