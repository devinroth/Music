//
//  Collections.swift
//  Music
//
//  Created by Devin Roth on 7/23/16.
//  Copyright © 2016 Devin Roth Music. All rights reserved.
//

import Foundation

//Collections

//Standard Scales
public struct Scale {
    public static let major           : [Interval]     = [.perfect1,.major2,.major3,.perfect4,.perfect5,.major6,.major7]
    public static let blues           : [Interval]     = [.perfect1,.minor3,.perfect4,.augmented4,.perfect5,.minor7]
    public static let chromatic       : [Pitch]        = [0,1,2,3,4,5,6,7,8,9,10,11]
    public static let wholeTone       : [Pitch]        = [0,2,4,6,8,10]
    
    public struct Minor {
        public static let natural     : [Interval]     = [.perfect1,.major2, .minor3,.perfect4,.perfect5,.minor6,.minor7]
        public static let harmonic    : [Interval]     = [.perfect1,.major2,.minor3,.perfect4,.perfect5,.major6,.major7]
        public static let melodic     : [Interval]     = [.perfect1,.major2,.minor3,.perfect4,.perfect5,.minor6,.major7]
    }
    public struct Pentatonic {
        public static let major       : [Interval]     = [.perfect1,.major2,.major3,.perfect5,.major6]
        public static let minor       : [Interval]     = [.perfect1,.minor3,.perfect4,.perfect5,.minor7]
    }
    public struct Octatonic {
        public static let halfStep    : [Pitch]       = [0,1,3,4,6,7,9,10]
        public static let wholeStep   : [Pitch]       = [0,2,3,5,6,8,9,11]
    }
}

//scale degree names
public enum Degree: Int {
    case I
    case II
    case III
    case IV
    case V
    case VI
    case VII
    case VIII
    case IX
    case X
    case XI
    case XII
}

//Standard Modes
public struct Mode {
    public struct Major {
        public static let ionian      : [Interval]     = Scale.major.mode(.I)!
        public static let dorian      : [Interval]     = Scale.major.mode(.II)!
        public static let phrygian    : [Interval]     = Scale.major.mode(.III)!
        public static let lydian      : [Interval]     = Scale.major.mode(.IV)!
        public static let mixolydian  : [Interval]     = Scale.major.mode(.V)!
        public static let aeolian     : [Interval]     = Scale.major.mode(.VI)!
        public static let locrian     : [Interval]     = Scale.major.mode(.VII)!
    }
}


//chord inversions names
public enum Inversion: Int {
    case root
    case first
    case second
    case third
}

//standard chords
public struct Chord {
    //standard triads
    public struct Triad {
        public static let augmented   : [Interval]    = [.perfect1,.major3,.augmented5]
        public static let major       : [Interval]    = [.perfect1,.major3,.perfect5]
        public static let minor       : [Interval]    = [.perfect1,.minor3,.perfect5]
        public static let diminished  : [Interval]    = [.perfect1,.minor3,.diminished5]
    }
    //standard seventh chords
    public struct Seventh {
        public static let augmentedMajor          : [Interval]    = [.perfect1,.major3,.augmented5,.major7]
        public static let majorMajor              : [Interval]    = [.perfect1,.major3,.perfect5,.major7]
        public static let majorMinor              : [Interval]    = [.perfect1,.major3,.perfect5,.minor7]
        public static let minorMajor              : [Interval]    = [.perfect1,.minor3,.perfect5,.major7]
        public static let minorMinor              : [Interval]    = [.perfect1,.minor3,.perfect5,.minor7]
        public static let diminishedMajor         : [Interval]    = [.perfect1,.minor3,.diminished5,.major7]
        public static let diminishedMinor         : [Interval]    = [.perfect1,.minor3,.diminished5,.minor7]
        public static let diminishedDiminished    : [Interval]    = [.perfect1,.minor3,.diminished5,.diminished7]
    }
    //common names
    var aug     = Chord.Triad.augmented
    var maj     = Chord.Triad.major
    var min     = Chord.Triad.minor
    var dim     = Chord.Triad.diminished
    var maj7    = Chord.Seventh.majorMajor
    var v7      = Chord.Seventh.majorMinor
    var min7    = Chord.Seventh.minorMinor
    var min7b5  = Chord.Seventh.diminishedMinor
    var dim7    = Chord.Seventh.diminishedDiminished
}
