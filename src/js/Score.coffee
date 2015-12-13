class Score extends createjs.Container
	constructor:->
		super()

		@text = new createjs.Text('0', '16px Arial', '#036')
		@text.set x:5,y:8
		@addChild @text

		# @high = new createjs.Text('Personal High Score!','16px Arial','#f00')
		# @high.set y:5
		# @addChild @high

		@init()

	init:=>
		@value = 0
		# @high.visible = false
		@update()

	update:=>
		@text.text = @value
		@value +=1

	stop:=>
		# @high.set x:10+@text.width, visible:true



module.exports = Score
