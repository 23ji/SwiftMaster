import UIKit

/*:
 # Part17 - 중첩 타입
 */
/*:
 ## 중첩 타입(Nested Types)
* 간단한 중첩 타입의 예제
---
*/
// 타입 내부에 타입을 선언하는 것은 언제나 가능

class Aclass {
    struct Bstruct {
        enum Cenum {
            case aCase   // 열거형에는 케이스 필요
            case bCase
            
            struct Dstruct {
                
            }
        }
        var name: Cenum
        
        //🍑 멤버와이즈 이니셜라이저 제공되고 있는 것
//        init(name: Cenum) {
//            self.name = name
//        }
    }
}


// 타입 선언과 인스턴스의 생성

let aClass: Aclass = Aclass()

let bStruct: Aclass.Bstruct = Aclass.Bstruct(name: .bCase) //🍑 이렇게 쓴 이유는 위의 멤버와이즈 이니셜라이저가 제공되기 때문 : 138강 4분쯤

let cEnum: Aclass.Bstruct.Cenum = Aclass.Bstruct.Cenum.aCase     // 열거형은 케이스선택

let dStruct: Aclass.Bstruct.Cenum.Dstruct = Aclass.Bstruct.Cenum.Dstruct()


/**==============================================================================
 - 왜 사용할까?
 - 1) 특정 타입 내에서만 사용하기 위함
      Bstruct는 Aclass타입과 관계가 있고, Aclass없이는 의미가 없을 수 있음 (그래서 범위를 명확히 한정)
 - 2) 타입 간의 연관성을 명확히 구분하고, 내부 구조를 디테일하게 설계 가능
================================================================================**/



/*:
---
* Swift 공식 문서의 예제 (실제 사용 방법)
---
*/
struct BlackjackCard {

    // 중첩으로 선언 타입 ==============================================
    // Suit(세트) 열거형
    enum Suit: Character {     // 원시값(rawValue)사용
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }

    // 순서(숫자) 열거형
    enum Rank: Int {     // 원시값(rawValue)사용
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace   // (원시값 존재하지만 사용하지 않고자 함 ===> values)
        
        // Values 타입정의 (두개의 값을 사용) //===> 열거형 값(순서)을 이용 새로운 타입을 반환하기 위함
        struct Values {
            let first: Int, second: Int?
        }
        
        // (읽기) 계산 속성 (열거형 내부에 저장 속성은 선언 불가)
        var values: Values {
            switch self { //🍑 이 때 self는 Rank.two...Rank.ace 중 하나
            case Rank.ace: // .ace로 써도 동일
                return Values(first: 1, second: 11)    // 에이스 카드는 1 또는 11 로 쓰임
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)  // 10으로 쓰임
            default:
                return Values(first: self.rawValue, second: nil)    // 2 ~ 10까지의 카드는 원시값으로 쓰임
            }
        }
    }
    
    // 블랙잭 카드 속성 / 메서드  =======================================
    // 어떤 카드도, 순서(숫자)와 세트(Suit)를 가짐
    let rank: Rank, suit: Suit
    
    // (읽기) 계산속성
    var description: String {
        get {
            var output = "\(suit.rawValue) 세트,"
            output += " 숫자 \(rank.values.first)"
            
            if let second = rank.values.second {   // 두번째 값이 있다면 (ace만 있음)
                output += " 또는 \(second)"
            }
            
            return output
        }
    }
}



// A - 스페이드

let card1 = BlackjackCard(rank: .ace, suit: .spades) //🍑 .spades = BlackjackCard.Suit.spades
print("1번 카드: \(card1.description)")



// 5 - 다이아몬드

let card2 = BlackjackCard(rank: .five, suit: .diamonds)
print("2번 카드: \(card2.description)")

//let card2 = BlackjackCard(rank: <#T##BlackjackCard.Rank#>, suit: <#T##BlackjackCard.Suit#>)




// 정의한 타입을 외부에서 사용하기 위해서는 중첩되어 있는 타입도 붙여야함(강제) ====> 훨씬 명확해짐

let heartsSymbol: Character  = BlackjackCard.Suit.hearts.rawValue

let suit = BlackjackCard.Suit.hearts



/*:
---
* 실제 API의 사용 예시 (일단 형태에만 집중)
---
*/
// 실제 API에서 중첩 타입을 사용하는 경우

let fomatter = DateFormatter()

// dateStype변수의 타입 확인해보기
fomatter.dateStyle = .full
fomatter.dateStyle = DateFormatter.Style.none

/**==========================================================
 - var dateStyle: Style { get set }                 (타입확인)
 - var dateStyle: DateFormatter.Style { get set }   (내부정의)
============================================================**/



// 타입 확인하기 위해

let setting1: DateFormatter.Style = DateFormatter.Style.full
let setting2: DateFormatter.Style = DateFormatter.Style.medium


// Style.full     // ===> 만약에 외부에 선언되어 있다면, 실제 명확하지 않음
// Style.medium


// 만약에 이렇게 선언했다면 어떤 타입과 관계가 있는지 명확하지 않음
// (이 열거형만 보면 어디서 쓰일지 유추 불가)

enum Style {
    case full
    case long
    case medium
    case none
}


struct DateFormatters {
    var style: Style
    //var style: DateFormatters.Style
    
    // 중첩타입으로 선언
//    enum Style {
//        case full
//        case long
//        case medium
//        case none
//    }
}


var dateStyle1 = DateFormatters(style: .full)
dateStyle1 = DateFormatters(style: Style.full)
dateStyle1.style = Style.full
dateStyle1.style = .full



// 중첩타입으로 선언했을때 사용법 (타입을 쓸려면 전체 중첩타입을 다 써야함)

//var dateStyle2 = DateFormatters(style: .full)
//dateStyle2 = DateFormatters(style: DateFormatters.Style.full)
//dateStyle2.style = DateFormatters.Style.full
//dateStyle2.style = .long





//:> 중첩 타입을 배우는 목적
/**==================================================
 1) 중첩타입으로 선언된 API들을 볼줄 알아야함 ⭐️
    DateFormatter.Style.full
    (중간 타입에 대문자가 나오면, 중첩타입임을 인지)
 
 2) 실제 앱을 만들때 중첩 선언을 잘 활용해야함 (타입 간의 관계 명확성)
 3) 하나의 타입의 내부 구조(계층 관계 등)를 디테일하게 설계 가능
 ====================================================**/







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
