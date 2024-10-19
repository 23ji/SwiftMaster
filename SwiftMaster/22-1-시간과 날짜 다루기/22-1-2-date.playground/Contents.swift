import UIKit


//:> 생각나지않으면, 필요할때 찾아쓰면 됨 (외우는 것 절대 아님)
/**=========================================
 - 날짜를 제대로 다루려면?

 - 1) 달력을 다루는 Calendar 구조체의 도움도 필요 (양력, 음력인지)
 - 2) 문자열로 변형해주는 DateFormatter 클래스의 도움도 필요
 
   * 기본적으로 지역설정/타임존의 영향이 있음
============================================**/


/*:
 ## Calendar 구조체의 이해
* 스위프트에서 기본으로 제공해주는, 달력(Calendar) 구조체 타입
---
*/
// "절대 시점(Date)"을 연대/연도/날짜/요일과 같은 "달력의 요소"로 변환을 돕는 객체 ⭐️


// 그레고리력 (Gregorian calendar) - 양력 (전세계표준 달력)
var calendar = Calendar.current   // 타입 속성 ==> 현재의 달력(양력) 반환


/**================================================================================
let calendar1 = Calendar(identifier: .gregorian)  // 직접 생성하기 (이런 방식으로 잘 사용하지는 않음)
let calendar2 = Calendar.autoupdatingCurrent      // 유저가 선택한 달력 기준(세계적 서비스를 한다면)
 ==================================================================================**/

//:> 지역설정 ➡︎ 나라(지역)마다 날짜와 시간을 표시하는 형식과 언어가 다름
calendar.locale    // 달력의 지역 (영어/한국어) (달력 표기 방법과 관련된 개념)
calendar.timeZone  // 타임존 ==> Asia/Seoul (UTC 시간관련된 개념)



// 필요할때 찾아서 쓰면됨
calendar.locale = Locale(identifier: "ko_KR")
//calendar.timeZone = TimeZone(identifier: "Asia/Seoul")


/**==================================================================================
 - 지역설정 문자열: https://gist.github.com/xta/6e9b63db1fa662bb3910b680f9ebd458  (700여개)
 - 타임존 문자열: https://gist.github.com/mhijack/2b63b84d96802ccc719291474ac9df72 (440여개)
 ==================================================================================**/





let now = Date()

// (원하는)요소로 요소화 시키는 메서드(타입 알려주면 그것을 정수로 반환)


//:> Date의 "년/월/일/시/분/초"를 확인하는 방법

// 1) 날짜 - 년 / 월 / 일
        // 🍑 연도라는 요소를 뽑아내는 것 <ㄱ
let year: Int = calendar.component(.year, from: now)
                // 🍑 ㄴ> 캘린더의 컴포넌트라는 요소를 가지고 그 중 이미 정의되어 있는 year라는 타입을 가지고 now를 변환하는 것!
let month: Int = calendar.component(.month, from: now)
let day: Int = calendar.component(.day, from: now)


// 2) 시간 - 시 / 분 / 초
let timeHour: Int = calendar.component(.hour, from: now)
let timeMinute: Int = calendar.component(.minute, from: now)
let timeSecond: Int = calendar.component(.second, from: now)


// 실제 앱에서 표시할때는 위와 같은 식으로 분리해서, 레이블(Label)에 표시 가능



// 3) 요일
let weekday: Int = calendar.component(.weekday, from: now)

// 일요일 - 1
// 월요일 - 2
// 화요일 - 3
// ...
// 토요일 - 7

// 참고
// https://developer.apple.com/documentation/foundation/calendar/component/weekday



//:> Date는 Calendar(양력)의 도움을 받아야 여러가지로 활용가능

print("\(year)년 \(month)월 \(day)일")

// 실제로 이렇게 사용하진 않고, 뒤에서 배울 DateFormatter로 활용 가능




/*:
---
* 하나의 요소가 아닌 여러개의 데이터를 얻는 방법은? (DateComponents)
---
*/

let myCal = Calendar.current


var myDateCom = myCal.dateComponents([.year, .month, .day], from: now)
//myCal.dateComponents(<#T##components: Set<Calendar.Component>##Set<Calendar.Component>#>, from: <#T##Date#>)

myDateCom.year
myDateCom.month
myDateCom.day


print("\(myDateCom.year!)년 \(myDateCom.month!)월 \(myDateCom.day!)일")





/*:
 ## 실제 프로젝트에서 활용 방식
* 달력을 기준으로, 나이계산 하기
---
*/

class Dog {
    var name: String
    var yearOfBirth: Int
    
    init(name: String, year: Int) {
        self.name = name
        self.yearOfBirth = year
    }
    
    // 나이를 계산하는 계산 속성
    var age: Int {
        get {
            let now = Date()
            let year = Calendar.current.component(.year, from: now)
            return year - yearOfBirth
        }
    }
}


let choco = Dog(name: "초코", year: 2015)
choco.age



/*:
---
* 열거형으로 요일을 만들고, 오늘의 요일을 계산하기
---
*/
// (원시값)열거형으로 선언된 요일
enum Weekday: Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    
    // ⭐️ 타입 계산속성
    static var today: Weekday {
        let weekday: Int = Calendar.current.component(.weekday, from: Date())  // 요일을 나타내는 정수
        return Weekday(rawValue: weekday)!
    }
}




// 오늘이 무슨요일인지
let today = Weekday.today




/*:
---
* 두 날짜 사이의 일수 계산하기
---
*/

let startDate = Date()
let endDate = startDate.addingTimeInterval(3600 * 24 * 60)

let calendar2 = Calendar.current
let someDays = calendar2.dateComponents([.day], from: startDate, to: endDate).day!

print("\(someDays)일 후")







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
