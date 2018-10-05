import Foundation

public func factorial_for(n:Int) -> Int {
    var result = 1
    for i in 0 ..< n { // 범위를 굳이 0 부터 한 이유는 0! = 1 이기 때문입니다.
        result = result * (i+1)
    }
    return result
}
// n 개의 티셔츠 중 k 개의 티셔츠를 고를 수 있는 가지수 는 n! / k! * (n-k)! 인데
// n 과 k 가 같은값, 즉 3 라고 한다면 3! / 3! * 0! 이 1이 나와야 하기 때문에 

public func factorial_recur(n:Int) -> Int {
    if n == 0 { // 요구사항2. 종료조건이면서, 0! 은 1 인 것을 만족시켜줌.
        return 1
    }
    return n * factorial_recur(n: n-1) // 재귀호출.
    // 요구사항 1. 문제의 크기가 작은 방향으로 이동해서 작은것 먼저 해결 (n-1 이므로 1씩 작아지죠?)
}
