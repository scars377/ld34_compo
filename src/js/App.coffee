console.clear()

Wall = require 'Wall'
Bird = require 'Bird'
Shot = require 'Shot'
Score = require 'Score'
Bounds = require 'Bounds'
Fragment = require 'Fragment'
# Ranking = require 'Ranking'

require 'index.jade'
require 'App.scss'


class Game extends createjs.Stage
	paused: false
	constructor:->
		super 'canvas'

		createjs.Ticker.setFPS(60)
		createjs.Ticker.addEventListener('tick', @render)

		@bounds = new Bounds()
		@addChild @bounds

		@walls = new createjs.Container()
		@addChild @walls
		@addWall()

		@fragments = new createjs.Container()
		@addChild @fragments

		@bird = new Bird(@walls)
		@bird.addEventListener('hit', @stopGame)
		@bird.addEventListener('fall',@stopGame)
		@addChild @bird

		@shots = new createjs.Container()
		@addChild @shots

		@score = new Score()
		@addChild @score

		window.addEventListener('keydown',@keydown)

	render:=>
		@update()
		if @paused then return
		@bird.update()
		@score.update()
		@bounds.update()
		s?.update() for s in @shots.children
		w?.update() for w in @walls.children
		f?.update() for f in @fragments.children

	restart:=>
		@stopGame()
		@paused = false
		@bird.init()
		@score.init()
		@walls.removeAllChildren()
		@shots.removeAllChildren()
		@fragments.removeAllChildren()
		@addWall()

	keydown:(e)=>
		switch e.keyCode
			when 87 #W
				return if @paused
				@bird.flap()

			when 69 #E
				return if @paused
				shot = new Shot(@bird.getHeadPos(),@walls)
				@shots.addChild shot

			when 82 #R
				@restart()


	addFragments:(e)=>
		for i in [0..5]
			f = new Fragment(e.target)
			@fragments.addChild(f)

	addWall:=>
		wall = new Wall()
		wall.addEventListener('hole',@addFragments)
		@walls.addChild wall
		@addWallTimer = setTimeout(@addWall,1000*(Math.random()*1+1))


	stopGame:=>
		@paused = true
		@score.stop()
		ga('send','event',{
			eventCategory: 'Game'
			eventAction: 'Score'
			eventValue: @score.value
		})
		clearTimeout @addWallTimer


game = new Game()
# ranking = new Ranking()


setImmediate ->
	document.getElementsByTagName('a')[0].focus()
	document.getElementsByTagName('a')[0].blur()
