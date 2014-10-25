function updateCountdown() {
	
	var $countdown = $('.countdown');
	
    // 100 is the max message length
    var remaining = 100 - $('#micropost_content').val().length;
    $countdown.text(remaining + ' characters remaining.');
	
	var color = 'grey';
	if (remaining < 20) { color = 'black'; }
	if (remaining < 10) { color = 'red'; }
	$countdown.css( { color: color} );
}

$(document).ready(function($) {
    updateCountdown();
    $micropost_content = $('#micropost_content');

    $micropost_content.change(updateCountdown);
    $micropost_content.keyup(updateCountdown);
    $micropost_content.keydown(updateCountdown);
});