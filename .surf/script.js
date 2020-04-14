(function() {
	document.addEventListener('keydown', keybind, false);
})();

function keybind(e) {
	if(e.altKey && String.fromCharCode(e.keyCode) == "R")
		simplyread();
}

if(window.content && window.content.document && window.content.document.simplyread_original === undefined) window.content.document.simplyread_original = false;

function simplyread(nostyle, nolinks)
{
	/* count the number of <p> tags that are direct children of parenttag */
	function count_p(parenttag)
	{
		var n = 0;
		var c = parenttag.childNodes;
		for (var i = 0; i < c.length; i++) {
			if (c[i].tagName == "p" || c[i].tagName == "P")
				n++;
		}
		return n;
	}
	
	var doc;
	doc = (document.body === undefined)
		  ? window.content.document : document;
	
	/* if simplyread_original is set, then the simplyread version is currently active,
	 * so switch to the simplyread_original html */
	if (doc.simplyread_original) {
		doc.body.innerHTML = doc.simplyread_original;
		for (var i = 0; i < doc.styleSheets.length; i++)
			doc.styleSheets[i].disabled = false;
		doc.simplyread_original = false
		return 0;
	}
	
	doc.simplyread_original = doc.body.innerHTML;
	doc.body.innerHTML = doc.body.innerHTML.replace(/<br[^>]*>\s*<br[^>]*>/g, "<p>");
	
	var biggest_num = 0;
	var biggest_tag;
	
	/* search for tag with most direct children <p> tags */
	var t = doc.getElementsByTagName("*");
	for (var i = 0; i < t.length; i++) {
		var p_num = count_p(t[i]);
		if (p_num > biggest_num) {
			biggest_num = p_num;
			biggest_tag = t[i];
		}
	}
	
	if (biggest_num == 0) return 1;
	
	/* save and sanitise content of chosen tag */
	var fresh = doc.createElement("div");
	fresh.innerHTML = biggest_tag.innerHTML;
	fresh.innerHTML = fresh.innerHTML.replace(/<\/?font[^>]*>/g, "");
	fresh.innerHTML = fresh.innerHTML.replace(/style="[^"]*"/g, "");
	if(nolinks)
		fresh.innerHTML = fresh.innerHTML.replace(/<\/?a[^>]*>/g, "");
	fresh.innerHTML = fresh.innerHTML.replace(/<\/?span[^>]*>/g, "");
	fresh.innerHTML = fresh.innerHTML.replace(/<style[^>]*>/g, "<style media=\"aural\">"); /* ensures contents of style tag are ignored */
	
	for (var i = 0; i < doc.styleSheets.length; i++)
		doc.styleSheets[i].disabled = true;
	
	srstyle =
		"p{margin:0ex auto;} h1,h2,h3,h4{font-weight:normal}" +
		"p+p{text-indent:2em;} body{background:#cccccc none}" +
		"img{display:block; max-width: 32em; padding:1em; margin: auto}" +
		"h1{text-align:center;text-transform:uppercase}" +
		"div#sr{width:34em; padding:8em; padding-top:2em;" +
		"  background-color:white; margin:auto; line-height:1.4;" +
		"  text-align:justify; font-family:serif; hyphens:auto;}";
		/* text-rendering:optimizeLegibility; - someday this will work,
		 *   but at present it just ruins justify, so is disabled */
	
	doc.body.innerHTML =
		"<style type=\"text/css\">" + (nostyle ? "" : srstyle) + "</style>" +
		"<div id=\"sr\">" + "<h1>"+doc.title+"</h1>" + fresh.innerHTML + "</div>";
	
	return 0;
}





// ==UserScript==
// @name vimkeybindings
// @namespace renevier.fdn.fr
// @author arno <arenevier@fdn.fr>
// @licence GPL/LGPL/MPL
// @description use vim keybingings (i, j, k, l, …) to navigate a web page.
// ==/UserScript==
/*
* If you're a vim addict, and you always find yourself typing j or k in a web
* page, then wondering why it just does not go up and down like any good
* software, that user script is what you have been looking for.
*/
function up() {
	if (window.scrollByLines)
	window.scrollByLines(-1); // gecko
	else
	window.scrollBy(0, -12); // webkit
}
function down() {
	if (window.scrollByLines)
	window.scrollByLines(1); // gecko
	else
	window.scrollBy(0, 12); // webkit
}
function pageup() {
	if (window.scrollByPages)
	window.scrollByPages(-1); // gecko
else
	window.scrollBy(0, 0 - _pageScroll()); // webkit
}
function pagedown() {
	if (window.scrollByPages)
	window.scrollByPages(1); // gecko
	else
	window.scrollBy(0, _pageScroll()); // webkit
}
function right() {
	window.scrollBy(15, 0);
}
function left() {
	window.scrollBy(-15, 0);
}
function home() {
	window.scroll(0, 0);
}
function bottom() {
	window.scroll(document.width, document.height);
}
// If you don't like default key bindings, customize here.
// if you want to use the combination 'Ctrl + b' (for example), use '^b'
var bindings = {
	'h' : left,
	'l' : right,
	'k' : up,
	'j' : down,
	'g' : home,
	'G' : bottom,
//'^b': pageup,
//'^f': pagedown,
 }
function isEditable(element) {

if (element.nodeName.toLowerCase() == "textarea")
return true;
// we don't get keypress events for text input, but I don't known
// if it's a bug, so let's test that
if (element.nodeName.toLowerCase() == "input" && element.type == "text")
return true;
// element is editable
if (document.designMode == "on" || element.contentEditable == "true") {
return true;
}

return false;
}
function keypress(evt) {
var target = evt.target;

// if we're on a editable element, we probably don't want to catch
// keypress, we just want to write the typed character.
if (isEditable(target))
return;
var key = String.fromCharCode(evt.charCode);
if (evt.ctrlKey) {
key = '^' + key;
}
var fun = bindings[key];
if (fun)
	fun();
}
function _pageScroll() {
	// Gecko algorithm
	// ----------------
	// The page increment is the size of the page, minus the smaller of
	// 10% of the size or 2 lines.
	return window.innerHeight - Math.min(window.innerHeight / 10, 24);
}
window.addEventListener("keypress", keypress, false) ;





/* prevent surf from unexpectedy opening new windows */
function untarget() {
	var links = document.getElementsByTagName('a');
	Array.prototype.slice.call(links).forEach(function(anchor, index, arr) {
		if (anchor["target"] == "_blank")
			anchor.removeAttribute("target");
	});
}
window.onload = untarget;






// easy links for surf
// christian hahn <ch radamanthys de>, sep 2010
testcomplete = function() {
	if(document.readyState=="complete") {
		run(); return;
	}
	window.setTimeout("testcomplete()",200);
}
testcomplete();
run=function() {
	// config , any css
	var modkey      = 18;  //ctrl=17, alt=18
	var cancelkey   = 67;  // c
	var newwinkey   = 84;  // t
	var openkey     = 70;  // f
	var label_style = {"color":"black","fontSize":"10px","backgroundColor":"#27FF27","fontWeight":"normal","margin":"0px","padding":"0px","position":"absolute","zIndex":99};
	var hl_style    = {"backgroundColor":"#E3FF38","fontSize":"15px"};
	var nr_base     = 5;   // >=10 : normal integer,
	// globals
	var ankers     = document.getElementsByTagName("a");
	var labels     = new Object();
	var ui_visible = false;
	var input      = "";
	// functions
	hl=function(t) {
		for(var id in labels) {
			if (t && id.match("^"+t)==t)
				for(var s in hl_style)
					labels[id].rep.style[s]=hl_style[s];
			else
				for(var s in label_style)
					labels[id].rep.style[s]=label_style[s];
		}
	}
	open_link=function(id, new_win) {
		try {
			var a = labels[input].a;
			if(a && !new_win) window.location.href=a.href;
			if(a && new_win)  window.open(a.href,a.href);
		} catch (e) {}
	}
	set_ui=function(s) {
		var pos = "static";
		ui_visible = true;
		if(s == "hidden") {
			ui_visible = false;
			pos = "absolute";
			input="";
		}
		for(var id in labels) {
			labels[id].rep.style.visibility=s;
			labels[id].rep.style.position=pos;
		}
	}
	base=function(n, b) {
		if(b>=10) return n.toString();
		var res = new Array();
		while(n) {
			res.push( (n%b +1).toString() )
			n=parseInt(n/b);
		}
		return res.reverse().join("");
	}
	// main
	// create labels
	for (var i=0; i<ankers.length; i++) {
		var a = ankers[i];
		if (!a.href) continue;
		var b = base(i+1,nr_base);
		var d = document.createElement("span");
		d.style.visibility="hidden";
		d.innerHTML=b;
		for(var s in label_style)
			d.style[s]=label_style[s];
		labels[b]={"a":a, "rep":d};
		a.parentNode.insertBefore(d, a.nextSibling);
	}
	// set key handler
	window.onkeydown=function(e) {
		if (e.keyCode == modkey) {
			set_ui("visible");
		}
	}
	window.onkeyup=function(e) {
		if (e.keyCode == modkey ) {
			open_link(input);
			set_ui("hidden");
			hl(input);
		} else if (ui_visible) {
			if(e.keyCode == newwinkey) {
				open_link(input, true);
				set_ui("hidden");
			} else if(e.keyCode == cancelkey)
				input="";
			else if(e.keyCode == openkey) {
				open_link(input);
				set_ui("hidden");
			} else
				input += String.fromCharCode(e.keyCode);
			hl(input);
		}
	}
}
