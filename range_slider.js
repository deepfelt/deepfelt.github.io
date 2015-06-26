
$(document ).ready(function(){
$('input[type="range"]').on('mouseup', function() {
  this.blur();
}).on('mousedown input', function() {
  styl.inject('input[type=range]:focus::-webkit-slider-thumb:after, input[type=range]:focus::-ms-thumb:after, input[type=range]:focus::-moz-range-thumb:after', {content: "'"+this.value+"'"}).apply();
});
});
