Global = require 'Global'


class CloudSlice extends createjs.Shape
	constructor:(color)->
		super()
		@graphics.f(color)
		x = 0
		loop
			w = 100 + Math.random()*100
			h = 75 + Math.random()*75
			@graphics.de(x,-h/2,w,h)
			x += w*.6
			break if x>Global.width+100
		@size = x


class Cloud extends createjs.Container
	constructor:(color,pos,@depth)->
		super()
		@y = pos

		bg = new createjs.Shape()
		bg.graphics.f(color).dr(0,0,Global.width,Global.height - pos)

		@s1 = new CloudSlice(color)
		@s2 = new CloudSlice(color)
		@s2.x = @s1.size

		@addChild bg,@s1,@s2

	update:=>
		@s1.x -= @depth*1
		@s2.x -= @depth*1
		if @s1.x < -@s1.size then @s1.x = @s2.x + @s2.size
		if @s2.x < -@s2.size then @s2.x = @s1.x + @s1.size


class Background extends createjs.Container
	constructor:->
		super()
		@bg = new createjs.Shape()
		@bg.graphics.lf(['#59cfe0','#d1f1f6'],[0,1],0,0,0,Global.height).dr(0,0,Global.width,Global.height)
		@addChild @bg

		@clouds = for c,i in ['#fff','#dff','#bff']
			@addChild new Cloud(c, 300+i*90, i+1)

	update:=>
		c.update() for c in @clouds



module.exports = Background
