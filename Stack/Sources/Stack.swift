
import Foundation

public struct Stack<Element> {
    
    //MARK: - storage : 쌓여있는 것들 배열로
    private var storage = Array<Element>() // 외부에서 접근할 수 없는 private 키워드 붙음.
    public init(_ element: [Element]) {
        storage = element // 초기화 함수의 매개변수로 배열을 넣을 수 있음.
    }
    public init() {}
    
    //MARK: - push : 쌓기
    public mutating func push(_ element: Element) { // push 위에 쌓기 .
        storage.append(element)
    }
    
    //MARK: - pop : 위에서 꺼내기
    @discardableResult // 반환값 무시할 수 있게 해주는 옵션, 컴파일러가 경고표시 안나게 해줌.
    public mutating func pop() -> Element? { // pop 위에서 부터 꺼내기.
        return storage.popLast()
    }
    
    //MARK: - useful 메소드
    public func peek() -> Element? {
        return storage.last
    }
    
    public var isEmpty: Bool {
        return peek() == nil
    }
    
    
}

extension Stack: CustomStringConvertible { 
    // CustomStringConvertible 프로토콜 채택.
    // description 정의하는 프로토콜
    public var description: String { // 연산 프로퍼티로 실시간으로 바뀌는 Stack 의 stackElements 를 정의
        
        let topDivider = "--- top ---\n"
        let bottomDivider = "\n ----------"
        
        let stackElements = storage
            .map { (i) in // 배열에 있는 요소들 모두 문자열로 바꾸고.
                "\(i)"
        }.reversed() // 배열 순서 바꾸고
        .joined(separator: "\n") // 문자열 사이사이에 줄 바꿈 해주면 . Stack 처럼 보이기 가능.
        
        return topDivider + stackElements + bottomDivider
    }
}



