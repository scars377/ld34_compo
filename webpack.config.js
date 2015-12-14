var webpack = require("webpack");
var path = require('path');

module.exports = {
	plugins:[],

	context: path.resolve('src'), //absolute
	entry: {
		app: ['App.coffee'],
	},


	output: {
		path: path.resolve('dist'), //absolute
		filename: 'js/[name].js', //must NOT be an absolute path
	},


	devServer: {
		// historyApiFallback: true,
		stats: {
			colors: true,
			hash:         false, // add the hash of the compilation
			version:      false, // add webpack version information
			timings:      true, // add timing information
			assets:       true, // add assets information
			chunks:       false, // add chunk information
			chunkModules: false, // add built modules information to chunk information
			modules:      false, // add built modules information
			cached:       false, // add also information about cached (not built) modules
			reasons:      false, // add information about the reasons why modules are included
			source:       false, // add the source code of modules
			errorDetails: true, // add details to errors (like resolving log)
			chunkOrigins: false, // add the origins of chunks and chunk merging info
		},
	},



	resolve: {
		root: [
			path.resolve('src/js'),
			path.resolve('src/css'),
			path.resolve('src/html'),
			path.resolve('src'),
			path.resolve('node_modules'),
		],
		extensions:[
			'',
			'.js',
			'.coffee',
		]
	},
	resolveLoader: {
		root: path.resolve('node_modules')
	},


	module: {
		loaders: [
			//BASIC
			{
				test: /\.css$/,
				loader: 'style!css!autoprefixer?browsers=last 4 versions',
				// loader: 'style!css?modules!autoprefixer?browsers=last 4 versions',
				//使用 CSS Modules
				include: path.resolve('src')
			}, {
				test: /\.scss$/,
				loader: 'style!css!autoprefixer?browsers=last 4 versions!sass',
				// loader: 'style!css?modules!autoprefixer?browsers=last 4 versions!sass',
				//使用 CSS Modules
				include: path.resolve('src/css')
			}, {
				test: /\.html$/,
				loader: 'file?name=[name].html',
				//一般 html 一定在根目錄，例外另外處理
				include: path.resolve('src/html')
			},
			//EXTENDS
			{
				test: /\.coffee$/,
				loader: 'coffee',
				include: path.resolve('src/js')
			},{
				test: /\.jade$/,
				// loader: 'jade-html?pretty',
				loader: 'jade-html',
				include: path.resolve('src/html')
			},
			//ASSETS
			{
				test: /\.mp4$/,
				loader: 'file?name=[path][name].[ext]',
				include: path.resolve('src/video')
			}, {
				test: /\.(ttf|woff|eot|svg)$/,
				loader: 'file?name=[path][name].[ext]',
				include: path.resolve('src/fonts')
			}, {
				test: /\.json$/,
				loader: 'file?name=[path][name].[ext]',
				include: path.resolve('src/json')
			}, {
				test: /\.jpe?g$|\.gif$|\.png$|\.svg$/,
				loader: 'url?limit=10000&name=[path][name].[ext]',
				include: path.resolve('src/img')
			}
		],
		postLoaders:[
			{
				test: /\.jade$/,
				loader:'file?name=[name].html',
				include: path.resolve('src/html')
			}
		]
	}
};
