
import Foundation

public struct LinkedList<Value> { // 전체 연결리스트를 관리하는 하는 LinkedList 구조체
    
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {} // 모든 프로퍼티들 옵셔널이면 nil 로 초기화됨.
    
    public var isEmpty: Bool {
        return head == nil 
        // head 와 nil 을 비교해서 nil 이라면 true 반환. head 가 nil 이면 빈 연결리스트 라는 걸 표현.
    }
    
    //MARK: - Push ( adding a value at the front of the list )
    public mutating func push(_ value: Value) { // mutating 
        head = Node(value: value, next: head) // head 생성 , head 에 메모리 주소가 부여되는 시점.
        if tail == nil {
            tail = head // head 의 메모리 주소를 tail 넣는다.  tail 을 통해 head 바꿀 수 있다.
        }
    }
    
    //MARK: - Append ( adding a value at the end of the list )
    public mutating func append(_ value: Value) { // 1, 2, 3순서.
        copyNodes()
        guard !isEmpty else{ // 연결리스트가 비어있는지 체크 후 비어있다면 push 메소드 실행. 첫 번째 노드 추가하는 것 동일
            push(value)
            return
        }
        // 자 여기서 부터는 두 번째 이상 노드를 추가할 때 실행되는 과정.
        tail!.next = Node(value: value) 
        // tail 은 head 와 같은 Node(1,nil) 인스턴스를 참조하고 있음을 유의
        // tail.next 에 새로운 Node 인스턴스 할당 하면 같은 참조정보를 가진 head.next 도 바뀌게 되겠죠?
        tail = tail?.next 
        // tail 이라는 변수에 원래는 head 와 같은 첫 번째 노드 인스턴스의 참조를 가지고 있었지만
        // 새로 들어온 노드 인스턴스의 참조정보 할당해준다. 
        // 그럼 자연스럽게 추가하는 노드를 tail 변수가 참조하게 되고 tail 이 뒷부분을 차지하는 것 처럼 된다.
    }

    //MARK: - Insert ( adding a value at the particular place in the list )
    //Insert 1 - 삽입을 원하는 노드의 위치 ( index ) 찾기
    public func node(at index: Int) -> Node<Value>? { // 매개변수에 원하는 번째 노드 넣으면 노드 반환해줌^^
        var currentNode = head // 탐색하기 전 시작포인트 설정해주기. head 는 연결리스트의 첫 노드! 
        var currentIndex = 0 // 시작 포인트 0 부터!
        
        while currentNode != nil && currentIndex < index { 
            // 헤드노드가 nil 이 아니고 : 빈 노드인지 확인
            // 현재 노드 탐색하고 끝 포인트가 매개변수로 들어온 index 보다 작을 때 까지 무한반복.
            currentNode = currentNode!.next // 현재 노드가 다음 노드가 됨 -> 탐색맞쥬?
            currentIndex += 1 // 인덱스 하나 올라감. -> 하나하나 탐색!
        }
        return currentNode 
        // 반환하는 현재 노드는 매개변수 index 의 값 번째 Node 가 된다.
    }
    
    //Insert 2 - 값을 삽입하기.
    public mutating func insert(_ value: Value, after node: Node<Value>) {
        // 두 번째 매개변수에 먼저 알아낸, 내가 원하는 특정 노드 넣어서 그 뒤에 값 삽입하기.
        guard tail !== node else { 
            // tail 과 node 둘 모두 클래스의 인스턴스라서 참조정보를 가지고 있죠?
            // 그러므로 ==, != 는 할 수 없습니다. 값이 아니라 참조정보를 비교해야 하니까요.
            // ===, !== 를 이용해서 해당 인스턴스를 비교하는 방법을 이용합니다.
            // 내가 넣어준 두 번째 매개변수 node 가 tail 노드라면 append() 쓰면 됩니다.
            append(value)
            return
        }
        node.next = Node(value: value, next: node.next) 
        // 특정 노드의 인스턴스를 알고 있는 상태입니다. (탐색해서 두 번째 매개변수로 넣어주었으니까요.)
        // 그 노드의 다음 노드에 삽입하고자 하는 새로운 노드의 인스턴스 할당합니다.
        // 새로운 노드의 next 는 삽입하기 전 노드의 다음노드를 넣어줍니다. 
        // 이러면 가운데 쏙 들어가게 되겠죠?
        //return node.next!
    }
    
    //MARK: - Pop
    public mutating func pop() -> Value? { // 제거할 맨 앞의 노드 반환하고, 그 노드 없애서 제거 구현!
        defer{ // 삭제하기 전에, 데이터가 남아있을 때 삭제할 노드 반환해줘야 겠죠? 그러므로 defer 
               // 노파심에.. defer 는 함수에서 제일 나중에 실행되게 만드는 키워드 입니다.
            head = head?.next 
            // 현재의 head 를 제거할 목적이니까 현재의 head 에 다음 노드를 넣어줍니다. head 를 옮기는 과정인 것이죠.
            // 헤드 노드는 모든 참조가 떨어지므로 ARC 에 의해 참조 해제된다.
            // 스위프트는 메모리를 헤제하는 과정을 자동으로 해줍니다 . 그것이 Automatic Reference Counting 임
            if isEmpty { 
                tail = nil // 모두 제거 했다면 tail 도 메모리 필요 없으니 nil 할당해서 비워줍니다.
            }
        }
        return head?.value // 여기서 반환하는 값은 삭제되기 전 헤드노드의 값. defer 가 맨 나중에 실행하므로.
    }
    
    //MARK: - Remove Last
    public mutating func removeLast() -> Value? { 
        guard let head = head else { 
            // 현재 연결리스트의 head 가 nil 인지 확인 : 빈 리스트 인지 확인하는 것,.
            return nil // 빈 리스트면 nil 반환
        }
        guard head.next != nil else {// 노드가 하나 뿐이라면 
            return pop() // 마지막 노드를 제거하든, pop() 하든 똑같쥬? pop() 으로 실행함.
        }
        var prev = head // 마지막 노드의 이전노드를 찾아야 해! 그 이전노드를 prev 라고 하자!
        var current = head // 탐색 시작할 현재노드.
        
        while let next = current.next { // 현재 노드의 다음 노드가 nil 이 아니면 계속 반복.
            prev = current
            current = next // 마지막 반복에서 current 는 제일 마지막 노드가 되겠쥬? 그럼 prev 는 이전노드.
        }
        prev.next = nil // 마지막 노드의 이전 노드가 마지막이 되도록 next 에 nil 할당.
        tail = prev // 현재 연결리스트 인스턴스의 tail 이 그 이전노드로 변화되죠?
        return current.value // 탐색했던 마지막 노드를 제거한 것이니 반환.
    }
    
    //MARK: - Removing a particular node
    public mutating func remove(after node: Node<Value>) -> Value? {
        // 매개변수에는 내 맘대로 특정 리스트의 특정 노드를 넣으면 된다.
        // insert 할 때 특정 인덱스의 노드 반환받는 메소드를 사용하면 되겠쥬?
        defer { // 제거할 값 먼저 반환하고 제거 수행하려고 defer 씁니다.
            if node.next === tail { // node 가 tail 의 이전 노드이면.
                tail = node // tail 에 node 할당하면 그냥 끝나쥬?
            }
            node.next = node.next?.next 
            // 가운데 에 있는 노드 제거하려면. next 가 바뀌게 되쥬? 중간에 구멍 뚫리는 거니까요.
            // 마지막 노드의 이전노드라서 tail 을 변경해 주는 경우에도 next 에 nil 이 할당되니까. 문제없이 실행되쥬.
        }
        return node.next?.value
    }
    
    private mutating func copyNodes(){
        guard !isKnownUniquelyReferenced(&head) else {
            return
        }
        guard var oldNode = head else {
            return
        }
        head = Node(value: oldNode.value)
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode?.next = Node(value: nextOldNode.value)
            newNode = newNode?.next
            
            oldNode = nextOldNode
        }
        tail = newNode 
    }
    
}
/*
 1. 전체 연결리스트를 manage 하는 구조체 LinkedList, class 가 아닌 struct 로 작성한 이유? : 
 */

extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        guard let head = head else {
            return "Empty List"
        }
        return String(describing: head)
    }
}

extension LinkedList: Collection { // Collection 프로토콜을 채택하게 하는 extension
    
    public struct Index: Comparable { 
        // Comparable 프로토콜을 채택하는 구조체
        // 지금 LinkedList 구조체 안에 새로운 구조체 Index 가 있는 상황임. 이렇게 쓸 수 있어? 어떻게 쓰지.
        // 커스텀 인덱스를 여기에 왜 정의하는건지.. 구조체 아래에 새로운 구조체를 정의할 수 있는건지 모르겠네.
        
        public var  node: Node<Value>?
        
        static public func ==(lhs: Index, rhs: Index) -> Bool { 
            // Index 라는 구조체의 타입 메소드 ==
            // 연결리스트의 Comparable 할 수 있는 
            
            switch (lhs.node, rhs.node) {
            case let(left?, right?):
                return left.next === right.next
            case (nil,nil):
                return true
            default:
                return false
            }
        } 
        
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node, next: {$0?.next})
            return nodes.contains { $0 === rhs.node }
        }
        
    }
    // Collection 프로토콜에서 필요한 것들.
    // 이런게 다 Array 에도 정의 되있는 거임.
    public var startIndex: Index {
        return Index(node: head)
    }
    public var endIndex: Index {
        return Index(node: tail?.next)
    }
    public func index(after i: Index) -> Index {
        return Index(node: i.node?.next)
    }
    public subscript(position: Index) -> Value {
        return position.node!.value
    }
 }
