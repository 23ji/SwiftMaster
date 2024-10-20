import UIKit

/*:
 ## @available / #available
 * Swift API Availability
 ---
 */
// 새로운 업데이트 사항에 따라서, iOS 예전버전에서는 코드로 인해 크래시가 발생할 수 있음
// 그래서 해당 코드에 대해 어떤 버전이상만 적용가능하다는 힌트를 컴파일러에 주는 것

// @available은 타입 또는 메서드에 붙일때
// #available는 조건문에서 사용

@available(iOS 11.0, *)
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @available(iOS 11.0, *) // 🍑 클래스, 함수 등에는 @
    func doSomething() {
        // (if, while, guard문으로도 사용 가능)
        if #available(iOS 11.0, *) { // 🍑  조건문에는 #
            // iOS 11버전이상인 경우 적용 시킬 코드를 작성
            
        } else {
            // iOS 11버전미만인 경우 적용 시킬 코드를 작성
        }
        
    }

}



/**==============================
 (참고) iOS 등버전, Swift버전에 따라
 - iOS
 - iOSApplicationExtension
 - macOS
 - macOSApplicationExtension
 - watchOS
 - watchOSApplicationExtension
 - tvOS
 - tvOSApplicationExtension
 - swift
 ================================**/
// 참고: https://nshipster.com/available/







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
