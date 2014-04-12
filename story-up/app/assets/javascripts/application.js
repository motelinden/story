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
//= require owl.carousel.min
//= require jquery.validate
//= require jquery.validate.additional-methods
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