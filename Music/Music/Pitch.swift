//
//  Pitch.swift
//  Music
//
//  Created by Devin Roth on 7/23/16.
//  Copyright © 2016 Devin Roth Music. All rights reserved.
//

import Foundation

public protocol PitchProtocol {
    func transposed(_ pitch: Int) ->Int
    func inverted() -> Int
}

public struct Pitch {
    var value: Int
    public init(){
        self.value = 0
    }
    public init(_ value: Int){
        self.value = value
    }
}

extension Pitch: PitchProtocol {
    public init(_ note: Note){
        self.value = (note.rawValue + 9) * 7 % 12
    }
    
    public func transposed(_ pitch: Int) ->Pitch {
        var pitch = (self.value + pitch) % 12
        if pitch < 0 {
            pitch += 12
        }
        return pitch
    }
    public func inverted() ->Pitch {
        return (12 - self.value)%12
    }
}

extension Array where Element: PitchProtocol {
    public func transposed(_ pitch: Pitch)->[Pitch]{
        var transposed: [Pitch] = []
        for element in self {
            transposed.append(Pitch((element as! Pitch).transposed(pitch.value)))
        }
        return transposed
    }
    public func inverted()->[Pitch]{
        var inverted: [Pitch] = []
        for element in self {
            inverted.append(Pitch((element as! Pitch).inverted()))
        }
        return inverted
    }
    public func retrograded()->[Element]{
        return self.reversed()
    }
    public func notes()->[Note]{
        var notes: [Note] = []
        for element in self {
            notes.append(Note(element as! Pitch))
        }
        return notes
    }
}

extension Pitch: ExpressibleByIntegerLiteral {
    public typealias Pitch = Int
    
    /// Create an instance initialized to `value`.
    public init(integerLiteral value: Pitch.IntegerLiteralType) {
        self.value = (value%12 + 12) % 12
    }
}

extension Pitch: CustomStringConvertible {
    public var description: String {
        get {
            return String(self.value)
        }
    }
}
