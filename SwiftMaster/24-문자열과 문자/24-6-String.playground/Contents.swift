import UIKit

/*:
 ## 문자열을 배열로 변환
 * 문자열의 배열화, (문자열)배열의 문자열화
 ---
 */
//:> 문자열(데이터바구니) ⇄ 배열  (쉽게 변형가능)
/**============================================
 - 문자열 자체도, 여러개의 문자를 담고 있는 데이터이기 때문에
   쉽게 배열로 변형이 가능하고, 반대 변형도 쉬움
 
 -  String    <====>  [String]   문자열 배열
 -  String    <====> [Character] 문자 배열
 ============================================**/


var someString = "Swift"


// 1) 문자열을 문자열(String) 배열화 하기 ⭐️ // 🍑 타입 : 문자열 => 이 방법 사용하기!

var array: [String] = someString.map { String($0) }

// 🍑 이렇게 길게 쓸 수도 있음
//  var array1: [String] = someString.map { chr in
//                              String(chr)
//                         }

print(array)


// 2) 문자열을 문자(Character) 배열화 하기 // 🍑 타입 : 캐릭터 => 이렇게 사용하지 말기!!!

var array2: [Character] = Array(someString)     // [Character]      //typealias Element = Character



// (참고) 문자열을 문자열(String) 배열화하는 추가적 방법 // 🍑 타입 : 문자열
var array3: [String] = Array(arrayLiteral: someString)  // [String]





// 3) 문자열 배열 [String] =====> 문자열 🍑 이 방법 사용!

var newString = array.joined()
newString = array3.joined()


// 4) 문자 배열  [Character] ======> 문자열

var newString2 = String(array2)




/*:
 ---
 * (활용 예시) 문자열을 뒤죽박죽 섞는다면?
 ---
 */
someString = "Swift"


someString.randomElement()     // 문자열에서 랜덤으로 뽑아내는 것 가능
someString.shuffled()          // 섞어서 문자(Character) 배열로 리턴 ["t", "i", "w", "S", "f"]




//someString.shuffled().joined()     // 불가능 (문자배열 이기때문)


var newString3 = String(someString.shuffled())
print(newString3)


// map고차함수를 사용해서 변환 ⭐️ 🍑 이 방법 사용!
// 🍑 문자열 -> 배열 -> 배열.섞는 메서드 -> 다시 문자열로
newString3 = someString.map { String($0) }.shuffled().joined()
print(newString3)








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
