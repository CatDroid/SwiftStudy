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
 
}


func entry() -> Void
{
    var temp:MyStruct = MyStruct(a: 12, b: true) ;
    temp.a = 3 ;
    
    var temp2:MyStruct = temp ;
    temp2.a = 4 ;
    print("结构体 数组 集 字典 和 枚举等都是值类型，在变量复制 函数传递鞥都是复制/值复本 \(temp2.a) \(temp.a)")
}
