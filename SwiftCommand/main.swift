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


// 函数类型
/*
  Kotlin的lambda
 
 val fullLambda : (Int,Double)->Boolean = {
         number:Int,number2:Double -> Boolean  // lambda表达式中函数参数不能用() 没有参数就留空
             if (number.toDouble() == number2) {
                 //return true ;
                 true ;
             } else  {
                 false ;
             }//  在非内联的Lambda表达式中不能使用 return
     }
 
 */

let funcVar:(Int,Double)->Bool =  {

    (min:Int, max:Double)-> Bool in

    let sum = Double(min) + max ;
    print("函数作为第一类值 \(sum)");
    return true ;
}

let funcVarSimple:(Int,Double)->Bool =  {
    min, max in // 自动推断类型 不用写() 和 ->返回值类型
    let sum = Double(min) + max ;
    return sum != 0 ; // 除非只有单行 才不用return ; 跟kotlin不一样 必须return
}

let funcVarMoreSimple:(Int,Double)->Bool =  { Double($0) + $1 != 0   }
// 自动参数名字  省略 参数名字和 in
// 单行表达式。  省略return

print("最简化的闭包 \(funcVarMoreSimple(1,1)) , \(funcVarMoreSimple(1,-1.0))  ") // 最简化的闭包 true , false

/*
 
 非逃逸闭包: 一个接受闭包作为参数的函数， 闭包是在这个函数结束前内被调用。
 逃逸闭包: 一个接受闭包作为参数的函数，该闭包可能在函数返回后才被调用，也就是说这个闭包逃离了函数的作用域
 (包括最为返回值 或者 DispatchQueue.global().async 异步执行)
 
 当你声明一个接受闭包作为形式参数的函数时，你可以在形式参数前写@escaping来明确闭包是允许逃逸
 
 逃逸闭包的生命周期长于函数，函数退出的时候，逃逸闭包的引用仍被其他对象持有，不会在函数结束时释放。
 
 为什么要分逃逸闭包和非逃逸闭包

 为了管理内存，闭包会强引用它捕获的所有对象，
 比如你在闭包中访问了当前控制器的属性、函数，
 编译器会要求你在闭包中显示 self 的引用，
 这样闭包会持有当前对象，容易导致循环引用。

 非逃逸闭包不会产生循环引用，它会在函数作用域内释放，
 编译器可以保证在函数结束时闭包会释放它捕获的所有对象；
 
 使用非逃逸闭包的另一个好处是编译器可以应用更多强有力的性能优化，
 例如，当明确了一个闭包的生命周期的话，
 就可以省去一些保留（retain）和释放（release）的调用；
 此外非逃逸闭包它的上下文的内存可以保存在栈上而不是堆上。

 综上所述，如果没有特别需要，开发中使用非逃逸闭包是有利于内存优化的，
 所以苹果把闭包区分为两种，特殊情况时再使用逃逸闭包。
 
 */
func MyFunc(fixInt:Int, closure:@escaping (Int,Double)->Bool ) -> (Double)->Bool
{
    return {
        (arg:Double) -> Bool in
        return closure(fixInt, arg);
    }
}

print("函数类型 闭包 \(funcVar(12,3.3))");

let MyFunc2 = MyFunc(fixInt:3) { // 闭包是函数最后一个参数 可以写在外面: 挂尾闭包
    (arg1:Int, arg2:Double) -> Bool in
    if (Double(arg1) == arg2) {
        return true ;
    } else {
        return false ;
    }
}

print("逃逸闭包 \(MyFunc2(12))"); // false
print("逃逸闭包 \(MyFunc2(3.0))");// true


// Swift中默认给参数局部参数名称和外部参数名称默认相同。
// 如果不想为方法的参数提供外部参数名称，在前面使用下划线 (_) 作为该参数的显式外部名称
func funcArgName(_ x:Int, _ y:Int, _ z:Int, _ w:Double) // 前面使用下划线 (_) 作为该参数的显式外部名称
{
    print("函数的局部名称和外部名称 \(x) \(y) \(z) \(w)");
}

funcArgName(1, 2, 3, 4);
//funcArgName(x:1, y:2, z:3, w:4); // 如果函数声明时候没有 _   必须显式使用外部参数名(默认跟内部参数名一样)

let obj1 = ConsoleIO();
obj1.funcArgName(x:1, y:2, z:3, w:4);


let array1 = ["0", "1" , "2" , "3"]
let range = 0..<array1.count  // 区间运算符 返回类型是Range<int>   半开区间,适合遍历数组
for idx in range
{
    print("idx = \(array1[idx])" );
}


func ifFunc(_ arg:String?)
{
    if let n = arg // n的类型是 String 不是可选类型
    {
        print("ifFunc arg is NOT nil \(n)")
    }
    else
    {
        //print("ifGurad arg is nil \(n)") // 不能用n 在else块中 n是没有定义的
        print("ifFunc arg is nil");
        return
    }
}

func guardFunc(_ arg:String?)
{
    guard let n = arg  else {
        print("ifGurad arg is nil  ")
        return
    }
    // 这里是可以使用 局部变量n的
    print("ifGurad arg is NOT nil \(n)")
   
}

ifFunc("hello"); // ifFunc arg is NOT nil hello
guardFunc(nil);  // ifGurad arg is nil


// 枚举类型
enum Movement:Int {
    case LEFT
    case RIGHT
    case TOP
    case BOTTOM
}

/*
 整型(Integer)
 浮点数(Float Point)
 字符串(String)
 布尔类型(Boolean)
 */


let aMove = Movement.LEFT


switch aMove {
case Movement.LEFT:
    print("Enum switch Left")
case .RIGHT: // 省略 Movement.
    print("Enum switch right")
default:
    print("Enum default");
}

if aMove == .RIGHT {
    print("enum match");
} else {
    print("enum not match");
}

// enum 算是特殊的class DG GZ都是实例化的对象 构造函数是private的
enum Area: String {
    case JM = "jiangmen"
    case GZ = "guangzhou"
    case SZ = "shenzhen"
    
    func introduce() -> String {
        switch self {
        case .JM: return "I come from jiangmen "
        case .GZ: return "I come from guangzhou "
        case .SZ: return "I come from shenzhen "
        default:
            return "I don't know where i come from"
        }
    }
    
    // 属性  计算属性 只能读取  没有 { get{} set{} }
    var name: String {
        switch self {
        case .JM,.GZ,.SZ : return self.rawValue
        default:
            return "unknown"
        }
    }
}

print("enum string raw value \(Area.GZ.rawValue)") // guangzhou

if let newArea = Area.init(rawValue: "zhongshan") {
    print("使用原始值类型定义枚举 match \(newArea)")
} else {
    print("使用原始值类型定义枚举 not match enum ")
}

print("enum function \(Area.JM.introduce())")

print("只读属性 \(Area.JM.name)")

// 关联值
//   枚举类型中在枚举项的旁边"存贮额外的其他类型的值"，这些值被称为关联值。
//   并且每次在代码中使用有关联值的枚举项时，该关联值都会有所不同。
//   Swift中可以定义枚举以"存储任何给定类型的关联值"，并且每个枚举项的值类型也可以不同
enum Trade {
    case Buy(stock:String,amount:Int)
    case Sell(stock:String,amount:Int,fax:Double)
    case Pend(String,Int,Bool) // 这样不用外部参数名字
    
    // 增加一个存储属性到枚举中不被允许，但你依然能够创建计算属性
    // 计算属性的内容都是建立在枚举值下或者枚举关联值得到的
    var info:String {
        switch self {
        case .Buy(let stock, let amount):
            return  "stock:\(stock),amount:\(amount)"
        case .Sell(let stock, let amount, let fax):
            return  "stock:\(stock),amount:\(amount) fax:\(fax)"
        case .Pend(let name, let total, let full):
            return "name:\(name),total:\(total) full:\(full)"
        }
    }
    
}

// 枚举的case可以传值
let trade = Trade.Buy(stock: "003100", amount: 100)

// 使用Switch语句  匹配枚举项  并且  提取 "枚举项的关联值"
// 可以使用let和var将每个关联值  "提取为常量或变量" ，以在case的正文中使用

switch trade {
case .Buy(let stock, let amount):
    print("stock:\(stock),amount:\(amount)")
case .Sell(let stock, let amount, let fax):
    print("stock:\(stock),amount:\(amount) fax:\(fax)")
case .Pend(let name, let total, let full):
    print("name:\(name),total:\(total) full:\(full)")
}


print("enum只读属性 与关联值  \(Trade.Pend( "shanghai", 12, false).info)" )


