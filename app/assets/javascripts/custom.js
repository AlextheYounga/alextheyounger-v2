$(document).ready(function () {
  $('.mobile-menu').hide
  //Menu button on click event
  $('.mobile-nav-button').on('click', function () {
    // Toggles a class on the menu button to transform the burger menu into a cross
    $(".mobile-nav-button .mobile-nav-button__line:nth-of-type(1)").toggleClass("mobile-nav-button__line--1");
    $(".mobile-nav-button .mobile-nav-button__line:nth-of-type(2)").toggleClass("mobile-nav-button__line--2");
    $(".mobile-nav-button .mobile-nav-button__line:nth-of-type(3)").toggleClass("mobile-nav-button__line--3");

    // Toggles a class that slides the menu into view on the screen
    $('.mobile-menu').toggleClass('mobile-menu--open');
    $('.mobile-menu').toggleClass('z-negative');
    $('.mobile-menu').toggleClass('z-40');
    $('.mobile-menu ul').toggleClass('hidden');
    return false;
  });

  $(window).on('scroll', function () {
    if ($(window).scrollTop() > 0) {
      $('#admin-nav').addClass('fixed');
    } else {
      $('#admin-nav').removeClass('fixed');
    }
  });
  if ($(window).scrollTop() > 0) {
    $('#admin-nav').addClass('fixed');
  } else {
    $('#admin-nav').removeClass('fixed');
  }

  if ($('.flash-msg').is(":visible")) {
    setTimeout(fade_out, 20000);

    function fade_out() {
      $('.flash-msg').fadeOut().empty();
    }
  }
});

const languageColors = {
  'HTML': '#e34c26',
  'CSS': '#563d7c',
  'SCSS': '#c6538c',
  'Ruby': "#701516",
  'Ruby on Rails': "#701516",
  'Python': "#3572A5",
  'JavaScript': "#f1e05a",
  'Electron JS': "#f1e05a",
  'PHP': "#4F5D95",
  'PHP Laravel': "#4F5D95",
  'Laravel': "#4F5D95",
  'Wordpress': "#4F5D95",
  'Blade': '#f7523f',
  'Vue': '#2c3e50',
  'Java': "#b07219",
  'C++': "#f34b7d",
  'CPlusPlus': "#f34b7d",
  'C': "#555555",
  'C#': "#178600",
  'Scala': "#c22d40",
  'Objective-C': "#438eff",
  'Shell': "#89e051",
  'Perl': "#0298c3",
  'CoffeeScript': "#244776",
  'Haskell': "#5e5086",
  'Erlang': "#B83998",
  'Emacs Lisp': "#c065db",
  'Clojure': "#db5855",
  'Lua': "#000080",
  'Go': "#00ADD8",
  'Groovy': "#e69f56",
  'Puppet': "#302B6D",
  'TypeScript': "#2b7489",
  'OCaml': "#3be133",
  'Objective-C++': "#6866fb",
  'Objective-CPlusPlus': "#6866fb",
  'Common Lisp': "#3fb68b",
  'DM': "#447265",
  'Julia': "#a270ba",
  'Smalltalk': "#596706",
  'PowerShell': "#012456",
  'R': "#198CE7",
  'F#': "#b845fc",
  'Dart': "#00B4AB",
  'Haxe': "#df7900",
  'Rust': "#dea584",
  'Vala': "#fbe5cd",
  'Elixir': "#6e4a7e",
  'Swift': "#ffac45",
  'Kotlin': "#F18E33",
  'Elm': "#60B5CC",
  'SystemVerilog': "#DAE1C2",
  'Coq': "#7cb5ec",
  'ABAP': "#E8274B",
  'Vim script': "#199f4b",
  'Fortran': "#4d41b1",
  'Roff': "#ecdebe",
  'WebAssembly': "#04133b",
  'Jsonnet': "#0064bd",
  'MATLAB': "#e16737",
  'TSQL': "#434348",
  'Visual Basic .NET': "#a791b4",
  '.NET': "#a791b4",
  'NET': "#a791b4",
}

function stringParameterize(str1) {
  if (str1.includes("+")) {
    return str1.trim().toLowerCase().replace(/[^a-zA-Z0-9 -]/, "").replace(/\s/g, "-").replace("+", "plus");
  }
  return str1.trim().toLowerCase().replace(/[^a-zA-Z0-9 -]/, "").replace(/\s/g, "-");
};

function padZero(str, len) {
  len = len || 2;
  var zeros = new Array(len).join('0');
  return (zeros + str).slice(-len);
}

function invertColor(hex, bw) {
  // https://stackoverflow.com/questions/63378749/is-there-a-way-to-generate-foreground-text-and-navigation-contrasting-colour-t
  if (hex.indexOf('#') === 0) {
     hex = hex.slice(1);
  }
  // convert 3-digit hex to 6-digits.
  if (hex.length === 3) {
     hex = hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
  }
  if (hex.length !== 6) {
     throw new Error('Invalid HEX color.');
  }
  var r = parseInt(hex.slice(0, 2), 16),
      g = parseInt(hex.slice(2, 4), 16),
      b = parseInt(hex.slice(4, 6), 16);
  if (bw) {
      // http://stackoverflow.com/a/3943023/112731
      return (r * 0.299 + g * 0.587 + b * 0.114) > 186
        ? '#000000'
        : '#FFFFFF';
  }
  // invert color components
  r = (255 - r).toString(16);
  g = (255 - g).toString(16);
  b = (255 - b).toString(16);
  // pad each with zeros and return
  return "#" + padZero(r) + padZero(g) + padZero(b);
}

function generateProjectFrameworkColors() {
  var projectsContainer = document.getElementById("projects-container");
  if (typeof (projectsContainer) != 'undefined' && projectsContainer != null) {
    var languageBubbles = document.getElementsByClassName("framework-bubble");
    for (var i = 0; i < languageBubbles.length; i++) {
      var framework = languageBubbles.item(i).dataset.framework
      var frameworkBgColor = languageColors[framework]
      var textColor = invertColor(frameworkBgColor, true)

      languageBubbles.item(i).style.backgroundColor = frameworkBgColor
      languageBubbles.item(i).style.color = textColor
   }
  }
}

function generateLanguageBarColors() {
  var langStats = document.getElementById("language-bar");
  if (typeof (langStats) != 'undefined' && langStats != null) {

    for (var _i = 0, _Object$entries = Object.entries(languageColors); _i < _Object$entries.length; _i++) {
      var _Object$entries$_i = _Object$entries[_i];
      lang = _Object$entries$_i[0];
      color = _Object$entries$_i[1];
      var barItems = document.querySelectorAll(".bar-item." + stringParameterize(lang));
      var octicons = document.querySelectorAll(".octicon." + stringParameterize(lang));

      if (typeof barItems != 'undefined' && barItems != null) {
        for (var i = 0, length = barItems.length; i < length; i++) {
          barItems[i].style.backgroundColor = color;
        }
      }

      if (typeof octicons != 'undefined' && octicons != null) {
        for (var i = 0; i < octicons.length; i++) {
          octicons[i].style.color = color;
        }
      }
    }
  }
}


window.onload = function () {
  generateLanguageBarColors()
  generateProjectFrameworkColors()

  if ($('#resume')[0]) {
    particlesJS("particles-js", {
      "particles": {
        "number": {
          "value": 180,
          "density": {
            "enable": true,
            "value_area": 800
          }
        },
        "color": {
          "value": "#ffffff"
        },
        "shape": {
          "type": "circle",
          "stroke": {
            "width": 0,
            "color": "#000000"
          },
          "polygon": {
            "nb_sides": 5
          },
          "image": {
            "src": "img/github.svg",
            "width": 100,
            "height": 100
          }
        },
        "opacity": {
          "value": 0.5,
          "random": false,
          "anim": {
            "enable": false,
            "speed": 1,
            "opacity_min": 0.1,
            "sync": false
          }
        },
        "size": {
          "value": 3,
          "random": true,
          "anim": {
            "enable": false,
            "speed": 40,
            "size_min": 0.1,
            "sync": false
          }
        },
        "line_linked": {
          "enable": true,
          "distance": 150,
          "color": "#ffffff",
          "opacity": 0.4,
          "width": 1
        },
        "move": {
          "enable": true,
          "speed": 6,
          "direction": "none",
          "random": false,
          "straight": false,
          "out_mode": "out",
          "bounce": false,
          "attract": {
            "enable": false,
            "rotateX": 600,
            "rotateY": 1200
          }
        }
      },
      "interactivity": {
        "detect_on": "canvas",
        "events": {
          "onhover": {
            "enable": true,
            "mode": "grab"
          },
          "onclick": {
            "enable": true,
            "mode": "push"
          },
          "resize": true
        },
        "modes": {
          "grab": {
            "distance": 140,
            "line_linked": {
              "opacity": 1
            }
          },
          "bubble": {
            "distance": 400,
            "size": 40,
            "duration": 2,
            "opacity": 8,
            "speed": 3
          },
          "repulse": {
            "distance": 200,
            "duration": 0.4
          },
          "push": {
            "particles_nb": 4
          },
          "remove": {
            "particles_nb": 2
          }
        }
      },
      "retina_detect": true
    });
  }
};



