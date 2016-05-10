//  Created by Pawel Chmiel on 06.05.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.

import UIKit

enum BreakfastErrors: ErrorType {
    case emptyFridge
    case noMilk
    case noEggs
}

struct Fridge {
    
    private var empty: Bool {
        return !milk && !eggs
    }
    
    var milk: Bool
    var eggs: Bool
    
    
    init(milk: Bool = false, eggs: Bool = false){
        self.milk = milk
        self.eggs = eggs
    }
    
}

//Two cooking functions

func scrambledEggs(fridge: Fridge) throws -> String {
    guard !fridge.empty else { throw BreakfastErrors.emptyFridge }
    
    if !fridge.eggs {
        throw BreakfastErrors.noEggs
    } else {
        return "Cool, let's cook it"
    }
}

func pancakes(fridge: Fridge) throws -> String  {
    guard !fridge.empty else { throw BreakfastErrors.emptyFridge }
    
    if !fridge.eggs {
        throw BreakfastErrors.noEggs
    } else {
        if !fridge.milk {
            throw BreakfastErrors.noMilk
        } else {
            return "I love pancakes"
        }
    }
}

//Examples of usage:

var fridge = Fridge(milk: false, eggs: true)

do {
   var resultsOfCooking = try scrambledEggs(fridge)
} catch BreakfastErrors.emptyFridge {
    print("fill the fridge")
} catch BreakfastErrors.noEggs {
    print("go and buy some eggs")
} catch BreakfastErrors.noMilk {
    print("go and buy some milk")
} catch {
    print("something else..")
}

//Example of not using do-catch block but forcing the call

//I'm sure eggs are in the fridge

let breakfast = try! scrambledEggs(fridge)

//One more example with empty fridge

fridge.milk = false
fridge.eggs = false

do {
    try pancakes(fridge)
} catch BreakfastErrors.emptyFridge {
    print("fill the fridge")
} catch BreakfastErrors.noEggs {
    print("go and buy some eggs")
} catch BreakfastErrors.noMilk {
    print("go and buy some milk")
}  catch {
    print("something else..")
}

//Another example with using only two catch block, but fulfilling all cases
do {
    try pancakes(fridge)
} catch let error as BreakfastErrors {
    switch error {
    case .emptyFridge:
        print("fill the fridge")
    case .noEggs:
        print("go and buy some eggs")
    case .noMilk:
        print("go and buy some milk")
    }
} catch {
    print("something else")
}
