//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: # 올바른 비동기함수의 설계
//: ### 리턴(return)이 아닌 콜백함수를 통해, 끝나는 시점을 알려줘야 한다.

//:> 함수(메서드)를 아래처럼 설계하면 절대 안된다.
//                              🍑 리턴형 설계 <ㄱ
func getImages(with urlString: String) -> UIImage? {
    
    // 🍑1번
    let url = URL(string: urlString)!
    // 🍑2번
    var photoImage: UIImage? = nil
    // 🍑 3번
    // 🍑 UrlSession은 내부적으로 비동기적으로 동작(설계)
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print("에러있음: \(error!)")
        }
        // 옵셔널 바인딩 🍑 데이터가 옵셔널타입이기 때문에
        guard let imageData = data else { return }
        
        // 데이터를 UIImage 타입으로 변형
        photoImage = UIImage(data: imageData)
        
    }.resume()
    
    // 🍑4번
    return photoImage    // 항상 nil 이 나옴 🍑 => 비동기적이기 때문에 항상 nil이 나옴
    // 🍑 3번을 실행 후 기다리지 않고! 바로 4번으로 넘어가기 때문에 항상 nil
}



getImages(with: "https://bit.ly/32ps0DI")    // 무조건 nil로 리턴함 ⭐️






//:> 올바른 함수(메서드)의 설계 - 콜백함수의 사용법
//                                        🍑 클로저 형식 <ㄱ
func properlyGetImages(with urlString: String, completionHandler: @escaping (UIImage?) -> Void) {
    
    let url = URL(string: urlString)!
    
    var photoImage: UIImage? = nil
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print("에러있음: \(error!)")
        }
        // 옵셔널 바인딩
        guard let imageData = data else { return }
        
        // 데이터를 UIImage 타입으로 변형
        photoImage = UIImage(data: imageData)
        // 🍑 콜백함수 실행
        completionHandler(photoImage)
        
    }.resume()
    
}



// 올바르게 설계한 함수 실행
properlyGetImages(with: "https://bit.ly/32ps0DI") { (image) in
    
    // 처리 관련 코드 넣는 곳...
    
    DispatchQueue.main.async {
        // UI관련작업의 처리는 여기서
    }
    
}



sleep(5)


PlaygroundPage.current.finishExecution()
//: [Next](@next)
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
