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
    
    // return nil 代表失败，并且整个构造函数链立刻返回
    // 子类可用不可失败的构造函数overrid父类的可失败构造函数
    //A non-failable initializer cannot delegate to failable initializer
    // 不可失败构造函数 不能委托 可失败构造函数
    //convenience init(){
    //    self.init(id:12);
    //}
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
    
    
   
    
}
