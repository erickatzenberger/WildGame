//Changes background color of textfield upon focus

$(':input').focusin(function() {
$(this).css('background-color', '#ffffcc');
});

$(':input').focusout(function() {
$(this).css('background-color', '#ffffff');
});

//end bg change

//Regulates behavior of textfield's default value of zero

$(document).ready(function() {
var default_0 = '0';

$('input[class="lb"], input[class="percent"], input[class="fields"]').attr('value', default_0).focus(function() {
	if ($(this).val() == default_0) {
		$(this).attr('value', '');

		}
	}).blur(function() {
	if($(this).val() == '') {
	$(this).attr('value', default_0)
	}
	});
});
//end default 0

//Calculate Sum etc.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
$(document).ready(function(){
        //iterate through each textboxes and add keyup
        //handler to trigger sum event

    $('.percent,.lb').keyup(function(){
        calculateSum();
        if ($(this).hasClass('lb')) {
            calclb();
        }
    });

	$('.percent').keyup(function(){
        percentsr();
	});
});

// !!!!!!!!! ALL Button !!!!!!!!
$('.all').change( function(){
   $('.percent').val(function() {
		return $('#' + this.id.replace(/percent/,'all')).is(':checked') ? 100 : 0;
    });
	
});

$('.all').click(function() {
    $('":text", ":checkbox"').not(this).attr('disabled', $(this).is(':checked'));
 });
