//
//  Extension.swift
//  SwiftCommand
//
//  Created by hehanlong on 2020/10/25.
//

import Foundation


extension Double {
    
    // 扩展 统一单位 转换成米
    var km: Double {
        return self * 1_000.0
    }
    var m: Double {
        return self
    }
    var cm: Double {
        return self / 1_00.0
    }
    var mm: Double {
        return self / 1_000.0
    }
    
    // 基本工资 + 绩效 -> 实际工资
    subscript(okr: Int) -> Double
    {
        var base = self > 0 ? self: 1000 ; // 最低工资100
        var myokr = okr > 10 ? 10 : okr ; // okr [0,10]
        myokr = myokr < 0 ? 0 : myokr;
        
        var mymoney = base
        while(myokr > 0) {
            mymoney += 1000;
            myokr -= 1
        }
        return mymoney
    }
    
    // 扩展中新增嵌套类型
    enum Direction {
        case Negative
        case Zero
        case Postive
    }
    
    var Signature:Direction {
        if self < 0 {
            return Direction.Negative
        } else if (self == 0) {
            return Direction.Zero
        } else {
            return Direction.Postive
        }
    }
    
} // 只能扩展类或实例 的 计算属性

// 只能扩展便利构造函数  不能是指定构造函数和析构函数

class GamePlayer {
    var money:Double
    init(dollar:Double) {
        money = dollar
    }
}

extension GamePlayer {
    convenience init(renminbi:Double) { // 参数名字不一样 不是同一个构造函数
        let dollar = renminbi * 6.0
        self.init(dollar:dollar); // 必须调用指定构造函数
    }
}

func dumpSignature(array:[Double])
{
    for i in array {
        switch(i.Signature) {
        case .Zero:
            print("0 ", terminator:"") // 必须使用.EnumCase 
        case .Negative:
            print("- ", terminator:"")
        case .Postive:
            print("+ ", terminator:"")
            
        }
    }
    print("");
}

func dictionnaryFun(_ temp:[Int:String]) -> Void
{
    for one in temp {
        print("dictionnary作为参数以及实参是字典字面量 \(one.key) \(one.value)")
    }
}

/**
 使用inout定义函数参数,调用时需加&符号
 */
func inc(_ i:inout Int) {
    i += 1
    //i++ // 为什么Swift删除了自增(++)和自减(--)运算符 https://www.zhihu.com/question/269146744
}

// 这是因为inout不是按引用传递，它只是在函数退出时写入调用方的参数的可变影子副本
// @escaping 逃逸闭包 不能捕捉 inout参数 
//
//func inc2(i: inout Int) -> () -> Int {
//
//    return {
//        () -> Int in
//        i += 1
//        return i
//    }  // 闭包中截获inout参数i
//}

func ExtensionEntry()
{

    print("厘米->米 \(114.5.cm)")
    
    let chinesePlayer = GamePlayer(renminbi:100);
    print("只能扩展便利构造函数 \(chinesePlayer.money)")
    
    
    print("扩展下标 \(12000[3])")
    
    print("扩展嵌套类型 \( (-200.0).Signature )") // 扩展嵌套类型 Negative
    
    dumpSignature(array:[-1.0, 2, 4.0, 0, 100, -2, -3.333]);
    
    dictionnaryFun([1:"one", 2:"two", 3:"three"])
    
    
    var argument = 0
    inc(&argument)
    print("输入输出参数(In-Out Parameter)  after 0->\(argument) ")
    
    
    
}

