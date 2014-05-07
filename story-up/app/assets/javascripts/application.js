// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require owl.carousel
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require resizeend
//= require turbolinks
//= require jquery.form
//= require_tree .

function popup(data, target) {
  var options = {
      placement: 'top',
      trigger: 'manual',
      content: function () {
          return data;
      },
      container: 'body',
      html: 'true'
    };

    target.popover(options);
    target.popover('show');
    window.setTimeout(function(){
      target.popover('destroy');},2000);
}

function short_text(max, text) {
  if(text.length > max) {
    return text.substring(0, max) + "...";
  }
  else {
    /*offset = max - text.length;
    for(var i = 0; i < offset; i++) {
      text += " ";
    }*/

    return text;
  }
}

function initCarousel(owl, next_id, pre_id) {
    owl.owlCarousel({
       items : 6, //6 items above 1500px browser width
       itemsDesktop : [1500,4], //4 items between 1500px and 901px
       itemsDesktopSmall : [900,2], // 2 items betweem 900px and 501px
       itemsTablet: [500,1], //2 items between 600 and 0;
       itemsMobile : false // itemsMobile disabled - inherit from itemsTablet option
    });

    if(next_id != "" && pre_id != "") {
      // Custom Navigation Events
      $(next_id).click(function(){
          owl.trigger('owl.next');
      })
      $(pre_id).click(function(){
          owl.trigger('owl.prev');
      })
    }
}