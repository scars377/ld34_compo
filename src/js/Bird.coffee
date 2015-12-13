UP_SPEED = 8
GRAVITY = .2
RADIUS = 20
HITTEST_RADIUS = 18

imgDown = require 'img/bird_down.png'
imgUp   = require 'img/bird_up.png'

Global = require 'Global'

class Bird extends createjs.Container
	v:0
	constructor:(@walls)->
		super()
		ss = new createjs.SpriteSheet({
			images: [imgDown,imgUp]
			frames: [
				[0,0,60,60,1]
				[0,0,60,60,0]
			]
			animations:{
				normal: 0
				flap: [0,1,'flapEnd',.3]
				flapEnd: [1,1,'normal',.02]
			}
		})
		@sprite = new createjs.Sprite(ss)
		@sprite.set x:-30,y:-35
		@sprite.gotoAndStop 'normal'
		@addChild @sprite


		@hitTestPoints = [
			[ #common
				[59, 28]
				[30,20]
				[0,28]
				[30,50]
				[45,20]
				[16,25]
				[10,46]
				[47,42]
			]
			[ #wing-up
				[12,55]
				[33,7]
				[13,0]
			]
			[ #wing-down
				[53,41]
				[41,50]
				[48,45]
				[5,53]
			]
		]

		@pp = new createjs.Shape()
		@pp.set x:-30,y:-35
		# @addChild @pp
		@addEventListener('added',@init)

	flap:=>
		@sprite.gotoAndPlay 'flap'
		@v = -UP_SPEED
		@rotation = -30

	init:=>
		@set x:100, y:100, v: 0, rotation:0

	getHeadPos:=>
		p = @hitTestPoints[0][0]
		@sprite.localToGlobal(p[0],p[1])

	update:()=>
		@y += @v
		@v += GRAVITY
		@rotation += 1

		q

		# @pp.graphics.clear()
		for p in @hitTestPoints[@sprite.currentFrame+1]
			q = @sprite.localToGlobal(p[0],p[1])
			# @pp.graphics.f('#f00').dc(p[0],p[1],2).ef()
			if @walls.hitTest q.x,q.y
				@sprite.gotoAndStop 'normal'
				@dispatchEvent 'hit'
				return

		for p in @hitTestPoints[0]
			q = @sprite.localToGlobal(p[0],p[1])
			# @pp.graphics.f('#f00').dc(p[0],p[1],2).ef()
			if @walls.hitTest q.x,q.y
				@sprite.gotoAndStop 'normal'
				@dispatchEvent 'hit'
				return

		if @y > Global.height-RADIUS or @y<RADIUS
			@dispatchEvent 'fall'

module.exports = Bird
