// Dependencies
const gulp = require('gulp');
const sass = require('gulp-sass');
const autoprefixer = require('gulp-autoprefixer');
const sourcemaps = require('gulp-sourcemaps');
const concat = require('gulp-concat');
const plumber = require('gulp-plumber');
const rename = require('gulp-rename');
const terser = require('gulp-terser');
const images = require('gulp-imagemin');
const browserSync = require('browser-sync').create();

// Source Paths
const styleSrc = 'src/sass/**/*.scss';
const scriptSrc = [
  'node_modules/jquery/dist/jquery.min.js',
  'node_modules/popper.js/dist/umd/popper.min.js',
  'node_modules/bootstrap/dist/js/bootstrap.min.js',
  'node_modules/moment/min/moment.min.js',
  'src/js/*.js'
];
const imagesSrc = 'src/img/*';
const htmlSrc = 'src/*.html';
const cfmSrc = 'src/*.cfm';
const cfcsSrc = 'src/cfcs/*.cfc';
const rootCfcsSrc = 'src/*.cfc';

// Distribution paths
const baseDist = './dist';
const styleDist = 'dist/assets/css';
const scritpDist = 'dist/assets/js';
const imagesDist = 'dist/assets/img';
const htmlDist = 'dist';
const cfmDist = 'dist';
const cfcsDist = 'dist/cfcs';
const rootCfcsDist = 'dist';

// Compiles all SASS files
gulp.task('sass', function() {
  gulp.src(styleSrc)
    .pipe(sourcemaps.init())
    .pipe(sass().on('error', sass.logError))
    .pipe(sourcemaps.write())
    .pipe(plumber())
    .pipe(sass({
      // Nested for Development
      //outputStyle: 'nested'
      // Compressed for Dist
      outputStyle: 'compressed'
    }))
    .pipe(rename({
      basename: 'app',
      suffix: '.min'
    }))
    .pipe(autoprefixer({
      browsers: ['last 2 versions'],
      cascade: false
    }))
    .pipe(gulp.dest(styleDist));
});

// Concat and Compress JS files
gulp.task('scripts', function() {
  gulp.src(scriptSrc)
    .pipe(plumber())
    .pipe(concat('app.min.js'))
    .pipe(terser())
    .pipe(gulp.dest(scritpDist));
});

// Copy and Optimize Images to Dist
gulp.task('images', function() {
  gulp.src(imagesSrc)
    .pipe(images())
    .pipe(gulp.dest(imagesDist));
});

// Copy All HTML files
gulp.task('html', function(){
  gulp.src(htmlSrc)
    .pipe(gulp.dest(htmlDist))
});

// Copy All CFM files
gulp.task('cfm', function(){
  gulp.src(cfmSrc)
    .pipe(gulp.dest(cfmDist))
});

// Copy All Root CFC files
gulp.task('rootCfcs', function(){
  gulp.src(rootCfcsSrc)
    .pipe(gulp.dest(rootCfcsDist))
});

// Copy All CFC Folder files
gulp.task('cfcs', function(){
  gulp.src(cfcsSrc)
    .pipe(gulp.dest(cfcsDist))
});

// Watch for changes
gulp.task('watch', function(){
  // Serve files from the root of this project
  browserSync.init({
    proxy: 'localhost:50024/dist',
    notify: false
  });
  gulp.watch(styleSrc,['sass']);
  gulp.watch(scriptSrc,['scripts']);
  gulp.watch(htmlSrc, ['html']);
  gulp.watch(cfmSrc, ['cfm']);
  gulp.watch(cfcsSrc, ['cfcs']);
  gulp.watch(rootCfcsSrc, ['rootCfcs']);
  gulp.watch(
    [htmlDist+'/*html', cfmDist+'/*cfm', rootCfcsDist+'/*cfc', cfcsDist+'/*cfc', styleDist+'/*.css', scritpDist+'/*.js']
  ).on('change', browserSync.reload);
});

// Use default task to launch Browsersync and watch files
gulp.task('default', ['sass', 'scripts', 'images', 'html', 'cfm', 'rootCfcs', 'cfcs' ,'watch'], function () {});