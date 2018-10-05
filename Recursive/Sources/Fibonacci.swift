
import Foundation
public func fibonacci_recur(n: Int) -> Int { 
    if n == 0 || n == 1 { //종료조건
        return n
    }else {
        return fibonacci_recur(n: n-1) + fibonacci_recur(n: n-2) // 요구사항 2. n 감소
    }
}

public func fibonacci_for(n: Int) -> Int {
    if n == 1 || n == 0 {
        return n
    }else {
        var result = 0
        var a = 0
        var b = 1
        for _ in 2...n {
            result = a + b
            a = b
            b = result
        }
        return result // a + b
    }
}

public func fibonacci_for_array(n: Int) -> Int {
    var fibo:[Int] = [0 , 1]
    if n == 0 { 
        return fibo[0]
    }
    else if n == 1 { 
        return fibo[1]
    }
    else {
        for i in 2...n {
            fibo.append(fibo[i-1] + fibo[i-2])
        }
        return fibo[n]
    }
}


