
public extension RandomAccessCollection where Element: Comparable {
    // 프로토콜의 extention 을 사용해서 구현한 함수는 이 프로토콜을 채택한 모든 객체가 사용할 수 있어.
    // Comparable 은 Element 가 String 이나 Int 처럼 비교할 수 있는 타입이어야 한다는 뜻.
    func binarySearch(for value: Element, in range: Range<Index>? = nil) -> Index? {
        // 특정 범위에서 찾을때 Range 타입을 사용. 
        // Range 구조체의 제네릭을 이용해서 Index 타입을 설정
        // Index 는 Collection 프로토콜의 index 타입을 말하는 것
        let range = range ?? startIndex..<endIndex 
        // 매개변수가 nil 이면 RandomAccessCollection 을 채택한 타입(배열)의 startIndex, endIndex 로 범위 정해줌.
        guard range.lowerBound < range.upperBound else { return nil } 
        // 0 ..< 4 뒤에께 큰지 체크 하는 동시에 배열에 없는 값 입력시 종료조건.
        // 재귀호출에서 입력값 변화는 range 거든? 찾는 값이 없다면 range 가 작아질 때까지 작아져서 
        // range.lowerBound == range.upperBound 이 되겠지?  종료조건2
        let size = distance(from: range.lowerBound, to: range.upperBound)
        let middle = index(range.lowerBound, offsetBy: size / 2) // 중간 인덱스를 반환해줌
        // index 메소드 : 앞의 매개변수가 Collection 의 시작값.
        // 뒤의 매개변수가 시작으로 부터의 거리. 즉 0부터 시작해서 거리가 3 이면 3, 2부터시작해서 거리가 3 이면 5.
        if self[middle] == value { // 재귀호출 종료조건1
            return middle // 찾으려하는 value 의 인덱스 반환해줌.
        }else if self[middle] > value { // 여기서 self는 RandomAccessCollection 을 채택한 것의 인스턴스.
            return binarySearch(for: value, in: range.lowerBound..<middle) 
            // 왼쪽으로 탐색, range 에 변화를 줌.
        }else {
            return binarySearch(for: value, in: index(after: middle)..<range.upperBound) // 오른쪽
        }
    }
}
// 매개변수는 배열 인스턴스 array 와, 찾고자 하는 값인 value
public func binarySearch_for (array: [Int],for value: Int) -> Int? {
    var startIndex = 0 // 매개변수 배열의 첫 번째 인덱스
    var endIndex = array.count - 1 // 배열의 마지막 인덱스
    // array.endIndex 로 설정하면 안됩니다.
    while startIndex <= endIndex { // 원하는 값 못찾았을 때 종료조건
        let middleIndex = (startIndex + endIndex) / 2 // 중간 인덱스 
        if value == array[middleIndex]{
            return middleIndex // 값 찾았을 때 종료조건
        } else if array[middleIndex] > value { // 왼쪽 탐색
            endIndex = middleIndex - 1 // 뒷쪽 인덱스 값 변화줌.
        } else if array[middleIndex] < value { // 오른쪽 탐색
            startIndex = middleIndex + 1 // 앞쪽 인덱스 값 변화줌
        }
    }
    return -1 // 찾고자 하는 값이 없을 때 while 문이 종료되므로 -1 반환하도록 설정
}
// 매개변수에는 배열과 찾고자하는 값에 더해서 찾으려는 범위까지 입력 가능.
public func binarySearch_recur (array: [Int],
                                for value: Int,
                                startIndex: Int? = nil,
                                endIndex: Int? = nil) -> Int? {
    var startIndex = startIndex ?? 0
    var endIndex = endIndex ?? array.count - 1
    var middleIndex: Int {
        return (startIndex + endIndex) % 2 == 0 ? (startIndex + endIndex) / 2 : (startIndex + endIndex + 1) / 2 
        // 특정 범위를 입력해 주었을 때 두 인덱스의 값이 홀수일 때 인덱스가 하나 작아지므로 바꿔주고
    }
    guard startIndex <= endIndex else { return -1 } // 원하는 값 못찾았을 때 종료조건
    if value == array[middleIndex] { // 원하는 값 찾았을 때 종료조건
        return  middleIndex
    } else if array[middleIndex] > value { // 왼쪽 탐색
        endIndex = middleIndex - 1 // 뒷쪽 인덱스 변화줘서 재귀호출
        // 재구호출은 문제의 범위가 작은 방향으로 이동해야 한다는 원칙이 적용되는 부분
        return binarySearch_recur(array: array, for: value, startIndex: startIndex, endIndex: endIndex)
    } else if array[middleIndex] < value { // 오른쪽 탐색
        startIndex = middleIndex + 1 // 앞쪽 인덱스 변화줘서 재귀호출
        return binarySearch_recur(array: array, for: value, startIndex: startIndex, endIndex: endIndex)
    } else { return -1 }
}

