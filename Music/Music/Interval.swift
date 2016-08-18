//
//  Interval.swift
//  Music
//
//  Created by Devin Roth on 7/18/16.
//  Copyright © 2016 Devin Roth Music. All rights reserved.
//

import Foundation

//enums
public enum Interval: Int {
    case vDim5      = -34
    case ivDim2
    case ivDim6
    case ivDim3
    case ivDim7
    case ivDim4
    case ivDim1
    case ivDim5
    case iiiDim2
    case iiiDim6
    case iiiDim3
    case iiiDim7
    case iiiDim4
    case iiiDim1
    case iiiDim5
    case iiDim2
    case iiDim6
    case iiDim3
    case iiDim7
    case iiDim4
    case iiDim1
    case iiDim5
    case dim2
    case dim6
    case dim3
    case dim7
    case dim4
    case dim1
    case dim5
    case min2
    case min6
    case min3
    case min7
    case per4
    case per1       = 0
    case per5
    case maj2
    case maj6
    case maj3
    case maj7
    case aug4
    case aug1
    case aug5
    case aug2
    case aug6
    case aug3
    case aug7
    case iiAug4
    case iiAug1
    case iiAug5
    case iiAug2
    case iiAug6
    case iiAug3
    case iiAug7
    case iiiAug4
    case iiiAug1
    case iiiAug5
    case iiiAug2
    case iiiAug6
    case iiiAug3
    case iiiAug7
    case ivAug4
    case ivAug1
    case ivAug5
    case ivAug2
    case ivAug6
    case ivAug3
    case ivAug7
    case vAug4      = 34
}

extension Interval {
    public enum Quality: Int {
        case vDim    = -34
        case ivDim   = -33
        case iiiDim  = -26
        case iiDim   = -19
        case dim     = -12
        case min     = -5
        case per     = 0
        case maj     = 2
        case aug     = 6
        case iiAug   = 13
        case iiiAug  = 20
        case ivAug   = 27
        case vAug    = 34
    }
    
    public var quality: Quality {
        switch self.rawValue {
        case -34         : return .vDim
        case -33 ... -27 : return .ivDim
        case -26 ... -20 : return .iiiDim
        case -19 ... -13 : return .iiDim
        case -12 ...  -6 : return .dim
        case -5  ...  -2 : return .min
        case -1  ...   1 : return .per
        case  2  ...   5 : return .maj
        case  6  ...  12 : return .aug
        case 13  ...  19 : return .iiAug
        case 20  ...  26 : return .iiiAug
        case 27  ...  33 : return .ivAug
        default          : return .vAug
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

//initializers
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
    public init?(_ quality: Quality,_ value: Value){
        switch quality {
        case .vDim:
            switch value {
            case .fifth:
                self = .vDim5
            default:
                return nil
            }
        case .min:
            switch value {
            case .second,.third,.sixth,.seventh:
                self = Interval(rawValue: value.rawValue - 8)!
            default:
                return nil
            }
        case .per:
            switch value {
            case .first,.fourth,.fifth:
                self = Interval(rawValue: value.rawValue)!
            default:
                return nil
            }
        case .maj:
            switch value {
            case .second,.third,.sixth,.seventh:
                self = Interval(rawValue: value.rawValue - 1)!
            default:
                return nil
            }
        case .vAug:
            switch value {
            case .fourth:
                self = .vAug4
            default:
                return nil
            }
        case .dim,.iiDim,.iiiDim,.ivDim:
            self = Interval(rawValue: quality.rawValue + (value.rawValue + 4) % 7 )!
        case .aug,.iiAug,.iiiAug,.ivAug:
            self = Interval(rawValue: quality.rawValue + value.rawValue)!
        }
    }
}
//Methods
public protocol IntervalProtocol {
    func transposed(up: Self)->Self?
    func transposed(down: Self)->Self?
}
extension Interval: IntervalProtocol {
    public func transposed(up interval: Interval)->Interval?{
        return Interval(between: interval.inverted(), and: self)
    }
    public func transposed(down interval: Interval)->Interval?{
        return Interval(between: interval, and: self)
    }
    public func inverted()->Interval{
        return Interval(rawValue: -self.rawValue)!
    }
}

//Arrays
extension Array where Element: IntervalProtocol {
    public func mode(_ degree: Degree) -> Array<Element>? {
        if self.count < 5 || self.count - 1 < degree.rawValue { return nil }
        if let mode = self.rotated(degree.rawValue) {
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
        return self.rotated(inversion.rawValue)
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
    public func notes(root note: Note) -> [Note]?{
        var notes: [Note] = []
        for interval in self {
            if let note = Note(interval as! Interval, above: note) {
                notes.append(note)
            } else { return nil }
        }
        return notes
    }
    
}

//custon strings
extension Interval.Quality: CustomStringConvertible {
    public var description: String {
        switch self {
        case .vDim       : return "Quintuply Diminished"
        case .ivDim      : return "Quadruply Diminished"
        case .iiiDim     : return "Triply Diminished"
        case .iiDim      : return "Doubly Diminished"
        case .dim        : return "Diminished"
        case .min        : return "Minor"
        case .per        : return "Perfect"
        case .maj        : return "Major"
        case .aug        : return "Augmented"
        case .iiAug      : return "Doubly Augmented"
        case .iiiAug     : return "Triply Augmented"
        case .ivAug      : return "Quadruply Augmented"
        case .vAug       : return "Quintuply Augmented"
        }
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

extension Interval: CustomStringConvertible {
    
    public var description: String {
        get {
            return self.quality.description + " " + self.value.description
        }
    }
}
