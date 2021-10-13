# Observer 실습

라벨에 옵저버를 달고 버튼을 누를때마다 이벤트를 전달해서 라벨의 숫자 Update 실습
이게 맞는건진 모르게씀 ! ㅋㅋ

<img width="361" alt="스크린샷 2021-10-14 오전 1 30 16" src="https://user-images.githubusercontent.com/55231029/137175071-4d872cad-c895-4330-b543-ae5e290da702.png">


### ViewController

```swift
//
//  ViewController.swift
//  MemoApp
//
//  Created by 이숭인 on 2021/10/13.
//

import UIKit

protocol Observer {
    var id: Int { get }
    func update()
}
extension UILabel: Observer {
    var id: Int {
        get {
            self.hash
        }
    }
    
    func update() {
        let count = Int(self.text ?? "0")
        self.text = "\((count ?? 0) + 1)"
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    
    private let manager = TestManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.subscribe(observer: testLabel)
        
    }
    @IBAction func testAction(_ sender: Any){
        manager.notify(data: "")
    }
}
```

### Manager

```swift
//
//  VIewModel.swift
//  MemoApp
//
//  Created by 이숭인 on 2021/10/13.
//

import UIKit

protocol Subject {
    var observers: [Observer] { get set }
    func subscribe(observer: Observer)
    func unsubscribe(observer: Observer)
    func notify(data: String)
}

class TestManager: Subject {
    static let shared = TestManager()
    
    private init() {}
    
    var observers: [Observer] = [Observer]()
    
    func subscribe(observer: Observer) {
        self.observers.append(observer)
    }
    
    func unsubscribe(observer: Observer) {
        if let index = self.observers.firstIndex(where: { $0.id == observer.id }) {
            self.observers.remove(at: index)
        }
    }
    
    func notify(data: String) {
        for observer in self.observers {
            observer.update()
        }
    }
}
```


