// ==UserScript==
// @name        Get URL from get-to.link
// @namespace   Violentmonkey Scripts
// @match       https://get-to.link/*
// @grant       GM_setClipboard
// @version     1.0
// @author      mustaqimM
// @description 2022/04/10, 10:25:11
// ==/UserScript==

(function() {
  'use strict';

  var aurl = "https://get-to.link/find/";
  var icon = "file:///usr/share/icons/Papirus/22x22/actions/edit-link.svg"
  var url = document.querySelector('a[href*=' + CSS.escape(aurl) + ']');

  GM_setClipboard(url, 'text/plain');

  // OPTIONAL: Show system notification, comment block if unneeded.
  if (Notification.permission === 'granted') {
    var notify = new Notification('Copied URL!', {
      body: url,
      icon: icon
    });
  } else {
    Notification.requestPermission().then(function(status) {
      if(status === 'granted') {
        var notify = new Notification('Copied URL!', {
          body: url,
          icon: icon
        });

      } else {
        console.log('User denied the notification permission dialogue.');
      }
    }).catch(function(err) {
      console.error(err);
    });
  }

})();
