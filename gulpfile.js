// Dependencies
const gulp = require('gulp');
const sass = require('gulp-sass');
//const autoprefixer = require('gulp-autoprefixer');
const sourcemaps = require('gulp-sourcemaps');
const concat = require('gulp-concat');
const plumber = require('gulp-plumber');
const rename = require('gulp-rename');
const terser = require('gulp-terser');
const images = require('gulp-imagemin');
const browserSync = require("browser-sync").create();

// Source Paths
const styleSrc = 'src/sass/**/*.scss';
const scriptSrc = [
	'node_modules/jquery/dist/jquery.min.js',
	//'node_modules/popper.js/dist/umd/popper.min.js',
	//'node_modules/bootstrap/dist/js/bootstrap.min.js',
	'node_modules/moment/min/moment.min.js',
	'src/js/*.js'
];
const imagesSrc = 'src/img/*';
const htmlSrc = 'src/*.html';
const cfmSrc = 'src/*.cfm';
const cfcsSrc = 'src/cfcs/*.cfc';
const rootCfcsSrc = 'src/*.cfc';

// Distribution paths
const baseDist = 'dist';
const styleDist = baseDist + '/assets/css';
const scritpDist = baseDist + '/assets/js';
const imagesDist = baseDist + '/assets/img';
const cfcsDist = baseDist + '/cfcs';

// Compiles all SASS files
function css() {
	return gulp
		.src(styleSrc)
		.pipe(sourcemaps.init())
		.pipe(sass().on('error', sass.logError))
		.pipe(sourcemaps.write())
		.pipe(plumber())
		.pipe(sass({
			outputStyle: 'compressed'
		}))
		.pipe(rename({
			basename: 'app',
			suffix: '.min'
		}))
		// .pipe(autoprefixer({
		// 	browsers: ['last 2 versions'],
		// 	cascade: false
		// }))
		.pipe(gulp.dest(styleDist))
		.pipe(browserSync.stream());
}

// Concat and Compress JS files
function scripts() {
	return gulp
		.src(scriptSrc)
		.pipe(plumber())
		.pipe(concat('app.min.js'))
		.pipe(terser())
		.pipe(gulp.dest(scritpDist))
		.pipe(browserSync.stream());
}

// Copy and Optimize Images to Dist
function imgOpt() {
	return gulp
		.src(imagesSrc)
		.pipe(images())
		.pipe(gulp.dest(imagesDist));
}

// Copy All HTML files
function html() {
	return gulp
		.src(htmlSrc)
		.pipe(gulp.dest(baseDist))
}

// Copy All CFM files
function cfm() {
	return gulp
		.src(cfmSrc)
		.pipe(gulp.dest(baseDist))
}

// Copy All Root CFC files
function rootCfcs() {
	return gulp
		.src(rootCfcsSrc)
		.pipe(gulp.dest(baseDist))
}

// Copy All CFC Folder files
function cfcs() {
	return gulp
		.src(cfcsSrc)
		.pipe(gulp.dest(cfcsDist))
}

// Watch for changes
function watch() {
	browserSync.init({
		proxy: '127.0.0.1:3000/' + baseDist + '/',
		port: 50024,
		notify: false
	});
	gulp.watch(htmlSrc, html).on('change', browserSync.reload);
	gulp.watch(cfmSrc, cfm).on('change', browserSync.reload);
	gulp.watch(rootCfcsSrc, rootCfcs).on('change', browserSync.reload);
	gulp.watch(cfcsSrc, cfcs).on('change', browserSync.reload);
	gulp.watch(styleSrc, css);
	gulp.watch(scriptSrc, scripts);
}

// define complex tasks
const build = gulp.series(gulp.parallel(css, scripts, imgOpt, html, cfm, rootCfcs, cfcs));

// export tasks
exports.css = css;
exports.scripts = scripts;
exports.imgOpt = imgOpt;
exports.html = html;
exports.cfm = cfm;
exports.rootCfcs = rootCfcs;
exports.build = build;
exports.watch = watch;
exports.default = build;