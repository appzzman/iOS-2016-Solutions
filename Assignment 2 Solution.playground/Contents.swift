//: Playground - noun: a place where people can play

import UIKit


/*:
Assignment 2
Implement a formula that calculates mothly mortgage loan based on: http://www.mtgprofessor.com/formulas.htm


    The loan has specific information:
    interest 4.125
    balance  $93.000
    remaining number of months 360


    Make sure to create a tuple that holds the following values:
    interest, balance, period
    
    Use the tuple in calculations.

    Use function pow(a,b) to get the power of a number
    pow(a,b)
        
    Keep in mind that pow takes as argument Double. 
    To cast any number to double use Double(numberToCast)

    Arithmetic Operators are identical to most of the programming languages:
    + - / *


    Print the result to the screen, your output should look similar to:
    The monthly mortgage is $xxx.x

    To round the number use a round function:
    round(100 * NUMBER_TO_ROUND) / 100)

*/

let c = 0.04125 / 12.0 //Interest rate
let L = 93000.0
let n = 360

let loanInformation = (interest: c, balance:L, period:n)

let top = loanInformation.interest * pow(1+loanInformation.interest, Double(loanInformation.period))
let down = pow(1+loanInformation.interest, Double(loanInformation.period)) - 1

let P = loanInformation.balance * top / down

//Print it to the screen 
print("The monthly mortgage is $\(round(100 * P) / 100)")

