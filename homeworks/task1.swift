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
        var fibonacciSequence: [Int] = [0]
        var a = 1, b = 1, c = 0, d = n
        while d > 0 {
            fibonacciSequence.append(a)
            c = b
            b += a
            a = c
            d -= 1
        }
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

