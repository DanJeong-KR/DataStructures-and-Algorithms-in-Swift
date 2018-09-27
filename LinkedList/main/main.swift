import Foundation


example(of: "creating and linking nodes") {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)
    
    node1.next = node2
    node2.next = node3
    
    print(node1)
}

example(of: "push") { // 처음이라 각 단계마다 자세하게 설명합니다. 여기서 놓치면 뒤에 어려워요! 잘 따라오세요
    var list = LinkedList<Int>()
    list.push(3) 
    // value = 3 인 노드의 참조정보가 list.head 에 할당되고, tail == nil 이므로 tail 에 head 의 참조정보가 할당됩니다.
    // 현재 value 3 , next nil 이고 head 와 tail 은 위치가 같습니다.
    list.push(2) 
    // value = 2 인 노드의 참조정보가 list.head 에 할당되고 tail 은 nil 이 아니므로 새로 값이 설정되지 않는다. 
    // 현재 value 2 , next 에는 이전 단계의 head 인 value 3 노드의 참조정보가 들어있겠죠? 
    // tail 은 변함이 없으므로 그대로 value 3 인 노드의 참조정보가 있습니다.
    // 즉 ! 새로운 노드가 앞으로 가고, tail 노드는 가만있으면 자동으로 뒤로 가게 되니까 push 과정이 일어난 것이죠.
    list.push(1) // 마찬가지..^^
    print(list)
}

example(of: "append") {
    var list = LinkedList<Int>()
    list.append(1) // 첫 노드니까 push(1) 과 동일한 과정이 실행되겠죠?
    list.append(2) // 여기서 부터 긴장
    // 두 번째 노드(값이 2) 가 추가됩니다. tail.next = Node(2) 가 실행되겠죠?
    // tail.next 는 tail 에 있는 참조정보를 이용해서 next 에 접근하는 것이죠? 
    // 그 곳에 Node(2) 라는 새로운 노드 인스턴스를 할당합니다.
    // 현재 상태는 tail.next와 head.next 둘 다 Node(2) 를 가리키는 상태입니다.
    // tail 과  head 가 같은 Node(1) 을 가리키고 있었기 때문에 tail 로 접근해도 head 도 같이 바뀝니다. (참조의 특성이죠?)
    // tail = tail.next 가 실행됩니다.
    // 원래는 tail 과 head 가 같은 Node(1) 의 참조정보 가지고 있었는데 tail 에 tail.next 에 있는 Node(2) 의 참조정보 할당합니다.
    // 이로써 head 는 앞에꺼!, tail 은 뒤에 노드의 참조정보를 따로 가지게 되는 것이죠.
    // 이러면 연결리스트의 뒤에 추가 되고 append 과정이 수행되는 것입니다.
    list.append(3) // 마찬가지
    print(list)
}


example(of: "insert at a particular index"){
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1) // 1, 2, 3 인 연결리스트
    
    print(" 삽입 전 리스트 \(list)")
    list.insert(-1, after: list.node(at: 1)!) // 인덱스 1 번째 노드 (컴퓨터에선 2번째 겠죠?) 뒤에 -1 삽입
    print(" 삽입 후 리스트 \(list)")
}

example(of: "pop") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)// 1, 2, 3 인 연결리스트
    
    print("pop 전 리스트 \(list)")
    let poppedValue = list.pop() 
    // 제거할 값 반환받은거 poppedValue 에 먼저 저장한 후, 노드 제거를 수행합니다. (defer 썻었죠?)
    print("pop 된 value = \(poppedValue)")
    print("pop 후 리스트 \(list)")
}

example(of: "removing the last node") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1) // 1, 2, 3 연결리스트
    
    print("Before removing last node: \(list)")
    let removedValue = list.removeLast() // 제거한 노드 출력하기 위해.
    print("after removing last node: \(list)")
    print("Removed value \(removedValue!) " )
}

example(of: "removing a node after a particular node") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1) // 1, 2, 3 인 연결리스트
    
    print("Before removing at particular index: \(list)")
    //let index = 1
    let node = list.node(at: 0)
    let removedValue = list.remove(after: node!)
    print("After removing at index \(0): \(list)")
    print("Removed value : " + String(describing: removedValue!))
}

example(of: "using collection") {
    var list = LinkedList<Int>()
    for i in 0...9 {
        list.append(i)
    }
    print("List: \(list)")
    print("First element: \(list[list.startIndex])")
    print("Array Containing first 3 elements: \(Array(list.prefix(3)))")
    print("Array Containing last 3 elements: \(Array(list.suffix(3)))")
    
    let sum = list.reduce(0, +) // reduce 메소드 모르겠음.
    
    
    print(sum)
}

example(of: "LinkedList COW") {
    var list1 = LinkedList<Int>()
    list1.append(1)
    list1.append(2)
    var list2 = list1
    // 인스턴스 는 값으로 복사되서 전달되는데
    // 내부적으로 복사된 head, tail 이 값이 아닌 '참조 정보' 가 복사되므로 같은 것을 가리킴.
    list2.append(3) 
    // list2 라는 list1 과는 다른 인스턴스에 접근해서 head, tail 을 수정하지만
    // head, tail 이 저장하고 있는 것은 연결리스트의 노드의 '참조정보' 이기 때문에 
    // list1, list2 두 인스턴스 모두 변경된다.
    print(list1)
    print(list2)
}

example(of: "test") {
    var list1 = LinkedList<Int>()
    (1...3).forEach { list1.append($0)}
    var list2 = list1
    
    list2.push(0)
    
    print(list1)
    print(list2)
}

var list = LinkedList<Int>()
list.append(1)
list.append(2)
list.append(3)
list.append(4)

private func printInReverse<T>(_ node: Node<T>?) {
    guard let node = node else{ // 들어온 node 가 nil 인지 체크. 마지막 노드면 중지.
        return
    }
    printInReverse(node.next)
    print(node.value)
}

func printInReverse<Int>(_ list: LinkedList<Int>) {
    printInReverse(list.head)
    /*
     var reverseValue = Array<Int>()
     
     var currentNode = list.head
     while currentNode?.next != nil {
     reverseValue.append(currentNode!.value)
     currentNode = currentNode!.next
     }
     reverseValue.append(list.tail!.value)
     
     reverseValue.reverse()
     for i in reverseValue {
     print(i)
     }
     */
    
}

printInReverse(list)
