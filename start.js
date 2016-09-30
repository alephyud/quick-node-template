'use strict';
require('coffee-script/register');

var path = require('path');
global.APP_DIR = path.dirname(process.mainModule.filename) + '/';

require (global.APP_DIR + 'src/server/server');