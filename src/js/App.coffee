console.clear()

require 'index.jade'
require 'App.scss'

Game = require 'Game'
Global = require 'Global'

stage = new createjs.Stage 'canvas'

loadComplete=(e)->
	game = new Game()
	stage.removeChild progress
	stage.addChild game

loadProgress=(e)->
	progress.text = (e.progress*100).toFixed(0)+'%'
	stage.update()

progress = new createjs.Text('asdf','14px Consolas','#666')
progress.set x:Global.width/2, y:Global.height/2, textAlign:'center', textBaseline:'bottom'
stage.addChild progress


queue = new createjs.LoadQueue()
queue.addEventListener('complete', loadComplete)
queue.addEventListener('progress', loadProgress)
queue.installPlugin(createjs.Sound)
queue.loadManifest([
	{id:'break',src: require('snd/break.mp3')}
	{id:'dead', src: require('snd/dead.mp3')}
	{id:'jump', src: require('snd/jump.mp3')}
	{id:'shot', src: require('snd/shot.mp3')}
	{id:'m1',   src: require('snd/m1.mp3')}
	{id:'m2',   src: require('snd/m2.mp3')}
])







setImmediate ->
	document.getElementsByTagName('a')[0].focus()
	document.getElementsByTagName('a')[0].blur()
