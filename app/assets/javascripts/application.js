//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets
//= require_tree .


window.onload = function() {
    var filters = document.getElementsByClassName('filterable');
    if (filters) {
        window.bops.initFilters();
    };  
};
