//
//  Interval.swift
//  Music
//
//  Created by Devin Roth on 7/18/16.
//  Copyright © 2016 Devin Roth Music. All rights reserved.
//

import Foundation

//Mark: Interval
public protocol IntervalProtocol {
    func transposed(up: Self)->Self?
    func transposed(down: Self)->Self?
}


public enum Interval: Int {
    case quintuplyDiminished5 = -34
    case quadruplyDiminished2
    case quadruplyDiminished6
    case quadruplyDiminished3
    case quadruplyDiminished7
    case quadruplyDiminished4
    case quadruplyDiminished1
    case quadruplyDiminished5
    case triplyDiminished2
    case triplyDiminished6
    case triplyDiminished3
    case triplyDiminished7
    case triplyDiminished4
    case triplyDiminished1
    case triplyDiminished5
    case doublyDiminished2
    case doublyDiminished6
    case doublyDiminished3
    case doublyDiminished7
    case doublyDiminished4
    case doublyDiminished1
    case doublyDiminished5
    case diminished2
    case diminished6
    case diminished3
    case diminished7
    case diminished4
    case diminished1
    case diminished5
    case minor2
    case minor6
    case minor3
    case minor7
    case perfect4
    case perfect1 = 0
    case perfect5
    case major2
    case major6
    case major3
    case major7
    case augmented4
    case augmented1
    case augmented5
    case augmented2
    case augmented6
    case augmented3
    case augmented7
    case doublyAugmented4
    case doublyAugmented1
    case doublyAugmented5
    case doublyAugmented2
    case doublyAugmented6
    case doublyAugmented3
    case doublyAugmented7
    case triplyAugmented4
    case triplyAugmented1
    case triplyAugmented5
    case triplyAugmented2
    case triplyAugmented6
    case triplyAugmented3
    case triplyAugmented7
    case quadruplyAugmented4
    case quadruplyAugmented1
    case quadruplyAugmented5
    case quadruplyAugmented2
    case quadruplyAugmented6
    case quadruplyAugmented3
    case quadruplyAugmented7
    case quintuplyAugmented4 = 34
}

extension Interval {
    public enum Quality: Int {
        case quintuplyDiminished    = -34
        case quadruplyDiminished    = -33
        case triplyDiminished       = -26
        case doublyDiminished       = -19
        case diminished             = -12
        case minor                  = -5
        case perfect                = 0
        case major                  = 2
        case augmented              = 6
        case doublyAugmented        = 13
        case triplyAugmented        = 20
        case quadruplyAugmented     = 27
        case quintuplyAugmented     = 34
    }
    
    public var quality: Quality {
        switch self.rawValue {
        case -34         : return .quintuplyDiminished
        case -33 ... -27 : return .quadruplyDiminished
        case -26 ... -20 : return .triplyDiminished
        case -19 ... -13 : return .doublyDiminished
        case -12 ...  -6 : return .diminished
        case -5  ...  -2 : return .minor
        case -1  ...   1 : return .perfect
        case  2  ...   5 : return .major
        case  6  ...  12 : return .augmented
        case 13  ...  19 : return .doublyAugmented
        case 20  ...  26 : return .triplyAugmented
        case 27  ...  33 : return .quadruplyAugmented
        default          : return .quintuplyAugmented
        }
    }
}
extension Interval.Quality: CustomStringConvertible {
    public var description: String {
        switch self {
        case quintuplyDiminished   : return "Quintuply Diminished"
        case quadruplyDiminished   : return "Quadruply Diminished"
        case triplyDiminished      : return "Triply Diminished"
        case doublyDiminished      : return "Doubly Diminished"
        case diminished            : return "Diminished"
        case minor                 : return "Minor"
        case perfect               : return "Perfect"
        case major                 : return "Major"
        case augmented             : return "Augmented"
        case doublyAugmented       : return "Doubly Augmented"
        case triplyAugmented       : return "Triply Augmented"
        case quadruplyAugmented    : return "Quadruply Augmented"
        case quintuplyAugmented    : return "Quintuply Augmented"
        }
    }
}
extension Interval {
    public enum Value: Int {
        case fourth
        case first
        case fifth
        case second
        case sixth
        case third
        case seventh
    }
    
    public var value: Value {
        return Value(rawValue: (self.rawValue + 36) % 7)!
    }
}
extension Interval.Value: CustomStringConvertible {
    public var description: String {
        get {
            switch self {
            case .first  : return "1st"
            case .second : return "2nd"
            case .third  : return "3rd"
            case .fourth : return "4th"
            case .fifth  : return "5th"
            case .sixth  : return "6th"
            case .seventh: return "7th"
            }
        }
    }
}

extension Interval {
    public init?(between bottom: Note, and top: Note){
        if let interval = Interval(rawValue: top.rawValue - bottom.rawValue) {
            self = interval
        } else {
            return nil
        }
    }
    public init?(between bottom: Interval, and top: Interval){
        if let interval = Interval(rawValue: top.rawValue - bottom.rawValue) {
            self = interval
        } else {
            return nil
        }
    }
    //maybe a way to simplify uses note values
    public init?(_ quality: Quality,_ value: Value){
        switch quality {
        case .quintuplyDiminished:
            switch value {
            case .fifth:
                self = .quintuplyDiminished5
            default:
                return nil
            }
        case .minor:
            switch value {
            case .second,.third,.sixth,.seventh:
                self = Interval(rawValue: value.rawValue - 8)!
            default:
                return nil
            }
        case .perfect:
            switch value {
            case .first,.fourth,.fifth:
                self = Interval(rawValue: value.rawValue)!
            default:
                return nil
            }
        case .major :
            switch value {
            case .second,.third,.sixth,.seventh:
                self = Interval(rawValue: value.rawValue - 1)!
            default:
                return nil
            }
        case .quintuplyAugmented:
            switch value {
            case .fourth:
                self = .quintuplyAugmented4
            default:
                return nil
            }
        case .diminished,.doublyDiminished,.triplyDiminished,.quadruplyDiminished:
            self = Interval(rawValue: quality.rawValue + (value.rawValue + 4) % 7 )!
        case .augmented,.doublyAugmented,.triplyAugmented,.quadruplyAugmented:
            self = Interval(rawValue: quality.rawValue + value.rawValue)!
        }
    }
    public func inversion()->Interval{
        return Interval(rawValue: -self.rawValue)!
    }
}

extension Interval: IntervalProtocol {
    public func transposed(up interval: Interval)->Interval?{
        return Interval(between: interval.inversion(), and: self)
    }
    public func transposed(down interval: Interval)->Interval?{
        return Interval(between: interval, and: self)
    }
}

extension Interval: CustomStringConvertible {
    
    public var description: String {
        get {
            return self.quality.description + " " + self.value.description
        }
    }
}

extension Array where Element: IntervalProtocol {
    public func mode(_ degree: Degree) -> Array<Element>? {
        if self.count < 5 || self.count - 1 < degree.rawValue { return nil }
        if let mode = self.rotate(degree.rawValue) {
            var transposed = Array<Element>()
            for element in mode{
                if let element = element.transposed(down: self[degree.rawValue]) {
                    transposed.append(element)
                } else { return nil }
            }
            return transposed
        } else { return nil }
    }
    public func inversion(_ inversion: Inversion) -> Array<Element>? {
        if self.count > 4 || self.count - 1 < inversion.rawValue { return nil }
        return self.rotate(inversion.rawValue)
    }
    public func transposed(up interval: Element) -> Array<Element>? {
        var transposed = Array<Element>()
        for element in self {
            if let element = element.transposed(up: interval) {
                transposed.append(element)
            } else { return nil }
        }
        return transposed
    }
    public func transposed(down interval: Element) -> Array<Element>? {
        var transposed = Array<Element>()
        for element in self {
            if let element = element.transposed(down: interval) {
                transposed.append(element)
            } else { return nil }
        }
        return transposed
    }
    public func notes(withRoot note: Note) -> [Note]?{
        var notes: [Note] = []
        for interval in self {
            if let note = Note(interval as! Interval, above: note) {
                notes.append(note)
            } else { return nil }
        }
        return notes
    }
    
}
