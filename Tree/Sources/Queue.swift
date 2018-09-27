import Foundation

public struct Queue<T> {
    
    private var leftStack: [T] = []
    private var rightStack: [T] = []
    
    public init() {}
    
    public var isEmpty: Bool {
        return leftStack.isEmpty && rightStack.isEmpty
    }
    
    public var peek: T? {
        return !leftStack.isEmpty ? leftStack.last : rightStack.first
    }
    
    @discardableResult public mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        return leftStack.popLast()
    }
}
