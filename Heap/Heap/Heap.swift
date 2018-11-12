
struct Heap<Element: Comparable> { // 값에 Comparable 프로토콜 채택하게한 건 sort 에 <,> 넣을 거라서
    
    var elements: [Element] = [] // 배열로 구현할거야.  트리는 O(log n) / 배열은 O(1) random access
    let sort: (Element, Element) -> Bool // 함수 타입의 상수가 있음.
    
    init(sort: @escaping (Element,Element) -> Bool, elements: [Element] = []) { 
        // sort 에 < , > 넣는거 개꿀이네?
        // @escaping 키워드는 
        self.sort = sort
        self.elements = elements
        
        if !elements.isEmpty {
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1){
                // 랜덤한 배열을 Heap 구조로 바꿈
                siftDown(from: i)
            }
        }
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    func peek() -> Element? {
        return elements.first
    }
    
    func leftChildIndex(ofParentAt index: Int) -> Int {
        return 2*index + 1
    }
    
    func rightChildIndex(ofParentAt index: Int) -> Int {
        return 2*index + 2
    }
    
    func parentIndex(ofChildAt index: Int) -> Int {
        return (index - 1) / 2
    }
    
    //MARK: - 루트노드 제거
    // swap 은 O(1) 이고 sifhDown 은 O(log n) 이라서 전체 시간복잡도 O(log n)
    mutating func remove() -> Element? { 
        guard !isEmpty else { // 비어있지 않으면 삭제 연산 진행할것
            return nil
        }
        elements.swapAt(0, count - 1) // Array 의 swapAt 메소드 활용 
        defer { 
            // defer 키워드는 { } 실행구문 안의 로직을 가장 마지막에 실행하도록 순서를 보장해주는 역할
            // 어디 위치에 있어서 실행 순서는 가장 마지막.
            siftDown(from: 0) // 루트노드 sift Down 
        }
        return elements.removeLast() // 삭제할 노드 삭제후 반환하기.
    }
    
    mutating func siftDown(from index: Int) {
        // 이 메소드가 실행될 시점에선 배열의 가장 크거나 작은 놈이 루트노드가 되어있는 시점임.
        var parent = index
        
        while true {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            // left, right 가 parent 가 변함에 따라 변하니까 var 라고 하기 쉬운데 while 의 { } 입장에서는 변하지 않는 값이므로 let 임을 유의
            
            var candidate = parent // 탐색할 아이 지정
            if left < count , sort(elements[left], elements[candidate]) {
                // 왼쪽 자식노드가 있고, 그 자식노드 값이 부모노드 값보다 크다면
                candidate = left
            }
            if right < count , sort(elements[right], elements[candidate]) {
                candidate = right
            }
            if candidate == parent {  // 종료조건
                // return 만날때까지 무한반복, 위의 조건에 부합하지 않는 순서일 때 return 하는 것.
                return
            }
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
    //MARK: - 새로운 노드 삽입하기
    // append 는 O(1), siftUp 은 O(log n) 이므로 전체 효율은 O(log n)
    mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
        
    }
    
    mutating func siftUp(from index: Int) {
        var child = index // 마지막 인덱스
        
        while true {
            let parent = parentIndex(ofChildAt: child) 
            
            if child > 0 && sort(elements[child], elements[parent]) { // > 이니까
                elements.swapAt(child, parent)
                child = parent
            }else {
                return
            }
        }
        /* // 이렇게도 작성할 수 있음.
        var parent = parentIndex(ofChildAt: child)
        while child > 0 && sort(elements[child], elements[parent]) {
            
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }*/
    }
    
    //MARK: - 임의의 노드 제거하기
    mutating func remove(at index: Int) -> Element? {
        guard index < elements.count else {  return nil } 
        // 위에 정의한 count 를 쓰지않은 이유는 count 는 Heap 인스턴스에서 count를 알려고 하는 거고 
        // 인스턴스의 메소드가 실행될떄마다 값이 바뀔 가능성 있음.
        
        if index == elements.count - 1 {
            return elements.removeLast()
        }else {
            elements.swapAt(index, elements.count-1) // 제거하려는 값은 맨 뒤로 보내기~
            siftDown(from: index) // index 자리 기준으로 아랫쪽 재정렬
            siftUp(from: index) // index 자리 기준으로 위쪽 재정렬
        }
        return elements.removeLast() 
    }
    
    //MARK: - 값 검색하기
    // 모든 노드 한번씩 탐색해야 하기 때문에 O(n) 최악
    // 탐색 메소드는 트리는 O(log n) 임. 배열이 더 안좋아.
    func index(of element: Element, startingAt i:Int) -> Int? {
        // 값, 시작 인덱스를 주고 , 값에 해당하는 인덱스 있으면 인덱스 반환 , 없으면 nil 
        // 모든 경우의 수 다 생각해야함 ㅠㅠ. 극혐
        if i >= count {
            return nil
        }
        if sort(element, elements[i]) {
            // max heap 이면 > , min heap 이면 <  인데
            // > 이면 elements[i] 이 max 인데 찾고자 하는 element 가 더 크므로 범위 초과
            // < 이면 elements[i] 이 min 인데 찾고자 하는 element 가 더 작으므로 범위 초과
            return nil 
        }
        if element == elements[i] { // 값 찾았을 때
            return i
        }
        if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
            // 왼쪽으로 재귀호출 이진 트리 탐색이랑 원리가 같음.
            return j
        }
        if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
            // 오른쪽으로 재귀호출
            return j
        }
        return nil
    }
}


