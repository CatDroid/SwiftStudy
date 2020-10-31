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
    
    // 协议不用指定属性是计算还是存储 只要指定名字 类型和 只读还是可读可写  具体实现类结构体中 属性可以是存储属性也可以是计算属性
    var readWriteProperty:String {get set}
    
    //static let classProperty:Int{get set} //error  'let' declarations cannot be computed properties
    //static let classProperty:Int{get}  // error 'let' declarations cannot be computed properties
    // 协议(protocol)不能简单地定义一个值必须是常量，也不应该定义一个常量，即，实现细节必须由实现它的类/结构来照顾(或决定)
    static var classProperty:String{get}
    
    mutating func flip();
    
    // 通过协议规定“实现类” 去实现特定的构造函数
    init(read:Bool, info:String)
}

protocol MyProtocal2 {
    func showName() -> String ;
}

protocol MyProtocal3: MyProtocal2 {
    func dumpName() ;
}

protocol MyProtocol4 {
    func dumpId();
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

// 在扩展中实现协议
extension MyProtocalEnum: MyProtocal2 {
    func showName() -> String {
        if (self == .ON) {
            return "在扩展中实现协议 ON"
        } else {
            return "在扩展中实现协议 OFF"
        }
    }
}

extension MyProtocalEnum: MyProtocal3 {
    func dumpName() {
        if (self == .ON) {
            print("协议的继承 在扩展中已实现协议不用再实现 ON")
        } else {
            print("协议的继承 在扩展中已实现协议不用再实现 OFF")
        }
    }
}

extension MyProtocalEnum: MyProtocol4 {
    func dumpId()
    {
        print("MyProtocalEnum not valid");
    }
}

// 协议的组合。函数参数必须满足两个协议
func callProtocolComposition(obj:  MyProtocol4 & MyProtocal3 )
{
    obj.dumpName();
    obj.dumpId();
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
        temp = MyProtocalEnum(flag:true)
    } else {
        temp = MyProtocalImplementClass(true, "first")
    }
    
    // 检查协议一致性
    // is 检查是否实现某个协议
    // as 对协议类型进行转换 as?没有实现类型时候返回nil as!没有实现类型异常
    
    // Value of type 'MyInterface?' does not conform to 'MyProtocal3' in coercion
    //if let temp3 = temp as MyProtocal3 {
    let temp3:AnyObject = temp as AnyObject; // 不能是Any Any is MyProtocal3 总是返回false
    let temp5:Any = temp as Any;
    print("temp = \(temp)");
    print("AnyObject is protocol? \(temp3 is MyProtocal3)");
    print("Any is protocol? \(temp5 is MyProtocal3)");
    if let temp4 = temp3 as? MyProtocal3 {
        print("as?没有实现类型时候返回nil");
        temp4.dumpName();
    }
    // AnyObject：可以代表任何class类型的实例；
    // Any：可以代表任何类型，甚至包括方法(func)类型。
     
    

    printAdd(temp);
    temp.flip()
    print("协议中函数声明为mutating,那么变量声明必须是var :\(String(describing: temp))");
    
    
    
    let temp2 = MyProtocalEnum(flag:true);
    print("\(temp2.showName())");
    temp2.dumpName(); // 扩展已经实现过的协议不用重复
    callProtocolComposition(obj:temp2);
    
}
