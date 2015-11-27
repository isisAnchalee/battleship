window.StaticGamePages = (function() {
  
  function initialize(){
    autoFocusNewGameInput()
  };

  function focusInput(focusEl){
    $(focusEl).focus();
  };

  function autoFocusNewGameInput(){
    $('#wombat-img').click(function(e){
      focusInput('#new-game-field');
    });
  };

  return {
    initialize: initialize
  };

})();