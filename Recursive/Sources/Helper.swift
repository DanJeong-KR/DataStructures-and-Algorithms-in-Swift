
import Foundation

public func example( description:String, excute:()->() ) {
    print("---Example of \(description)---")
    excute()
}

public func processTime(blockFunction: () -> ()) -> Float { 
    let startTime = CFAbsoluteTimeGetCurrent() 
    blockFunction() 
    let processTime = CFAbsoluteTimeGetCurrent() - startTime 
    return (Float(processTime))
}




