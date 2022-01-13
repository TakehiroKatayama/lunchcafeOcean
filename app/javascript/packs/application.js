require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');
require('jquery');
require('slick.js');

import 'src/application';
import 'bootstrap/dist/js/bootstrap';
import '@fortawesome/fontawesome-free/js/all';
import './fadein';
import toastr from 'toastr';
window.toastr = toastr;
