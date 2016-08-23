//
//  ViewController.m
//  runtime
//
//  Created by czbk on 16/8/22.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController



//class_copyIvarList（）返回一个指向类的成员变量数组的指针
//class_copyPropertyList（）返回一个指向类的属性数组的指针
- (void)viewDidLoad {
    [super viewDidLoad];

    
    unsigned int count = 0;
    
    /*
        Ivar:表示成员变量类型
        获取一个指向该类,成员变量的指针
     */
    Ivar *ivars = class_copyIvarList([Person class], &count);
    
    //遍历
    for(int i = 0; i< count; i++){
        //根据ivar获得成员变量的名称(是C语言字符串)
        Ivar ivar = ivars[i];
        
        //
        const char *name = ivar_getName(ivar);
        
        //转换成oc
        NSString *key = [NSString stringWithUTF8String:name];
        
        //打印
        NSLog(@"%d->%@",i,key);
    }
    
    
    
}

@end
