//
//  ViewController.swift
//  Selector2
//
//  Created by Allen H on 2021/11/03.
//

import UIKit

// 🍑ViewController 안에는 항상 view라는게 있음
class ViewController: UIViewController {

    // 버튼 관련 속성(변수) 선언 (일단 인스턴스 생성해서 담기)
    let codeButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // 코드로 짜는 UI관련 함수 // 🍑viewDidLoad에도 써도 되지만 실무에서는 이렇게 ~~에 대한 함수를 만들어 놓고 그 함수를 viewDidLoad에서 호출함
    func configureUI() {
        // 버튼 셋팅
        codeButton.setTitle("Code Button", for: .normal)
        codeButton.setTitleColor(.white, for: .normal)
        codeButton.backgroundColor = .blue
        // 자동 제약 잡아주는 것 취소 ===> 코드로 오토레이아웃 잡으려면 필수
        codeButton.translatesAutoresizingMaskIntoConstraints = false
        // 버튼 눌렀을때 실행시킬 함수 연결하기 ⭐️⭐️⭐️
        // 🍑 이 버튼이 for 방식으로 눌렸을때, self가 셀렉터 액션이 실행되게 함
        codeButton.addTarget(self, action: #selector(ViewController.codeButtonTapped), for: .touchUpInside)
        // 🍑 결론 : 셀렉터는 (아래 있는) @objc func codeButtonTapped()의 메모리의 주소를 가르킴
        
        // 버튼을 화면에 올리기
        view.addSubview(codeButton)
        // 오토레이아웃 코드로 짜기 (지금 중요하지 않음)
        NSLayoutConstraint.activate([
            codeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            codeButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 30),
            codeButton.widthAnchor.constraint(equalToConstant: 200),
            codeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    // 스토리보드의 버튼이 눌렸을 때 실행되는 함수
    // 🍑  @objc 필수
    @IBAction func storyBoardButtonTapped(_ sender: UIButton) {
        print("스토리보드 버튼 눌림")
    }
    
    // 코드로 만든 버튼이 눌렸을 때 실행되는 함수
    @objc func codeButtonTapped() {
        print("코드 버튼 눌림")
    }


}

