//
//  ProtocolClass.swift
//  SwiftCommand
//
//  Created by hehanlong on 2020/10/25.
//

import Foundation


protocol MyInterface {
    func addToString(arg1:Int, arg2:Int) -> String
    
    var readOnlyProperty:Bool {get}
    
    var readWriteProperty:String {get set}
    
    //static let classProperty:Int{get set} //error  'let' declarations cannot be computed properties
    //static let classProperty:Int{get}  // error 'let' declarations cannot be computed properties
    // 协议(protocol)不能简单地定义一个值必须是常量，也不应该定义一个常量，即，实现细节必须由实现它的类/结构来照顾(或决定)
    static var classProperty:String{get}
    
    mutating func flip();
    
    // 通过协议规定“实现类” 去实现特定的构造函数
    init(read:Bool, info:String)
}


class MyProtocalImplementClass:MyInterface
{

    func addToString(arg1: Int, arg2: Int) -> String {
        return "\(arg1 + arg2)"
    }
    
    var readOnlyProperty: Bool
    
    var readWriteProperty: String
    
    
    init(_ opened:Bool, _ info:String)
    {
        print("MyProtocalImplementClass 指定构造函数");
        readOnlyProperty = opened
        readWriteProperty = info
    }
    
    // 协议的构造函数 必须require 必要的构造函数
    required init(read:Bool, info:String)
    {
        print("MyProtocalImplementClass 必要构造函数");
        readOnlyProperty = read
        readWriteProperty = info
    }
    
    static var classProperty: String = "MyProtocalImplementClass" ;
    
    // 'mutating' isn't valid on methods in classes or class-bound protocols
    // mutation 是不需要用在class中
    func flip() {
        print("nothing to do");
    }
    
}

enum MyProtocalEnum : MyInterface{
 

    case ON
    case OFF
    
    func addToString(arg1: Int, arg2: Int) -> String {
        return "MyProtocalEnum not implement "
    }
    
    // Enums must not contain stored properties enum不能包含存储属性
    var readOnlyProperty: Bool {
        get {
            return false
        }
    }
    
    var readWriteProperty: String {
        get {
            return "Enum 不支持 存储属性 "
        }
        
        set {
            print("如果protocal属性是读写的话，必须实现set和get ")
        }
    }
    
    static var classProperty: String = "MyProtocalEnum"
    
    mutating func flip() { // struct enum的方法如果可以修改成员 必须声明mutating 对应的协议也要声明mutation
        if self == .OFF {
            self = .ON ; // Enum case 'ON' cannot be used as an instance member
        } else {
            self = .OFF ;
        }
        
         
    }
    
    init(flag:Bool) {
        if (flag) {
            self = .ON ;
        } else {
            self = .OFF ;
        }
    }
    
    // required  非class中实现协议规定构造函数 不用required
    init(read:Bool, info:String)
    {
        if (read) {
            self = .ON ;
        } else {
            self = .OFF ;
        }
    }

    
}

func printAdd(_ obj:MyInterface)
{
    print("procotal function \(obj.addToString(arg1: 2, arg2: 3))")
}


func ProtocolClassEntry()
{
    //let temp:MyInterface! // Mutating method 'flip' may not be used on immutable value 'temp'
    var temp:MyInterface!
    
    // 0 ~ X 之间的随机数
    let NwNumber2 = arc4random() % 10
    if NwNumber2 > 5 {
        temp = MyProtocalImplementClass(true, "first")
    } else {
        temp = MyProtocalEnum(flag:true)
    }
    

    printAdd(temp);
    temp.flip()
    print("协议中函数声明为mutating,那么变量声明必须是var :\(String(describing: temp))");
    
}
