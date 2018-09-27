
import Foundation

public struct BinarySearchTree<Element: Comparable> {
    public private(set) var root: BinaryNode<Element>? 
    // private(set) 은 set(write 속성) 은 private 이고 get(read 속성)은 default 인 internal 인 것.
    // get, set 을 나누고 싶을때 () 안에 get, set 넣어줄 수 있어~
    init() {}
    
    //MARK: - Insert 메소드 두개 
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)  
        // 메소드를 호출할 때 쓰는 메소드야. BinarySearchTree의 인스턴스를 통해 호출할 메소드.
        // 구조체 내부에 정의한 root 를 변경하므로 mutating 키워드.
        // from 매개 변수에는 항상 root 노드가 들어간다는 것을 유의.
    }
    // 재귀호출 할거야.
    private func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> { 
        // 빈 노드에 삽입할 가능성 있어서 첫 매개변수 옵셔널 넣어줄게.
        guard let node = node else{ return BinaryNode(value: value)}
        // 이 구문은 두 가지 역할이 있어. 옵셔널 해제, 그리고 해당 위치에 값 삽입.
        // 루트노드가 nil 인 빈 노드라면 루트 노드의 값은 반환값인 삽입하는 BinaryNode 가 되지?
        if value < node.value { // value : 삽입될 노드의 값이 부모노드 보다 작으면 ?
            node.leftChild = insert(from: node.leftChild, value: value) // 왼쪽 노드로 가서 재귀호출.
        }else { // 삽입될 노드의 값이 부모노드와 같거나 그보다 크면?
            node.rightChild = insert(from: node.rightChild, value: value) // 오른쪽 노드로 가서 재귀호출
        }
        return node 
        // 탐색 하다가 자식 노드가 nil 인 삽입할 노드에 도착하면 guard 구문의 return 으로 값이 삽입되
        // 마지막의 return 이랑 guard 의 return 은 다른 함수의 범위에서 반환되는 값이라는게 헷갈릴 수 있어.
        // guard 의 return 은 마지막에 호출된 insert메소드의 return 이고
        // 마지막의 return 은 node 가 nil 이 아닐 때 계속 호출되는 return 이고.
        // 헷갈리면 예를들어 탐색이 많으면 이 커다란 insert 안에 무수히 많은 insert 가 존재하겠지?
        // 삽입하고자 하는 곳 찾아 가야하니까 무수히 많은 insert() 를 호출해서 찾아가잖아.
        // 다 찾았을 때 guard 에 의해 return 이 호출 되는 건 마지막 insert 메소드의 범위에서의 return 인 것이지.
        // 재귀호출에서 이 함수의 범위를 잘 이해해야해. 함수안에서 여러 함수가 호출되니까 이 범위가 헷갈리거든.
        // 마지막 return 은 재귀호출의 특징인 처음 호출한 root노드에 대한 node 가 가장 마지막에 return 하기 때문에 모든 변경사항을 담은 root 노드의 node 가 마지막에 return 하는 거야.
    }
    
    //MARK: - 값 찾기 
    /*
    public func contains(_ value: Element) -> Bool {
        guard let root = root else{ return false } // 빈 노드 
        
        var found = false
        root.traverseInOrder {
            /* 클로져 이기 때문에 이렇게 작성해도 무방해! 헷갈릴까봐 아래처럼 작성한거야
             if $0 == value {
                found = true
             }
            */
            (a) in // 매개변수는 이진노드의 값 (value) 이지? 
            if a == value {
                found = true
            }
        }
        return found
    }
    */ 
    // 위에서 작성한 것은 모든 값을 비교하지만, 그럴 필요없쥬? 오른자식노드는 항상 왼자식노드 보다 크니까!
    // 더 빠르게 실행 가능하겠지?
    public func contains(_ value: Element) -> Bool {
        var current = root 
        
        while let node = current { // current 가 nil 이 아닐 때 까지 반복
            if node.value == value{ // nil 이 아니면 current 노드 검사
                return true
            }
            if value < node.value { // 매개변수 value 가 현재노드 value 보다 작다면 왼쪽이쥬?
                current = current?.leftChild
            } else {
                current = current?.rightChild // 반대면 오른쪽이쥬?
            }
        }
        return false
    }
    
    // 삽입과 마찬가지로 재귀호출
    public mutating func remove(_ value: Element) {
        // 실제로 호출되는 메소드. insert 때 봤쥬? 
        root = remove(node: root, value: value)
    }
    // 삽입과 마찬가지로 재귀호출
    private func remove(node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element>?{
        guard let node = node else { return nil } // 빈 노드에서 제거하면 nil 반환.
        if value == node.value {
            // 요기가 이제 지우는 거야. 3 가지 경우로 나뉘는
            if node.leftChild == nil && node.rightChild == nil { // 1. leaf node 면!
                return nil // 그냥 없애버리면 되므로 nil 반환~
            }
            if node.leftChild == nil { // 2.1 오른쪽노드만 존재할 때
                return node.rightChild // 해당 노드를 지우고 오른쪽 자식노드로 수정되는 거임. 한칸 올라오니까
            }
            if node.rightChild == nil { // 2.2 왼쪽 노드만 존재할 때
                return node.leftChild // 해당 노드를 지우고 왼쪽 자식 노드로 수정되는 거임.
            }
            node.value = node.rightChild!.min.value // 3. 자식 노드가 두개 모두 존재할 때
            // 자식노드 전부 있을 경우 오른노드쪽에서 최소값 구하고 최소값으로 수정.
            node.rightChild = remove(node: node.rightChild, value: node.value)
            // 값은 수정했고 수정한 값 제거하려고 오른쪽을 시작으로 remove 메소드 다시 재귀호출.
            // value 부분을 수정한 값인 node.value 이 들어가 있지? 없애는 값이 node.value 니까~
            // 삭제되는 노드는 leaf 노드가 삭제되는 방식으로 삭제 되겠네. 왼쪽 최소값은 leaf 노드 니까
        } else if value < node.value { // 삽입 할 때랑 같지? 탐색하는 거야.
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        return node
    }
}

extension BinaryNode {
    var min: BinaryNode {
        return leftChild?.min ?? self 
        // leftChild 가 nil 이 아니면 왼쪽 , nil 이면 self.
        // 왼쪽 자식노드가 nil 일 때까지 계속 가다가 nil 이면 그에 해당하는 BinaryNode 인 self 반환. => 최소값 찾는거임
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        guard let root = root else { return "empty tree "} // root 가 옵셔널 이니까.
        return String(describing: root) // BinaryNode 클래스의 description 정의 해 놓아서 이렇게만 해주면댐.
    }
}
