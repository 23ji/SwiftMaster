import UIKit

/*:
 ## fatalError( )
 * fatalError( ) 함수의 이해
 ---
 */
/**==============================================================
 func fatalError(_ message: @autoclosure () -> String = String(),
                file: StaticString = #file,
                line: UInt = #line) -> Never

- 1) message: (에러발생할때) 표시하려고 하는 메세지
- 2) file: (에러발생) 파일이름 (기본설정 #file)
- 3) line: (에러발생) 라인번호 (기본설정 #line)
 
* 리턴형: Never 타입
================================================================**/



func someCloseAppSituation() {
    fatalError("앱 해킹시도 흔적 발견")
}


//someCloseAppSituation() // 🍑 이거 실행하면 아래 출력됨
// __lldb_expr_4/fatalError.playground:22: Fatal error: 앱 해킹시도 흔적 발견


/*:
 ---
 * 애플 내부의 구현 - 간단한 예시
 ---
 */
var name: String

//print(name)
// fatalError.playground:32:5: note: variable defined here

// 애플 내부에도 많은 함수들이 fatalError로 구현된 경우가 많음

// 빨간 줄을 표시하고, 어떤 치명적 에러가 발생했는지도 알려주며
// ===> 실은 개발자에게 (실제 앱을 출시하기 전에 오류를) 체크하고 수정할 수 있도록 알려주는 것임

// 그럼 우리도 직접 내부에서 동작하는 것처럼
// 필요한 경우에 조건에 따라서, 앱을 종료시키는 에러를 직접 만들 수 있음




/*:
 ## 디버깅 함수
 * 디버깅(테스트/검증)을 위해 일부러 앱을 중지 시키는 함수
 ---
 */
/**===============================================
 [디버깅(검증) 함수]
 - assert()
 - assertionFailure() // 🍑  디버깅 때 사용
 - precondition()
 - preconditionFailure() // 🍑  실제 출시 앱에 사용
 - fatalError() // 🍑 제일 쎈 종료
 
 앱을 테스트하여서, 런타임동안 발생할 수 있는 여러 버그의 가능성,
 잘못된 코드의 검증 등을 수행하도록 도와주는 함수
 
 - print() / dump() 일종의 디버깅 함수
   어떤 코드들이 입력되는지, 콘솔창을 통해 확인 / 검증
 ================================================**/

/*:
 ---
 * precondition( ) / preconditionFailure( ) 함수의 사용
 ---
 */
//:> precondition( ) ➞ 실제앱을 출시시에도, 앱을 의도적으로 종료시켜야하는 상황
// 유의미하기 때문에, 앱을 일부러 종료해야함
// 예) 앱의 업데이트로 인해, 버전이 업데이트 되었는데, 이전버전을 계속 깔고 있다면
//    서버와의 통신이 잘못될 수 있기 일부러 종료시켜야 할 수도 있음


func appUpdateCheck1() {
    let update = false
    precondition(update, "앱을 업데이트 하지 않음")
}


//appUpdateCheck1()




func appUpdateCheck2() {
    let update = false
    
    if update {
        // 앱을 업데이트 했을때, 정상적으로 실행할 코드
        
    } else {
        preconditionFailure("앱을 업데이트 하지 않음")
    }
}


//appUpdateCheck2()


/*:
 ---
 * assert( ) / assertionFailure( ) 함수의 사용
 ---
 */
//:> assert( ) ➞ 실제앱을 출시시, 일부러 앱을 종료시켜야 정도의 상황은 아니지만, 디버그모드에서는 검증 가능
// 예상하는 범위를 벗어난 결과이지만, 아주 유의미하지는 않아서, 굳이 종료 시키는 것은 안 좋음
// 예) 레이블에 20 % / 30% /... 100% 표시한다고 했을때, -10%라고 표시된다고 굳이 앱을 종료시켜야 하는가?


func enterWrongValue1() {
    let someWrongInput = -1
    assert(someWrongInput > 0, "유저가 값을 잘못 입력") // 🍑 조건, 출력 메서지
}


//enterWrongValue1()




func enterWrongValue2() {
    let someWrongInput = -1
    
    if someWrongInput > 0 {
        // 정상적으로 처리하는 코드
        
    } else {
        assertionFailure("유저가 값을 잘못 입력") // 🍑 오류 메세지 (조건 안따짐)
    }
}


//enterWrongValue2()







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
