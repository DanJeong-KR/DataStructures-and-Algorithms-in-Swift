import Foundation


public struct QueueArray<T>: Queue { // Queue 프로토콜을 채택함.
    private var array = Array<T>() 
    // 제네릭 타입 T 로 Queue 프로토콜의 Element 타입이 추론되겠죠? Queue 프로토콜에서 설명한 associatedtype 이니까요!
    public init() {}
    
    // protocol에서 정의한 것들 지켜야쥬?
    public var isEmpty: Bool {
        return array.isEmpty // 배열의 isEmpty 프로퍼티 사용하면 되쥬?
    }
    public var peek: T? {
        return array.first // 배열의 first 프로퍼티 사용하면 되쥬? 
    }
    
    public mutating func enQueue(_ element: T) -> Bool { // 큐 추가.
        array.append(element) 
        // append 연산은 수행속도가 O(1) 입니다. 이 표기법을 몰라도 됩니다. 수행속도 : O(1) > O(n) > O(n2)제곱
        // 왜냐하면 표준라이브러리의 Array 의 append 연산이 O(1) 로 수행됩니다.
        // 이게 뭐냐면 배열이 꽉 찼는데 더 추가해야 될 때마다 해당 배열 인스턴스는 배열의 크기를 두배로 늘립니다.
        // 그림으로 보시죠!
        return true
    }
    //MARK: - deQueue
    public mutating func deQueue() -> T? {
        return isEmpty ? nil : array.removeFirst() 
        // 비어있으면 제거할 게 없으므로 반환값도 없습니다. 그러므로 isEmpty 를 기준으로 if를 실행합니다.
        // 위의 구문은 isEmpty 가 true 면 nil , false 면 array.removeFirst() 를 반환하라는 뜻입니다.
        // 제거 연산은 수행속도가 O(n) 입니다. 배열에서 첫 아이템 제거 연산이 O(n) 이라서..
        // 배열에서 속도가 왜그래? : 배열의 맨 앞의 아이템을 제거하면 그 뒤에 있는 것들이 한칸씩 앞으로 이동해야 되기 떄문.
        // 그림으로 보시죠!
    }
}

extension QueueArray: CustomStringConvertible {
    public var description: String {
        return String(describing: array) // array 배열을 출력하도록 해줌.
    }
}

