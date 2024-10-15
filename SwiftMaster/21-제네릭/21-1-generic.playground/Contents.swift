import UIKit

/*:
 # Part21 - 제네릭(Generics)
 */
/*:
 ## 제네릭 문법
 * 제네릭(Generics) 문법이 왜 필요한가?
 ---
 */
// 제네릭이라는 문법의 필요성 알아보기

// 정수 2개

var num1 = 10
var num2 = 20



// 🍑 inout 키워드 : 변수의 주소를 전달해 두 변수가 서로 교환될 수 있게 해주는 키워드 -> 함수 마지막 부분에서 배웠었음
// 두 숫자를 스왑(서로 교환)하는 함수의 정의
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}


// 🍑 inout 키워드 -> 사용시 반드시 & 붙여서 사용해야함
// 위에서 정의한 함수의 실행
swapTwoInts(&num1, &num2)

print(num1)
print(num2)



// 만약, Double을 교환하고 싶다면?, String을 교환하고 싶다면?


// Double을 스왑하는 함수의 정의

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let tempA = a
    a = b
    b = tempA
}



// (정수가 아닌) 문자열을 스왑하는 함수의 정의

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let tempA = a
    a = b
    b = tempA
}

/**======================================================================
 - 제네릭이 없다면, 함수(클래스, 구조체, 열거형 등)타입마다 모든 경우를 다 정의해야 하기 때문에
 - 개발자의 할일이 늘어난다. (유지보수/재사용성 관점에서 어려움)
=========================================================================**/


//:> 또다른 예시
// 배열을 가지고
let numbers = [2, 3, 4, 5]
let scores = [3.0, 3.3, 2.4, 4.0, 3.5]
let people = ["Jobs", "Cook", "Musk"]



// 출력하는 함수 만들기 ===> 각 케이스(타입)마다 필요한 함수를 만들어야함
func printIntArray(array: [Int]) {
    for number in array {
        print(number)
    }
}


func printDoubleArray(array: [Double]) {
    for number in array {
        print(number)
    }
}


func printStringArray(array: [String]) {
    for number in array {
        print(number)
    }
}


printIntArray(array: numbers)
printDoubleArray(array: scores)
printStringArray(array: people)



// 따지고 보면 기능은 똑같은데..
// 타입이 다르다는 이유로 여러개의 함수를 만드는 것이 비효율적이라는 것



/*:
 ---
 * 제네릭(Generics)의 개념이 없다면, 함수를 모든 경우마다 다시 정의해야 한다.
 ---
 */
/**===================================================================================
 - 제네릭 문법
 - 형식에 관계없이, 한번의 구현으로 모든 타입을 처리하여, 타입에 유연한 함수 작성가능 (유지보수/재사용성 증가)
 - (함수 뿐만아니라) 구조체 / 클래스 / 열거형도 제네릭으로 일반화 가능


 - 타입 파라미터는 함수 내부에서 파라미터 형식이나 리턴형으로 사용됨 (함수 바디에서 사용하는 것도 가능)
 - 보통은 T를 사용하지만 다른 이름을 사용하는 것도 문제가 없음, 형식이름이기 때문에 UpperCamelcase로 선언
 - 2개이상을 선언하는 것도 가능


 - 제네릭은 타입에 관계없이, 하나의 정의(구현)로 모든 타입(자료형)을 처리할 수 있는 문법
 - 제네릭 함수, 제네릭 구조체/클래스
 - 일반 함수와 비교해보면, 작성해야하는 코드의 양이 비약적으로 감소


 - 타입 파라미터는 실제 자료형으로 대체되는 플레이스 홀더(어떤 기호같은것) ===> 새로운 형식이 생성되는 것이 아님
 - 코드가 실행될때 문맥에 따라서 실제 형식으로 대체되는 "플레이스 홀더"일뿐
======================================================================================**/



/*:
 ## 제네릭 함수의 정의
 * 제네릭(Generics) 함수를 정의하는 방법
 ---
 */
/**================================================================================
 - 타입 파라미터<T>는 함수 내부에서 파라미터의 타입이나 리턴형으로 사용됨 (함수 바디에서 사용하는 것도 가능)
 - (1) 관습적으로 Type(타입)의 의미인 대문자 T를 사용하지만,
       다른 문자를 사용해도 됨 <U> <A> <B> <Anything> (Upper camel case사용해야함)
 - (2) <T, U> <A, B> 이렇게 타입파라미터를 2개이상도 선언 가능
 ==================================================================================**/


// 파라미터의 타입에 구애받지 않는 일반적인(제네릭) 타입을 정의
                //<🍑>          🍑            🍑 -> 대문자로 시작하는 문자(열) 아무거나 사용하면 됨
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {      // 플레이스홀더의 역할(표시 역할일뿐) (같은 타입이어야함)
    let tempA = a
    a = b
    b = tempA
}

// 🍑 두개의 타입 사용시 이렇게 두개 구현
func swapTwoValues<T, A>(_ a: inout T, _ b: inout A) {      // 플레이스홀더의 역할(표시 역할일뿐) (같은 타입이어야함)
        // 함수 구현..
}



var string1 = "hello"
var string2 = "world"



// 제네릭으로 정의한 함수 사용해보기

swapTwoValues(&string1, &string2)     // 같은 타입이라면, 어떠한 값도 전달 가능 해짐
print(string1)
print(string2)





// 배열을 출력하는 예제

func printArray<T>(array: [T]) {
    for element in array {
        print(element)
    }
}


printArray(array: numbers)     // 플레이스홀더 ====> [Int]
printArray(array: scores)      // 플레이스홀더 ====> [Double]
printArray(array: people)      // 플레이스홀더 ====> [String]




/*:
 ---
 * 제네릭의 사용예시 - 스위프트 문법
 ---
 */
// 스위프트에서 컬렉션은 모두 구조체의 제네릭 타입으로 구현되어 있음


// 배열 타입
let array1: [String] = ["Steve", "Allen"] // 🍑 배열의 단축 문법
let array2: Array<String> = ["Cook", "Musk"]      // 실제 컴파일시 내부에서 일어나는 일 // 🍑 배열의 정식 문법



// 딕셔너리 타입
let dictType1: [String: Int] = ["Steve": 20, "Paul": 24]
let dictType2: Dictionary<String, Int> = ["Alex": 25, "Michel": 18]


// 옵셔널 타입
var optionalType1: String?
var optionalType2: Optional<String>



// 실제로 스위프트 내부 구현에는 제네릭을 많이 사용
// (이제 볼 줄 알게됨)

//swap(<#T##a: &T##T#>, <#T##b: &T##T#>)


// 🍑[1, 2, 3].map(<#T##transform: (Int) throws -> T##(Int) throws -> T#>) 여기서 이 T가 제네릭임

//Copyright (c) 2021 we.love.code.allen@gmail.com
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
//distribute, sublicense, create a derivative work, and/or sell copies of the
//Software in any work that is designed, intended, or marketed for pedagogical or
//instructional purposes related to programming, coding, application development,
//or information technology.  Permission for such use, copying, modification,
//merger, publication, distribution, sublicensing, creation of derivative works,
//or sale is expressly withheld.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

