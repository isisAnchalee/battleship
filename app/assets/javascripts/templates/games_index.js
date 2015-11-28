window.GamesIndex = (function() {
  var namespace;

  function initialize(){
    namespace = $("[data-controller='games'][data-action='index']");
    if (namespace.length > 0) {
      setupListeners();
    }
  };

  function setupListeners(){
    toggleInScore();
    toggleOutScore();
  };

  function toggleInScore(){
    namespace.find($('tr[data-id]')).mouseenter(function(e){
      var $toggleEl = $(this).find($('.score'))
      $toggleEl.fadeIn();
    });
  };

  function toggleOutScore(){
    namespace.find($('tr[data-id]')).mouseleave(function(e){
      var $toggleEl = $(this).find($('.score'))
      $toggleEl.fadeOut();
    });
  }

  return {
    initialize: initialize
  };

})();
