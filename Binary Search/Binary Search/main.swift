
import Foundation


var array = [2,3,4,5,6,7,8,9,10,11,12]
print(" 프로토콜 지향으로 구현한 이진탐색으로 '값 12' 찾아보기 : \(array.binarySearch(for: 12)!) 번째 인덱스에 있음 ")
print(" 프로토콜 지향으로 구현한 이진탐색으로 '값 13' 찾아보기 : \(array.binarySearch(for: 13)) ")

print(" 범위 정해서 '값 12' 찾아보기 : \(array.binarySearch(for: 12, in: 3..<array.endIndex)!) 번째 인덱스에 있음 ")
print(" 적절하지 않은 범위가 설정되면? '값 12' 찾아보기 : \(array.binarySearch(for: 12, in: 0..<8))  ")

/*
print(" 반복문으로 구현한 이진탐색으로 '값 12' 찾아보기 : \(binarySearch_for(array: array, for: 12)!) 번째 인덱스에 있음 ")
print(" 반복문으로 구현한 이진탐색으로 '값 13' 찾아보기 : \(binarySearch_for(array: array, for: 13)!) ")
print("\n")
print(" 재귀호출로 구현한 이진탐색으로 '값 10' 찾아보기 : \(binarySearch_recur(array: array, for: 10)!) 번째 인덱스에 있음 ")
print(" 재귀호출로 구현한 이진탐색으로 '값 13' 찾아보기 : \(binarySearch_recur(array: array, for: 13)!) ")
*/

