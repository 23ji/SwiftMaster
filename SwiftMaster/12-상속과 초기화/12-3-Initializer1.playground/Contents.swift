  import UIKit


/*:
## 3) 초기화(Initialization)
 * 초기화(Initialization)와 생성자(Initializer)
 ---
 */
/**=====================================================================
 - 초기화는 클래스, 구조체, 열거형의 인스턴스를 생성하는 과정임
 - 각 "저장 속성"에 대한 초기값을 설정하여 인스턴스를 사용가능한 상태로 만드는 것
   (열거형은 저장속성이 존재하지 않으므로, case중에 한가지를 선택 및 생성)

 - 결국, 이니셜라이저의 실행이 완료되었을 때,
 - 인스턴스의 모든 저장속성이 초기값을 가지는 것이 ==> 생성자(Initializer)의 역할

 - 참고) 소멸자
 - 생성자와 반대개념의 소멸자(Deinitializer)도 있음
 - 소멸자 ==> 인스턴스가 해제되기 전에 해야할 기능을 정의하는 부분
=====================================================================**/

/*:
---
* 생성자(Initializer) 구현의 기본
---
*/
// 클래스, 구조체, (열거형) 동일

class Color {
    //let red, green, blue: Double    // 동일한 타입일때, 한줄에 작성가능
    let red: Double
    let green: Double
    let blue: Double
    
    
    // 생성자도 오버로딩(Overloading)을 지원 (파리미터의 수, 아규먼트 레이블, 자료형으로 구분)
    
    init() {      // "init()" -> 기본 생성자. 저장 속성의 기본값을 설정하면 "자동" 구현이 제공됨
        red = 0.0
        green = 0.0
        blue = 0.0
    }

    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }

    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
}



/**===================================================
 - 초기화의 방법(저장속성이 초기값 가져야 함 🍑 하위 셋 중 하나로 선택해서 구현하면 됨
 - 1) 저장 속성의 선언과 동시에 값을 저장
 - 2) 저장 속성을 옵셔널로 선언 (초기값이 없어도 nil로 초기화됨)
 - 3) 생성자에서 값을 초기화

 - 반드시 생성자를 정의해야만 하는 것은 아님 ⭐️
 
 - 1-2번 방법으로 이니셜라이저를 구현하지 않아도,
 - 컴파일러는 기본 생성자(Default Initializer)를 자동으로 생성함 ==> init()
 - ==> 이니셜라이저 구현하면, 기본 생성자를 자동으로 생성하지 않음
======================================================**/




var color = Color()   // 기본 생성자 호출. 결국 Color()는 생성자를 호출하는 것임 (메서드 호출 문법과 형태 동일)
//var color2 = Color.init()


//color = Color(white: <#T##Double#>)
//color = Color.init(white: <#T##Double#>)

//color = Color(red: <#T##Double#>, green: <#T##Double#>, blue: <#T##Double#>)
//color = Color.init(red: <#T##Double#>, green: <#T##Double#>, blue: <#T##Double#>)




/*:
---
* 멤버와이즈 이니셜라이저(Memberwise Initializer) - 구조체의 특별한 생성자
---
*/
//:> 구조체는 멤버와이즈 이니셜라이저 자동 제공

struct Color1 {
    var red: Double = 1.0
    var green: Double = 1.0
    var blue: Double

}




/**============================================================
 - 생성자 기본 원칙
 - 컴파일러는 기본 생성자(Default Initializer)를 자동으로 생성함 ==> init()
 - ==> 이니셜라이저 구현하면, 기본 생성자를 자동으로 생성하지 않음

 - 구조체는 저장 속성들이 기본값을 가지고 있더라도,
 - 추가적으로 Memberwise멤버와이즈(멤버에 관한) 이니셜라이저를 자동으로 제공함

 - 개발자가 직접적으로 생성자를 구현하면, 멤버와이즈 이니셜라이저가 자동으로 제공되지 않음 ⭐️
   (멤버와이즈 이니셜라이저는 편의적 기능일뿐)
 ==============================================================**/


//var color1 = Color1()
//color1 = Color1(red: 1.0, green: 1.0, blue: 1.0)



// 구조체에서만 선언된 저장 속성의 이름을 파라미터로 제공하기 때문에
// 멤버에 관한 생성자를 제공한다는 뜻에서 멤버와이즈 이니셜라이저라고 부름
// (Memberwise 뜻: 멤버에 관하여) ( ~ wise:  ~ 에 관하여)




/**==================================================
 - 왜 멤버와이즈 이니셜라이저를 제공할까?
 
 - 굳이 이유를 찾자면, 클래스보다 더 편하게 쓰기 위함일 것으로 추측
 - 클래스의 경우에는, 생성자가 상속하고 관련이 있기 때문에 복잡
=====================================================**/








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
