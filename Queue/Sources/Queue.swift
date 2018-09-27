import Foundation

public protocol Queue {
    associatedtype Element 
    // associatedtype 키워드는 프로토콜을 정의할 때 제네릭타입 처럼 일반화 시킨 타입을 지정할 떄 사용합니다.
    // 아래에 Element 활용한 메소드들 정의한 것 보이시죠? 이 프로토콜을 채택한 것의 타입이 Int 라면 아래에 정의한 메소드들에서 쓴 Element 는 모두 Int 가 되는 것이죠. 물론 String 도 Double 도 내가 원하는 타입이 될 수도 있구요!
    // 이 프로토콜을 채택하는 객체가 자기가 원하는 타입의 Queue 를 작성할 수 있도록 말이쥬.
    mutating func enQueue(_ element: Element) -> Bool
    // 큐 끝에 새로운 큐를 추가하고 성공여부 반환
    mutating func deQueue() -> Element?
    // 가장 먼저 들어온 앞의 큐 제거하고 제거한 큐 반환하기.
    
    var isEmpty: Bool { get } // 큐가 비어있는지 알려주는 읽기전용 프로퍼티 (get은 읽기전용 을 알려주는 겁니다.)
    var peek: Element? { get } 
    // 가장 앞의 큐를 알려줍니다.. 제거하는게 아니구요 (deQueue 와 차이)
    // peek 은 '살짝 보다' 라는 뜻입니다^^.
    // get 은 읽기 라는 연산을 수행하고 set 은 쓰기 연산을 수행하는 키워드 입니다. (노파심에 ^^)
}

