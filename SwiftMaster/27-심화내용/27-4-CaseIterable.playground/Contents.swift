import UIKit

/*:
 ## CaseIterable 프로토콜
 * Enum타입에서 사용할 수 있는 CaseIterable (Swift 5.2 ~ )
 ---
 */
// Iterable: 영어의 뜻 ==> 반복가능한
/**=================================================================
 - 열거형에서 CaseIterable 프로토콜을 채택하면 타입 계산 속성이 자동으로 구현됨
 - static var allCases: Self.AllCases { get }

 - 이 "타입 계산속성"을 컴파일러가 자동으로 구현 제공 ====> 모든 케이스를 (정의한 순서대로) 포함한 배열을 리턴
 - 연관값(associated value)이 없는 경우에만 채택 가능 (원시값은 상관없음)
=====================================================================**/


enum Color: CaseIterable {  // Int
    case red, green, blue
}



//var color = Color.red // 🍑 열거형은 이렇게 붕어빵 찍어낼 수 있음
//color = .blue
//color = .green



Color.allCases     // [Color.red, Color.green, Color.blue]
// 🍑 allCases는 타입 속성임, 열거형의 모든 케이스를 배열에 담아 리턴 / CaseIterable 채택해서 사용가능해진거임
print(Color.allCases)




//var color2 = Color(rawValue: 0)
//color2 = Color(rawValue: Int.random(in: 0...Color.allCases.count))

/*:
 ---
 * 배열의 장점을 사용해 여러가지 편의적 기능 활용 가능
 ---
 */
// 손쉽게 반복문 사용 가능
for color in Color.allCases {
    print("\(color)")
}


// 필요로 하는 곳에서 선언도 간단하게
struct SomeView {
    //let colors: [Color] = [Color.red, Color.green, Color.blue]
    // 🍑 위처럼 안하고 아래처럼 가능해짐, 나중에 케이스 추가되도 일일이 추가해줄 필요 없음
    let colors = Color.allCases
}



// 공식문서의 예제

enum CompassDirection: CaseIterable {
    case north, south, east, west
}

// 1) 케이스의 갯수를 세기 편해짐 (케이스를 늘려도 코드 고칠 필요 없음)
print("방향은 \(CompassDirection.allCases.count)가지")


// 2) 배열 ===> 고차함수 이용 가능

let caseList = CompassDirection.allCases
                               .map({ "\($0)" }) // 🍑 문자열로 변환하는 중
                               .joined(separator: ", ")  // 배열 ===> 문자열화
// "north, south, east, west"


// 랜덤 케이스를 뽑아낼 수 있음

let randomValue = CompassDirection.allCases.randomElement()






/*:
 ---
 * 열거형 단원에서 다뤘던 원시값(Raw Value)를 이용한 케이스
 ---
 */
// 가위바위보 케이스

enum RpsGame: Int, CaseIterable {
    case rock = 0
    case paper = 1
    case scissors = 2
}


let number = Int.random(in: 0...100) % 3    // 3을 조금 더 멋지게 처리할 수 있는 것은 고급내용에서 다룸

let number2 = Int.random(in: 0...100) % RpsGame.allCases.count    // 나머지를 구하는 것이니 무조건 0, 1, 2 중에 한가지임


print(RpsGame.init(rawValue: number)!)

// 🍑 이제는 위처럼 하지 않아도됨, 아래처럼 가능

RpsGame.allCases.randomElement()




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
