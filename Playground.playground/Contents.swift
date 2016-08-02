//: Playground - noun: a place where people can play

import Foundation

import Music

//NOTE
var note = Note.fSharp

//properties
note.name
note.accidental

//initalizers
Note(.major2, above: .e)
Note(.minor3, below: .a)
Note(4)
Note(.c, .sharp)

//methods
note.transposed(up: .major2)
note.transposed(down: .minor2)

//INTERVAL
var interval = Interval.perfect5

//properties
interval.quality
interval.value

//initalizers
Interval(between: .perfect4, and: .major3)
Interval(between: .c, and: .g)
Interval(.major, .sixth)

//methods
interval.inversion()
interval.transposed(up: .major3)
interval.transposed(down: .minor3)

//PITCH
var pitch: Pitch = 3

//initalizers
Pitch(.dDoubleFlat)

//methods
pitch.transpose(1)
pitch.invert()

//COLLECTIONS
var cMajorScale = [Note.c,.d,.e,.f,.g,.a,.b]
var intervalCollection = [Interval.perfect5,.major2,.minor2]
var pitchCollection = [0,1,3,5]

//note
var melody = [Note.c,.a,.f,.g]
melody.rotate(1)
//melody.transpose(1)
melody.transposed(up: .major3)
melody.transposed(down: .major3)

//interval
var majorScale = Scale.major
majorScale.mode(.II)
majorScale.rotate(1)
majorScale.notes(withRoot: .aFlat)


var majorTriad = Chord.Triad.major
var majorTriad1stInversion = majorTriad.inversion(.second)

majorTriad.transposed(up: .minor2)
majorTriad.transposed(up: .perfect5)
majorTriad1stInversion?.notes(withRoot: .c)


//pitch
var octatonic = Scale.Octatonic.halfStep
octatonic.transposed(1)
octatonic.invert()
octatonic.retrograde()
octatonic.rotate(1)
octatonic.notes()

Scale.Minor.harmonic.notes(withRoot: .c)









