
import Foundation

extension Queue: CustomStringConvertible {
    public var description: String {
        return data.description + "가 내가 정의한 큐 설명입니다!"
    }
}

extension Queue: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = T
    public init(arrayLiteral elements: T...) {
        for element in elements {
            self.data.append(element)
        }
    }
}

public struct QueueIterator<T>: IteratorProtocol {
    var currentElement: [T]
    
    public mutating func next() -> T? {
        if !self.currentElement.isEmpty {
            return currentElement.removeFirst()
        }else {
            return nil
        }
    }
}

extension Queue: Sequence {
    public func makeIterator() -> QueueIterator<T> {
        return QueueIterator(currentElement: self.data)
    }
}

// Collection
extension Queue {
    private func  checkIndex(index: Int) {
        if index < 0 || index > count {
            fatalError("Index out of range")
        }
    }
}

extension Queue: MutableCollection {
    
    
    public var startIndex: Int {
        return 0 
    }
    
    public var endIndex: Int {
        return count - 1
    }
    
    public func index(after i: Int) -> Int {
        return  data.index(after: i)
    }
    
    public subscript (index: Int) -> T { 
        get {
            checkIndex(index: index) // 아 매개변수로 들어온 index 구나.
            return data[index]
        }
        set {
            checkIndex(index: index)
            data[index] = newValue
        }
    }
}

