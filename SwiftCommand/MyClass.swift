//
//  MyClass.swift
//  SwiftCommand
//
//  Created by hehanlong on 2020/10/24.
//

import Foundation


class MyClass
{
    let name:String
    var info:String?
    
    init(){
        name = "Return from initializer without initializing all stored properties"
    } // 错误 没有初始化 所有的存储属性  Return from initializer without initializing all stored properties
    
}
