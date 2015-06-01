
(function(f,h,i){function k(a,c){var b=(a[0]||0)-(c[0]||0);return b>0||!b&&a.length>0&&k(a.slice(1),c.slice(1))}function l(a){if(typeof a!=g)return a;var c=[],b="";for(var d in a){b=typeof a[d]==g?l(a[d]):[d,m?encodeURI(a[d]):a[d]].join("=");c.push(b)}return c.join("&")}function n(a){var c=[];for(var b in a)a[b]&&c.push([b,'="',a[b],'"'].join(""));return c.join(" ")}function o(a){var c=[];for(var b in a)c.push(['<param name="',b,'" value="',l(a[b]),'" />'].join(""));return c.join("")}var g="object",m=true;try{var j=i.description||function(){return(new i("ShockwaveFlash.ShockwaveFlash")).GetVariable("$version")}()}catch(p){j="Unavailable"}var e=j.match(/\d+/g)||[0];f[h]={available:e[0]>0,activeX:i&&!i.name,version:{original:j,array:e,string:e.join("."),major:parseInt(e[0],10)||0,minor:parseInt(e[1],10)||0,release:parseInt(e[2],10)||0},hasVersion:function(a){a=/string|number/.test(typeof a)?a.toString().split("."):/object/.test(typeof a)?[a.major,a.minor]:a||[0,0];return k(e,a)},encodeParams:true,expressInstall:"expressInstall.swf",expressInstallIsActive:false,create:function(a){if(!a.swf||this.expressInstallIsActive||!this.available&&!a.hasVersionFail)return false;if(!this.hasVersion(a.hasVersion||1)){this.expressInstallIsActive=true;if(typeof a.hasVersionFail=="function")if(!a.hasVersionFail.apply(a))return false;a={swf:a.expressInstall||this.expressInstall,height:137,width:214,flashvars:{MMredirectURL:location.href,MMplayerType:this.activeX?"ActiveX":"PlugIn",MMdoctitle:document.title.slice(0,47)+" - Flash Player Installation"}}}attrs={data:a.swf,type:"application/x-shockwave-flash",id:a.id||"flash_"+Math.floor(Math.random()*999999999),width:a.width||320,height:a.height||180,style:a.style||""};m=typeof a.useEncode!=="undefined"?a.useEncode:this.encodeParams;a.movie=a.swf;a.wmode=a.wmode||"opaque";delete a.fallback;delete a.hasVersion;delete a.hasVersionFail;delete a.height;delete a.id;delete a.swf;delete a.useEncode;delete a.width;var c=document.createElement("div");c.innerHTML=["<object ",n(attrs),">",o(a),"</object>"].join("");return c.firstChild}};f.fn[h]=function(a){var c=this.find(g).andSelf().filter(g);/string|object/.test(typeof a)&&this.each(function(){var b=f(this),d;a=typeof a==g?a:{swf:a};a.fallback=this;if(d=f[h].create(a)){b.children().remove();b.html(d)}});typeof a=="function"&&c.each(function(){var b=this;b.jsInteractionTimeoutMs=b.jsInteractionTimeoutMs||0;if(b.jsInteractionTimeoutMs<660)b.clientWidth||b.clientHeight?a.call(b):setTimeout(function(){f(b)[h](a)},b.jsInteractionTimeoutMs+66)});return c}})(jQuery,"flash",navigator.plugins["Shockwave Flash"]||window.ActiveXObject);
(function($){$.fn.input_replacement=function(c){var d=$.extend({},$.fn.input_replacement.defaults,c);return $(this).each(function(){var a=$(this);a.o=$.meta?$.extend({},d,$this.data()):d;if(a.val()==''){a.val(a.o.text);if(a.o.c){a.addClass(a.o.c)};a.bind('focus',function(){if(a.val()==a.o.text){a.val('')};if(a.o.c){a.removeClass(a.o.c)}});a.bind('blur',function(){if(a.val()==''){a.val(a.o.text);if(a.o.c){a.addClass(a.o.c)}}});$(window).unload(function(){if(a.val()==a.o.text){a.val('')}});var b=a.parents('form');if(b){b.each(function(){$(b).bind('submit',function(){if(a.val()==a.o.text){a.val()=''};return false})})}}})};$.fn.input_replacement.defaults={text:'Search...',c:''}})(jQuery);
$(window).ready(function() {
$(document.body).addClass('js');
if ( window.addEventListener ) {
var kkeys = [], konami = "38,38,40,40,37,39,37,39,66,65";
window.addEventListener("keydown", function(e){
kkeys.push( e.keyCode );
if ( kkeys.toString().indexOf( konami ) >= 0 )
$('#page').hide('explode', {pieces:10}, 500);
},
true);
}
$('a[href^="mailto:"]').each(function(){
var at = new RegExp('pmgat', 'g');
var dot = new RegExp('pmgdot', 'g');
$(this).attr('href', $(this).attr('href').replace(at, '@').replace(dot, '.'));
$(this).text($(this).text().replace(at, '@').replace(dot, '.'));
});
$('a.external').attr("target", "_blank");
$('.replace').input_replacement();
$('a.disabled-js').bind('click', function(e) {
e.preventDefault();
return false;
}).attr('href', '');
$('.flexslider').each(function (k,v) {
$(v).flexslider({
directionNav: false,
animation: 'slide'
});
});
$('a.custom-tweet-button').each(function(k,v) {
var url = $(v).attr('data-url');
var text = $(v).attr('data-text');
var via = $(v).attr('data-via');
var related = $(v).attr('data-related');
$(v).attr('href', $(v).attr('href') + '?url=' + url + '&text=' + text + '&via=' + via + '&related=' + related);
$(v).attr('target', '_blank');
});
$('a.custom-facebook-button').each(function(k,v) {
var url = $(v).attr('data-url');
$(v).attr('href', $(v).attr('href') + '?u=' + url);
$(v).attr('target', '_blank');
});
});
$(window).ready(function() {
$(document.body).addClass('js');
$('#result-block .inside').animate({'opacity' : .4});
eventHeight = 0;
eventsByPage = 0;
$.ajax({
url: uriBaseFull+"views/events/"
}).success(function(data) {
$('#result-block .content').html(data);
$('#result-block .inside').animate({'opacity' : 1});
eventHeight = $('.list-event').height() + parseInt($('.list-event').css('margin-bottom'));
eventsByPage = parseInt($('#data-current-limit').val());
var nbEvents = $('.list-event').length;
nbPage = Math.ceil(nbEvents/eventsByPage);
$('#result-block .pager .nb_page').text(nbPage);
$('#result-block .pager .page').text(1);
});
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
if (c_page > 1)
$('#block-news_container .container .pager .prev').removeClass('disabled');
else
$('#block-news_container .container .pager .prev').addClass('disabled');
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
$('#result-block .inside').animate({'opacity' : .4});
projectHeight = 0;
projectsByPage = 0;
$.ajax({
url: uriBaseFull+"views/projects/"
}).success(function(data) {
$('#result-block .content').html(data);
setProjectVerticalAlign();
$('#result-block .inside').animate({'opacity' : 1});
projectHeight = $('.list-project').height() + parseInt($('.list-project').css('margin-bottom'));
projectsByPage = parseInt($('#data-current-limit').val());
var nbProjects = $('.list-project').length;
nbPage = Math.ceil(nbProjects/projectsByPage);
$('#result-block .pager .nb_page').text(nbPage);
$('#result-block .pager .page').text(1);
});
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
$('#search-block form').bind('submit', function(event) {
event.preventDefault
$('#result-block .inside').animate({'opacity' : .4});
name = $(this).find('input#name').val();
edition = $(this).find('#edition').val() != '*' ? $(this).find('#edition').val() : '';
category = $(this).find('#category').val() != '*' ? $(this).find('#category').val() : '';
$.ajax({
url: uriBaseFull+'views/projects/'+name+'/'+edition+'/'+category
}).success(function(data) {
$('#result-block .content').html(data);
setProjectVerticalAlign();
$('#result-block .inside').animate({'opacity' : 1});
$('#result-block .content').css({top:0});
var nbProjects = $('.list-project').length;
nbPage = Math.ceil(nbProjects/projectsByPage);
$('#result-block .pager .nb_page').text(nbPage);
$('#result-block .pager .page').text(1);
var resultOffset = $('#result-block').offset().top - 20;
$('html, body').animate({scrollTop : resultOffset}, 500);
});
return false;
});
$('#search-block form #cancel').bind('click', function(event) {
event.preventDefault;
var form = $('#search-block form');
$(form).find('input#name').val(''); // Name
$(form).find('#edition').val('*'); // Edition
$(form).find('#category').val('*'); // Category
$(form).trigger('submit');
return false;
});
$('#pictures a.fancybox').fancybox({
'transitionIn'	:	'elastic',
'transitionOut'	:	'elastic',
'speedIn'		:	600,
'speedOut'		:	200,
'overlayShow'	:	false
});
});
