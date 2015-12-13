THICKNESS = 24


Global = require 'Global'
HOLE_RADIUS = Global.holeRadius
BAR_WIDTH  = Global.barWidth
BAR_HEIGHT = Global.barHeight


# imgs = for i in [1..3]
# 	img = require "img/bar#{i}.png"
# 	bmp = new createjs.Bitmap(img)
imgs = [
	new createjs.Bitmap(require "img/bar1.png")
	new createjs.Bitmap(require "img/bar2.png")
]

breakBmp = new createjs.Bitmap(require 'img/break.png')

class Wall extends createjs.Container
	hasHole: false
	constructor:->
		super()

		@barBmp = imgs[parseInt(Math.random()*imgs.length,10)]
		bar = new createjs.Container()
		@addChild bar

		@barMask = new createjs.Shape()
		@barMask.graphics.f('#000').dr(0,0,BAR_WIDTH,Global.height)

		bar.mask = @barMask


		for i in [0..Global.height/BAR_HEIGHT]
			bmp = @barBmp.clone()
			bmp.y = i*BAR_HEIGHT
			bar.addChild bmp

		@x = Global.width + BAR_WIDTH

	setHole:(y)=>
		@hasHole = true
		@holePos = y

		holeTop =    Math.max(y-HOLE_RADIUS, 0)
		holeBottom = Math.min(y+HOLE_RADIUS, Global.height)

		@barMask.graphics.clear().f('#000')
		.dr(0, 0, BAR_WIDTH, holeTop)
		.dr(0, holeBottom, BAR_WIDTH, Global.height - holeBottom)

		b1 = breakBmp.clone()
		b1.set y:-HOLE_RADIUS-1
		b2 = breakBmp.clone()
		b2.set y: HOLE_RADIUS+1, scaleY:-1
		breaks = new createjs.Container()
		breaks.y = y
		breaks.addChild(b1,b2)
		@addChild breaks

		@dispatchEvent('hole')




	update:=>
		@x -= Global.speed
		if @x<-BAR_WIDTH
			@parent.removeChild @



module.exports = Wall
