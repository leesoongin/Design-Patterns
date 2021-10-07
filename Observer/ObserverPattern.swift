import UIKit

protocol Publisher{ // subject
    var observers: [Observer] { get set }
    func subscribe(observer: Observer)// 구독
    func removeSubscribe(observer: Observer) // 구독 해제
    func notify(message: String) // 알림
}

protocol Observer{
    var id: String { get set }
    func update(message: String)
}

class AppleStore: Publisher {
    var observers: [Observer]
    
    init(observers: [Observer]){
        self.observers = observers
    }
    
    func subscribe(observer: Observer) {
        self.observers.append(observer)
        
    }
    
    func removeSubscribe(observer: Observer) {
        guard let removeIdx = self.observers.firstIndex(where: {
            $0.id == observer.id
        }) else {
            return
        }
        
        self.observers.remove(at: removeIdx)
        print(NSObject.hash())
    }
    
    func notify(message: String) {
        for observer in self.observers{
            observer.update(message: message)
        }
    }
}

class Customer: Observer{
    var id: String
    init(id: String){
        self.id = id
    }
    
    func update(message: String) {
        print("message 수신 --> \(message)")
    }
}

// 1번 테스트
let appleStore = AppleStore(observers: [])
let mumu = Customer(id: "mumu")
let nunu = Customer(id: "nunu")
let mymy = Customer(id: "mymy")
let zzzz = Customer(id: "zzzz")

appleStore.subscribe(observer: mumu)
appleStore.subscribe(observer: nunu)
appleStore.subscribe(observer: mymy)

appleStore.notify(message: "변경된 값입니당!")

appleStore.removeSubscribe(observer: mymy)

appleStore.notify(message: "나도 !@! 값입니당!")


//protocol touchEventPublisher{
//    var observers: [ItemObserver] { get set }
//    func subscribe(observer: ItemObserver)// 구독
//    func unSubscribe(observer: ItemObserver) // 구독 해제
//    func notify() // 데이터 변경 알림
//}
//
//protocol ItemObserver{
//    var id: String { get set }
//    func update(message: DummyModel)
//}
//
//class DummyModel: ItemObserver{
//    var id: String
//    var name: String
//    var phone: String
//
//    init(id: String, name: String, phone: String){
//        self.id = id
//        self.name = name
//        self.phone = phone
//    }
//
//    func update(message: DummyModel) {
//        self.id = message.id
//        self.name = message.name
//        self.phone = message.phone
//        print("id --> \(self.id), name --> \(self.name), phone --> \(self.phone)")
//    }
//}
//
//class CustomView: touchEventPublisher{
//    var observers: [ItemObserver]
//
//    init(observers: [ItemObserver]){
//        self.observers = observers
//    }
//
//    func subscribe(observer: ItemObserver) {
//        self.observers.append(observer)
//    }
//
//    func unSubscribe(observer: ItemObserver) {
//        guard let targetIdx = self.observers.firstIndex(where: {
//            $0.id == observer.id
//        }) else { return }
//
//        self.observers.remove(at: targetIdx)
//    }
//
//    func notify() {
//        for observer in self.observers{
//            observer.update(message: DummyModel(id: "변경된", name: "변경된id", phone: "ddphone"))
//        }
//    }
//}
//
//let dummyOne = DummyModel(id: "1", name: "firstName", phone: "firstPhone")
//let dummyTwo = DummyModel(id: "2", name: "secondname", phone: "secondPhone")
//let dummyThree = DummyModel(id: "3", name: "thirdName", phone: "thirdPhone")
//
//var customView = CustomView(observers: [])
//
//customView.subscribe(observer: dummyOne)
//customView.subscribe(observer: dummyTwo)
////customView.subscribe(observer: dummyThree)
//
//customView.notify()
//
//
