
import Foundation

example(of: "Create a Tree") {
    let tree = TreeNode("Beverages")
    
    let hot = TreeNode("Hot")
    let cold = TreeNode("Cold")
    
    let tea = TreeNode("Tea")
    let coffee = TreeNode("Coffee")
    let cocoa = TreeNode("Cocoa")
    
    let blackTea = TreeNode("black")
    let greenTea = TreeNode("green")
    let chaiTea = TreeNode("chai")
    
    let soda = TreeNode("Soda")
    let milk = TreeNode("Milk")
    
    let gingerAle = TreeNode("ginger ale")
    let bittleLemon = TreeNode("bittle lemon")
    
    tree.add(hot)
    tree.add(cold)
    
    hot.add(tea)
    hot.add(coffee)
    hot.add(cocoa)
    
    cold.add(soda)
    cold.add(milk)
    
    tea.add(blackTea)
    tea.add(greenTea)
    tea.add(chaiTea)
    
    soda.add(gingerAle)
    soda.add(bittleLemon)
    
    

    /*
    tree.forEachDepthFirst {
        a in print(a.value)
    }*/
    /*public func forEachLevelOrder(visit: (TreeNode) -> Void ){
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
     }public func forEachLevelOrder(visit: (TreeNode) -> Void ){
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
    tree.forEachDepthFirst {
        print($0.value)
    }*/
    
    //tree.forEachDepthFirst_good() 
    /*
    tree.forEachLevelOrder {
        print($0.value) 
    }*/
    //tree.forEachLevelOrder_good()
    
    
    
    let test = tree.search("Hot")
    print(test!.value)
}

