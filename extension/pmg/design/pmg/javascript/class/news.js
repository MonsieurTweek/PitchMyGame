/*-----------------------------------------------------------------------------
  [JS - News]

  1. Pager for News container
  
-----------------------------------------------------------------------------*/

/*---------------------------------------------------------------------
  [1. Pager for News container]
*/   
	
	function news_pager(link, direction) {

		if (!$(link).hasClass('disabled')) {
			var offset = $(link).attr('data-offset');
			var limit = $(link).attr('data-limit');

			$.ajax({
				url: uriBaseFull+"tools/news_pager/"+offset+"/"+limit+"/"+direction
			}).success(function(json) {
				var obj = $.parseJSON(json);

				for (x in obj) {
					var a = $('<a/>', {
						href: obj[x].URL,
						text: obj[x].Name
					});
					var d = $('<div/>', {
						class: 'line-news hide'
					});

					$(a).appendTo($(d));
					$(d).appendTo($('#block-news_container .container .inside .slider'));
				}

				// $('#block-news_container .container .inside .line-news:not(.hide)').remove();
				$('#block-news_container .container .inside .slider').fadeOut(200, function() {
					$(this).find('.line-news:not(.hide)').remove();
					$(this).find('.line-news').removeClass('hide');
					$(this).fadeIn(200, function() {
						thereIsAnotherPage();
					});
				});
			});

			return true;
		}
		else
			return false;
	}

	function thereIsAnotherPage() {
		var c_page = parseInt($('#block-news_container .container .pager .page').text());
		var nb_page = parseInt($('#block-news_container .container .pager .nb_page').text());

		// Check if prev is allowed
		if (c_page > 1)
			$('#block-news_container .container .pager .prev').removeClass('disabled');
		else
			$('#block-news_container .container .pager .prev').addClass('disabled');

		// Check if next is allowed
		if (c_page < nb_page)
			$('#block-news_container .container .pager .next').removeClass('disabled');	
		else
			$('#block-news_container .container .pager .next').addClass('disabled');

		var limit = parseInt($('#block-news_container .container .pager .prev').attr('data-limit'));
		var offset_prev = (limit * (c_page-1)) - limit >= 0 ? (limit * (c_page-1)) - limit : 0;
		var offset_next = $('#block-news_container .container .inside .line-news').length + (limit * (c_page-1));

		$('#block-news_container .container .pager .prev').attr('data-offset', offset_prev);
		$('#block-news_container .container .pager .next').attr('data-offset', offset_next);
	}

$(window).ready(function() {
	$(document.body).addClass('js');

	if ($('#block-news_container').length) {

		$('#block-news_container .container .pager .prev').bind('click', function() {
			if (news_pager(this, 'prev')) {
				$('#block-news_container .container .pager .page').text(parseInt($('#block-news_container .container .pager .page').text())-1);
			}

			return false;
		});

		$('#block-news_container .container .pager .next').bind('click', function() {	
			if (news_pager(this, 'next')) {
				$('#block-news_container .container .pager .page').text(parseInt($('#block-news_container .container .pager .page').text())+1);
			}

			return false;
		});

	}

});