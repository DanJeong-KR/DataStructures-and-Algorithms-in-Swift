import Foundation

public func power_recur(x:Double, n:Int) -> Double {
    if n == 0 { return 1 } // 요구사항 1 -> 종료조건. 
    else if n > 0 { // 양수
        if n % 2 == 0 { return power_recur(x: x, n: n / 2) * power_recur(x: x, n: n / 2) } // 짝수
            // 짝수
            // 요구사항 2 -> 재귀호출의 매개변수에 n / 2 이다. n 이 1 / 2 씩 작아짐.
        else { return x * power_recur(x: x, n: n-1) }
            // 홀수
            // 요구사항 2 -> n - 1 이므로 n 이 -1 씩 작아짐
    }else { return 1 / power_recur(x: x, n: -n) } // 음수 
}

public func power_for(x: Double, n: Int) -> Double { 
    if n == 0 { return 1} // 종료조건
    else{
        var result: Double = 1 
        for _ in 1...n { result = result * x }
        return result
    }
}
