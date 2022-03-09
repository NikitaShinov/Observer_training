//
//  ViewController.swift
//  Observer_training
//
//  Created by max on 09.03.2022.
//

import UIKit

protocol Observer: AnyObject {
    func update(subject: NotificationCenters)
}

class NotificationCenters {
    var state: Int = {
        return Int(arc4random_uniform(10))
    }()
    
    private var observers = [Observer]()
    
    func subscribe(_ observer: Observer) {
        print (#function)
        observers.append(observer)
    }
    
    func unsubscribe(_ observer: Observer) {
        if let index = observers.firstIndex(where: {$0 === observer}) {
            print (#function)
            observers.remove(at: index)
        }
    }
    
    func notify() {
        print (#function)
        observers.forEach({$0.update(subject: self)})
    }
    
    func someBusinessLogic() {
        print (#function)
        state = Int(arc4random_uniform(10))
        notify()
    }
}

class ObserverA: Observer {
    func update(subject: NotificationCenters) {
        print("Observer: \(subject.state)")
    }
}


class ViewController: UIViewController, Observer {
    
    let notification = NotificationCenters()
    let observer = ObserverA()

    @IBOutlet weak var countsLabel: UILabel!
    
    func update(subject: NotificationCenters) {
        countsLabel.text = "Number: \(subject.state)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func switcherTapped(_ sender: UISwitch) {
        if sender.isOn {
            notification.subscribe(self)
            notification.subscribe(observer)
        } else {
            notification.unsubscribe(self)
            notification.unsubscribe(observer)
        }
    }
    
    @IBAction func buttonBressed(_ sender: UIButton) {
        notification.someBusinessLogic()
    }
    
}

