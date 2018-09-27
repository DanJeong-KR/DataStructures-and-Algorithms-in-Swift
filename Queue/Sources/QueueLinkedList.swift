import Foundation



public class QueueLinkedList<T>: Queue {
    private var list = DoublyLinkedList<T>() // 연결리스트 인스턴스 생성
    public init() {}
    
    //MARK: - Comform to Queue protocol
    public func enQueue(_ element: T) -> Bool { // 큐에 값 추가하기.
        list.append(element) // 연결리스트의 append 메소드로 큐에 값을 추가합니다.
        return true
    }
    public func deQueue() -> T? { // 큐애 값 제거하기.
        guard !list.isEmpty, let element = list.first else {
            // 연결리스트 비어있지 않고
            // 연결리스트의 first 프로퍼티는 옵셔널로 선언되었으므로 바인딩으로 해제시킵니다.
            return nil
        }
        return list.remove(element) // 연결리스트의 remove 메소드로 첫 번째 값을 제거시킵니다.
    }
    
    public var peek: T? { // 큐의 가장 앞의 값을 반환해서 얻습니다.
        return list.first?.value
    }
    
    public var isEmpty: Bool{ // 연결리스트의 isEmpty 를 읽습니다.
        return list.isEmpty
    }
}

extension QueueLinkedList: CustomStringConvertible {
    public var description: String {
        return String(describing: list)
    }
}
