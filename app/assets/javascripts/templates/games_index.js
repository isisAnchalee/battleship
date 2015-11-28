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
    var path = ''
    $namespace.find($('tr[data-id]')).click(function(e){
      var $this = $(this),
           $url = $this.data('url'),
            $id = $this.data('id');
      sendAjaxRequest($url, handleSuccess, "POST")
    });
  };

  function sendAjaxRequest(url, success, method){
    $.ajax({
      url : url,
      type: method,
      dataType: 'json',
      complete: function(data, resp) {
        success(data, resp);
      }
    });   
  };

  function handleSuccess(data){
    var path;
    var res = JSON.parse(data.responseText);
    path = res['start_game'] ? '/games/' + res.id : '/'
    createFlashMessage('This game is full!');
  };

  function createFlashMessage(msg){
     $flash = $('<div>').addClass('fake-flash hidden').text(msg);
     $('.fake-flashes').append($flash).fadeIn(1000);

     setTimeout(function(){
       $flash.fadeOut(500);
     }, 1000);
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
