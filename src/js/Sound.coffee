class Sound
	muted: localStorage['muted'] is 'true'
	sounds:{}
	volumes:{
		break:1
		dead: 1
		jump:.3
		shot:.4
		m1:   1
		m2:   1
	}
	constructor:->

	play:(id)=>
		switch id
			when 'break'
				@sounds.shot?.stop()

			when 'dead'
				@clear()

		if @sounds[id]?
			@sounds[id].stop()
			@sounds[id].play()
		else
			# @sounds[id] = createjs.Sound.play(id)
			@sounds[id] = createjs.Sound.play(id,volume:@volumes[id])

	clear:=>
		s.stop() for id,s of @sounds

	startBGM:=>
		m = if Math.random()<.5 then 'm1' else 'm2'
		@sounds.bgm = createjs.Sound.play(m,loop:-1,volume:@volumes[m])

	toggleMute:=>
		@muted = !@muted
		createjs.Sound.muted = @muted
		localStorage['muted'] = @muted and 'true' or 'false'


module.exports = new Sound()

###
bgm:
http://www.beepbox.co/#5s3kbl01e00t8a7g0fj7i0r0w1111f2000d1111c0000h0000v0001o3210b4x4h4h4h4h4i4h4h4h4h4h8h4h4h4h4h4x4h4h4h4h4p21YFxQ6McA2QcB00G3aior0W1TyI3qeQlEgaoZ3BxR2j33P0godEWxRyOhpo0aoW15cexoAixgr1poq1oybc5y00aoD0H1iC1Ck2E5eo6Ha1F1jAxEOgkwFOIH8OIw0
###
