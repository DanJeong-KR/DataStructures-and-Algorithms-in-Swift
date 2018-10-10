
import Foundation

public struct Stack<T> {
    private var elements = Array<T>()
    public init() {}
    
    // for in 루프에서 사용하려면 Sequence 만들어야함.
    
    public mutating func pop() -> T? {
        return self.elements.popLast()
    }
    
    public mutating func push(element: T) {
        self.elements.append(element)
    }
    
    public func peek() -> T? {
        return self.elements.last
    }
    
    public var isEmpty: Bool {
        return self.elements.isEmpty
    }
    
    public var count: Int {
        return self.elements.count
    }
}


extension Stack: CustomStringConvertible {
    
    public var description: String {
        return self.elements.description + "이 내가 만든 스택입네다!!!!!!!!"
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: T...) {
        self.init()
        for element in elements { 
            self.elements.append(element) 
        }
    }
}

public struct ArrayIterator<T>: IteratorProtocol { 

    var currentElement: [T]
    init(elements: [T]) {
        self.currentElement = elements
    }
    
    public mutating func next() -> T? {
        if !self.currentElement.isEmpty { // 비어있지 않으면의 뜻이 nil 이 아니면 이지.
            return self.currentElement.popLast() // 마지막 꺼부터 반환하고 없애는 것. Stack 의 특성대로.
        }
        return nil
    }
}

extension Stack: Sequence {
    public func makeIterator() -> ArrayIterator<T> {
        return ArrayIterator<T>(elements: self.elements)
    }
}


