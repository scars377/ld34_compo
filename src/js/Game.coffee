Wall = require 'Wall'
Bird = require 'Bird'
Shot = require 'Shot'
Score = require 'Score'
Bounds = require 'Bounds'
Fragment = require 'Fragment'
Sound = require 'Sound'


class Game extends createjs.Container
	paused: false
	constructor:->
		super()

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
		Sound.startBGM()

	render:=>
		@stage?.update()
		if @paused then return
		@bird.update()
		@score.update()
		@bounds.update()
		s?.update() for s in @shots.children
		w?.update() for w in @walls.children
		f?.update() for f in @fragments.children

	restart:=>
		Sound.clear()
		@stopGame()
		@paused = false
		@bird.init()
		@score.init()
		@walls.removeAllChildren()
		@shots.removeAllChildren()
		@fragments.removeAllChildren()
		@addWall()
		Sound.startBGM()

	keydown:(e)=>
		switch e.keyCode
			when 87 #W
				return if @paused
				@bird.flap()
				Sound.play 'jump'

			when 69 #E
				return if @paused
				shot = new Shot(@bird.getHeadPos(),@walls)
				@shots.addChild shot
				Sound.play 'shot'

			when 82 #R
				@restart()


	addFragments:(e)=>
		Sound.play 'break'
		for i in [0..5]
			f = new Fragment(e.target)
			@fragments.addChild(f)

	addWall:=>
		wall = new Wall()
		wall.addEventListener('hole',@addFragments)
		@walls.addChild wall
		@addWallTimer = setTimeout(@addWall,1000*(Math.random()*1+1))


	stopGame:(e)=>
		Sound.play 'dead' if e?
		@paused = true
		@score.stop()
		score = @score.value
		ga('send','event',{
			eventCategory: 'Game'
			eventAction: 'Score'
			eventValue: score
		})

		clearTimeout @addWallTimer

module.exports = Game
