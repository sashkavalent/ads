$( document ).ajaxComplete(function() {
  hermitage.init();
});

$( document ).ready(function(){
  $('.selectpicker').selectpicker();

  setTagit();
  setInputValueBeforeSubmit();

});

function setTagit () {

  if (gon.keywords_hint) {
    var keywordsHint = gon.keywords_hint.map(function(g){ return g.name });
  }

  var settings = {
    availableTags: keywordsHint,
    autocomplete: {delay: 0, minLength: 1},
    removeConfirmation: true
  };

  $(".writable#keywords").tagit(settings);

  settings.readOnly = true;
  $(".readOnly#keywords").tagit(settings);

  if (gon.keywords) {
    var keywords = gon.keywords.map(function(g){ return g.name });
  }
  for(key in keywords) {
    $("#keywords").tagit("createTag", keywords[key]);
  }

}

function setInputValueBeforeSubmit () {
  $(':submit').click(function(){
    var keywords = $("#keywords").tagit("assignedTags").join(',');
    $('.tagit-hidden-field').last().val(keywords);
  })
}
