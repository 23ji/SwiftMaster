import UIKit

/*:
 ## 문자열의 삽입/교체/추가/삭제
 * 삽입(insert), 교체(replace), 추가(append), 삭제(remove)
 ---
 */
//:> 문자열은 배열과 유사한 데이터 바구니
/**================================================
 [삽입하기]
   insert(_:,at:)       // 특정인덱스에 문자
   insert(contentsOf:,at:)    // 특정인덱스에 문자열
 
 [교체하기]
   replaceSubrange(_:,with:)    // 범위기준 교체
   replacingOccurrences(of:,with:)       //  (존재하면) 해당글자가 있으면 교체 ==> 원본은 그대로
   replacingOccurrences(of:,with:,options:,range:)
 
 [추가하기]
   문자열 기본 연산자 + / +=
   append(_:)

 [삭제하기]
   remove(at:)        // 특정인덱스의 문자
   removeSubrange(_:)       // 특정인덱스의 문자열
 
 - removeFirst(2)
 - removeLast(2)
 - removeAll()
 - removeAll(keepingCapacity: true)
 

 
 [Subrange만 반환] 원본은 그대로
 - dropFirst(2)   // 앞의 두글자 뺀 나머지 반환
 - dropLast(2)    // 뒤의 두글자 뺀 나머지 반환
 ==================================================**/

/*:
 ---
 * 삽입하기 (insert)
 ---
 */
var welcome = "Hello"

// 🍑 문자 넣기
welcome.insert("!", at: welcome.endIndex) // 🍑 at에는 String.Index를 써야하기 때문에 정수 사용 않고 인덱스 사용해야함!
// "Hello!"

// 🍑 문자열 넣기
welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
// "Hello there!"



/*:
 ---
 * 교체하기 (replace)
 ---
 */
welcome = "Hello there!"
print(welcome)

if let range = welcome.range(of: " there!") {  // 범위를 가지고
    welcome.replaceSubrange(range, with: " Swift!")     // 교체하기
    print(welcome)
}


// 교체하되, 문자열 원본은 그대로 (occurrence: 존재하는)

var newWelcome = welcome.replacingOccurrences(of: "Swift", with: "World")
// "Swift"라는 문자열이 존재하면, "World"로 교체
print(welcome)
print(newWelcome)

                                                                                    // 대소문자 무시 옵션
newWelcome = welcome.replacingOccurrences(of: "swift", with: "New World", options: [.caseInsensitive], range: nil)
print(welcome)
print(newWelcome)


/*:
 ---
 * 추가하기 (append)
 ---
 */
"swift" + "!"  // 너무나 당연

welcome.append("!")
welcome.append(" Awesome!")


/*:
 ---
 * 삭제(제거)하기 (remove)
 ---
 */
welcome = "Hello Swift!"


// 인덱스를 가지고 지우기
// (endIndex의 전 인덱스)
welcome.remove(at: welcome.index(before: welcome.endIndex))     // "!" 지우기
welcome
// "Hello Swift"


// 인덱스 범위파악
var range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
//range = welcome.range(of: " Swift")!


// " Swift"의 범위를 파악하고 지우기
welcome.removeSubrange(range)
welcome      // "Hello"


welcome.removeAll()
welcome.removeAll(keepingCapacity: true)//🍑keepingCapacity :  지우되 메모리 용량은 남겨 놓겠다.


/*:
 ---
 * 문자열 삽입과 삭제의 활용
 ---
 */
var string = "Hello world"


// 1) " " 공백 문자열의 인덱스 찾기
// 2) " " 공백 문자열의 인덱스에 " super" 삽입하기


if let someIndex = string.firstIndex(of: " ") {
    string.insert(contentsOf: " super", at: someIndex)
    print(string)      // "Hello super world"
}


// 1) 첫 " " 공백 문자열의 인덱스 찾기
// 2) " super" 문자열의 범위 만들기
// 3) 범위 삭제하기


if let firstIndex = string.firstIndex(of: " ") {
    let range = firstIndex...string.index(firstIndex, offsetBy: 5)
    string.removeSubrange(range) // 🍑 super의 범위를 지움
    print(string)     // "Hello world"
}



// 바꿀 문자열을 정확하게 알고 있다면 ===> 범위를 직접 리턴하는 메서드 활용 ⭐️

if let range = string.range(of: " world") {
    string.removeSubrange(range)
    print(string)
}






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

