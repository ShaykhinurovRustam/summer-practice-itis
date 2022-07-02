import UIKit

protocol HomeworkService {
    func divideWithRemainder(_ x: Int, by y: Int) -> (Int, Int)
    func fibonacci(n: Int) -> [Int]
    func sort(rawArray: [Int]) -> [Int]
    func firstLetter(strings: [String]) -> [Character]
    func filter(array: [Int], condition: ((Int) -> Bool)) -> [Int]
}

struct Services: HomeworkService {
    func divideWithRemainder(_ x: Int, by y: Int) -> (Int, Int) {
        return (x / y, x % y)
    }
    
    func fibonacci(n: Int) -> [Int] {
        if n == 1 {
            return [0]
        } else if n == 2 {
            return [0, 1]
        }

        var fibonacciSequence: [Int] = fibonacci(n: n - 1)
        let l = fibonacciSequence.count

        fibonacciSequence.append(fibonacciSequence[l-1] + fibonacciSequence[l-2])
        return fibonacciSequence
    }

    func sort(rawArray: [Int]) -> [Int] {
        var temp: Int = .min
        var rawArray = rawArray
        for i in 0...rawArray.count - 2 {
            for j in 0...rawArray.count - i - 2 {
                if rawArray[j] > rawArray[j + 1] {
                    temp = rawArray[j]
                    rawArray[j] = rawArray[j + 1]
                    rawArray[j + 1] = temp
                }
            }
        }
        return rawArray;
    }

    func firstLetter(strings: [String]) -> [Character] {
        var firstLetterArr = [Character]()
        for string in strings {
            if let elem = string.first {
                firstLetterArr.append(elem)
            }
        }
        return firstLetterArr
    }

    func filter(array: [Int], condition: ((Int) -> Bool)) -> [Int] {
        var filteredArray = [Int]()
        for element in array {
            if condition(element) {
                filteredArray.append(element)
            }
        }
        return filteredArray
    }

}

let service: Services = Services.init()

print(service.divideWithRemainder(11, by: 6), " ", service.divideWithRemainder(10, by: 5))

print(service.fibonacci(n: 22))

print(service.sort(rawArray: [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]))

print(service.firstLetter(strings: ["abc", "def"]))

let compare: (Int) -> Bool = {x in return x > 3}
print(service.filter(array: [1, 2, 3, 4, 5], condition: compare))

