//
//  main.swift
//  SwiftCommand
//
//  Created by hehanlong on 2020/10/9.
//

import Foundation

print("Swift没有main函数,但是它有一个main文件. ")

// used before being initialized
// var MyInitNilInt:Int ; // 如果没有初始化 swift不会自动初始化 包括基础类型
// print("MyInitNilString = \(MyInitNilInt)");

// 声明变量时在类型后添加？或者！就是告诉编译器这个一个Optional的变量，如果没有初始化，你就将其初始化为nil
var MyInitNilInt:Int? ;  // 可选类型 就可以不初始化。swift会自动初始化为nil
print("MyInitNilInt = \(MyInitNilInt)"); //


// 叹号！
// a.声明时添加！，告诉编译器这个是Optional的，并且之后对该变量操作的时候，都隐式的在操作前添加！
// b.在对变量操作前添加！，表示默认为非nil，直接解包进行处理
//do {
//    var MyInitNilString:String! ;
//
//    // 编译通过 由于声明变量是! 所以这里不用写! 而是自动拆包
//    /// 但是运行出错 Fatal error: Unexpectedly found nil while implicitly unwrapping an Optional value  对可选类型值做隐式拆包 发现nil
//    try print("MyInitNilString = \(MyInitNilString.count)");
//} catch {
//    print("Excepetion");
//}

// 在默认情况下，当向一个整数赋超过它容量的值时，Swift 会报错而不是生成一个无效的数，给我们操作过大或者过小的数的时候提供了额外的安全性
// 三个算术溢出运算符来让系统支持整数溢出运算
// 溢出加法 &+
// 溢出减法 &-
// 溢出乘法 &*
var num1:UInt8 = 251
//var num2 = num1 + 20    // 溢出了 // Swift runtime failure: arithmetic overflow
var num2 = num1 &+ 20
print(num2)         // 输出为 15
print("整数溢出 num2 = \(num2)")


var a1 = 251 ;
var a2 = (251 + 20)%255
print("[求余的结果 = \(a2)", "跟溢出的结果不一样", separator:"][", terminator:"]\n") // = 16  terminator要自己加\n

var myDouble = 40.0 ; // 字面值推断是Double
var myFloat:Float = 14;


let CONST_VALUE = 12 ;
// CONST_VALUE = 13 ; // let是一个常量
print("CONST_VALUE is  \(CONST_VALUE), myDouble = \(myDouble) , myFloat = \(myFloat)")
// 采用斜线与小括号() 类似kotlin的模版字符串

let uninitialFlag:Bool ; // 没有初始值 必须声明类型

//print("uninitialFlag \(uninitialFlag)") // Constant 'uninitialFlag' used before being initialized

 
uninitialFlag = false ;
print("uninitialFlag = \(uninitialFlag) ") // uninitialFlag = false


let output = ConsoleIO();

output.writeMessage(msg: "main write message", to: OutputType.error)

print("switch with float -> \(output.switchFloat(value:6))") // 函数实参 使用 命名参数
 
print("switch with float -> \(output.switchFloat(value:9))")


//  var someDict = [KeyType: ValueType]() 字典键值对，是比较常用的容器


// 一个NSDictionary对象桥接之后的结果是[NSObject : AnyObject]字典
// (键为NSObject类型,值为AnyObject类型的Dictionary字典)。

var dict = [Int: String]()
var dict2:[Int: String] = [1:"One",2:"Two",3:"Three"]
var dict3:Dictionary<Int,String> = [1:"Cat",2:"Dog",3:"Sheep"]

for (key,value) in dict3
{
    print("遍历字典 (key=\(key),value=\(value))");
}

print("字典  \(dict2)");

if (dict2[5] == nil) {
    print("访问字典不存在的key, 返回值为nil")
}


let OcNumber = NSNumber.init(value: 12)
let originInt = OcNumber.intValue // 没有参数 不用()

print("Int -> NsNumber -> Int  \(originInt)")


let tuple = (one:"1", two : "2" , three :"3")
print("tuple \(tuple.one) \(tuple.2)");

// 输入数组 返回元组的函数
func MyTutleFuntion(array:Array<Int>)->(max:Int, min:Int)
{
    var max:Int = array[0];
    var min:Int = array[0];
    for element in array
    {
        if (element > max) {
            max = element ;
        } else if (element < min) {
            min = element ;
        }
    }
    
    return  (max, min)
}

let testArray:Array<Int> = [15,-101,8,-100,20,5]

let tupleResult = MyTutleFuntion(array:testArray);

print("输入数组 返回元组的函数 \(tupleResult.0) \(tupleResult.min) "); // 元祖下表从0开始

struct Person
{
      var age:Int = 0 ;
      var name:String = "";
}

enum ErrorTest:Error { // Error这个protocol，定义一下自己错误类型
    case nameVisiableError
    case ageError
    case heightError
    case nameLengthError
}

// 可以抛出错误的方法 必须 在方法声明的后面加上throws关键字，表示该方法可以抛出错误 否则编译出错
func checkPerson(p:Person) throws -> String {
       guard p.age>0 && p.age<120 else {
           throw ErrorTest.ageError
       }
       guard p.name.count<10 && p.name.count>0 else {
           throw ErrorTest.nameVisiableError
       }
      return "success"
   }

let p2 = Person(age: 1000, name: "小明") // 结构体可以逐一显式设置成员属性的值，类不可以

do {
    
//    try：会执行函数之后抛出函数
//    try?是选择类型的执行，当报错的时候，返回nil，不报错的时候返回正常的值
//    try!是强制解包，当抛出异常的时候也解包，导致崩溃问题。
    
    let result2 = try checkPerson(p: p2) // try后面必须接用throws 修饰的函数或方法，
    //不报错 下边会输出，报错则不执行
    try print("try的结果是", result2) // 只是警告 No calls to throwing functions occur within 'try' expression
} catch let error { // 可以不写error 默认是error
    //报错则执行相对应的错误类型
    switch error {
    case ErrorTest.ageError:
        print("ageError"); //break 可以没有break
    case ErrorTest.nameLengthError:
        print("nameLengthError"); //break
    case ErrorTest.nameVisiableError:
        print("nameLengthError"); //break
    case ErrorTest.heightError:
        print("heightError"); //break
    default:
        break
   }
}
