/*---------------------------------------------------------------------
JS - EZFEEDBACK

    1. Form Subject
    2. Google Map

*/

/*---------------------------------------------------------------------
[1. FORM SUBJECT]

*/

function displaySubject(){
    if( !$('#objSelect').length || !$('#subject').length )
        return;

	var val = $('#objSelect').val()
	if( val == 'default' )
		$('#subject').css('display', 'block');
	else
		$('#subject').css('display', 'none');
}

/*---------------------------------------------------------------------
[2. GOOGLE MAP]

*/

$(document).ready(function($){
    displaySubject();
    $('#objSelect').change(displaySubject);

    //Set the googlemap :
    if( $('#sidebar-googlemap-addr').length ){
        var addr = $('#sidebar-googlemap-addr address').text().replace(/\s/g, ' ');
        new google.maps.Geocoder().geocode({'address':addr}, function(r, s){
            if( !r.length ) return;
            var myOptions = {
                zoom:15,
                center: r[0].geometry.location,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var map = new google.maps.Map($('#googlemap').get(0), myOptions);
            var marker = new google.maps.Marker({
                map:map,
                position: r[0].geometry.location
            });
        });
    }
    
});
