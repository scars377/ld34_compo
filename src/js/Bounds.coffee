Global = require 'Global'


gcd = (a,b)->
	if b is 0
		a
	else if a<b
		gcd(a,b%a)
	else
		gcd(b,a%b)

lcm = (a,b)->
	a*b/gcd(a,b)

class Bounds extends createjs.Shape
	constructor:->
		super()
		w = Global.width
		h = Global.height
		@graphics.ss(2).s('#999').mt(0,0).lt(w,0).mt(0,h).lt(w,h)
		@graphics.es()

		[sawWidth, sawHeight, spacing] = [5,5,2]
		unitWidth = sawWidth+spacing
		@extraWidth = lcm(unitWidth,Global.speed)
		numSaws = (Global.width + @extraWidth)/unitWidth
		for i in [0..numSaws-1]
			x = i*(sawWidth+spacing)
			@graphics
				.f('#999')
				.mt x,0
				.lt x,sawHeight
				.lt x+sawWidth,0
				.mt x,h
				.lt x,h-sawHeight
				.lt x+sawWidth,h
				.ef()

	update:=>
		@x -= Global.speed
		@x = 0 if @x <= -@extraWidth

module.exports = Bounds
