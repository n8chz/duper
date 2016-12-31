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
    # console.log xhr.responseText
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

# In cases when an item is specified, and previous transactions with that item
# are all associated with the same account, autofill account field.
itemBlur = ->
  # $(this).next().val now contains the item number
  item_id = $(this).next().val()
  id = $(this).attr "id"
  $.ajax
    error: (jqXHR, textStatus, errorThrown) ->
    method: "GET"
    success: (data, textStatus, jqXHR) ->
      # alert JSON.stringify data
      if data.length == 1
        datum = data.pop()
        # place retrieved data in account fields
        pathDest = id.replace "item", "account"
        idDest = pathDest+"_id"
        $("##{idDest}").val datum.id
        $("##{pathDest}").val datum.account_pathname
    url: "/items/#{item_id}/accounts.json"

checkBalance = ->

  # enable form submission only if debits == credits
  totalDebits = columnTotal ".debit"
  $("#total_debits").text totalDebits.toFixed(2)
  totalCredits = columnTotal ".credit"
  $("#total_credits").text totalCredits.toFixed(2)
  difference = Math.abs(totalDebits - totalCredits)
  $("#imbalance").text difference.toFixed(2)
  imbalance = (difference > 0.015)
  # Also refuse posting if data not filled in...
  # imbalance |= $("#date").val() == ""
  # ...or there is not at least one credit entry.
  # imbalance |= $(".transaktion_entity").val() == ""

  # Make sure all entries are tied to an account!
  if !imbalance
    imbalance = $(".replic").is ->
      account = $(this).find(".entry_account").val()
      money = $(this).find(".money").val()
      # console.log " account ##{account}: $#{money}"
      account == "" && money > 0

  # disable post button if posting criteria are not met
  $("#post").attr "disabled", imbalance

arithmEval = (exp) ->
  # remove any whitespace characters:
  exp = exp.split(/\s/).join("")
  # verify that only legal characters remain:
  if exp.match /^[0-9+\-*\/().]+$/
    console.log "#{exp} -> #{eval exp}"
    # consider the string sanitized, use eval function:
    eval exp
  else
    # something weird has been included
    alert "?"

multiplicandBlur = ->
  $(this).val arithmEval $(this).val()
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

  $("h1").text "enter new purchase transaction" # see if we got this far

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
    newFieldset.find(".item").blur itemBlur
    newFieldset.find(".money").blur moneyBlur

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

  $(".item").blur itemBlur

  $(".money").blur ->
    $(this).val Number($(this).val()).toFixed 2


$(document).ready ready 

# see http://guides.rubyonrails.org/working_with_javascript_in_rails.html#page-change-events
$(document).on 'turbolinks:load', ready 

