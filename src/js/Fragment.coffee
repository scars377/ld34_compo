Global = require 'Global'
GRAVITY = .1

class Fragment extends createjs.Container
	constructor:(wall)->
		super()
		bmp = wall.barBmp.clone()
		bmp.set x:-bmp.width*.5, y:-bmp.height*.5
		@addChild bmp

		@set scaleY:.5, alpha:.75

		@x = wall.x
		@y = wall.holePos + (Math.random()*2-1)*Global.holeRadius

		v = 5
		phi = Math.random()*Math.PI*2

		@vx = v*Math.cos(phi) - Global.speed
		@vy = v*Math.sin(phi)

		@rotation = Math.random()*360
		@r = (Math.random()-.5)*10

	update:=>
		@x += @vx
		@y += @vy
		@vy += GRAVITY
		@rotation += @r

		if @x<0 or @x>Global.width or @y<0 or @y>Global.height
			@parent.removeChild @



module.exports = Fragment
