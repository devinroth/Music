//
//  Note.swift
//  
//
//  Created by Devin Roth on 7/18/16.
//
//

import Foundation

public protocol NoteProtocol {
}

//Fundamental Notes
public enum Note: Int, NoteProtocol {
    case Fbb        //Double Flats
    case Cbb
    case Gbb
    case Dbb
    case Abb
    case Ebb
    case Bbb
    case Fb         //Flats
    case Cb
    case Gb
    case Db
    case Ab
    case Eb
    case Bb
    case F          //Naturals
    case C
    case G
    case D          //Reflextion Point
    case A
    case E
    case B
    case Fs         //Sharps
    case Cs
    case Gs
    case Ds
    case As
    case Es
    case Bs
    case Fx         //Double Sharp
    case Cx
    case Gx
    case Dx
    case Ax
    case Ex
    case Bx
}
//Note Names
extension Note {
    public enum Name: Int {
        case F
        case C
        case G
        case D
        case A
        case E
        case B
    }
    public var name: Name {
        get {
            return Name(rawValue: self.rawValue % 7)!
        }
    }
}
//Accidentals
extension Note {
    public enum Accidental: Int {
        case bb     //Double Flat
        case b      //Flat
        case n      //Natural
        case s      //Sharp
        case x      //Double Sharp
    }
    
    public var accidental: Accidental {
        get {
            return Accidental(rawValue: self.rawValue / 7 )!
        }
    }
}

//Initializers
extension Note {
    public init(_ name: Name, _ accidental: Accidental){
        self = Note(rawValue: name.rawValue + accidental.rawValue*7)!
    }
    public init?(_ interval: Interval, above note: Note) {
        if let note = Note(rawValue: note.rawValue + interval.rawValue){
            self = note
        } else {
            return nil
        }
    }
    public init?(_ interval: Interval, below note: Note) {
        if let note = Note(rawValue: note.rawValue - interval.rawValue){
            self = note
        } else {
            return nil
        }
    }
    public init(_ pitch: Pitch) {
        
        let value = pitch.value * 7 % 12 + 3
        let min = Note.Bb
        
        if value < min.rawValue {
            self = Note(rawValue: value + 12)!
        } else if value > min.rawValue + 11 {
            self = Note(rawValue: value - 12)!
        } else {
            self = Note(rawValue: value)!
        }
    }
}

//Methods
extension Note {
    public func transposed(up interval: Interval) -> Note? {
        if let note = Note(rawValue: self.rawValue + interval.rawValue){
            return note
        } else {
            return nil
        }
    }
    public func transposed(down interval: Interval) -> Note? {
        if let note = Note(rawValue: self.rawValue - interval.rawValue){
            return note
        } else {
            return nil
        }
    }
}

//Arrays
extension Array where Element: NoteProtocol {
    public func transposed(up interval: Interval)->[Note]?{
        var transposed: [Note] = []
        for element in self {
            if let note = Note(interval, above: element as! Note) {
                transposed.append(note)
            } else { return nil }
        }
        return transposed
    }
    public func transposed(down interval: Interval)->[Note]?{
        var transposed: [Note] = []
        for element in self {
            if let note = Note(interval, below: element as! Note) {
                transposed.append(note)
            } else { return nil }
        }
        return transposed
    }
    public var description: String {
        get {
            return ""
        }
    }
}


//Custom Strings
extension Note.Name: CustomStringConvertible {
    public var description: String {
        get {
            switch self {
            case F      : return "F"
            case C      : return "C"
            case G      : return "G"
            case D      : return "D"
            case A      : return "A"
            case E      : return "E"
            case B      : return "B"
            }
        }
    }
}
extension Note.Accidental: CustomStringConvertible {
    public var description: String {
        get {
            switch self {
            case bb     : return "𝄫"
            case b      : return "♭"
            case n      : return "♮"
            case s      : return "♯"
            case x      : return "𝄪"
            }
        }
    }
}
extension Note: CustomStringConvertible {
    public var description: String {
        get {
            if self.accidental == .n {
                return self.name.description
            } else {
                return self.name.description + self.accidental.description
            }
        }
    }
}

