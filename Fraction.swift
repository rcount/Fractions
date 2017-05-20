//
//  Fraction.swift
//  Fractions
//
//  Created by Vickers, Stephen on 10/25/16.
//  Copyright © 2016 Vickers, Stephen. All rights reserved.
//

import Foundation

struct Fraction{

    //MARK: - Private variables for the Fraction class -
    
    fileprivate var numerator : Int = 0
    fileprivate var denominator : Int = 1


    //MARK: - Constructors for the Fraction class -

    init(){
        self.setNumerator(numerator: 1)
        self.setDenominator(denominator: 1)
    }
    
    init(numerator num : Int, denominator den : Int){
        self.setNumerator(numerator: num)
        self.setDenominator(denominator: den)
    }
    
    init(fraction : Fraction){
        self.setNumerator(numerator: fraction.numerator)
        self.setDenominator(denominator: fraction.denominator)
    }
    
    init(reciprocalOf fraction : Fraction){
        self.setNumerator(numerator: fraction.denominator)
        self.setDenominator(denominator: fraction.numerator)
    }

    init(wholeNumber: Int){
        self.setNumerator(numerator: wholeNumber)

    }


    //MARK: - Public functions for the Fraction Class -

    mutating public func setNumerator(numerator : Int) {
        self.numerator = numerator
    }
    
    mutating public func setDenominator(denominator : Int) {
        self.denominator = denominator
    }
    
 
}

//MARK: - Extension to make the Fraction class Comparable -

extension Fraction : Comparable {
    static func == (lhs: Fraction, rhs: Fraction) ->Bool {
        return (lhs.numerator * rhs.denominator) == (lhs.denominator * rhs.numerator)
    }
    
    static func < (lhs: Fraction, rhs: Fraction) -> Bool {
        return (lhs.numerator * rhs.denominator) < (lhs.denominator * rhs.numerator)
    }
    
    static func > (lhs: Fraction, rhs: Fraction) -> Bool {
        return (lhs.numerator * rhs.denominator) > (lhs.denominator * rhs.numerator)

    }

    static func <= (lhs: Fraction, rhs: Fraction) -> Bool {
        return (lhs.numerator * rhs.denominator) <= (lhs.denominator * rhs.numerator)

    }

    static func >= (lhs: Fraction, rhs: Fraction) -> Bool {
        return (lhs.numerator * rhs.denominator) >= (lhs.denominator * rhs.numerator)

    }

    static func != (lhs: Fraction, rhs: Fraction) -> Bool {
        return (lhs.numerator * rhs.denominator) != (lhs.denominator * rhs.numerator)

    }
}

//MARK: - Extension to have a math functions for the Fraction -

extension Fraction {

    static prefix func - (rhs:Fraction) -> Fraction {
        return Fraction(numerator: -rhs.numerator, denominator: rhs.denominator)
    }
    
    static func + (lhs: Fraction, rhs: Fraction) -> Fraction {
        let a = lhs.numerator * rhs.denominator
        let b = lhs.denominator * rhs.numerator
        let den = lhs.denominator * rhs.denominator
        
        let newNumbers = Fraction.reduce(numerator: a+b, denominator: den)
        
        return Fraction(numerator: newNumbers.num, denominator: newNumbers.den)
    }
    
    static func - (lhs: Fraction, rhs: Fraction) -> Fraction {
        return lhs + -rhs
    }
    
    static func * (lhs: Fraction, rhs: Fraction) -> Fraction {
        let newNumbers = Fraction.reduce(numerator: lhs.numerator * rhs.numerator,
                denominator: lhs.denominator * rhs.denominator)
        
        return Fraction(numerator: newNumbers.num, denominator: newNumbers.den)
    }
    
    static func / (lhs: Fraction, rhs: Fraction) -> Fraction {
        return lhs * Fraction(reciprocalOf: rhs)
    }
    
    static func += (lhs: inout Fraction, rhs: Fraction) {
        lhs = lhs + rhs
    }
    
    static func -= (lhs: inout Fraction, rhs: Fraction) {
        lhs = lhs - rhs
    }
    
    static func *= (lhs: inout Fraction, rhs: Fraction) {
        lhs = lhs * rhs
    }
    
    static func /= (lhs: inout Fraction, rhs: Fraction) {
        lhs = lhs / rhs
    }
    
    fileprivate static func gcd(lhs: Int, rhs: Int) -> Int {
        return rhs == 0 ? lhs: gcd(lhs: rhs, rhs: lhs % rhs)
    }
    
    fileprivate static func reduce(numerator : Int, denominator : Int) -> (num : Int, den: Int){
        var divisor = Fraction.gcd(lhs: numerator, rhs: denominator)
        if divisor < 0 { divisor *= -1}
        
        let num = numerator / divisor
        let den = denominator / divisor
        
        return (num, den)
        
    }
}

//MARK: - Extension to make Fraction conform to CustomStringConvertible

extension Fraction: CustomStringConvertible{
    var description : String {
        get {
            if(denominator == 0){
                return "Invalid fraction"
            }
            else if(numerator == 0){
                return "0"
            }
            else if(numerator == self.denominator){
                return "1"
            }
            else{
                return "\(self.numerator)/\(self.denominator)"
            }
        }
    }
}

//MARK: - Extension to make Fraction conform to Hashable -
extension Fraction: Hashable{
    var hashValue : Int {
        var hash = 31

        hash = hash ^ self.numerator
        hash = hash ^ self.denominator
        return hash
    }
}

//MARK: - Extension for Int to turn it into a fraction -

extension Int {
    var fraction : Fraction {
        return Fraction(numerator: self, denominator: 1)
    }
    
    var reciprocalOf : Fraction {
        return Fraction(numerator: 1, denominator: self)
    }
}

//MARK: - Extension for math functions between Int and Fraction -

extension Int {
    
    static func + (lhs: Fraction, rhs: Int) -> Fraction {
        return lhs + rhs.fraction
    }
    
    static func + (lhs: Int, rhs: Fraction) -> Fraction {
        return lhs.fraction + rhs
    }
    
    static func - (lhs: Fraction, rhs: Int) -> Fraction {
        return lhs - rhs.fraction
    }
    
    static func - (lhs: Int, rhs: Fraction) -> Fraction {
        return lhs.fraction - rhs
    }
    
    static func * (lhs: Fraction, rhs: Int) -> Fraction {
        return lhs * rhs.fraction
    }
    
    static func * (lhs: Int, rhs: Fraction) -> Fraction {
        return lhs.fraction * rhs
    }
    
    static func / (lhs: Fraction, rhs: Int) -> Fraction {
        return lhs / rhs.fraction
    }
    
    static func / (lhs: Int, rhs: Fraction) -> Fraction {
        return lhs.fraction / rhs
    }
}




