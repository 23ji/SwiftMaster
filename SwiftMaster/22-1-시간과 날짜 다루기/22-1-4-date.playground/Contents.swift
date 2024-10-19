import UIKit

//:> 생각나지않으면, 필요할때 찾아쓰면 됨 (외우는 것 절대 아님)
/*:
 ## 실제 프로젝트에서 활용 방식
* DateComponents를 활용해, 원하는 특정날짜/시간 생성하기
---
*/
var components = DateComponents()    // 구조체 (날짜/시간의 요소들을 다룰 수 있는)
components.year = 2021
components.month = 1
components.day = 1

components.hour = 12
components.minute = 30
components.second = 0


let specifiedDate: Date = Calendar.current.date(from: components)! // 🍑 컴포넌트를 데이터화 시키는 코드
print(specifiedDate)
 




// 조금 더 세련된 방식으로 구현
// 구조체의 확장 이용해서 Date에 생성자 구현

extension Date {
    // 구조체 실패가능 생성자로 구현
    init?(y year: Int, m month: Int, d day: Int) {
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        guard let date = Calendar.current.date(from: components) else {
            return nil  // 날짜 생성할 수 없다면 nil리턴
        }
        
        self = date      //구조체이기 때문에, self에 새로운 인스턴스를 할당하는 방식으로 초기화가능 //🍑 성공시
        // 🍑 self 사용 기억 안나면 Self / self 비교 수업 보기
    }
}




let someDate = Date(y: 2021, m: 1, d: 1)      // 특정날짜(시점) 객체 생성
let someDate2 = Date(y: 2021, m: 7, d: 10)








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
