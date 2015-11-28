window.GamesIndex = (function() {
  var $namespace;

  function initialize(){
    $namespace = $("[data-controller='games'][data-action='index']");
    if ($namespace.length > 0) {
      setupListeners();
    }
  };

  function setupListeners(){
    toggleInScore();
    toggleOutScore();
    joinGame();
  };

  function toggleInScore(){
    $namespace.find($('tr[data-id]')).mouseenter(function(e){
      var $toggleEl = $(this).find($('.score'))
      $toggleEl.fadeIn();
    });
  };

  function joinGame(){
    $namespace.find($('tr[data-id]')).click(function(e){
      var $url = $(this).data('url');
      $.ajax({
        url : $url,
        type: "POST",
        dataType: 'json',
        complete: function(data, resp) {
          console.log(data, resp)
        }
      });
    });
  };

  function toggleOutScore(){
    $namespace.find($('tr[data-id]')).mouseleave(function(e){
      var $toggleEl = $(this).find($('.score'))
      $toggleEl.fadeOut();
    });
  }

  return {
    initialize: initialize
  };

})();
