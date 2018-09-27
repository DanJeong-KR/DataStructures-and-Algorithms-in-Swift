
import Foundation

public class TreeNode<T> {
    public var value: T // 노드가 가지고 있는 값
    public var children = Array<TreeNode>() // 자식 노드가 없을 수도 많을 수도 있으니 배열로 만들자.
    public init(_ value:T){
        self.value = value // 값으로 초기화 하기.
    }
    
    public func add(_ child: TreeNode) { // 노드에 자식노드 추가하기.
        children.append(child)  
    }
    
}


extension TreeNode { // 깊이 우선 탐색.
    
    public func forEachDepthFirst(visit:(TreeNode) -> Void) {
        visit(self)
        // 입력 매개변수로 클로저가 들어올거야. 위에서 호출할 때 먼저 보여줬지?
        // 들어온 클로저의 매개변수에 self 를 넣은 뒤 실행시키는 거야.
        // 여기서 self 는 현재 이 메소드가 호출될 당시의 TreeNode(self)의 인스턴스야.
        // 호출할 때 클로저에 { print($0.value) } 이렇게 넣었었지?
        // 적용하면 클로저에서 $0 은 첫 매개변수를 뜻하므로 self 인 상수 tree 에 있는 TreeNode 인스턴스 인 것이지.
        // 그러므로 print(tree.value) 가 되겠지? 그래서 첫 번째 출력이 beverage
        
        children.forEach { 
        // 배열의 forEach 메소드 사용
        // forEach 는 배열의 각각 요소에서 클로저에 들어온 실행을 하라는 의미.
            $0.forEachDepthFirst(visit: visit) 
            // 요 부분에서 재귀호출 사용하는거야. 재귀호출 : 자기가 자기 자신을 호출하는 것.
            // beverage 자식노드 hot, cold 잖아 . hot, cold 에서 다시 forEachDepthFirst 메소드를 실행하는 거야.
            // 
        }
    }
    
    public func forEachDepthFirst_for(visit: (TreeNode) -> Void) {
        visit(self)
        // 입력받는 클로저의 매개변수에 self (현재의 TreeNode 인스턴스.)
        
        for child in children {
            child.forEachDepthFirst(visit: visit)
        }
    }
    
    
    public func forEachDepthFirst_good() {
        print(self.value)
        
        for child in children {
            child.forEachDepthFirst_good()
        }
    }
}

extension TreeNode {
    public func forEachLevelOrder(visit: (TreeNode) -> Void ){
        visit(self) // 루트 노트는 방문했어.
        var queue = Queue<TreeNode>() 
        // TreeNode 객체를 Queue 방식으로 저장할거야.
        // 제네릭으로 정의되 있는 Queue를 TreeNode 타입을 지정해서 인스턴스 생성한 거야.
        children.forEach { // 자식노드 부터 시작이야.
            queue.enqueue($0) // 큐에 자식노드 두 개 먼저 저장.
        }
        while let node = queue.dequeue() { 
            // 큐가 비어있지 않은 이상 계속 반복됨 
            // dequeue() 한 후에는 반환된 값은 큐에서 지워짐을 유의해!
            // 반환된 값이 큐에서 없어지니까 다음 큐의 dequeue() 가 let node 에 할당되서 반복이 진행되는거야.
            visit(node) // 현재 노드 방문해 주고.
            node.children.forEach { 
                // 현재 노드의 자식노드들 큐에 넣어 줘야 레벨 순서대로 나중에 visit 할 수 있어!
                queue.enqueue($0)
            }
        }
    }
    public func forEachLevelOrder_good(){
        print(self.value)
        var queue = Queue<TreeNode>() 
        children.forEach { 
            queue.enqueue($0) 
        }
        while let node = queue.dequeue() { 
            print(node.value)
            node.children.forEach { 
                queue.enqueue($0)
            }
        }
    }
}

extension TreeNode where T: Equatable { 
    // generic 타입의 범위를 where 키워드를 사용해서 제한할 수 있어.
    // 더 궁금하면 링크 걸어준 곳으로 가봐!
    public func search(_ value: T) -> TreeNode? {
        // 매개변수에는 트리에서 찾고자 하는 노드의 값입력 받고, 찾으면 해당 노드 반환해줌.
        var result: TreeNode? // 반환값으로 사용할 result
        forEachDepthFirst { node in 
            // forEachLevelOrder 을 사용해도 무방합니다. 어떤 방식으로 해도 모든 노드를 검사하기 때문에.
            if node.value == value {
                result = node
            } // 찾고자 하는 노드가 검사하는 노드의 값과 일치하는지 확인함.
        }
        return result // 찾으면 해당 노드 반환하고 못찾으면 nil 반환.
    }
}

