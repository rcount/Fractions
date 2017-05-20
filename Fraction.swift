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

    ///Fileprivate variable to hold the numerator of the fraction
    fileprivate var numerator : Int = 0

    ///fileprivate variable to hld the denominator of the fraction
    fileprivate var denominator : Int = 1


    //MARK: - Constructors for the Fraction class -

    ///Default Constructor for the Fraction class
    init(){
        self.setNumerator(numerator: 1)
        self.setDenominator(denominator: 1)
    }

    ///Overloaded Constructor for the Fraction class
    ///
    /// -Parameters:
    ///         - numerator: number for the numerator of the Fraction
    ///         -denominator: number for the denominator of the Fraction
    init(numerator num : Int, denominator den : Int = 1){
        self.setNumerator(numerator: num)
        self.setDenominator(denominator: den)
    }

    ///Overloaded Constructor for the Fraction Class to copy one fraction into another
    ///
    /// -Parameter fraction:    A fraction to copy into another one
    init(fraction : Fraction){
        self.setNumerator(numerator: fraction.numerator)
        self.setDenominator(denominator: fraction.denominator)
    }

    ///Overloaded Constructor for the Fraction Class to get the Reciprocal of another Fraction
    ///
    /// -Parameter reciprocalOf:    A fraction you want to get the Reciprocal Of
    init(reciprocalOf fraction : Fraction){
        self.setNumerator(numerator: fraction.denominator)
        self.setDenominator(denominator: fraction.numerator)
    }

    ///Overloaded Constructor for the Fraction Class to turn a hole number into a fraction
    ///
    /// -Parameter wholeNumber:     An Int to turn into a fraction
    init(wholeNumber: Int){
        self.init(numerator: wholeNumber)
    }

    //MARK: - Public functions for the Fraction Class -

    ///Function to set the Numerator for the Fraction
    ///
    /// -Parameter numerator:   An Int for the numerator
    mutating public func setNumerator(numerator : Int) {
        self.numerator = numerator
    }

    ///Function to set the Denominator for the Fraction
    ///
    /// -Parameter denominator: An Int for the denominator
    mutating public func setDenominator(denominator : Int) {
        self.denominator = denominator
    }

    ///Function to get the Numerator of the fraction
    ///
    /// -Returns: An Int that is the numerator of the Fraction
    public func getNumerator() -> Int{
        return self.numerator
    }

    ///Function to get the Denominator of the fraction
    ///
    /// -Returns: An Int that is the Denominator of the Fraction
    public func getDenominator() -> Int{
        return self.denominator
    }

 
}

//MARK: - Extension to make the Fraction class Comparable -

extension Fraction : Comparable {

    ///Static Function to compare two fractions for equality
    ///
    /// -Parameters:
    ///         -lhs: A fraction to compare on the left side of the ==
    ///         -rhs: A fraction to compare on the right side of the ==
    ///
    /// -Returns: True if they are equal, false if they aren't
    static func == (lhs: Fraction, rhs: Fraction) ->Bool {
        return (lhs.getNumerator() * rhs.getDenominator()) == (lhs.getDenominator() * rhs.getNumerator())
    }

    ///Static Function to compare if the left hand Side is less than the right hand side
    ///
    /// -Parameters:
    ///         -lhs: A fraction to compare on the left side of the ==
    ///         -rhs: A fraction to compare on the right side of the ==
    ///
    /// -Returns: True if the left hand one is less, false if it's greater
    static func < (lhs: Fraction, rhs: Fraction) -> Bool {
        return (lhs.getNumerator() * rhs.getDenominator()) < (lhs.getDenominator() * rhs.getNumerator())
    }

}

//MARK: - Extension to have a math functions for the Fraction -

extension Fraction {

    ///Static prefix function to get the negative of the current fraction
    ///
    /// -Parameter rhs: A fraction you want to get the negative of
    ///
    /// -Returns: A fraction with the numerator set to negative.
    static prefix func - (rhs: Fraction) -> Fraction {
        return Fraction(numerator: -rhs.getNumerator(), denominator: rhs.getDenominator())
    }

    ///Static function to add two fractions together
    ///
    /// -Parameters:
    ///         - lhs: A fraction on the left side of the plus sign
    ///         - rhs: A fraction of the right side of the plus sign
    ///
    /// - Returns: A new fraction of the addition of the two fractions
    static func + (lhs: Fraction, rhs: Fraction) -> Fraction {
        let a = lhs.numerator * rhs.denominator
        let b = lhs.denominator * rhs.numerator
        let den = lhs.denominator * rhs.denominator
        
        let newNumbers = Fraction.reduce(numerator: a+b, denominator: den)
        
        return Fraction(numerator: newNumbers.num, denominator: newNumbers.den)
    }

    ///Static function to Subtract two Fractions
    ///
    /// -Parameters:
    ///         - lhs: A fraction on the left side of the minus sign
    ///         - rhs: A fraction of the right side of the minus sign
    ///
    /// - Returns: A new fraction of the subtraction of the two fractions
    static func - (lhs: Fraction, rhs: Fraction) -> Fraction {
        return lhs + -rhs
    }

    ///Static function to multiply two fractions together
    ///
    /// -Parameters:
    ///         - lhs: A fraction on the left side of the multiply sign
    ///         - rhs: A fraction of the right side of the multiply sign
    ///
    /// - Returns: A new fraction of the multiplication of the two fractions
    static func * (lhs: Fraction, rhs: Fraction) -> Fraction {
        let newNumbers = Fraction.reduce(numerator: lhs.numerator * rhs.numerator,
                denominator: lhs.denominator * rhs.denominator)
        
        return Fraction(numerator: newNumbers.num, denominator: newNumbers.den)
    }

    ///Static function to divide two Fraction
    ///
    /// -Parameters:
    ///         - lhs: A fraction on the left side of the divide sign
    ///         - rhs: A fraction of the right side of the divide sign
    ///
    /// - Returns: A new fraction of the division
    static func / (lhs: Fraction, rhs: Fraction) -> Fraction {
        return lhs * Fraction(reciprocalOf: rhs)
    }

    ///Static function to add two fractions together
    ///
    /// -Parameters:
    ///         - lhs: A fraction on the left side of the plus sign
    ///         - rhs: A fraction of the right side of the plus sign
    ///
    /// - Returns: the lhs with the rhs added to it
    static func += (lhs: inout Fraction, rhs: Fraction) {
        lhs = lhs + rhs
    }

    ///Static function to Subtract two Fractions
    ///
    /// -Parameters:
    ///         - lhs: A fraction on the left side of the minus sign
    ///         - rhs: A fraction of the right side of the minus sign
    ///
    /// - Returns: the lhs with the rhs subtracted from it
    static func -= (lhs: inout Fraction, rhs: Fraction) {
        lhs = lhs - rhs
    }

    ///Static function to multiply two fractions together
    ///
    /// -Parameters:
    ///         - lhs: A fraction on the left side of the multiply sign
    ///         - rhs: A fraction of the right side of the multiply sign
    ///
    /// - Returns: the lhs with the rhs multiplied to it.
    static func *= (lhs: inout Fraction, rhs: Fraction) {
        lhs = lhs * rhs
    }

    ///Static function to divide two Fraction
    ///
    /// -Parameters:
    ///         - lhs: A fraction on the left side of the divide sign
    ///         - rhs: A fraction of the right side of the divide sign
    ///
    /// - Returns: the lhs with the rhs divided from it
    static func /= (lhs: inout Fraction, rhs: Fraction) {
        lhs = lhs / rhs
    }

    ///FilePrivate function to get the Greatest Common Denominator for two number
    ///
    /// -Parameters:
    ///         -lhs: An Int to check for the GCD
    ///         -rhs: An Int to check for the GCD
    ///
    /// -Returns: If the rhs is 0 then it returns the lhs,
    ///           else it recursively class it's self with rhs in lhs and rhs set to lhs % rhs
    fileprivate static func gcd(lhs: Int, rhs: Int) -> Int {
        return rhs == 0 ? lhs: gcd(lhs: rhs, rhs: lhs % rhs)
    }

    ///FilePrivate function to reduce a two numbers
    ///
    /// -Parameters:
    ///         -numerator: an Int of the fraction to reduce
    ///         -denominator: an Int of the fraction to reduce
    ///
    /// -Returns: a Tuple of the numerator and denominator
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

    ///Calculated Variable to get the description of the the fraction
    ///
    /// -Returns: a String representation of the Fraction
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

    ///Calculated Variable to get the HashValue of the fraction
    ///
    /// -Returns: An Int representation of the Fraction
    var hashValue : Int {
        var hash = 31

        hash = hash ^ self.numerator
        hash = hash ^ self.denominator
        return hash
    }
}

//MARK: - Extension for Int to turn it into a fraction -

extension Int {

    ///Calculated Variable to make an Int a Fraction
    ///
    /// -Returns: A fraction of the wholeNumber
    var fraction : Fraction {
        return Fraction(wholeNumber: self)
    }

    ///Calculated Variable to get the reciprocal of a fraction
    ///
    /// -Returns: A fraction of the reciprocal of the whole number
    var reciprocalOf : Fraction {
        return Fraction(numerator: 1, denominator: self)
    }
}

//MARK: - Extension for math functions between Int and Fraction -

extension Int {

    ///Static function to add a Fraction and an Int
    ///
    /// -Parameters:
    ///         - lhs: A fraction on the left side of the plus sign
    ///         - rhs: A Int on the right side of the plus sign
    ///
    /// - Returns: A new fraction of the addition of the fraction and Int
    static func + (lhs: Fraction, rhs: Int) -> Fraction {
        return lhs + rhs.fraction
    }

    ///Static function to add a Fraction and an Int
    ///
    /// -Parameters:
    ///         - lhs: A Int on the right side of the plus sign
    ///         - rhs: A fraction on the left side of the plus sign
    ///
    /// - Returns: A new fraction of the addition of the fraction and Int
    static func + (lhs: Int, rhs: Fraction) -> Fraction {
        return lhs.fraction + rhs
    }

    ///Static function to Subtract an Int from a fraction
    ///
    /// -Parameters:
    ///         - lhs: A fraction on the left side of the plus sign
    ///         - rhs: A Int on the right side of the plus sign
    ///
    /// - Returns: A new fraction of the Subtraction of the fraction and Int
    static func - (lhs: Fraction, rhs: Int) -> Fraction {
        return lhs - rhs.fraction
    }

    ///Static function to Subtract two a Fraction from and Int
    ///
    /// -Parameters:
    ///         - lhs: A Int on the right side of the plus sign
    ///         - rhs: A fraction on the left side of the plus sign
    ///
    /// - Returns: A new fraction of the addition of the fraction and Int
    static func - (lhs: Int, rhs: Fraction) -> Fraction {
        return lhs.fraction - rhs
    }

    ///Static function to multiply a Fraction and an Int
    ///
    /// -Parameters:
    ///         - lhs: A fraction on the left side of the plus sign
    ///         - rhs: A Int on the right side of the plus sign
    ///
    /// - Returns: A new fraction of the addition of the fraction and Int
    static func * (lhs: Fraction, rhs: Int) -> Fraction {
        return lhs * rhs.fraction
    }

    ///Static function to multiply a Fraction and an Int
    ///
    /// -Parameters:
    ///         - lhs: A Int on the right side of the plus sign
    ///         - rhs: A fraction on the left side of the plus sign
    ///
    /// - Returns: A new fraction of the addition of the fraction and Int
    static func * (lhs: Int, rhs: Fraction) -> Fraction {
        return lhs.fraction * rhs
    }

    ///Static function to Divide an Int from a fraction
    ///
    /// -Parameters:
    ///         - lhs: A fraction on the left side of the plus sign
    ///         - rhs: A Int on the right side of the plus sign
    ///
    /// - Returns: A new fraction of the Division of the fraction and Int
    static func / (lhs: Fraction, rhs: Int) -> Fraction {
        return lhs / rhs.fraction
    }

    ///Static function to Subtract two a Fraction from and Int
    ///
    /// -Parameters:
    ///         - lhs: A Int on the right side of the plus sign
    ///         - rhs: A fraction on the left side of the plus sign
    ///
    /// - Returns: A new fraction of the addition of the fraction and Int
    static func / (lhs: Int, rhs: Fraction) -> Fraction {
        return lhs.fraction / rhs
    }
}




