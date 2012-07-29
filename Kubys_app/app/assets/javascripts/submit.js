//Reset button for trimmings
$('#reset_trimmings').click(function() {
	$('":text", ":checkbox"').attr('disabled', false);
	$(':checkbox').removeAttr('checked');
	 $(':text').not($('#otherid')).val('0');
});
// "Split" functions on "save_trimmings" click
$('#save_trimmings').click(function() {
	var total= $('.split:checked'),
        count=total.length;
        var split = 0;
        //iterate through each textboxes and add the values
        $(".percent").each(function() {
 
            //add only if the value is number
            if(!isNaN(this.value) && this.value.length!=0) {
                split += parseFloat(this.value);
            }
 
        });
	
	
	
	$('.percent').val(function() {
		// ensure split is not selected only once
	  if(count== 1){
		alert('Split cannot have only one selection');
		throw('error');
		}
	
		//calculate split
	   if ($('#' + this.id.replace(/percent/,'split')).is(':checked')) {
	   var split1 = Math.round((((100-split)/count)*10))/10;
	   return split1}
	   else { return this.value;}
    });
});


//If split is checked disable everything else
$('.split').click(function() {
	if($('.split').is(':checked')){
		$('":text", ":checkbox"').not($('.split')).attr('disabled', true);
	}
	else{$('":text", ":checkbox"').not($('.split')).attr('disabled', false);}
});

//Calculate the sum of specific pound orders
function calclb() {
var sumlb=0;
  $(".lb").each(function() {
            //add only if the value is number
			if(!isNaN(this.value) && this.value.length!=0) {
                sumlb += parseFloat(this.value);
				if(sumlb !=0){
					$('.all').attr('disabled', true);
				}
			}
	});
}

//Disable corresponding lb split and remainder when percent is populated
function percentsr() {
$(".percent").each(function() {
	if(this.value != 0){
	$('#' + this.id.replace(/percent/, 'remainder')).attr('disabled', true);
	$('#' + this.id.replace(/percent/, 'split')).attr('disabled', true);
	$('#' + this.id.replace(/percent/, 'lb')).attr('disabled', true);
	}
});
}
//Caluculate the sum of percent array
    function calculateSum() {
        var sum = 0;
        //iterate through each textboxes and add the values
        $(".percent").each(function() {
            //add only if the value is number
			if(!isNaN(this.value) && this.value.length!=0) {
                sum += parseFloat(this.value);
				if (sum == 100) {
					alert('100% of trim has been utilized');
					$('":text", ":checkbox"').not($('.percent')).attr('disabled', true);
					throw('trim used');
				}
				else if (sum != 0) {
					$('":text", ":checkbox"').not($('.percent')).attr('disabled', false);
					$('.all').attr('disabled', true);
					}
				else {$('":text", ":checkbox"').not($('.percent')).attr('disabled', false);}
            }
			
 
        });
		
		//Percent calculate when remainder is selected	
		$('.remainder').change(function() {
			
			$('.percent').val(function() {
				if($('#' + this.id.replace(/percent/,'remainder')).is(':checked')){
					return 100 - sum;
				}
				else if ($('#' + this.id.replace(/percent/, 'remainder')).not(':checked') && this.value == 100 - sum) {
					if ($('#' + this.id.replace(/percent/, 'remainder')).not(':checked') && this.value == 50){
						return 50;
					}
					else { 
						return 0; 
					}
				}
				else { 
					return this.value;
				}
			});
		});
		
	//Disable other buttons when remainder is selected
		$('.remainder').click(function() {
			$('":text", ":checkbox"').not(this).attr('disabled', $(this).is(':checked'));
		});
	
	}


// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

/* Array mix[] will contain values corresponding to the
ratio of meat to final product delivered */
var mix = [0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,1,0.5,0.5,0.5,0.5,0.5,3,1,1];

// Set the mix for an other item, default value is 0.5
mix[24] = 0.5;

//Set value for donation
mix[25] = 1;

/* Array inc[] will contain values corresponding to the
increments in which products are sold */
var inc = [5,1.5,5,5,5,5,5,1.5,1.5,1.5,1.5,1.5,5,5,5,5,5,1.5,1.5,1.5,1,1,1.5,1.5];

//Set the inc for an other item, default value is 5
inc[24] = 5;

//Set value for donation
inc[25] = 1.5;
/* Create an array with values corresponding to trim required for 1 increment
Here the decision rule can be changed----
Currently the decision rule is: produce if nettrim > [(mix[i]*inc[i])/2]
Except for hamburger and chili where the *(0.5) does not apply because n/c
*/
var need1 = [2.5, 0.75, 2.5, 2.5, 2.5, 2.5, 2.5, 0.75, 0.75, 0.75, 0.75, 0.75, 2.5, 2.5, 2.5, 5, 2.5, 0.75, 0.75, 0.75, 0.5, 3, 1.5, 1.5,];

var need = [];

for(x=0;x<mix.length;x++) {
	need[x]=(need1[x]/2);
}

need[22] = 1.5;
need[23] = 1.5;


//Set the need for an other item, default value is 2.5
need[24] = 2.5;

//Set value for Donation
need[25] = 1.5;

// Function to calculate once save_trimmings is clicked
$('#save_trimmings').click(function() {

// Variables are easily understood within the context of equations
var var1=0, var2=0, var3=0, var4=0, var5=0, var6=0, var7=0, var8=0, var9=0, var10=0, lesspounds=0, poundsum=0;

// Variables which will be used in various stages to determine 'net trim'
var net1=0, net2=0, net3=0, net4=0, net5=0, net6=0, net7=0, net8=0, net9=0, net10=0;

// These are just columns that will be used to facilitate calculations
var column1 = [];
var column2 = [];
var column3 = [];
var column4 = [];
var column5 = [];
var column6 = [];
var column7 = [];
var column8 = [];
var column9 = [];
var column10 = [];
var column11 = [];
var columnr = [];
var arraypounds = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
/* Get the values that have been populated in percentage fields
to form array 'pcent' */
var pcent = [document.getElementById('percent1').value];
pcent[1] = [document.getElementById('percent2').value];
pcent[2] = [document.getElementById('percent3').value];
pcent[3] = [document.getElementById('percent4').value];
pcent[4] = [document.getElementById('percent5').value];
pcent[5] = [document.getElementById('percent6').value];
pcent[6] = [document.getElementById('percent7').value];
pcent[7] = [document.getElementById('percent8').value];
pcent[8] = [document.getElementById('percent9').value];
pcent[9] = [document.getElementById('percent10').value];
pcent[10] = [document.getElementById('percent11').value];
pcent[11] = [document.getElementById('percent12').value];
pcent[12] = [document.getElementById('percent13').value];
pcent[13] = [document.getElementById('percent14').value];
pcent[14] = [document.getElementById('percent15').value];
pcent[15] = [document.getElementById('percent16').value];
pcent[16] = [document.getElementById('percent17').value];
pcent[17] = [document.getElementById('percent18').value];
pcent[18] = [document.getElementById('percent19').value];
pcent[19] = [document.getElementById('percent20').value];
pcent[20] = [document.getElementById('percent21').value];
pcent[21] = [document.getElementById('percent22').value];
pcent[22] = [document.getElementById('percent23').value];
pcent[23] = [document.getElementById('percent24').value];
pcent[24] = [document.getElementById('percent25').value];
pcent[25] = [document.getElementById('percent26').value];
/* Get the values that have been populated in pound fields
to form array 'pounds' */
var pounds = [document.getElementById('lb1').value];
pounds[1] = [document.getElementById('lb2').value];
pounds[2] = [document.getElementById('lb3').value];
pounds[3] = [document.getElementById('lb4').value];
pounds[4] = [document.getElementById('lb5').value];
pounds[5] = [document.getElementById('lb6').value];
pounds[6] = [document.getElementById('lb7').value];
pounds[7] = [document.getElementById('lb8').value];
pounds[8] = [document.getElementById('lb9').value];
pounds[9] = [document.getElementById('lb10').value];
pounds[10] = [document.getElementById('lb11').value];
pounds[11] = [document.getElementById('lb12').value];
pounds[12] = [document.getElementById('lb13').value];
pounds[13] = [document.getElementById('lb14').value];
pounds[14] = [document.getElementById('lb15').value];
pounds[15] = [document.getElementById('lb16').value];
pounds[16] = [document.getElementById('lb17').value];
pounds[17] = [document.getElementById('lb18').value];
pounds[18] = [document.getElementById('lb19').value];
pounds[19] = [document.getElementById('lb20').value];
pounds[20] = [document.getElementById('lb21').value];
pounds[21] = [document.getElementById('lb22').value];
pounds[22] = [document.getElementById('lb23').value];
pounds[23] = [document.getElementById('lb24').value];
pounds[24] = [document.getElementById('lb25').value];
pounds[25] = [document.getElementById('lb26').value];
// Get the value from trim field as variable trim
var trim= document.getElementById('entertrim').value;

/* First step is taking any order of a specific amount of pounds
checking if enough meat is available.*/
for(v=0;v<pcent.length;v++) {
	if(pounds[v]> 0) {
	arraypounds[v] = Math.round(pounds[v]/inc[v])*inc[v];
	}
}

/*Determine the amount of trim used for specific pound orders
and deduct this amount from available trim */
for(w=0;w<pcent.length;w++) {
	column7[w] = mix[w]*arraypounds[w];
}

for(ps=0;ps<pcent.length;ps++) {
	poundsum += arraypounds[ps];
}

for(y=0;y<pcent.length;y++) {
	lesspounds += column7[y];
}

// If trim cannot fill specific pound order throw error
if(trim - lesspounds < -2.5) {
	alert('Not enough meat to fill specific pound order');
	throw "there was an error";
}

trim = trim - lesspounds;

/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*********************************************************
If the total of percent fields does not equal 100 than 
alert attendant otherwise proceed with calculation 
*********************************************************
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */

for (a=0;a<pcent.length;a++) {
	(var1 += pcent[a]*1)
}
var variable2 = Math.round(var1);
if (variable2 != 100) {
	alert('Please make a selection to complete order');
	throw "there was an error";
}

//Specific Pounds cannot be used alone
var totalsplit= $('.split:checked'),
        countsplit=totalsplit.length;
	var totalremainder = $('.remainder:checked'),
		countremainder = totalremainder.length;
	var totalall = $('.all:checked'),
		countall = totalall.length;

if(poundsum != 0 && variable2 ==0 && countsplit ==0 && countremainder ==0 && countall ==0) {
	alert('Specific pounds requires an additional selection');
	throw "there was an error";
}


/* ***********************************************************
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */

// Calculate first gross allotment of product and then sum
for (b=0;b<pcent.length;b++) { 
	column1[b] = (trim/mix[b])*pcent[b]*0.01;
	var2 += column1[b];
}

// Round gross alotment to conform with product increments
for (c=0;c<pcent.length;c++) {
	column2[c] = var2*pcent[c]*0.01;
	column3[c] = Math.round(column2[c]/inc[c])*inc[c];
}

/* First 'net trim' calculation: net trim is the difference
between the trim brought in by the customer and the about of
trim used to produce the customer's products. The remainder of 
this function will attempt to minimize this amount subject to 
the constraints provided */  
for (d=0;d<pcent.length;d++) {
	var3 += column3[d]*mix[d];
	net1 = trim-var3;

}

// test function for large net trim differences
if(net1 > 10 || net1 < -10) {
	for(n=0;n<pcent.length;n++) {
	column3[n] = column3[n] + net1*pcent[n]*0.01;
	}
}

for(q=0;q<pcent.length;q++) {
	var6 += column3[q]*mix[q];
	net4 = trim-var6;
}

if(net4 > 10 || net4 < -10) {
	for(r=0;r<pcent.length;r++) {
	column3[r] = column3[r] + net4*pcent[r]*0.01;
	}
}

if(var6 != var3) {
	for(t=0;t<pcent.length;t++) {
	column6[t] = Math.round(column3[t]/inc[t])*inc[t];
	}
}

for(az=0;az<pcent.length;az++) {
	if(column6[az] > 0) {
	column3[az]=column6[az]
	}
}	
// Increment/Decrement results based on net trim
for (e=0;e<pcent.length;e++) {
	if(net1 > need[e] && column3[e] > 0) {
		column3[e]=column3[e] + inc[e];
		net1 = net1 - need1[e];
			if(net1 < need[e]) break;				
	}
}

for(f=pcent.length-1;f>= 0; f--) {
	if(net1 < -need[f] && column3[f]/inc[f] > 1) {
		column3[f] = column3[f] - inc[f];
		net1 = net1 + need1[f];
			if(net1 > need[f]) break;
	}
} 
// Re-calculate net trim based on previous increment/decrement
for(g=0;g<pcent.length;g++){
	var4+=column3[g]*mix[g];
	net2=trim-var4;
}

for(p=0;p<pcent.length;p++) {
	column4[p]=column3[p];
}

// Increment/Decrement based on net2
for(h=0;h<pcent.length;h++) {
	if(net2 > need[h] && column4[h] > 0) {
	column4[h] = column4[h] + inc[h];
	net2=net2-need1[h];
		if(net2 < need[h]) break;
	}
}

for(i=pcent.length-1;i >= 0; i--) {
	if(net2 < -need[i] && column4[i]/inc[i] > 1) {
	column4[i] = column4[i] - inc[i];
	net2 = net2 + need1[i];
		if(net2 > need[i]) break;
	}
}

// Re-calculate net trim based on previous increment/decrement
for(j=0;j<pcent.length;j++){
	var5+=column4[j]*mix[j];
	net3=trim-var5;
}

for(k=0;k<pcent.length;k++) {
	column5[k]=column4[k];
}

// Increment/Decrement based on net3
for(l=0;l<pcent.length;l++) {
	if(net3 > need[l] && column4[l] > 0) {
	column5[l] = column5[l] + inc[l];
	net3=net3-need1[l];
		if(net3 < need[l]) break;
	}
}

for(m=pcent.length-1; m>=0;m--) {
	if(net3 < -need[m] && column4[m]/inc[m] > 1) {
	column5[m] = column5[m] - inc[m];
	net3 = net3 + need1[m];
		if(net3 > -need[m]) break;
	}
}
 // Recalculate net trim based on previous net trim
for(aa=0;aa<pcent.length;aa++){
	var7+=column5[aa]*mix[aa];
	net5=trim-var7;
}

for(ab=0;ab<pcent.length;ab++) {
	column8[ab]=column5[ab];
}

// Increment/Decrement based on net5
for(ac=0;ac<pcent.length;ac++) {
	if(net5 > need[ac] && column5[ac] > 0) {
	column8[ac] = column8[ac] + inc[ac];
	net5=net5-need1[ac];
		if(net5 < need[ac]) break;
	}
}

for(ad=pcent.length-1; ad>=0;ad--) {
	if(net5 < -need[ad] && column5[ad]/inc[ad] > 1) {
	column8[ad] = column8[ad] - inc[ad];
	net5 = net5 + need1[ad];
		if(net5 > -need[ad]) break;
	}
}

 // Recalculate net trim based on previous net trim
for(ae=0;ae<pcent.length;ae++){
	var8+=column8[ae]*mix[ae];
	net6=trim-var8;
}

for(af=0;af<pcent.length;af++) {
	column9[af]=column8[af];
}

// Increment/Decrement based on net6
for(ag=0;ag<pcent.length;ag++) {
	if(net6 > need[ag] && column8[ag] > 0) {
	column9[ag] = column9[ag] + inc[ag];
	net6=net6-need1[ag];
		if(net6 < need[ag]) break;
	}
}

for(ah=pcent.length-1; ah>=0;ah--) {
	if(net6 < -need[ah] && column8[ah]/inc[ah] > 1) {
	column9[ah] = column9[ah] - inc[ah];
	net6 = net6 + need1[ah];
		if(net6 > -need[ah]) break;
	}
}

// Recalculate net trim based on previous net trim
for(ai=0;ai<pcent.length;ai++){
	var9+=column9[ai]*mix[ai];
	net7=trim-var9;
}

for(aj=0;aj<pcent.length;aj++) {
	column10[aj]=column9[aj];
}

// Increment/Decrement based on net6
for(ak=0;ak<pcent.length;ak++) {
	if(net7 > need[ak] && column9[ak] > 0) {
	column10[ak] = column10[ak] + inc[ak];
	net7=net7-need1[ak];
		if(net7 < need[ak]) break;
	}
}

for(al=pcent.length-1; al>=0;al--) {
	if(net7 < -need[al] && column9[al]/inc[al] > 1) {
	column10[al] = column10[al] - inc[al];
	net7 = net7 + need1[al];
		if(net7 > -need[al]) break;
	}
}
 // Recalculate net trim based on previous net trim

 for(am=0;am<pcent.length;am++){
	var10+=column10[am]*mix[am];
	net8=trim-var10;
}

for(an=0;an<pcent.length;an++) {
	column11[an]=column10[an];
}

// Increment/Decrement based on net8
for(ao=0;ao<pcent.length;ao++) {
	if(net8 > need[ao] && column10[ao] > 0) {
	column11[ao] = column11[ao] + inc[ao];
	net8=net8-need1[ao];
		if(net8 < need[ao]) break;
	}
}

for(ap=pcent.length-1; ap>=0;ap--) {
	if(net8 < -need[ap] && column10[ap]/inc[ap] > 1) {
	column11[ap] = column11[ap] - inc[ap];
	net8 = net8 + need1[ap];
		if(net8 > -need[ap]) break;
	}
}

/* ****************************************************
*******************************************************
*******************************************************
This is testing area for setting the result column */
 for( z=0;z<pcent.length;z++) {
 columnr[z]=column11[z] + arraypounds[z];
 }
/* *****************************************************
********************************************************
******************************************************** */



// Print results from colr to corresponding 'result' textfields
document.forms['form1'].elements['result1'].value = columnr[0];
document.forms['form1'].elements['result2'].value = columnr[1];
document.forms['form1'].elements['result3'].value = columnr[2];
document.forms['form1'].elements['result4'].value = columnr[3];
document.forms['form1'].elements['result5'].value = columnr[4];
document.forms['form1'].elements['result6'].value = columnr[5];
document.forms['form1'].elements['result7'].value = columnr[6];
document.forms['form1'].elements['result8'].value = columnr[7];
document.forms['form1'].elements['result9'].value = columnr[8];
document.forms['form1'].elements['result10'].value = columnr[9];
document.forms['form1'].elements['result11'].value = columnr[10];
document.forms['form1'].elements['result12'].value = columnr[11];
document.forms['form1'].elements['result13'].value = columnr[12];
document.forms['form1'].elements['result14'].value = columnr[13];
document.forms['form1'].elements['result15'].value = columnr[14];
document.forms['form1'].elements['result16'].value = columnr[15];
document.forms['form1'].elements['result17'].value = columnr[16];
document.forms['form1'].elements['result18'].value = columnr[17];
document.forms['form1'].elements['result19'].value = columnr[18];
document.forms['form1'].elements['result20'].value = columnr[19];
document.forms['form1'].elements['result21'].value = columnr[20];
document.forms['form1'].elements['result22'].value = columnr[21];
document.forms['form1'].elements['result23'].value = columnr[22];
document.forms['form1'].elements['result24'].value = columnr[23];
document.forms['form1'].elements['result25'].value = columnr[24];
document.forms['form1'].elements['result26'].value = columnr[25];
document.forms['form1'].elements['nettrim'].value = net8;
});
