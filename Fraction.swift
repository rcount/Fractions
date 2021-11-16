//
//  Fraction.swift
//  Fraction
//
//  Created by Stephen Vickers on 11/16/21.
//

import Foundation

struct Fraction {

    //MARK: - Public functions for the Fraction class -
    
    var numerator : Int = 0
    var denominator : Int = 1
    var formatted : String {
        get {
            if(self.denominator == 0){
                return "Invalid Fraction: \(self.numerator)/0"
            }
            else if(self.numerator == 0){
                return "0"
            }
            
            else if(self.numerator == self.denominator){
                return "1"
            }
            else if(self.denominator == 1){
                return "\(self.numerator)"
            }
            else {
                let separator = "\u{2044}"
                return "\(self.numerator.superScript)\(separator)\(self.denominator.subScript)"
            }
        }
    }

    //MARK: - Lifecycle methods for the class -
    

    init(numerator num: Int = 1, denominator den : Int = 1) {
        self.setNumerator(numerator: num)
        self.setDenominator(denominator: den)

    }

    init (fraction : Fraction){
        self.setNumerator(numerator: fraction.numerator)
        self.setDenominator(denominator: fraction.denominator)

    }

    init(reciprocalOf fraction : Fraction){
        self.setNumerator(numerator: fraction.denominator)
        self.setDenominator(denominator: fraction.numerator)
    }
    
    //MARK: - Public functions for the class -

    mutating func setNumerator(numerator num: Int)  {
        self.numerator = num
    }

    mutating func setDenominator(denominator den: Int) {
        
        if (den < 0){
            self.setNumerator(numerator: -self.numerator)
        }
        self.denominator = abs(den)
    }
    
    //MARK: - Private functions for the class -
    
    fileprivate func reduce() -> (numerator: Int, denominator : Int) {
        var divisor = Fraction.gcd(lhs: numerator, rhs: denominator)
        if divisor < 0 {divisor *= -1}
        
        let num = numerator / divisor
        let den = denominator / divisor
        
        return (num, den)
    }
}

//MARK: - Extension to make Fraction comform to Hashable -

extension Fraction : Hashable {
    
    func hash(into hasher: inout Hasher) {
        self.numerator.hash(into: &hasher)
        self.denominator.hash(into: &hasher)
    }

    
    
}

//MARK: - Extension to make Fraction comform to Comparable -

/*
 * These extensions are to make the Fraction struct conform to Comparable.
 * To do that if the Denominators are the same then
 */
extension Fraction : Comparable {
    static func == (lhs : Fraction , rhs : Fraction) -> Bool {
       return (lhs.numerator * rhs.denominator) == (lhs.denominator * rhs.numerator)
    }

    //function to compare a two fractions for "Great-than"
    static func < (lhs : Fraction, rhs: Fraction) -> Bool {
        return (lhs.numerator * rhs.denominator) < (lhs.denominator * rhs.numerator)
    }

    static func > (lhs : Fraction, rhs : Fraction) -> Bool {
        return (lhs.numerator * rhs.denominator) > (lhs.denominator * rhs.numerator)
    }

    static func <= (lhs : Fraction, rhs: Fraction) -> Bool {
       return (lhs.numerator * rhs.denominator) <= (lhs.denominator * rhs.numerator)
    }

    static func >= (lhs : Fraction, rhs: Fraction) -> Bool {
        return (lhs.numerator * rhs.denominator) >= (lhs.denominator * rhs.numerator)
    }
}

//MARK: - Extenstion to add the mathmatical operators to the function class -

/*
 * extensions for all the math operators for the Fraction Class. Always returns a Reduced Fraction
 */
extension Fraction {
    
    //Function to make use of the prefix operator "-". i.e. Fraction 2/3 would be
    //changed by using - as -Fraction and would then become -2/3.
    static prefix func - (rhs : Fraction) -> Fraction{
        return Fraction(numerator: -rhs.numerator, denominator: rhs.denominator)
    }
    
    //Function to add one fraction to another and return a fraction
    //@return new reduced fraction consisting of sum of lhs and rhs
    static func + (lhs : Fraction, rhs: Fraction) -> Fraction {
        let a = lhs.numerator * rhs.denominator
        let b = lhs.denominator * rhs.numerator
        let den = lhs.denominator * rhs.denominator
        
        let numbers = Fraction.reduce(numerator: a+b, denominator: den)

        return Fraction(numerator: numbers.numerator, denominator: numbers.denominator)
    }

    //function to subtract one Fraction from another and return a Fraction
    // @return lhs + -rhs since we already the addition we use that and just add by a negitive
    // rhs fraction
    static func - (lhs : Fraction, rhs : Fraction) -> Fraction {
        return lhs + -rhs

    }

    //function to multiply two Fractions together and return a Fraction
    static func * (lhs: Fraction, rhs : Fraction) -> Fraction{
        let numerator = lhs.numerator * rhs.numerator
        let denominator = lhs.denominator * rhs.denominator
        
        let numbers = Fraction.reduce(numerator: numerator, denominator: denominator)
        
        return Fraction(numerator: numbers.numerator, denominator: numbers.denominator)
    }

    //function to multiply two Fractions together and return a Fraction
    //@return lhs * the reciprocalof : rhs. Since the multiply func can do the work we let it.
    static func / (lhs : Fraction, rhs: Fraction) -> Fraction {
        return  lhs * Fraction(reciprocalOf: rhs)
    }

    //function for a +=. left is decleared inout as that's what's changed
    static func +=  (lhs: inout Fraction, rhs: Fraction) {
        lhs = lhs + rhs
    }

    //function for a -=. left is decleared inout as that's what's changed
    static func -= (lhs: inout Fraction, rhs: Fraction) {
        lhs = lhs - rhs
    }

    //function for a *=. left is decleared inout as that's what's changed
    static func *= (lhs: inout Fraction, rhs: Fraction) {
        lhs = lhs * rhs
    }

    //function for a /=. left is decleared inout as that's what's changed
    static func /= (lhs: inout Fraction, rhs: Fraction) {
        lhs = lhs / rhs
    }

    //function to get the GCD of two numbers, decleared fileprivate so the it can be called anywhere in the current file
    //used to get a divisor between a numerator and a denominator also
    fileprivate static func gcd( lhs: Int, rhs: Int) -> Int {
        return rhs == 0 ? lhs : gcd(lhs: rhs, rhs: lhs % rhs)
    }

    //Function to reduce a Fraction to the lowest possible Fraction
    static func reduce(numerator : Int, denominator : Int) -> (numerator : Int, denominator: Int) {
        var divisor = Fraction.gcd(lhs: numerator, rhs: denominator)
        if divisor < 0 {divisor *= -1}

        let num = numerator / divisor
        let den = denominator / divisor

        return (num, den)
    }
}

//MARK: - Extension to make Fraction comform to CustomStringConvertible -

extension Fraction: CustomStringConvertible{
    var description: String {
        return self.formatted
    }
}

//MARK: - Extensions to make Int work with the Fraction class -

extension Int{
    var superScript: String{
        var superScript = ""
        let translationTable: [String: String] = [
                    "0": "\u{2070}",
                    "1": "\u{00B9}",
                    "2": "\u{00B2}",
                    "3": "\u{00B3}",
                    "4": "\u{2074}",
                    "5": "\u{2075}",
                    "6": "\u{2076}",
                    "7": "\u{2077}",
                    "8": "\u{2078}",
                    "9": "\u{2079}"
        ]
        
        for n in String(self){
            let m = String(n)
            superScript += translationTable[m] ?? ""
        }
        
        return superScript
    }
    
    var subScript: String{
        var subScript = ""
        let translationTable: [String: String] = [
            "0": "\u{2080}",
            "1": "\u{2081}",
            "2": "\u{2082}",
            "3": "\u{2083}",
            "4": "\u{2084}",
            "5": "\u{2085}",
            "6": "\u{2086}",
            "7": "\u{2087}",
            "8": "\u{2088}",
            "9": "\u{2089}"
        ]
        
        for n in String(self){
            let m = String(n)
            subScript += translationTable[m] ?? ""
        }
        
        return subScript
    }
}

/*
 * Extension on Int that makes an Int a Fraction.
 */
extension Int  {

    var fraction : Fraction {
        return Fraction(numerator: self, denominator: 1)
    }

    var reciprocalOf : Fraction {
        return Fraction(numerator: 1, denominator: self)
    }
}


/*
 *Extension on Fraction that allows you to use the math operands with a Fraction and and Int.
 */
extension Fraction {

    static func + (lhs : Fraction, rhs : Int) -> Fraction {
        return lhs + rhs.fraction
    }

    static func + (lhs : Int, rhs : Fraction) -> Fraction {
        return lhs.fraction + rhs
    }

    static func - (lhs: Fraction, rhs: Int) -> Fraction {
        return lhs - rhs.fraction
    }

    static func - (lhs: Int, rhs: Fraction) -> Fraction {
        return lhs.fraction - rhs
    }

    static func * (lhs : Fraction, rhs: Int) -> Fraction {
        return lhs * rhs.fraction
    }

    static func * (lhs : Int, rhs : Fraction) -> Fraction {
        return lhs.fraction * rhs
    }

    static func / (lhs : Fraction, rhs : Int) -> Fraction {
        return lhs / rhs.fraction
    }

    static func / (lhs : Int, rhs : Fraction) -> Fraction {
        return lhs.fraction / rhs
    }

    static func += (lhs : inout Fraction, rhs : Int) {
        lhs = lhs + rhs.fraction
    }

    static func -= (lhs : inout Fraction, rhs : Int) {
        lhs = lhs - rhs.fraction
    }

    static func *= (lhs : inout Fraction, rhs : Int) {
        lhs = lhs * rhs.fraction
    }

    static func /= (lhs: inout Fraction, rhs : Int){
        lhs = lhs / rhs.fraction
    }


}
