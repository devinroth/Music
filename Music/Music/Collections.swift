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
    public static let Major           : [Interval]     = [.per1,.maj2,.maj3,.per4,.per5,.maj6,.maj7]
    public static let Blues           : [Interval]     = [.per1,.min3,.per4,.aug4,.per5,.min7]
    public static let Chromatic       : [Pitch]        = [0,1,2,3,4,5,6,7,8,9,10,11]
    public static let WholeTone       : [Pitch]        = [0,2,4,6,8,10]
    
    public struct Minor {
        public static let Natural     : [Interval]     = [.per1,.maj2,.min3,.per4,.per5,.min6,.min7]
        public static let Harmonic    : [Interval]     = [.per1,.maj2,.min3,.per4,.per5,.maj6,.maj7]
        public static let Melodic     : [Interval]     = [.per1,.maj2,.min3,.per4,.per5,.min6,.maj7]
    }
    public struct Pentatonic {
        public static let Major      : [Interval]     = [.per1,.maj2,.maj3,.per5,.maj6]
        public static let Minor      : [Interval]     = [.per1,.min3,.per4,.per5,.min7]
    }
    public struct Octatonic {
        public static let HalfStep    : [Pitch]       = [0,1,3,4,6,7,9,10]
        public static let WholeStep   : [Pitch]       = [0,2,3,5,6,8,9,11]
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
        public static let Ionian      : [Interval]     = Scale.Major.mode(.I)!
        public static let Dorian      : [Interval]     = Scale.Major.mode(.II)!
        public static let Phrygian    : [Interval]     = Scale.Major.mode(.III)!
        public static let Lydian      : [Interval]     = Scale.Major.mode(.IV)!
        public static let Mixolydian  : [Interval]     = Scale.Major.mode(.V)!
        public static let Aeolian     : [Interval]     = Scale.Major.mode(.VI)!
        public static let Locrian     : [Interval]     = Scale.Major.mode(.VII)!
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
        public static let Augmented     : [Interval]    = [.per1,.maj3,.aug5]
        public static let Major         : [Interval]    = [.per1,.maj3,.per5]
        public static let Minor         : [Interval]    = [.per1,.min3,.per5]
        public static let Diminished    : [Interval]    = [.per1,.min3,.dim5]
    }
    //standard seventh chords
    public struct Seventh {
        public static let AugmentedMajor        : [Interval]    = [.per1,.maj3,.aug5,.maj7]
        public static let MajorMajor            : [Interval]    = [.per1,.maj3,.per5,.maj7]
        public static let MajorMinor            : [Interval]    = [.per1,.maj3,.per5,.min7]
        public static let MinorMajor            : [Interval]    = [.per1,.min3,.per5,.maj7]
        public static let MinorMinor            : [Interval]    = [.per1,.min3,.per5,.min7]
        public static let DiminishedMajor       : [Interval]    = [.per1,.min3,.dim5,.maj7]
        public static let DiminishedMinor       : [Interval]    = [.per1,.min3,.dim5,.min7]
        public static let DiminishedDiminished  : [Interval]    = [.per1,.min3,.dim5,.dim7]
    }
    //common names
    var aug     = Chord.Triad.Augmented
    var maj     = Chord.Triad.Major
    var min     = Chord.Triad.Minor
    var dim     = Chord.Triad.Diminished
    
    var maj7    = Chord.Seventh.MajorMajor
    var v7      = Chord.Seventh.MajorMinor
    var min7    = Chord.Seventh.MinorMinor
    var min7b5  = Chord.Seventh.DiminishedMinor
    var dim7    = Chord.Seventh.DiminishedDiminished
}
