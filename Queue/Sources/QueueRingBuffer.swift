
import Foundation

public struct QueueRingBuffer<T>: Queue { 
    private var ringBuffer: RingBuffer<T> // 전에 구현한 RingBuffer 
    
    public init(count: Int) {
        ringBuffer = RingBuffer<T>(count: count) // BingBuffer 는 고정된 크기의 배열이 필요했었쥬?
    }
    
    public var isEmpty: Bool { // RingBuffer 에서 했쥬?
        return ringBuffer.isEmpty
    }
    
    public var peek: T? { // RingBuffer 에서 했쥬?
        return ringBuffer.first
    }
    
    public mutating func enQueue(_ element: T) -> Bool {
        return ringBuffer.write(element) // RingBuffer 에서 write 메소드가 enQueue
    }
    
    public mutating func deQueue() -> T? { // RingBuffer 에서 read 메소드가 deQueue
        return isEmpty ? nil : ringBuffer.read()
    }
}

extension QueueRingBuffer: CustomStringConvertible {
    public var description: String {
        return String(describing: ringBuffer) 
        // 출력도 RingBuffer 에서 다 만들어놨쥬?
    }
}
