# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  acInputs = $("input[data-value]")
  acInputs.map ->
    $(this).autocomplete
      source: $(this).data("source")
      select: (event, ui) ->
        $(this).val ui.item.label
        $("#"+$(this).data("value")).val ui.item.value
        false

# $(".replicator").click ->
#   parent = $(this).parent()
#   newFieldset = parent.find(".replic").last().clone()
#   newFieldset.find("input[name]").each ->
#     oldName = $(this).attr("name")
#     newName = oldName.replace /\[(\d*)\]/ (match, p1) -> "["+(Number(p1)+1)+"]"
#     $(this).attr("name", newName)
#   parent.append(newFieldset)

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
    $(this).before(newFieldset)
        
