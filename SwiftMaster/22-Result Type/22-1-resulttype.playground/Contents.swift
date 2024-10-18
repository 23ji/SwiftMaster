import UIKit


/*:
 # Part22 - Result Type
 */
/*:
 ## Result 타입
 * Result 타입에 대한 이해
 ---
 */
/**======================================================
 - 에러가 발생하는 경우, 에러를 따로 외부로 던지는 것이 아니라
 - 리턴 타입 자체를 Result Type(2가지를 다 담을 수 있는)으로 구현해서
 - 함수 실행의 성공과 실패의 정보를 함께 담아서 리턴


 - 실제 Result타입의 내부 구현 // 🍑 <Success, Failure> -> 제네릭
 - enum Result<Success, Failure> where Failure : Error
 - https://developer.apple.com/documentation/swift/result


 - Result타입은 열거형
 - case success(연관값)
 - case failure(연관값)
 ========================================================**/

/*:
 ---
 * 에러 처리의 과정 (3단계)
 ---
 */
// 에러 정의 (어떤 에러가 발생할지 경우를 미리 정의)
// 🍑 에러 프로토콜을 채택해 에러를 enum 타입으로 정의
enum HeightError: Error {    //에러 프로토콜 채택 (약속)
    case maxHeight
    case minHeight
}




// throwing함수 (앞에서 배운)
// 🍑 에러를 던질 수 있는 함수 생성    <ㄱ
func checkingHeight(height: Int) throws -> Bool {    // (에러를 던잘수 있는 함수 타입이다)
    
    if height > 190 {
        throw HeightError.maxHeight // 🍑 에러 던짐
    } else if height < 130 {
        throw HeightError.minHeight
    } else {
        if height >= 160 {
            return true
        } else {
            return false
        }
    }
}



// 🍑 에러 처리를 위해선 do, try catch 필요, 정상적인 경우 do블럭 실행하다가 에러 생기면 try -> catch
do {
    let _ = try checkingHeight(height: 200)
    print("놀이기구 타는 것 가능")
} catch {
    print("놀이기구 타는 것 불가능")
}




/*:
 ---
 * Result타입을 활용한 에러의 처리
 ---
 */
// 에러는 동일하게 정의되어 있다고 가정
// Result타입에는 성공/실패했을 경우에 대한 정보가 다 들어있음
// 🍑 열거형을 사용해 정상 경우, 에러 경우 구현 / 연관값을 통해 구체적인 정보 담음
                            //<Success, Failure> 이렇게 타입 선언 <ㄱ
func resultTypeCheckingHeight(height: Int) -> Result<Bool, HeightError> {
    
    if height > 190 {
// 🍑 열거형 Result에서 fail~선택, 
        //HeighError 열거형 안에 max~ 선택 <ㄱ
        return Result.failure(HeightError.maxHeight) // 🍑 -> 에러 타입 결과 반환!
    } else if height < 130 {
        return Result.failure(HeightError.minHeight)
    } else {
        if height >= 160 {
            return Result.success(true)
        } else {
            return Result.success(false)
        }
    }
}



// 리턴값을 받아서
// 🍑 throws 키워드가 사라졌기 때문에 try도 필요없음 그냥 받으면 됨
let result = resultTypeCheckingHeight(height: 200)


// 처리
// 🍑 복잡한 do try catch 없이 간단히 case로 처리 가능
switch result {
case .success(let data): // 🍑 연관값을 data에 바인딩
    print("결과값은 \(data)입니다.")
case .failure(let error): // 🍑 연관값을 error에 바인딩
    print(error)
}




/*:
 ---
 * Result타입의 다양한 활용
 ---
 */
// Result타입에는 여러메서드가 존재
// get()메서드는 결과값을 throwing함수처럼 변환가능한 메서드 (Success밸류를 리턴)

do {
    let data = try result.get() // 🍑 result에 바로 .get 이런거 붙여서 다시 에러를 던지는 함수로 사용 가능
    print("결과값은 \(data)입니다.")
} catch {
    print(error)
}


/**==================================================
 - Result타입을 왜 사용할까?
 
 - 성공/실패의 경우를 깔끔하게 처리가 가능한 타입

 - 기존의 에러처리 패턴을 완전히 대체하려는 목적이 아니라
   개발자에게 에러 처리에 대한 다양한 처리 방법에 대한 옵션을 제공
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
