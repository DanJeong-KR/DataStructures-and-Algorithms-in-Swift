
import Foundation

public class Node<T> { // 연결리스트가 가지는 기본적인 노드 클래스 입니다.
    
    public var value: T // 값
    public var next: Node<T>? // 다음 노드 참조
    public var previous: Node<T>? // 이전 노드 참조 : 여기가 단순연결리스트와 차이.
    
    public init(value: T) {
        self.value = value
    }
}

extension Node: CustomStringConvertible {
    
    public var description: String {
        return String(describing: value)
    }
}

public class DoublyLinkedList<T> { // 더블연결리스트 클래스
    
    private var head: Node<T>? // 헤드 노드
    private var tail: Node<T>? // 테일 노드
    
    public init() { }
    
    public var isEmpty: Bool { // 헤드노드가 비었으면 연결리스트가 비어있는 거쥬?
        return head == nil
    }
    
    public var first: Node<T>? { 
        // head 노드는 항상 가장 앞에 있으므로 first 프로퍼티로 설정하면 됩니다.
        // 옵셔널임을 유의 (리스트가 비어있으면 nil 이니까요^^)
        return head
    }
    
    public func append(_ value: T) {
        let newNode = Node(value: value) // 새로 들어올 노드 초기화하고 newNode 에 저장.
        
        guard let tailNode = tail else { // tail 이 nil 인지 검사 = 리스트가 비어있는지 검사.
            head = newNode // 비어있으면 head, tail 모두 설정해줌.
            tail = newNode
            return
        }
        // 비어있지 않다면 실행.
        newNode.previous = tailNode // 새로 들어올 노드의 '이전 참조' 에 현재 tail 노드로.
        tailNode.next = newNode // 현재 tail 노드의 '다음 참조' 를 새로 들어올 노드로.
        tail = newNode // 연결정보 완료했으면 마지막으로 새로운 테일노드 설정해줌.
        // 정리하면 새로 들어올 노드를 들어올 당시의 'tail 노드' 와 연결을 서로 해주고 
        // 들어올 당시의 'tail 노드' 는 그 당시에는 마지막 노드지만 이제는 마지막 노드의 '이전노드' 가 되므로
        // 새로 들어온 노드가 진짜 'tail' 노드가 되는 것이쥬.
    }
    
    public func remove(_ node: Node<T>) -> T {
        let prev = node.previous // 제거할 노드의 이전참조
        let next = node.next // 제거할 노드의 다음참조
        
        if let prev = prev { // 가장 앞의 노드면 prev 가 nil 이쥬?
            prev.next = next 
            // 가장 앞의 노드가 아니면 제거되는 노드의 이전노드의 다음노드가 제거되는 노드의 다음노드가 되쥬?
        } else {
            head = next // 가장 앞의 노드면 head 노드 새로 설정, 제거되는 노드 다음노드가 새로운 head 노드 됨.
        }
        
        next?.previous = prev // 제거 하는 노드의 다음노드의 이전노드 참조가 제거하는 노드의 이전노드로 설정.
        
        if next == nil { // 제거하는 노드가 마지막 노드라면
            tail = prev // tail 노드 새로 설정해줌.
        }
        
        // 마지막에 할일을 다 한 참조정보들 메모리에서 없애기.
        node.previous = nil 
        node.next = nil
        
        return node.value
    }
}

extension DoublyLinkedList: CustomStringConvertible {
    
    public var description: String {
        var string = ""
        var current = head // head 노드에서 시작!
        while let node = current {
            string.append("\(node.value) -> ") 
            // 문자열 메소드인 append 사용해서 노드의 값을 연결리스트 처럼 -> 로 이어 붙인다.
            current = node.next
            // 다음 반복을 위해 current 가 next 가지게 하기.
        }
        return string + "end"  // 마지막에 end 를 붙여서 리스트의 끝이라는 것을 표현.
    }
}
/*
public class LinkedListIterator<T>: IteratorProtocol {
    
    private var current: Node<T>?
    
    init(node: Node<T>?) {
        current = node
    }
    
    public func next() -> Node<T>? {
        defer { current = current?.next }
        return current
    }
}

extension DoublyLinkedList: Sequence {
    
    public func makeIterator() -> LinkedListIterator<T> {
        return LinkedListIterator(node: head)
    }
}
 */
