$(document).ready(function() {
//Disable if frozen is selected
	$('#weight').keyup(function() {
		if(this.value !='') {
        	$('.frozenform').attr('disabled', true);
        }
		else{$(':checkbox').attr('disabled', false);}
    });
});

//Disable when none is clicked
$('.save_nothing').click(function() {
  $('#game_form .item_id, #game_form .taxidermy').attr('disabled', this.checked);
});

//disable none $('#game_form .item_id, #game_form .taxidermy')
$('#game_form .item_id, #game_form .taxidermy').click(function() {
  $('.save_nothing').attr('disabled', this.checked);
});

