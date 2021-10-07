
protocol Duck {
    // 두 프로토콜을 따른 행동 그룹 클래스들의 상위 형식
    var flyBehavior: FlyBehavior? { get set }
    var quackBehavior: QuackBehavior? { get set }
    
    func setFlyBehavior(_ behavior: FlyBehavior)
    func setQuackBehavior(_ behavior: QuackBehavior)
    func swim() // 공통
    func display() // 공통
    
    func performFly() // 날지못하는놈, 나는 놈 - 변화
    func performQuack() // 꽦꽦, 끾끾 - 변화
}

class MallardDuck: Duck {
    var flyBehavior: FlyBehavior?
    var quackBehavior: QuackBehavior?
    
    func setFlyBehavior(_ behavior: FlyBehavior) {
        self.flyBehavior = behavior
    }
    func setQuackBehavior(_ behavior: QuackBehavior) {
        self.quackBehavior = behavior
    }
    
    func swim() {
        print("수영은 다 할줄 암 ㅋㅋ")
    }
    
    func display() {
        print("모양은 그냥 다다름 ㅋㅋ")
    }
    
    func performFly() {
        // flyBehavior 라는 상위 구현체를 따르는 어떤 객체라도 flyBehavior에 들어갈 수 있음.
        // MallardDuck 에서는 실행시에 flyBehavior에 대입된 구체적인 객체에 대해 몰라도 수행이 가능
        // 이게 스트래티지 패턴!
        guard let flyBehavior = self.flyBehavior else { return }
        
        flyBehavior.fly()
    }
    
    func performQuack() {
        // 마찬가지
        guard let guackBehavior = self.quackBehavior else { return }
        guackBehavior.quack()
    }
}

protocol FlyBehavior {
    func fly()
}
class FlyWithWings: FlyBehavior {
    func fly() {
        print("날개로 날아요!")
    }
}
class FlyNoWay: FlyBehavior {
    func fly() {
        print("날지 못해요 ㅠㅠ")
    }
}

protocol QuackBehavior {
    func quack()
}
class Quack: QuackBehavior {
    func quack() {
        print("꽦꽦")
    }
}
class Squeak: QuackBehavior {
    func quack() {
        print("끾끾")
    }
}
class MuteQuack: QuackBehavior {
    func quack() {
        print("읍읍..")
    }
}


func test(){
    let mallarDuck: MallardDuck = MallardDuck()
    
    mallarDuck.setFlyBehavior(FlyWithWings())
    mallarDuck.setQuackBehavior(Quack())
    
    mallarDuck.performFly()
    mallarDuck.performQuack()
    
    mallarDuck.setFlyBehavior(FlyNoWay())
    mallarDuck.setQuackBehavior(MuteQuack())
    
    mallarDuck.performFly()
    mallarDuck.performQuack()
}

test()
