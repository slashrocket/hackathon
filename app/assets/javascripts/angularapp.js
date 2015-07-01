//= require jquery
//= require jquery_ujs
//= require angular
//= require angular-ui-router
//= require angular-bootstrap
//= require bootstrap-switch/dist/js/bootstrap-switch.min.js
//= require angular-bootstrap-switch
//= require angular-svg-round-progressbar
//= require angular-resource
//= require angular-cookies
//= require angular-smart-table
//= require angular-rails-templates
//= require_tree ./ng-app
//= require_tree ../templates

$(document).on('ready', function() {
  return $('[ng-app]').each(function() {
    var module;
    module = $(this).attr('ng-app');
    return angular.bootstrap(this, [module]);
  });
});