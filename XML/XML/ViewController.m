//
//  ViewController.m
//  XML
//
//  Created by zhangzh on 16/6/20.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "ViewController.h"
#import "DDXML.h"

@interface ViewController ()

@end

@implementation ViewController

//1.DOM的解析方式,主流使用
//2.SAX,读取一点xml,解析一部分,适合大数据量

/**
 *
 <catalog>
 <cd country="USA">
     <title>Empire Burlesque</title>
     <artist>Bob Dylan</artist>
      <price>10.90</price>
 </cd>
 
 <cd country="UK">
 <title>Hide your heart</title>
 <artist>Bonnie Tyler</artist>
 <price>9.90</price>
 </cd>
 
 <cd country="USA">
 <title>Greatest Hits</title>
 <artist>Dolly Parton</artist>
 <price>9.90</price>
 </cd>
 </catalog>
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //2.Xpath语句
    //1.读取整个xml文档
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"file.xml" ofType:nil];
    
    DDXMLDocument *document=  [[DDXMLDocument alloc]initWithData:[NSData dataWithContentsOfFile:filePath] options:0 error:nil];
    
    
    //1.定位节点
    
    //创建读取的路径
//    NSString *xpath = @"/catalog/cd/title";
//    
//    //2.根据节点的路径,找出对应的节点
//    
//     NSArray *titles= [document nodesForXPath:xpath error:nil];
//    
//    for (DDXMLElement *title in titles) {
//        NSLog(@"%@",title.stringValue);
//    }
    
    //未知查询
//    NSString *path1 = @"/catalog/cd/*";
//    NSArray *titles= [document nodesForXPath:path1 error:nil];
//    
//    for (DDXMLElement *title in titles) {
//        NSLog(@"%@",title.stringValue);
//    }

    //分支查询下标从1开始
    NSString *xpath = @"/catalog/cd[last()]";
    NSError *erro = nil;
    
    NSArray *titles= [document nodesForXPath:xpath error:&erro];
    
        for (DDXMLElement *title in titles) {
            NSLog(@"%@",title.stringValue);
        }

    NSLog(@"%@",erro);

}
//以遍历的方式读取xml
- (void)haha{
    //1.读取整个xml文档
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"file.xml" ofType:nil];
    
    DDXMLDocument *document=  [[DDXMLDocument alloc]initWithData:[NSData dataWithContentsOfFile:filePath] options:0 error:nil];
    //1.获取到子节点
    
    NSArray *catalogs= document.children;
    
    for (DDXMLElement *catalog in catalogs) {
        
        //获取catalog子节点
        NSArray *cds = catalog.children;
        
        for (DDXMLElement *cd in cds) {
            //获取到cd节点的属性
            
            DDXMLNode *att= [cd attributeForName:@"country"];
            
            NSLog(@"cd节点的属性名是%@,值为%@",att.name,att.stringValue);
            
            //继续获取子节点
            NSArray *subElements= cd.children;
            
            for (DDXMLElement *element in subElements) {
                
                NSLog(@"节点名%@,节点值为%@",element.name,element.stringValue);
            }
        }
        
    }
    

}
/*
 
 <movie country=@"USA">
 <title>小黄人</title>
 <year>2015</year>
 
 </movie>
 */
- (void)XMLParser{
    //拼接xml
    //(1)创建跟标签
    DDXMLElement *movie = [DDXMLElement elementWithName:@"movie"];
    //添加属性
    DDXMLElement *att = [DDXMLElement attributeWithName:@"country" stringValue:@"USA"];
    
    //给节点添加属性
    [movie addAttribute:att];
    
    //创建子节点
    
    DDXMLElement *title = [DDXMLElement elementWithName:@"title" stringValue:@"小黄人"];
    
    //将子节点添加到父节点上
    
    [movie addChild:title];
    
    DDXMLElement *year = [DDXMLElement  elementWithName:@"year" stringValue:@"2015"];
    
    [movie addChild:year];
    
    
    //将拼接好的xml转换为字符串
    
    NSLog(@"%@",movie.XMLString);

}

@end
