import UIKit

/*:
 ## Never타입
 * 함수의 리턴의 의미
 ---
 */
//:> 함수의 리턴 - 1) 값의 리턴 + 2) 제어권 리턴
/**==========================================
 - 함수의 return의 의미 (일반적인 경우)
 
 - 1) (함수의 결과로 인한) 값을 리턴
 - 2) 함수 내부로 전달했던 CPU실행의 제어권을 다시 돌려줌
 =============================================**/


func addTwoNumbers(a: Int, b: Int) -> Int {
    var c = a + b
    return c
}


var num1 = 5
var num2 = 3


var num3 = addTwoNumbers(a: num1, b: num2) // 🍑 실행하면 17번째 줄로 가서 실행, 그리고 실행 후 다시 28줄로 돌아감
print(num3)





/*:
 ---
 * Never타입과 함수의 제어권을 Nonreturning하는 함수들
 ---
 */
//:> 리턴형이 Never타입인 함수의 이해
func crashAndBurn() -> Never {
    fatalError("앱의 해킹이 발견됨")
}




print("1")
crashAndBurn() // 🍑  40번째 갔다가 네버이기때문에 49번째 줄로 제어권 안돌아옴
print("2")





/**==============================================================
 - Nonreturning(논리터닝) 함수:
   : 제어권을 전달하지 않음(함수를 호출했던 코드로 다시 제어권을 전달하지 않음)
 
 - 명시적으로 제어권을 전달하지 않는다는 것을 표시하기 위해 Never(네버)타입으로 선언

 - Never타입을 리턴하는 함수
 - 1) 함수 내부에서 프로그램을 종료시켜야함(예: fatalError())
 - 2) 항상 에러를 던져서, catch문에서 처리하도록 해야함(제어권을 catch문으로)
=================================================================**/


/**==============================================================
 - Never타입 (임시적인 타입)
 
 - 내부가 빈 열거형으로 선언
 - 인스턴스를 생성할 수 없음(Uninhabited Type)
   예) let day: Weekday = Weekday.monday 이런식의 인스턴스 생성 불가
      또한 let some = Never() 도 안됨 (단순 표시를 위한 타입이라고 봐야함)
================================================================**/


/**==============================================================
 - 왜 사용할까?
 - 런타임(실제 앱 실행중)에 발생할 수 있는 에러를 미리 발견하고, 검증/테스트 하기 위함
 
 - 앱의 해킹이라는 극단적인 예를 들었지만, 실제로 앱의 해킹이 아닌 조금 가벼운 에러라면
   실제 앱을 출시(release)시에는 해당 코드를 삭제하여야함
   (삭제하지 않으면 앱이 꺼질 가능성이 높기 때문에 사용자에게 사용성이 안 좋은 앱으로
    평가받을 가능성이 높음)
================================================================**/



/*:
 ---
 * 예시) 에러를 던지는 Never타입 함수의 예시
 ---
 */
// 1) 에러 정의
enum SomeError: Error {
    case aError
    case bError
}


// 2) 에러를 던지는 함수의 정의 // 🍑 에러 던지는 경우 딱히 안씀

func someThrowingErrorFuncion() throws -> Never {
    if true {
        throw SomeError.aError
    } else {
        throw SomeError.bError
    }
}


// 3) 에러를 던지는 함수의 실행

do {
    try someThrowingErrorFuncion()
} catch {
    print(error)
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
