// functions to calculate fingerprint and send it to the server ========================
function trackAstEvent(clientData) {
  try {
    var endpoint = '//static.enzymic.co/ast_events';
    var request = new XMLHttpRequest();

//    addTapadPixel(clientData.cookie_uid);

    var data = Object.keys(clientData).reduce(function(a,k){
      if (k == 'selectors_data') {
        var selectors_data = Object.keys(clientData[k]).reduce(function(arr,key){
          arr.push(encodeURIComponent("ast_event["+k+"]["+key+"]")+'='+encodeURIComponent(clientData[k][key]));
          return arr
        }, []);
        a = a.concat(selectors_data);
      } else {
        a.push(encodeURIComponent("ast_event["+k+"]")+'='+encodeURIComponent(clientData[k]));
      }
      return a
    }, []).join('&');
    request.open('POST', endpoint);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
    request.send(data);
  } catch (err) {
    console.log(err);
  }
};

function pluginsHashCode() {
  try {
    var plugins = navigator.plugins;
    var plugins_text = '';
    for(var i = 0; i < plugins.length; i++) { plugins_text += plugins[i].name }
    return plugins_text.split('').reduce(function(prevHash, currVal) {
      return ((prevHash << 5) - prevHash) + currVal.charCodeAt(0);
    }, 0);
  } catch (err) {
    console.log(err);
  }
};

function hashCode(uid) {
  try {
    var hash = 0, i, chr;
    if (uid.length === 0) return hash;
    for (i = 0; i < uid.length; i++) {
      chr   = uid.charCodeAt(i);
      hash  = ((hash << 5) - hash) + chr;
      hash |= 0; // Convert to 32bit integer
    }
    return Math.abs(hash);
  } catch (err) {
    console.log(err);
  }
};

function getClientData() {
  try {
    let client_data = {};

    client_data.user_agent = navigator.userAgent || '';
    client_data.plugins_hash = pluginsHashCode() || '';
    client_data.device_memory = navigator.deviceMemory || '';
    client_data.hardware_concurrency = navigator.hardwareConcurrency || '';
    client_data.vendor = navigator.vendor || '';
    client_data.cookie_enabled = navigator.cookieEnabled || '';
    client_data.max_touch_points = navigator.maxTouchPoints || 0;
    client_data.platform = navigator.platform || '';
    var languages = navigator.languages;
    if (languages) {
      client_data.languages = languages.join(', ');
    } else {
      client_data.languages = '';
    }
    var mime_types = navigator.mimeTypes;
    if (mime_types) {
      client_data.mime_types = mime_types.length;
    } else {
      client_data.mime_types = '';
    }
    client_data.screen_width = screen.width || '';
    client_data.screen_height = screen.height || '';
    client_data.screen_depth = screen.pixelDepth || '';
    return client_data;
  } catch (err) {
    console.log(err);
  }
}

function calculateUid(clientData) {
  try {
    var uid = [clientData.user_agent, clientData.plugins_hash,
      '203.63.215.92', clientData.hardware_concurrency, clientData.vendor,
      clientData.languages, clientData.mime_types, clientData.cookie_enabled,
      clientData.max_touch_points, clientData.platform, clientData.screen_width,
      clientData.screen_height, clientData.screen_depth];
    uid = uid.join('; ');
    return hashCode(uid);
  } catch (err) {
  console.log(err);
  }
}

function isUrlValid(url) {
  try {
    // check if url is a valid image url
    var validUrlRegex = /(http)?s?:?(\/\/[^"']*\.(?:png|jpg|jpeg|gif|png|svg))/i;
    var isValidUrl = validUrlRegex.test(url);

    var isSvgLogo = (/\.(svg)$/i).test(url) && (url.indexOf('logo') !== -1)

    // return TRUE if url is valid and not svg logo (e.g. http://site/images/logo/l.svg)
    return isValidUrl && !isSvgLogo;
  } catch (err) {
    console.log(err);
  }
}

//function getMeta(url, callback) {
//  try {
//    var img = new Image();
//    img.src = url;
//    img.onload = function() { callback(url, this.width, this.height); }
//  } catch (err) {
//    // send err
//  }
//}

function getUrl(container) {
    var ogUrl = container.querySelector("meta[property='og:url']");
    var url = window.location.href;

    if (ogUrl && /http:\/\/|https:\/\//i.test(ogUrl.getAttribute('content'))) {
      url = ogUrl.getAttribute('content');
    }


    var splitParams = url.indexOf('FPProductDisplay') == -1 && url.indexOf('ProductDisplay') == -1 && url.indexOf('marlobeauty') == -1;


    if (('143' == '3' || '143' == '4') && url.indexOf('?dispatch=checkout.complete') > 0) {
      url = url.split("&")[0];
    } else if (splitParams) {
      url = url.split("?")[0];
      url = url.replace(/\/?$/, '');
    }

    if ('143' == '38' || url.includes("//tags.tiqcdn.com/utag/xaxis/-pizza-hut")) {
      var url_string = window.location.href;
      var param_url = new URL(url_string);
      url = param_url.searchParams.get("xaxis_url")
    }

  return url;
}

function collectData(container) {
  try {
    var data = {};
    data.smart_tag_id = '143' || '';
    data.ip = '203.63.215.92' || '';

    var client_data = getClientData();
    data.uid = calculateUid(client_data);

    var ogTitle = container.querySelector("meta[property='og:title']");
    var ogDescription = container.querySelector("meta[property='og:description']");

    var url = getUrl(container);

    if ('143' == '10' && document != container) {
      var fbButton = container.getElementsByClassName('fb-share-button')[0];
      if (fbButton) {
        url = fbButton.getAttribute('data-href');
      }
    }

    data.url = url.replace(/http:|https:/, '');
    data.url_protocol = window.location.protocol;

    if (ogTitle) {
      ogTitle = ogTitle.getAttribute('content');
    } else {
      ogTitle = document.title;
    }
    data.page_title = ogTitle;

    if (ogDescription) {
      ogDescription = ogDescription.getAttribute('content');
    } else {
      ogDescription = container.querySelector("meta[name='description']");
      if (ogDescription) {
        ogDescription = ogDescription.content;
      } else {
        ogDescription = '';
      }
    }
    data.page_description = ogDescription;

    var srcList = [];

    var elementNames = ["div", "img", "a"] // Put all the tags you want bg images for here
    elementNames.forEach(function (tagName) {
      var tags = container.getElementsByTagName(tagName);
      var numTags = tags.length;
      for (var i = 0; i < numTags; i++) {
        var tag = tags[i];

        // sometimes window.getComputedStyle returns 404
        try {
          var imgUrl = window.getComputedStyle(tag, false).backgroundImage.slice(4, -1).replace(/"/g, "");
        } catch(err) {
          var imgUrl = null;
        }

        if (isUrlValid(imgUrl) && tag.clientWidth >= 100 && tag.clientHeight >= 50) {
          srcList.unshift(imgUrl); // add url to the beginning of the arr

          //getMeta(imgUrl, function (url, width, height) {
          //      if (width >= 100 && height >= 50  ) {
          //          srcList.push(url);
          //      }
          //});
        }
      }
    });

    var imgs = container.querySelectorAll('img');
    Array.prototype.forEach.call(imgs, function(el, i){
      if (isUrlValid(el.src) && el.clientWidth >= 100 && el.clientHeight >= 50) {
        srcList.push(el.src);
      }
    });

    var ogImage = container.querySelector("meta[property='og:image']");
    if (ogImage && ogImage.getAttribute('content')) {
      srcList.unshift(ogImage.getAttribute('content'))
    }

    // unique images urls
    srcList = srcList.filter((item, i, ar) => ar.indexOf(item) === i);

    var imagesCount = (srcList.length > 4) ? 4 : srcList.length;

    for (var i = 0; i < imagesCount; i++) {
      data["image_source_" + (i+1)] = srcList[i];
    }

    function grabSelectors(nodes, arr) {
      try {
        nodes.forEach(function (value) {
          if (value.nodeType === Node.TEXT_NODE) {
            arr.push(value.nodeValue.replace(/^\s+|\s+$/gm, ''));
          } else if (value.nodeType === Node.ELEMENT_NODE) {
            grabSelectors(value.childNodes, arr);
          }
        });
        return arr;
      } catch(err) {
        return [];
      }
    }

    var selectors_data = {};


        var productImageSelectorName = 'div.product-hero-image-container img'.replace(/&quot;/g, '"');
        var productImg = container.querySelector(productImageSelectorName);

        if (productImg != null) {
          if ('143' == '88') {
            var productImgvalue = productImg.getAttribute('largesrc'); // to grab all the images of different colors
          } else if ('143' == '91') {
            var productImgvalue = productImg.style.backgroundImage.slice(4, -1).replace(/"/g, ""); //to grab image for BCA EXPO
          } else if ('143' == '92') {
            var productImgvalue = productImg.getAttribute('value'); // get img url for kreditkerenbanget
          } else if ('143' == '97') {
            var productImgvalue = productImg.getAttribute('content'); // get img url content for peanuts
          } else {
            var productImgvalue = productImg.getAttribute('src'); // get img url
          }

          if (productImgvalue != null && productImgvalue !== '') {
            if (productImgvalue.startsWith('/') && !productImgvalue.startsWith('//')) {
              productImgvalue = window.location.origin + productImgvalue;
            }
            if (productImgvalue.startsWith('//')) {
              productImgvalue = window.location.protocol + productImgvalue;
            }

              data['image_source_1'] = productImgvalue;
          }
        }
        if ('product_name' == 'category') {
          var breadcrumbs = container.querySelectorAll('h1.product-title'.replace(/&quot;/g, '"').replace(/&#39;/g, "'"));
          if (breadcrumbs.length > 2) {
            var el = breadcrumbs[2];
          } else {
            var el = breadcrumbs[0];
          }
        } else {
          var selectorName = 'h1.product-title'.replace(/&quot;/g, '"').replace(/&#39;/g, "'");

          if (selectorName.includes('.querySelector(')) {
            try { var el = eval(selectorName) } catch (err) { var el = '' }
            var value = null;
            // "document.querySelector("[data-flix-mpn]").getAttribute("data-flix-mpn")"
            if (selectorName.includes('getAttribute')) {
              var value = [el]
            }
          } else if (selectorName.startsWith("dataLayer") || selectorName.startsWith("ldJson")) {
            try { var el = eval(selectorName) } catch (err) { var el = '' }
            var value = [el];
          } else if (selectorName.includes('querySelectorAll')) {
            //document.querySelectorAll("input[name='product-size-picker']:not([disabled])")
            try { var el = eval(selectorName) } catch (err) { var el = '' }
            try { var value = Array.from(el).map(x => x.value) } catch (err) { var value = null }
          } else if (selectorName.startsWith("?")) {
            const queryString = window.location.search;
            const urlParams = new URLSearchParams(queryString);
            var el = queryString;
            var value = urlParams.get(selectorName.substring(1));
            if (value != null) { value = [value] };
          } else {
            var el = container.querySelector(selectorName);
            var value = null;
          }
        }

        if ('h1.product-title'.includes('meta[name=')) {
          var selectorName = 'h1.product-title'.replace(/&quot;/g, '\"');
          var el = container.querySelector(selectorName);
          var value = el.getAttribute('content')
        }

        if (el != null && (el.textContent !== '' || (value != null && value !== ''))) {
          var childTextArr = grabSelectors(el.childNodes, []);
          if ('143' == '19') {
            var childTextArr = [el.childNodes[0].nodeValue.replace(/^\s+|\s+$/gm, '')]
          }
          if (value !== null && value !== '' && value !== undefined && value.length > 0) {
            selectors_data['product_name'] = value.join(' ');
          } else {
            selectors_data['product_name'] = childTextArr.filter(val => val != '').join(' ');
          }
        }

        if ('price' == 'category') {
          var breadcrumbs = container.querySelectorAll(' div.product-information span.price-container'.replace(/&quot;/g, '"').replace(/&#39;/g, "'"));
          if (breadcrumbs.length > 2) {
            var el = breadcrumbs[2];
          } else {
            var el = breadcrumbs[0];
          }
        } else {
          var selectorName = ' div.product-information span.price-container'.replace(/&quot;/g, '"').replace(/&#39;/g, "'");

          if (selectorName.includes('.querySelector(')) {
            try { var el = eval(selectorName) } catch (err) { var el = '' }
            var value = null;
            // "document.querySelector("[data-flix-mpn]").getAttribute("data-flix-mpn")"
            if (selectorName.includes('getAttribute')) {
              var value = [el]
            }
          } else if (selectorName.startsWith("dataLayer") || selectorName.startsWith("ldJson")) {
            try { var el = eval(selectorName) } catch (err) { var el = '' }
            var value = [el];
          } else if (selectorName.includes('querySelectorAll')) {
            //document.querySelectorAll("input[name='product-size-picker']:not([disabled])")
            try { var el = eval(selectorName) } catch (err) { var el = '' }
            try { var value = Array.from(el).map(x => x.value) } catch (err) { var value = null }
          } else if (selectorName.startsWith("?")) {
            const queryString = window.location.search;
            const urlParams = new URLSearchParams(queryString);
            var el = queryString;
            var value = urlParams.get(selectorName.substring(1));
            if (value != null) { value = [value] };
          } else {
            var el = container.querySelector(selectorName);
            var value = null;
          }
        }

        if (' div.product-information span.price-container'.includes('meta[name=')) {
          var selectorName = ' div.product-information span.price-container'.replace(/&quot;/g, '\"');
          var el = container.querySelector(selectorName);
          var value = el.getAttribute('content')
        }

        if (el != null && (el.textContent !== '' || (value != null && value !== ''))) {
          var childTextArr = grabSelectors(el.childNodes, []);
          if ('143' == '19') {
            var childTextArr = [el.childNodes[0].nodeValue.replace(/^\s+|\s+$/gm, '')]
          }
          if (value !== null && value !== '' && value !== undefined && value.length > 0) {
            selectors_data['price'] = value.join(' ');
          } else {
            selectors_data['price'] = childTextArr.filter(val => val != '').join(' ');
          }
        }



    // income smart tag optimize parameter grabbing

    // havas smart tag customize category

    if (!(Object.keys(data).length === 0 && data.constructor === Object)) {
      selectors_data['event_type'] = 'impression';
      data.event_type = 0;
    }

    selectors_data['language'] = navigator.language;
    selectors_data['user_agent'] = navigator.userAgent;

    data.selectors_data = selectors_data;

    return data;
  } catch (err) {
    console.log(err);
  }
};

function collectClickData(container, attr) {
  try {
    var data = {};
    data.smart_tag_id = '143' || '';
    data.ip = '203.63.215.92' || '';

    var client_data = getClientData();
    data.uid = calculateUid(client_data);

    var ogTitle = document.querySelector("meta[property='og:title']");
    var ogDescription = document.querySelector("meta[property='og:description']");

    var url = getUrl(document);

    data.url = url.replace(/http:|https:/, '');
    data.url_protocol = window.location.protocol;

    if (ogTitle) {
      ogTitle = ogTitle.getAttribute('content');
    } else {
      ogTitle = document.title;
    }
    data.page_title = ogTitle;

    if (ogDescription) {
      ogDescription = ogDescription.getAttribute('content');
    } else {
      ogDescription = document.querySelector("meta[name='description']");
      if (ogDescription) {
        ogDescription = ogDescription.content;
      } else {
        ogDescription = '';
      }
    }
    data.page_description = ogDescription;

    var srcList = [];
    var imgs = container.querySelectorAll('img');
    Array.prototype.forEach.call(imgs, function(el, i){
      if (isUrlValid(el.src) && el.clientWidth >= 100 && el.clientHeight >= 50) {
        srcList.push(el.src);
      }
    });

    var imagesCount = (srcList.length > 4) ? 4 : srcList.length;

    for (var i = 0; i < imagesCount; i++) {
      data["image_source_" + (i+1)] = srcList[i];
    }

    var selectors_data = {};
    let el = container;
    let value = null;
    if (attr !== null) {
      let counter = 0;
      for (let key in attr) {
        if (counter === 0) {
          counter++;
          let v = attr[key];
          if (v !== null) {
            if (v === 'value') {
              value = el.innerText;
            } else {
              value = el.getAttribute(v);
            };
            selectors_data[v] = value;
          };
          continue;
        }
        let paramTag = el.querySelector(key);
        value = paramTag.innerText;
        selectors_data[attr[key]] = value;
        counter++;
      }
    };

    // income smart tag optimize parameter grabbing


    selectors_data['event_type'] = 'click';
    data.event_type = 1;

    data.selectors_data = selectors_data;

    return data;
  } catch (err) {
    console.log(err);
  }
};






// ======================================================================================================

function checkLoaded() {
  return document.readyState === "complete";
}

function setClickHandlers(jquery_path) {
  // ".item &&.container_to_grab | .product-name; title | .price-action-block; price"
  // [".item ", " .product-name; title ", " .price-action-block; price"]
  let selectorsArray = jquery_path.replace(/&quot;/g, '\"').replace(/&amp;/g, '&').split('|');
  // [".item"]
  let selectorParams = selectorsArray[0].trim().split(';');
  // .item &&.container_to_grab
  let selectorName = selectorParams[0].split('&&')[0].trim();
  // &&.container_to_grab
  let containerName = selectorParams[0].split('&&')[1];

  let tags = document.querySelectorAll(selectorName);

  // {item: null, .product-name: "title", .price-action-block: "price"}
  let selectorAttr;
  if (selectorParams.length > 1) {
    selectorAttr = {};
    selectorAttr[selectorName] = selectorParams[1].trim();
  } else if (selectorsArray.length > 1) {
    selectorAttr = {};
    selectorAttr[selectorName] = null;
  };
  if (selectorsArray.length > 1) {
    for (let i = 1; i < selectorsArray.length; i++) {
      let sParam = selectorsArray[i].trim().split(';');
      selectorAttr[sParam[0].trim()] = sParam[1].trim();
    }
  };

  var event = '143' == '86' ? 'mouseup' : 'click'
  if (tags != null && tags.length > 0) {
    for (let i = 0; i < tags.length; i++) {
      tags[i].addEventListener(event, function (evt) {
        if (typeof containerName == 'undefined'|| containerName == undefined) {
          container = tags[i];
        } else {
          container = tags[i].closest(containerName);
        }
        readyClick(container, selectorAttr);
      })
    }
  };
}



function readyClick(tag, attr) {
  try {
    if (document.attachEvent ? document.readyState === "complete" : document.readyState !== "loading"){
      clickFn(tag, attr);
    } else {
      document.addEventListener('DOMContentLoaded', clickFn(tag, attr));
    }
  } catch (err) {
    console.log(err);
  }
}

function ready(fn) {
  try {
    if (document.attachEvent ? document.readyState === "complete" : document.readyState !== "loading"){
      // Uniqlo customization
      if ('143' == '88') {
        setTimeout(function() { fn(document); }, 2000);
      }
      if('143' == '104') {
        if (typeof waitForStarhubLoaderHide == 'function') {
          waitForStarhubLoaderHide();
        }
      } else{
        fn(document);
      }
    } else {
      document.addEventListener('DOMContentLoaded', fn(document));
    }
  } catch (err) {
    console.log(err);
  }
}

var fn = function(div) {
  try {
    // calculate client data - fingerprints
    var clientData = collectData(div);
    window.selectorsData = clientData.selectors_data;
    // read or set cookies
    getOrSetCookie(function (cookie_uid, is3rdPartyCookieEnabled) {
      if (is3rdPartyCookieEnabled == true) {
        clientData.cookie_uid = cookie_uid;
        window.cookie_uid = cookie_uid;
      }

      trackAstEvent(clientData); // send event to the server

      if (typeof popupGrabbing == 'function') {
        popupGrabbing();
      }

      if (typeof waitForPopupElement == 'function' && waitForPopupElement.executed == undefined) {
        waitForPopupElement.executed = true;
        waitForPopupElement();
      }

      if (typeof waitForUniqloReactClick == 'function') {
        waitForUniqloReactClick();
      }

      if (typeof waitForMewatchReactClick == 'function') {
        waitForMewatchReactClick();
      }

    });
  } catch (err) {
    console.log(err);
  }
}

// WAIT UNTIL DOCUMENT IS FULLY READY AND CALCULATE ALL UIDS AND SEND ===================================
// Sometimes when loading through GTM, this script loads after window `load` finished
// to send event in this cases we can just call fn() function
if (checkLoaded()) {
  ready(fn);
} else {
  window.addEventListener('load', function() {
    ready(fn);
  })
}

// =========================================================================================================

var clickFn = function (div, attr) {
  try {
    var clientData = collectClickData(div, attr);
      if (window.selectorsData) {
        clientData.selectors_data = Object.assign({}, window.selectorsData, clientData.selectors_data);
      }
    if (window.cookie_uid) {
      clientData.cookie_uid = window.cookie_uid;
    }
    trackAstEvent(clientData); // send event to the server

    if (typeof popupGrabbing == 'function') {
      popupGrabbing();
    }
  } catch (err) {
    console.log(err);
  }
}

// GET AND SET cookie functions ============================================================================
function getOrSetCookie(callback) {
  try {
    var value = getRandomInt(100000000, 999999999);
    var request = new XMLHttpRequest();

    // check if 3rd party cookie are enabled or disabled
    request.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 201) {
        var resp = JSON.parse(this.responseText);
        var cookie_uid = resp.cvalue;

        check3rdPartyCookiesEnabled(cookie_uid, callback);
      }
    };

    var endpoint = '//static.enzymic.co/set_third_party_cookie';

    request.open('POST', endpoint, true);
    request.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    request.withCredentials = true;
    request.crossDomain = true;
    request.send('cvalue='+value);
  } catch (err) {
    console.log(err);
  }
};

function check3rdPartyCookiesEnabled(cookie_uid, callback) {
  try {
    var request = new XMLHttpRequest();

    // check if 3rd party cookie are enabled or disabled
    request.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 201) {
        var resp = JSON.parse(this.responseText);
        if (resp.cvalue && resp.cvalue == cookie_uid) {
          callback(cookie_uid, true);
        } else {
          callback(cookie_uid, false);
        }
      }
    };

    var endpoint = '//static.enzymic.co/check_third_party_cookie';

    request.open('GET', endpoint, true);
    request.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    request.withCredentials = true;
    request.crossDomain = true;
    request.send();
  } catch (err) {
    console.log(err);
  }
};

// returns random number in interval
function getRandomInt(min, max) {
  try {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min)) + min; //The maximum is exclusive and the minimum is inclusive
  } catch (err) {
    console.log(err);
  }
};

function addTapadPixel(cookie_uid){
  try {
    var productionEnv = true;
    if(productionEnv && cookie_uid){
      var tapadPixelUrl = '//static.enzymic.co/ads/request_to_tapad';

      $.ajax({
        type: "POST",
        url: tapadPixelUrl,
        data: ({cookie_id: cookie_uid}),
        success:    function(response, status) {
          console.log(status);
        }
      });
    }
  } catch (err) {
    console.log(err);
  }
}
// =======================================================================================================
