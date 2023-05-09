extends Node2D


func startParticle(particle):
	particle = returnParticle(particle)
	particle.emitting = true

func stopParticle(particle):
	particle = returnParticle(particle)
	particle.emitting = false

func returnParticle(particle: String):
	match particle:
		"running":
			return $running
		"landing":
			return $landing
