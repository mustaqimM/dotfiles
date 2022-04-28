// ==UserScript==
// @name        Hacker News to Premii
// @namespace   Violentmonkey Scripts
// @match       https://news.ycombinator.com/item?id=*
// @grant       none
// @run-at      document-start
// @version     0.1
// @author      mustaqimM
// @description redirects HN to Premii
// @icon        data:image/bmp;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAMAAAD04JH5AAABuVBMVEX/ZgD/ZgD/ZgD//////v7/+fX/1rv/49D/693/9vD/bw//agb/+/n/iDj/7uP/2sL/aAP/yaX/bQv/ZwH/fCT/mFT//fz/gCv/gCz/3cb/4Mz/sn//8ur/0LD/7eH/dBf/+PP/w5v/6Nn/gzD/7N//hTT/lE3/tYT/fSb/j0T/r3n/cxX/o2b/k0v/bAr/omT/38r/gi//9O3/mlf/zKr/l1L/8ef/p2z/pWn/oGD/1rr/0bP/6dv/+vb/s4D/1Lf/hTP/dxz/cRL/nl7/173/vZH/5tX/bg3/+PT/0bL/8un/9/H/zaz/6Nj/7+T/1Lj/iTr/kkr/kUj/3cf/9e7/eyP/6dr/xJz/49H/tob/7+X/gi7/u43/y6j/u47/5dT/fij/mFP/qnL/2b//zav/jED//fv/jkL/7uL/rXf/qXD/+/j/hjX/kEb/oWL/uoz/vpL//Pr/9/L/wZf/fyr/yqb/kUf/dhv/mlb/qnH/sHv/ijz/jUH/zq3/uIn/5tb/xqD/697/4c3/xZ//l1H/eR//tIL/jD//07b/rHX/6tz/5dP/uIj/1bn/chT/gzH/nl3/vJD/o2UQk21lAAAAAnRSTlPl8gYpWaEAAAJtSURBVHhe7dtVi+RQEAXg7qok7e4y7u6y7u7u7u7u7vqLd2/NwkCzmRnonT77UOehDoSQfA83BMKNx+OFxuMhcDxeLMD7V4ACFKAABShAAQpQgAIUoAAFKEABjonMukpAwhxN1smcBoytcAf4/L9DfpM5A9hEZqASUG+OBgMypwGTu0KuADmX2GQeAdyEBvAAGhCOgAEcbQADOBYCA/g6GsAL0IAly8EAru8BA3h1HAzgw2gAj+AALywz7SEYIFESuH8lDJDaIIJtcRRgR3qvCA6gAJPOoUYDsE6gAHwtIwvx5m0UwLr/VPDNQRCA7ZaFIliUAgF4cbpVBEtRAF7WZpuy2lEA7lglFehEAayxNdJr1/0LwPquimycFcCbhmLSm1PVAlwyG4C3dG6V7kYBuG572FR2JwrApV6p3XtQAKtvn/T+/moAjmuSMwAOiiCQG5Q+Ug2g1zWhGQCJoyI4drwsfbLmayARPyWC02fOmsqeqzmAes6L4MJFqfKlmgPostwzeyXBktoD6Kowh/O+6gE3RitizwVAt0Tgyw9L1/ZlJIBQQQR37mZBALo3LoIHD1EAejT1Nnj8BAWgCTYp556hAPRcBMWWAArQ/1IEr15bIAC9KYtg4i0KQF3yEIbfvUcB6AObjOc/ogCpUREU2mwQgJKfRNA0ggJQWqg8AANQnyULMQIDUIlNojjAnw9HOAAFm8EAyjWCAZSxwAD6jAbEv4AB9LUVDKBvNhhA39EA+oEGhGJgADVEwQCKhOdvA0O7UygWOzLF4qDTTa75+X9u4VCAAhSgAAUoQAEKUIACFKAABSiAwIH//v8LgEPtYRfHfrYAAAAASUVORK5CYII=
// ==/UserScript==

(function() {
  'use strict';

  var theurl = document.URL;
  var res = theurl.replace(/news.ycombinator.com\/item\?id\=/gi, "hn.premii.com\/\#\/comments\/");
  window.location.replace(res);
  
})();