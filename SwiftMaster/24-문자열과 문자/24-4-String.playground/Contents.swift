import UIKit

/*:
 ## 숫자(정수/실수) 등을 문자열로 변환 출력하려고 할때
 * 변수/표현식 등을 포함, 반올림의 구현
 ---
 */
// 단순 출력

var pi = 3.1415926
print("원하는 숫자는 \(pi)")



// 실제 앱 구현시, 반올림등을 상황이 자주 발생
// "원하는 숫자는 3.14" 라고 출력해야하는 경우 ⭐️



/*:
 ---
 * 출력 형식 지정자(Format Specifiers)
 ---
 */
// 문자열 생성자를 활용하는 방법
// String(format: <#T##String#>, <#T##arguments: CVarArg...##CVarArg#>)


var string: String = ""

string = String(3.1415926) // 🍑 정확히 말하면 String() 생성자로 생성하고 있는것!
//print(string)

string = "원하는 숫자는 " + String(format: "%.3f", pi)  // 반올림 // 🍑 % : 형식 지정, .n : 소수점 n번째 까지, f : 실수
//print(string)

string = "원하는 숫자는 " + String(format: "%.2f", pi)
//print(string)

string = "원하는 숫자는 " + String(format: "%.1f", pi)
//print(string)

string = String(format: "원하는 숫자는 %.2f", pi)       // %.2f 자리에 pi를 대체
//print(string)




/*:
 ---
 * 출력 형식 지정자(Format Specifiers)의 종류
 ---
 */
string = String(format: "%d", 7)           // %d, %D   ===> 정수
print(string)

string = String(format: "%2d", 7)          // 두자리로 표현
print(string)

string = String(format: "%02d", 7)         // 두자리로 표현하되, 0포함
print(string)

string = String(format: "%07.3f", pi)      // 일곱자리로 표현하되 0과 .(dot) 포함, (소수점아래는 3자리) // 🍑 003.142
print(string)



var swift = "Swift"
string = String(format: "Hello, %@", swift)       // %@  ===> 문자열
print(string)



//:> 절대 외울 필요없음! ➞ 필요할 때 찾아쓰기

// 참고 https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html#//apple_ref/doc/uid/TP40004265-SW1

/*:
 ---
 * 형식 지정자 활용 예시
 ---
 */
// CustomStringConvertible과 결합해서 사용해보기

struct Point: Codable {
    var x: Double
    var y: Double
}


extension Point: CustomStringConvertible {
    var description: String {
        let formattedValue = String(format: "%1$.2f , %2$.2f", self.x, self.y) // 🍑 1$ : 첫번째 파라미터 ...
        //let formattedValue = String(format: "%.2f", x) + " , " + String(format: "%.2f", y)
        return "\(formattedValue)"
    }
}

let p = Point(x: 3.1415926, y: 2.5963756)


print("\(p)")




// 자주 사용하는 경우

var firstName = "Gildong"
var lastName = "Hong"

var korean = "사용자의 이름은 %2$@ %1$@ 입니다."         // 1$ 첫번째 파라미터, 2$ 두번째 파라미터
var english = "The username is %1$@ %2$@."


string = String(format: korean, firstName, lastName)
print(string)


string = String(format: english, firstName, lastName)
print(string)




/*:
 ---
 * 참고: NumberFormatter 클래스를 이용하는 방법
 ---
 */
/**=================================
 - "숫자" <====> "문자" 변환을 다루는 클래스
 - NumberFormatter()
 
 [설정 가능 속성]
 .roundingMode              반올림모드
 .maximumSignificantDigits  최대자릿수
 .minimumSignificantDigits  최소자릿수
 .numberStyle               숫자스타일
===================================**/


// 소수점 버리기
let numberFormatter = NumberFormatter()
numberFormatter.roundingMode = .floor         // 버림으로 지정
numberFormatter.maximumSignificantDigits = 3  // 최대 표현하길 원하는 자릿수

let value = 3.1415926
var valueFormatted = numberFormatter.string(for: value)!    // 문자열화시키는 메서드
print(valueFormatted)   // 3.14



// 소수점 필수적 표현하기
numberFormatter.roundingMode = .floor         // 버림으로 지정
numberFormatter.minimumSignificantDigits = 4  // 최소 표현하길 원하는 자릿수

let value2 = 3.1
valueFormatted = numberFormatter.string(for: value2)!     // 문자열화시키는 메서드
print(valueFormatted)     // 3.100



// 세자리수마다 콤마 넣기 ⭐️

numberFormatter.numberStyle = .decimal
let price = 10000000
let result = numberFormatter.string(for: price)!
print(result) // "10,000,000"







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
