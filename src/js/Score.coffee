class Score extends createjs.Container
	constructor:->
		super()
		@text = new createjs.Text('0', '48px Arial Black', '#ff0')
		@text.shadow = new createjs.Shadow("#000", 1,1,2);
		@text.set x:12, y:6
		@addChild @text

		# @high = new createjs.Text('Personal High Score!','16px Arial','#f00')
		# @high.set y:5
		# @addChild @high

		@init()

	init:=>@setScore(0)

	setScore:(s)=>
		@value = s
		@text.text = @value

	addScore:=>
		@setScore(@value+1)
		createjs.Tween.get(@)
		.to x:10, alpha:0
		.to x:0, alpha:1, 300

	getScore:=>@value


module.exports = Score
