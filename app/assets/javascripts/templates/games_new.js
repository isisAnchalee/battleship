window.GamesNew = (function() {
  var $namespace;

  function initialize(){
    $namespace = $("[data-controller='games'][data-action='new']");

    if ($namespace.length > 0) {
      setupListeners();
    }
  };

  function setupListeners(){
    autoFocusNewGameInput()
  };

  function focusInput($focusEl){
    $focusEl.focus();
  };

  function autoFocusNewGameInput(){
    $namespace.find($('#wombat-img')).click(function(){
      $focusEl = $namespace.find($('#new-game-field'));
      focusInput($focusEl);
    });
  };

  return {
    initialize: initialize
  };

})();