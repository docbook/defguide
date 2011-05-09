// -*- JavaScript -*- 

function show(id) {
    var list = document.getElementById("l." + id);
    list.style.display = 'block';

    var plus = document.getElementById("pls." + id);
    plus.style.display = 'none';

    var minus = document.getElementById("plh." + id);
    minus.style.display = 'inline';
}

function hide(id) {
    var list = document.getElementById("l." + id);
    list.style.display = 'none';

    var plus = document.getElementById("pls." + id);
    plus.style.display = 'inline';

    var minus = document.getElementById("plh." + id);
    minus.style.display = 'none';
}

function showAll() {
    var divs = document.getElementsByTagName('div');
    var div = undefined;
    for (i = 0; i < divs.length; i++) {
	if (divs[i].className == 'refsynopsisdiv') {
	    div = divs[i];
	    break;
	}
    }

    if (div != undefined) {
	divs = div.getElementsByTagName("div");
	for (i = 0; i < divs.length; i++) {
	    if (divs[i].className == 'patnlist') {
		var id = divs[i].id.substring(2);
		show(id);
	    }
	}
    }

    var plus = document.getElementById("cmshow");
    plus.style.display = 'none';

    var minus = document.getElementById("cmhide");
    minus.style.display = 'inline';

    addDeleteLink();
}

function hideAll() {
    var divs = document.getElementsByTagName('div');
    var div = undefined;
    for (i = 0; i < divs.length; i++) {
	if (divs[i].className == 'refsynopsisdiv') {
	    div = divs[i];
	    break;
	}
    }

    if (div != undefined) {
	divs = div.getElementsByTagName("div");
	for (i = 0; i < divs.length; i++) {
	    if (divs[i].className == 'patnlist') {
		var id = divs[i].id.substring(2);
		hide(id);
	    }
	}
    }

    var plus = document.getElementById("cmshow");
    plus.style.display = 'inline';

    var minus = document.getElementById("cmhide");
    minus.style.display = 'none';

    addDeleteLink();
}

var XSLI;

function deleteAll() {
    var divs = document.getElementsByTagName("div");
    var dli = new Array();
    for (i = 0; i < divs.length; i++) {
	if (divs[i].className == 'patnlist') {
	    unwrapItem(divs[i]);
	    dli[dli.length] = divs[i].parentNode;
	}
    }

    var ul = dli[0].parentNode;

    for (i = 0; i < dli.length; i++) {
	ul.removeChild(dli[i]);
    }

    var sli = new Array();
    var lis = ul.getElementsByTagName("li");
    for (i = 0; i < lis.length; i++) {
	sli[i] = lis[i];
    }

    sli.sort(sortText);
    XSLI = sli;

    // Get rid of duplicates
    var nsli = new Array();
    var dups = new Array();
    nsli[0] = sli[0];
    var pos = 1;
    var dpos = 0;
    for (i = 1; i < sli.length; i++) {
	if (!sameAs(sli[i-1],sli[i])) {
	    nsli[pos] = sli[i];
	    pos++;
	} else {
	    dups[dpos] = sli[i];
	    dpos++;
	}
    }

    // Delete the dups...
    for (i = 0; i < dups.length; i++) {
	ul.removeChild(dups[i]);
    }

    // This effectively moves them into sorted order
    for (i = 0; i < nsli.length; i++) {
	ul.appendChild(nsli[i]);
    }

    var plus = document.getElementById("cmshow");
    var p = plus.parentNode;
    p.removeChild(plus);

    var minus = document.getElementById("cmhide");
    p.removeChild(minus);

    var del = document.getElementById("cmdelete");
    p.removeChild(del);
}

function unwrapItem(listdiv) {
    var li = listdiv.parentNode;
    var ul = li.parentNode;
    var lis = listdiv.getElementsByTagName("li");

    // why does this insertBefore change the lis array?
    while (lis.length > 0) {
	ul.insertBefore(lis[0],li);
    }
}

function sortText(a,b) {
    if (stringValue(a) < stringValue(b)) {
	return -1;
    } else {
	return 1;
    }
}

function sameAs(a,b) {
    return stringValue(a) == stringValue(b);
}

function stringValue(a) {
    var s = "";
    var c = a.firstChild;
    var e = false;

    while (c != null) {
	if (c.nodeType == Node.ELEMENT_NODE) {
	    e = e || c.nodeName == 'CODE'
	    s = s + stringValue(c);
	} else if (c.nodeType == Node.TEXT_NODE) {
	    s = s + c.data;
	}
	c = c.nextSibling;
    }

    // This makes "text" => "a text" and "alt" = "e alt" which forces
    // text to sort first...
    if (e) {
	return "e " + s;
    } else {
	return "a " + s;
    }
}

function addDeleteLink() {
    var plus = document.getElementById("cmshow");
    var delspan = document.getElementById("cmdelete");
    if (delspan == null) {
	var parent = plus.parentNode;
	delspan = document.createElement("span");
	delspan.setAttribute("id", "cmdelete");
	delspan.appendChild(document.createTextNode(" "));
	var dellink = document.createElement("a");
	dellink.setAttribute("href", "javascript:deleteAll()");

	var img = document.createElement("img");
	img.setAttribute("src","graphics/delete.gif");
	img.setAttribute("alt","[x]");
	img.setAttribute("border","0");

	dellink.appendChild(img);
	delspan.appendChild(dellink);

	parent.insertBefore(document.createTextNode(" "),plus);
	parent.insertBefore(delspan,plus);
	parent.insertBefore(document.createTextNode(" "),plus);
    }
}