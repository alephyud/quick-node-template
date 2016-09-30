gulp = require 'gulp'
browserify = require 'browserify'
stylus = require 'gulp-stylus'
source = require 'vinyl-source-stream'
sourcemaps = require 'gulp-sourcemaps'
concatCss = require 'gulp-concat-css'
gutil = require 'gulp-util'

gulp.task 'css', ->
  gulp.src 'src/styles/*.styl'
    .pipe stylus()
    .pipe concatCss 'styles.css'
    .pipe gulp.dest 'public/css'
  .on 'error', (err) -> console.log err.toString(); @emit 'end'


gulp.task 'js', ->
  browserify
    entries: ['./src/client/app.coffee']
    extensions: ['.coffee', '.js']
  .transform 'coffeeify'
  .transform 'debowerify'
  # .transform 'uglifyify'
  .bundle()
  .on 'error', (err) -> console.log err.toString(); @emit 'end'
  .pipe source 'scripts.js'
  .pipe gulp.dest 'public/js'

gulp.task 'watch', ->
  gulp.watch 'src/styles/*.styl', ['css']
  gulp.watch 'src/client/*.coffee', ['js']

gulp.task 'default', ['css', 'js']
