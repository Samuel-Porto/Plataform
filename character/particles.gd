extends Node2D

func startParticle(particle):
	particle = returnParticle(particle)
	particle.emitting = true
	if particle.one_shot:
		particle.restart()

func stopParticle(particle):
	particle = returnParticle(particle)
	particle.emitting = false

func returnParticle(particle: String):
	match particle:
		"running":
			return $running
		"landing":
			return $landing
