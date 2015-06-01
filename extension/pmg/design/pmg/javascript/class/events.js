/*-----------------------------------------------------------------------------
  [JS - Event]

  0. Set Content
  1. Pagination
  2. Slide up & down for embed version
  
-----------------------------------------------------------------------------*/

$(window).ready(function() {
	$(document.body).addClass('js');

/*---------------------------------------------------------------------
  [0. Set Content]
*/

	$('#result-block .inside').animate({'opacity' : .4});

	eventHeight = 0;
	eventsByPage = 0;

	// Request events
	$.ajax({
		url: uriBaseFull+"views/events/"
	}).success(function(data) {
		$('#result-block .content').html(data);
		$('#result-block .inside').animate({'opacity' : 1});
		eventHeight = $('.list-event').height() + parseInt($('.list-event').css('margin-bottom'));
		eventsByPage = parseInt($('#data-current-limit').val());

		// Set pager
		var nbEvents = $('.list-event').length;
		nbPage = Math.ceil(nbEvents/eventsByPage);
		$('#result-block .pager .nb_page').text(nbPage);
		$('#result-block .pager .page').text(1);
	});

/*---------------------------------------------------------------------
  [1. Pagination]
*/

	// Pager
	$('#result-block .pager .arrow.prev').bind('click', function(e) {
		e.preventDefault();

		if (parseInt($('#result-block .content').css('top')) <= (-1) * (eventHeight*(eventsByPage/2)) && !$(this).hasClass('disabled') ) {
            $(this).addClass('disabled');
			$('#result-block .content').animate({top: parseInt($('#result-block .content').css('top')) + eventHeight*(eventsByPage/2)}, function() {
                $('#result-block .pager .arrow.prev').removeClass('disabled');
            });
			pageNumber = parseInt($('#result-block .pager .page').text()) - 1;
			$('#result-block .pager .page').text( pageNumber );
		}

		return false;
	});

	$('#result-block .pager .arrow.next').bind('click', function(e) {
		e.preventDefault();

		var nbEvents = $('.list-event').length;
		var maxTop = ((nbEvents/2) * eventHeight) - (eventHeight*(eventsByPage/2));

		if ((-1)*parseInt($('#result-block .content').css('top')) < maxTop && !$(this).hasClass('disabled') ) {
            $(this).addClass('disabled');
			$('#result-block .content').animate({top: parseInt($('#result-block .content').css('top')) - eventHeight*(eventsByPage/2)}, function() {
                $('#result-block .pager .arrow.next').removeClass('disabled');
            });
			pageNumber = parseInt($('#result-block .pager .page').text()) + 1;
			$('#result-block .pager .page').text( pageNumber );
		}

		return false;
	});

/*---------------------------------------------------------------------
  [2. Slide up & down for embed version]
*/   

	if ($('#block-event').length) {
		$('#block-event .expand-button-block .button.expand').unbind('click').bind('click', function(e) {
			$('#block-event').addClass('expanded').removeClass('collapsed');
			return false;
		});
		$('#block-event .expand-button-block .button.collapse').unbind('click').bind('click', function(e) {
			$('#block-event').addClass('collapsed').removeClass('expanded');
			return false;
		});
	}

});
