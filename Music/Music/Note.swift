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

//Mark: Note
public enum Note: Int, NoteProtocol {
    case fDoubleFlat
    case cDoubleFlat
    case gDoubleFlat
    case dDoubleFlat
    case aDoubleFlat
    case eDoubleFlat
    case bDoubleFlat
    case fFlat
    case cFlat
    case gFlat
    case dFlat
    case aFlat
    case eFlat//fbb
    case bFlat
    case f
    case c
    case g
    case d //reflextion point
    case a
    case e
    case b
    case fSharp
    case cSharp
    case gSharp
    case dSharp//fbb
    case aSharp
    case eSharp
    case bSharp
    case fDoubleSharp
    case cDoubleSharp
    case gDoubleSharp
    case dDoubleSharp
    case aDoubleSharp
    case eDoubleSharp
    case bDoubleSharp
}
extension Note {
    public enum Name: Int {
        case f
        case c
        case g
        case d
        case a
        case e
        case b
    }
    public var name: Name {
        get {
            return Name(rawValue: self.rawValue % 7)!
        }
    }
}
extension Note.Name: CustomStringConvertible {
    public var description: String {
        get {
            switch self {
            case f: return "F"
            case c: return "C"
            case g: return "G"
            case d: return "D"
            case a: return "A"
            case e: return "E"
            case b: return "B"
            }
        }
    }
}
extension Note {
    public enum Accidental: Int {
        case doubleFlat
        case flat
        case natural
        case sharp
        case doubleSharp
    }
    
    public var accidental: Accidental {
        get {
            return Accidental(rawValue: self.rawValue / 7 )!
        }
    }
}
extension Note.Accidental: CustomStringConvertible {
    public var description: String {
        get {
            switch self {
            case doubleFlat: return "𝄫"
            case flat: return "♭"
            case natural: return "♮"
            case sharp: return "♯"
            case doubleSharp: return "𝄪"
            }
        }
    }
}

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
        let min = Note.bFlat
        
        if value < min.rawValue {
            self = Note(rawValue: value + 12)!
        } else if value > min.rawValue + 11 {
            self = Note(rawValue: value - 12)!
        } else {
            self = Note(rawValue: value)!
        }
    }
}
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

extension Note: CustomStringConvertible {
    public var description: String {
        get {
            if self.accidental == .natural {
                return self.name.description
            } else {
                return self.name.description + self.accidental.description
            }
        }
    }
}

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
}

