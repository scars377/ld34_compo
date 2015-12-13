SPEED = 6
UP_SPEED = 4
GRAVITY = .098

imgs = for i in [1..6]
	require "img/fruit#{i}.png"

Global = require 'Global'

class Shot extends createjs.Bitmap
	constructor:(pos, @walls)->
		img = imgs[parseInt(Math.random()*imgs.length,10)]
		super img
		@set x:pos.x, y:pos.y, v:-UP_SPEED, rotation:Math.random(), vr:Math.random()*10-5


	update:()=>
		@x += SPEED
		@y += @v
		@v += GRAVITY
		@rotation += @vr

		if @y<0
			@y = 0
			@v = 0

		for w in @walls.children
			if w.hitTest(@x-w.x,@y)
				w.setHole(@y) if not w.hasHole
				@remove()

		if @y>Global.height or @x>Global.width
			@remove()

	remove:=>
		@parent?.removeChild this


module.exports = Shot
