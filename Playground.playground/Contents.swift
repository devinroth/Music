//: Playground - noun: a place where people can play

import Foundation

import Music

//NOTE
var note = Note.Fs


//properties
note.name
note.accidental

//initalizers
Note(.maj2, above: .E)
Note(.min3, below: .A)
Note(4)
Note(.C, .b) // Seems pretty useless

//methods
note.transposed(up: .maj2)
note.transposed(down: .min2)

//INTERVAL
var interval = Interval.per5

//properties
interval.quality
interval.value

//initalizers
Interval(between: .per4, and: .maj3)
Interval(between: .C, and: .G)
Interval(.maj, .sixth) // Also useless

//methods
interval.inverted()
interval.transposed(up: .maj3)
interval.transposed(down: .min3)

//PITCH
var pitch: Pitch = 3

//initalizers
Pitch(.Dbb)

//methods
pitch.transposed(1)
pitch.inverted()

//COLLECTIONS
var cMajorScale         : [Note]        = [.C,.D,.E,.F,.G,.A,.B]
var intervalCollection  : [Interval]    = [.per5,.maj2,.min2]
var pitchCollection     : [Pitch]       = [0,1,3,5]

//note
var melody = [Note.C,.A,.F,.G]
melody.rotated(1)
melody.transposed(up: .maj3)
melody.transposed(down: .maj3)

//interval
var majorScale = Scale.Major
majorScale.mode(.II)
majorScale.rotated(1)
majorScale.notes(root: .Ab)


var majorTriad = Chord.Triad.Major
var majorTriad1stInversion = majorTriad.inversion(.second)

majorTriad.transposed(up: .min2)
majorTriad.transposed(up: .per5)
majorTriad1stInversion?.notes(root: .C)


//pitch
var octatonic = Scale.Octatonic.HalfStep
octatonic.transposed(1)
octatonic.inverted()
octatonic.retrograded()
octatonic.rotated(1)
octatonic.notes()

Scale.Minor.Harmonic.notes(root: .C)

//Collections
Scale.Blues
Scale.Minor.Melodic.notes(root: .C)
Chord.Triad.Major.inversion(.first)?.notes(root: .C)
Chord.Triad.Major.notes(root: .A)


