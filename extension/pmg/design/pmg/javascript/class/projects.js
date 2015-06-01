/*-----------------------------------------------------------------------------
  [JS - Projects]

    a. Vertical Align

	0. Set Content
	1. Pagination
	2. Formulaire
	3. Fancybox

-----------------------------------------------------------------------------*/

    /*---------------------------------------------------------------------
      [a. Vertical Align]
    */

    function setProjectVerticalAlign() {
        $('.list-project .hover_on').each(function(k,v) {
            $(v).show();
            var title = $(v).find('h3.title').first();
            var studio = $(v).find('p.studio').first();
            var newMarginTop = ($(v).outerHeight() - ($(title).outerHeight() + $(studio).outerHeight())) / 2;
            console.log($(title).text(), $(v).outerHeight(), $(title).outerHeight(), $(studio).outerHeight(), newMarginTop);
            $(v).removeAttr('style');
            if (newMarginTop >= 0)
                $(title).css('marginTop', newMarginTop);
        });
    }


$(window).ready(function() {
	$(document.body).addClass('js');

/*---------------------------------------------------------------------
  [0. Set Content]
*/

	$('#result-block .inside').animate({'opacity' : .4});

	projectHeight = 0;
	projectsByPage = 0;

	// Request projects
	$.ajax({
		url: uriBaseFull+"views/projects/"
	}).success(function(data) {
		$('#result-block .content').html(data);
        setProjectVerticalAlign();
		$('#result-block .inside').animate({'opacity' : 1});
		projectHeight = $('.list-project').height() + parseInt($('.list-project').css('margin-bottom'));
		projectsByPage = parseInt($('#data-current-limit').val());

		// Set pager
		var nbProjects = $('.list-project').length;
		nbPage = Math.ceil(nbProjects/projectsByPage);
		$('#result-block .pager .nb_page').text(nbPage);
		$('#result-block .pager .page').text(1);
	});

/*---------------------------------------------------------------------
  [1. Pagination]
*/

	// Pager
	$('#result-block .pager .arrow.prev').bind('click', function(e) {
		e.preventDefault();

		if (parseInt($('#result-block .content').css('top')) <= (-1) * (projectHeight*(projectsByPage/2)) && !$(this).hasClass('disabled') ) {
            $(this).addClass('disabled');
			$('#result-block .content').animate({top: parseInt($('#result-block .content').css('top')) + projectHeight*(projectsByPage/2)}, function() {
                $('#result-block .pager .arrow.prev').removeClass('disabled');
            });
			pageNumber = parseInt($('#result-block .pager .page').text()) - 1;
			$('#result-block .pager .page').text( pageNumber );
		}

		return false;
	});

	$('#result-block .pager .arrow.next').bind('click', function(e) {
		e.preventDefault();

		var nbProjects = $('.list-project').length;
		var maxTop = ((nbProjects/2) * projectHeight) - (projectHeight*(projectsByPage/2));

		if ((-1)*parseInt($('#result-block .content').css('top')) < maxTop && !$(this).hasClass('disabled') ) {
            $(this).addClass('disabled');
			$('#result-block .content').animate({top: parseInt($('#result-block .content').css('top')) - projectHeight*(projectsByPage/2)}, function() {
                $('#result-block .pager .arrow.next').removeClass('disabled');
            });
			pageNumber = parseInt($('#result-block .pager .page').text()) + 1;
			$('#result-block .pager .page').text( pageNumber );
		}

		return false;
	});

/*---------------------------------------------------------------------
  [2. Formulaire]
*/

	/** SUBMIT **/
	$('#search-block form').bind('submit', function(event) {
		event.preventDefault
		$('#result-block .inside').animate({'opacity' : .4});

		// Name
		name = $(this).find('input#name').val();
		// Edition
		edition = $(this).find('#edition').val() != '*' ? $(this).find('#edition').val() : '';
		// Type
		category = $(this).find('#category').val() != '*' ? $(this).find('#category').val() : '';

		// Request projects
		$.ajax({
			url: uriBaseFull+'views/projects/'+name+'/'+edition+'/'+category
		}).success(function(data) {
			$('#result-block .content').html(data);
            setProjectVerticalAlign();
			$('#result-block .inside').animate({'opacity' : 1});
			$('#result-block .content').css({top:0});

			// Set pager
			var nbProjects = $('.list-project').length;
			nbPage = Math.ceil(nbProjects/projectsByPage);
			$('#result-block .pager .nb_page').text(nbPage);
			$('#result-block .pager .page').text(1);

			// Slide to results
			var resultOffset = $('#result-block').offset().top - 20;
			$('html, body').animate({scrollTop : resultOffset}, 500);
		});

		return false;
	});

	/** CANCEL **/
	$('#search-block form #cancel').bind('click', function(event) {
		event.preventDefault;

		var form = $('#search-block form');
		$(form).find('input#name').val(''); // Name
		$(form).find('#edition').val('*'); // Edition
		$(form).find('#category').val('*'); // Category

		$(form).trigger('submit');

		return false;
	});

/*---------------------------------------------------------------------
  [3. Fancybox]
*/

	$('#pictures a.fancybox').fancybox({
		'transitionIn'	:	'elastic',
		'transitionOut'	:	'elastic',
		'speedIn'		:	600,
		'speedOut'		:	200,
		'overlayShow'	:	false
	});


});
