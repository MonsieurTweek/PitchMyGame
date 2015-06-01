/*-----------------------------------------------------------------------------
  [JS - Application]

  0. Konami Code
  1. Wash mail
  2. Target blank
  3. Input replace
  4. Disable links disabled
  5. Slideshow
  6. Custom Tweet Buttons
  
-----------------------------------------------------------------------------*/

$(window).ready(function() {
	$(document.body).addClass('js');
    
/*---------------------------------------------------------------------
  [0. Konami Code]
*/    
  if ( window.addEventListener ) {
    var kkeys = [], konami = "38,38,40,40,37,39,37,39,66,65";
    window.addEventListener("keydown", function(e){ 
        kkeys.push( e.keyCode ); 
        if ( kkeys.toString().indexOf( konami ) >= 0 ) 
            $('#page').hide('explode', {pieces:10}, 500);
    },
    true);
  }


/*---------------------------------------------------------------------
  [1. Wash mail]
*/
    
	$('a[href^="mailto:"]').each(function(){
        var at = new RegExp('pmgat', 'g');
        var dot = new RegExp('pmgdot', 'g');
        $(this).attr('href', $(this).attr('href').replace(at, '@').replace(dot, '.'));
        $(this).text($(this).text().replace(at, '@').replace(dot, '.'));
	});
    
/*---------------------------------------------------------------------
  [2. Target blank]
*/
    
	$('a.external').attr("target", "_blank");
    
/*---------------------------------------------------------------------
  [3. Input replace]
*/
	
	$('.replace').input_replacement();
    
/*---------------------------------------------------------------------
  [4. Disable links disabled]
*/    

  $('a.disabled-js').bind('click', function(e) {
    e.preventDefault();
    return false;
  }).attr('href', '');

/*---------------------------------------------------------------------
  [5. Slideshow]
*/
  
  $('.flexslider').each(function (k,v) {
    $(v).flexslider({
      directionNav: false,
      animation: 'slide'
    });
  });

/*---------------------------------------------------------------------
  [6. Custom Tweet Buttons]
*/

  $('a.custom-tweet-button').each(function(k,v) {
    var url = $(v).attr('data-url');
    var text = $(v).attr('data-text');
    var via = $(v).attr('data-via');
    var related = $(v).attr('data-related');

    $(v).attr('href', $(v).attr('href') + '?url=' + url + '&text=' + text + '&via=' + via + '&related=' + related);
    $(v).attr('target', '_blank');
  });

/*---------------------------------------------------------------------
  [7. Custom Facebook Buttons]
*/

  $('a.custom-facebook-button').each(function(k,v) {
    var url = $(v).attr('data-url');

    $(v).attr('href', $(v).attr('href') + '?u=' + url);
    $(v).attr('target', '_blank');
  });
    
});