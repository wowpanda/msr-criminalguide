
$(function() {
    window.addEventListener('message', function(event) {
        var item = event.data;
        
		if (item.showPlayerMenu == true) {
			$('html').css('display','block');
		} else if (item.showPlayerMenu == false) {
			$('html').css('display','none');
		}
    });
	
	$("#close-btn").click(function(){
        $.post('http://msr-criminalguide/spawnButton', JSON.stringify({}));
		$('html').css('display','none');
    });
});