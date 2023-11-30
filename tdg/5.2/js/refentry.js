(function() {
  const toggleElementList = function(div, singularMsg, pluralMsg) {
    const p = div.querySelector("p");
    const spans = p.querySelectorAll(":scope code.tag");
    const newP = document.createElement("p");
    const period = document.createTextNode(".");
    const pcount = spans.length -1;
    const del = document.createElement("span");
    const show = document.createElement("span");
    const hide = document.createElement("span");

    const thisElem = spans[0].cloneNode(true);

    newP.innerHTML = pcount + " element";
    if (pcount > 1) {
      newP.innerHTML += "s " + pluralMsg + " ";
    } else {
      newP.innerHTML += " " + singularMsg + " ";
    }

    del.setAttribute("class", "cmjs cmdelete");
    del.innerHTML = " ×";
    del.onclick = function () {
      p.style.display = "block";
      newP.style.display = "none";
    };

    show.setAttribute("class", "cmjs");
    show.innerHTML = " ⏵";
    show.onclick = function () {
      p.style.display = "block";
      show.style.display = "none";
      hide.style.display = "inline";
    };

    hide.style.display = "none";
    hide.setAttribute("class", "cmjs");
    hide.innerHTML = " ⏷";
    hide.onclick = function () {
      p.style.display = "none";
      show.style.display = "inline";
      hide.style.display = "none";
    };

    newP.appendChild(thisElem);
    newP.appendChild(period);
    newP.appendChild(del);
    newP.appendChild(show);
    newP.appendChild(hide);

    div.insertBefore(newP, p);

    p.style.display = "none";
  }

  const hideAll = function() {
    document.querySelectorAll(".refsynopsisdiv").forEach(function (div) {
      div.querySelectorAll(".patnlist").forEach(function (patn) {
        const id = patn.id.substring(2);
        hide(id);
      });
    });
  }

  const showAll = function() {
    document.querySelectorAll(".refsynopsisdiv").forEach(function (div) {
      div.querySelectorAll(".patnlist").forEach(function (patn) {
        const id = patn.id.substring(2);
        show(id);
      });
    });
  }

  const hide = function(id) {
    var list = document.getElementById("l." + id);
    list.style.display = 'none';

    var plus = document.getElementById("pls." + id);
    plus.style.display = 'inline';

    var minus = document.getElementById("plh." + id);
    minus.style.display = 'none';
  }

  const show = function(id) {
    var list = document.getElementById("l." + id);
    list.style.display = 'block';

    var plus = document.getElementById("pls." + id);
    plus.style.display = 'none';

    var minus = document.getElementById("plh." + id);
    minus.style.display = 'inline';
  }

  const deleteAll = function() {
    const dli = [];
    document.querySelectorAll(".patnlist").forEach(function (div) {
      dli.push(div.parentNode);
      unwrapItem(div);
    });

    const ul = dli[0].parentNode;
    dli.forEach(function (item) {
      ul.removeChild(item);
    });

    const sli = [];
    ul.querySelectorAll("li").forEach(function (li) {
      sli.push(li);
    });
    sli.sort(sortText);

    // Get rid of duplicates
    const nsli = [];
    const dups = [];
    nsli[0] = sli[0];
    let pos = 1;
    let dpos = 0;
    for (i = 1; i < sli.length; i++) {
      if (sameAs(sli[i-1],sli[i])) {
        dups[dpos] = sli[i];
        dpos++;
      } else {
        nsli[pos] = sli[i];
        pos++;
      }
    }

    // Delete the dups...
    dups.forEach(function (item) {
      ul.removeChild(item);
    });

    // Move them into sorted order...
    nsli.forEach(function (item) {
      ul.appendChild(item);
    });

    const widgets = [];
    document.querySelectorAll(".cmshow").forEach(function (widget) {
      widgets.push(widget);
    });
    document.querySelectorAll(".cmhide").forEach(function (widget) {
      widgets.push(widget);
    });
    document.querySelectorAll(".cmshowall").forEach(function (widget) {
      widgets.push(widget);
    });
    document.querySelectorAll(".cmhideall").forEach(function (widget) {
      widgets.push(widget);
    });
    widgets.forEach(function (widget) {
      const p = widget.parentNode;
      p.removeChild(widget);
    });
  }

  const unwrapItem = function(listdiv) {
    const li = listdiv.parentNode;
    const ul = li.parentNode;
    const lis = listdiv.getElementsByTagName("li");

    // why does this insertBefore change the lis array?
    while (lis.length > 0) {
      ul.insertBefore(lis[0],li);
    }
  }

  const sortText = function(a,b) {
    if (stringValue(a) < stringValue(b)) {
      return -1;
    } else {
      return 1;
    }
  }

  const sameAs = function(a,b) {
    return stringValue(a) == stringValue(b);
  }

  const stringValue = function(a) {
    let s = "";
    let c = a.firstChild;
    let e = false;

    while (c != null) {
      if (c.nodeType === Node.ELEMENT_NODE) {
        e = e || c.nodeName === 'CODE';
        s = s + stringValue(c);
      } else if (c.nodeType === Node.TEXT_NODE) {
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

  hideAll();

  document.querySelectorAll(".cmshow").forEach(function (span) {
    show(span.getAttribute("db-ref"));
    span.innerHTML = " ⏵";
    span.onclick = function() {
      show(span.getAttribute("db-ref"));
    };
  });

  document.querySelectorAll(".cmhide").forEach(function (span) {
    hide(span.getAttribute("db-ref"));
    span.innerHTML = " ⏷";
    span.onclick = function() {
      hide(span.getAttribute("db-ref"));
    };
  });

  let showAllWidget = document.querySelector(".cmshowall");
  let hideAllWidget = document.querySelector(".cmhideall");
  let deleteWidget = document.querySelector(".cmdelete");

  if (showAllWidget && hideAllWidget && deleteWidget) {
    showAllWidget.style.display = "inline";
    showAllWidget.innerHTML = " ⏵";
    showAllWidget.onclick = function() {
      showAllWidget.style.display = "none";
      hideAllWidget.style.display = "inline";
      showAll();
    };

    hideAllWidget.style.display = "none";
    hideAllWidget.innerHTML = " ⏷";
    hideAllWidget.onclick = function() {
      showAllWidget.style.display = "inline";
      hideAllWidget.style.display = "none";
      hideAll();
    };

    deleteWidget.innerHTML = " ×";
    deleteWidget.onclick = function() {
      deleteWidget.style.display = "none";
      showAllWidget.style.display = "none";
      hideAllWidget.style.display = "none";
      deleteAll();
    };
  }

  const pdiv = document.querySelector(".cmparents");
  if (pdiv) {
    let html = "<div class='title'>Parents<div class='cmx'>×</div></div><div class='body'><ul>";
    let atleastone = false;
    document.querySelectorAll(".refsection").forEach(function (div) {
      const h3 = div.querySelector("header h3");
      if (h3 && h3.innerHTML === "Parents") {
        const list = div.querySelector(".simplelist");
        list.querySelectorAll(".tag-element").forEach(function (code) {
          if (code.parentNode.tagName === "A") {
            const anchor = code.parentNode;
            const next = anchor.nextElementSibling;
            atleastone = true;
            html += "<li><a href='" + anchor.getAttribute("href") + "'>";
            html += code.innerHTML + "</a>";
            if (next) {
              html += " " + next.innerHTML;
            }
            html += "</li>";
          }
        });
      }
    });
    html += "</ul></body>";
    if (atleastone) {
      pdiv.classList.add("cmsidebar");
      pdiv.innerHTML = html;
    }
  }

  document.querySelectorAll(".refsection").forEach(function (div) {
    const h3 = div.querySelector("h3");
    if (h3 && h3.innerHTML == "Parents") {
      toggleElementList(div, 'contains', 'contain');
    }
    if (h3 && h3.innerHTML == "Children") {
      toggleElementList(div, 'occurs in', 'occur in');
    }
  });
})();
