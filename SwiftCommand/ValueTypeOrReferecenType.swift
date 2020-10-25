//
//  ValueTypeOrReferecenType.swift
//  SwiftCommand
//
//  Created by hehanlong on 2020/10/24.
//

import Foundation



struct MyStruct
{
    var a:Int = 2 ;
    var b:Bool = false ;
    
    // 如果自定义了构造函数，就不会有默认构造函数
//    init(temp1:Int) {
//        a = temp1
//    }
 
    
//    deinit { // Deinitializers may only be declared within a class
//        statements
//    } // 只有类(引用类型)才可以使用析构
}

// 结构体不可以被继承
//struct MyStruct2:MyStruct
//{
//
//}


class Base
{
    var name:String
    
    init(n:String) {
        name = n;
    }
    
    convenience init()
    {
        self.init(n:"default");// 便利构造函数 只能被本类调用和调用本类 ，便利函数链(构造链) 必须以指定构造函数结束
    }
    
    func overrideFunc(n:String)
    {
        print("Base overrideFunc \(n)")
    }
    
    deinit {
        print("Base deinit");
    }
    
}

class SubClass:Base
{
    var id:Int
    
    
    //  指定构造函数必须总是向上委托
    //  便捷构造函数必须总是横向委托
    init(id:Int) {
        self.id = id ;
        super.init(n:"Default");
       // super.init(); // Must call a designated initializer of the superclass 'Base' 子类的指定构造函数必须从它的直系父类调用指定构造函数
    } // 'super.init' isn't called on all paths before returning from initializer 给定构造函数必须调用父类构造函数
    
    
    init(n:String,id:Int)
    {
        self.id = id ; // 必须在调用父类构造函数/便利构造函数前 初始化本类的存储属性
        super.init(n: n)
        //self.id = id ; // Property 'self.id' not initialized at super.init call
    }
    
    // Overriding declaration requires an 'override' keyword 与父类的构造函数一样 需要override
    
    // 给定构造函数 不能 委托本类的构造函数
    // Designated initializer for 'SubClass' cannot delegate (with 'self.init');
    override convenience init(n:String) {
        self.init(n:n, id:12)
    }
    
    
    convenience init(name:String) { // 重写必须是 函数名字 类型 和 参数名字 都一样
        self.init(n:name, id:0)
    }
    
    
    func overrideFunc(n:String) ->String  // 函数名字 + 外参数名字(内参数可以不一样) + 类型 都一样 才是重写 ， 返回类型(但是这样会造成调用模棱两可) 加上override会报告错误
    {
        print("SubClass overrideFunc \(n)")
        return ""
    }
    
    // 只能有一个析构函数
    // 无参数  不用()  无返回值
    // 先子类后父类  不用super.deinit()
    deinit {
        print("SubClass deinit");
    }
    
    
}


enum MyError: Error // Error 是个协议 所有错误都必须继承
{
    case OUT_OF_RANGE
    case BAD_ID
    // Swift 枚举中支持以下四种关联值类型: 整型(Integer); 浮点数(Float Point); 字符串(String); 布尔类型(Boolean)
    case EXCEPTION(info:String) // 枚举关联值
}

class FailClass
{
    let id:Int ;
    let str:String;
    init? (id:Int) {
        if (id == 0) {
            return nil;
        }
        self.id = id ;
        self.str = "default"
    }
    
    func isValid() throws
    {
        if (id < 0) {
            throw MyError.BAD_ID;
        }
    }
    
    func isOutOfRange() throws -> Bool
    {
        if (id > 10) {
            throw MyError.OUT_OF_RANGE
        }
        return false
    }
    
    func getException() throws
    {
        if (str.isEmpty) {
            throw MyError.EXCEPTION(info: "Name is empty")
        }
        if (str.count > 10) {
            throw MyError.EXCEPTION(info: "Name is too long")
        }
        
    }
    
    // return nil 代表失败，并且整个构造函数链立刻返回
    // 子类可用不可失败的构造函数overrid父类的可失败构造函数
    //A non-failable initializer cannot delegate to failable initializer
    // 不可失败构造函数 不能委托 可失败构造函数
    //convenience init(){
    //    self.init(id:12);
    //}
    
    
    // 通过‘函数或者闭包’设置属性的默认值,最后()代表执行
    let boardColors:[Bool] = { // [Bool] = Array<Bool>
        
        var temp = [Bool]()
        
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temp.append(isBlack)
                isBlack = !isBlack
            }
        }
        
        return temp
    }()
    

}

var dictTest = [
    "name" : false ,
    "ok" : true
]

func test(key:String)
{
    let nullableFlag: Bool? = dictTest[key]
    
    guard let flag = dictTest[key]  else {
        //print("guard flag? is \(flag)") //Variable declared in 'guard' condition is not usable in its body
        print("guard is false")
        return
    } // guard' body must not fall through, consider using a 'return' or 'throw' to exit the scope
    // guard的block必须return或者throw
    print("guard is true \(flag)");
    
    
    let name: String? = "老王"
    let age: Int? = 10

    // if let 连用,判断对象的值是否为'nil'
    if let nameNew = name,  let ageNew = age { // nameNew和 ageNew的作用域仅在{}中
        
        // 进入分支后,nameNew 和 ageNew 一定有值
        print(nameNew + String(ageNew)) // 输出:老王10
    }
    
}

func entry() -> Void
{
    var temp:MyStruct = MyStruct(a: 12, b: true) ;
    temp.a = 3 ;
    
    var temp2:MyStruct = temp ;
    temp2.a = 4 ;
    print("结构体 数组 集 字典 和 枚举等都是值类型，在变量复制 函数传递鞥都是复制/值复本 \(temp2.a) \(temp.a)")
    
    
    var temp3:SubClass = SubClass(n:"ConvenienceName");
    
    let result:String  = temp3.overrideFunc(n:"call with result "); // No exact matches in call to instance method 'overrideFunc'

    //temp3.overrideFunc(n:"call with result "); // 模棱两可的使用  Ambiguous use of 'overrideFunc(n:)'
    
    // 默认不自动继承父类的构造函数，除非
    // 1.子类引入的新属性都有默认值，子类没有定义指定构造函数--就会自动继承父类的指定构造函数
    // 2.子类提供了所有父类的指定构造函数(包含1方式或者自定义方式)，就会自动继承父类的便利构造函数
    let temp4 = SubClass(); // 调用了SubClass继承Base的便利构造函数convenience init() 其中self.init委托给了 SubClass的便利构造函数convenience init(name:String)
    print("init() = \(temp4.id) \(temp4.name)")
 
    
    let fail:FailClass? = FailClass(id:0);
    
    print("可失败构造函数 init? \(fail)")
    
    let excpetion:FailClass? = FailClass(id:30); // 30 -1
    do {
        try excpetion?.getException(); // Call can throw, but it is not marked with 'try' and the error is not handled
        let result:Bool? = try excpetion?.isOutOfRange(); // Errors thrown from here are not handled
        print("错误处理 \(result ?? false) ")  // 空合操作符
        try excpetion?.isValid();      // 如果函数声明了throws 必须try 以及用do catch来handle
    } catch MyError.EXCEPTION(let information) { // 参数还可以这个形式 info:String
        print("Enum Error \(information)")
    } catch MyError.BAD_ID {
        print("bad id");
    } catch MyError.OUT_OF_RANGE {
        print("id is out of range");
    } catch { // 加入一个空的catch，用于关闭catch。否则会报错：Errors thrown from here are not handled because the enclosing catch is not exhaustive
        
    }
    
    //try! excpetion?.isValid(); // 不处理错误: 'try!' expression unexpectedly raised an error: SwiftCommand.MyError.BAD_ID
    
    // 错误时候返回nil
    if let resultOfRange = try? excpetion?.isOutOfRange() { // 将错误转换为可选类型
        print("out of range \(resultOfRange)") // false  if-let 变量为false 也会执行,只是用来判断非空
    }
    
    let resultOfRange = try? excpetion?.isOutOfRange()
    if  resultOfRange != nil  {
        print("out of range \(resultOfRange)") // false
    }
    
    //print(resultOfRange); // Cannot find 'resultOfRange' in scope
    

    test(key:"name");
    

    
    print("End of Entry");
    
}
