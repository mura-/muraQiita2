$(document).on 'ready page:load', ->
  new Vue
    el: '#editor',
    data:
      input: ''
    filters:
      marked: marked
