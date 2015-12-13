"use strict";
var gulp = require("gulp");
var $ = require("gulp-load-plugins")();
var runseq = require('run-sequence');
var del = require("del");
var webpack = require("webpack");
var webpackDevServer = require("webpack-dev-server");
var webpackConfig = require("./webpack.config.js");
var fs = require('fs');


/*
		██████  ███    ███
		██   ██ ████  ████
		██████  ██ ████ ██
		██   ██ ██  ██  ██
		██   ██ ██      ██
*/
gulp.task('rm',function(){
	return del('node_modules');
})




/*
███████  ██████  ███    ██ ████████ ███████
██      ██    ██ ████   ██    ██    ██
█████   ██    ██ ██ ██  ██    ██    ███████
██      ██    ██ ██  ██ ██    ██         ██
██       ██████  ██   ████    ██    ███████ */
gulp.task('fonts',function(){
	var text = fs.readFileSync('fonts/chars.txt',{encoding:'utf8'})
	// text = text.split('').reduce(function(a,b){
	// 	return (a.indexOf(b)!=-1?a:a+b)
	// },'')

	return gulp.src('fonts/*.ttf')
	.pipe($.fontmin({
		text:text,
		fontPath:'',
		hinting: false
	}))
	.pipe(gulp.dest('src/fonts'))
})



/*
		██████  ██    ██ ██ ██      ██████
		██   ██ ██    ██ ██ ██      ██   ██
		██████  ██    ██ ██ ██      ██   ██
		██   ██ ██    ██ ██ ██      ██   ██
		██████   ██████  ██ ███████ ██████
*/
// Production build
gulp.task("webpack-build", function(cb) {
	// modify some webpack config options
	var myConfig = Object.create(webpackConfig);
	myConfig.plugins = myConfig.plugins.concat(
		new webpack.DefinePlugin({
			"process.env": {
				// This has effect on the react lib size
				"NODE_ENV": JSON.stringify("production")
			}
		})
		, new webpack.optimize.DedupePlugin()
		, new webpack.optimize.UglifyJsPlugin({compress:{warnings:false}})
	);

	// run webpack
	webpack(myConfig, function(err, stats) {
		if(err) throw new $.util.PluginError("webpack-build", err);
		$.util.log("[webpack:build]", stats.toString({
			colors: true,
			chunkModules:false,
		}));
		cb();
	});
});
/*
		██████  ██ ███████ ███████
		██   ██ ██ ██      ██
		██   ██ ██ █████   █████
		██   ██ ██ ██      ██
		██████  ██ ██      ██
*/
gulp.task('diff',function(){
	return gulp.src('dist/**')
  	.pipe($.changed('dist_remote', {hasChanged: $.changed.compareSha1Digest}))
		.pipe(gulp.dest('dist_remote'))
		.pipe($.size({
			title: 'diff',
			showFiles:true,
		}))
})
/*
		██████
		██   ██
		██████
		██
		██
*/
gulp.task("p", function(cb){
	runseq('webpack-build','diff',cb)
});






/*
		██████  ███████ ██    ██
		██   ██ ██      ██    ██
		██   ██ █████   ██    ██
		██   ██ ██       ██  ██
		██████  ███████   ████
*/
//Dev Server
gulp.task("webpack-dev-server", function(cb) {
	// var host = '192.168.253.140'
	var host = 'localhost'
	var port = 3000

	var myConfig = Object.create(webpackConfig);
	myConfig.devtool = "cheap-module-eval-source-map";
	myConfig.debug = true;
	myConfig.entry.app.unshift('webpack-dev-server/client?http://'+host+':'+port);


	var serverConfig = Object.create(webpackConfig.devServer);
	// serverConfig.contentBase = myConfig.path;

	new webpackDevServer(webpack(myConfig), serverConfig)
	.listen(port, host, function(err) {
		if(err) throw new $.util.PluginError("webpack-dev-server", err);
		$.util.log("[webpack-dev-server]", 'http://'+host+':'+port+'/webpack-dev-server/');
		cb();
	});
});

/*
		██████  ███████ ███████  █████  ██    ██ ██   ████████
		██   ██ ██      ██      ██   ██ ██    ██ ██      ██
		██   ██ █████   █████   ███████ ██    ██ ██      ██
		██   ██ ██      ██      ██   ██ ██    ██ ██      ██
		██████  ███████ ██      ██   ██  ██████  ███████ ██
*/
gulp.task("default", ["webpack-dev-server"]);
