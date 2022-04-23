//
//  ViewController.m
//  SQLite3
//
//  Created by zxc on 2022/4/22.
//

#import "ViewController.h"
#import "SQLite3Tools.h"
#import "Shop.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//创建表
- (IBAction)createTableBtn:(UIButton *)sender
{
    [SQLite3Tools createTable];
}
//插入数据

- (IBAction)insertTableBtn
{
    Shop *shop=[[Shop alloc]init];
    shop.name=[NSString stringWithFormat:@"白菜-%d",arc4random() % 200];
    shop.price=(arc4random() % 10);
    
    [SQLite3Tools insertTable:shop];
    //执行查询
    [self selectTableBtn];

}
//查询数据库
- (IBAction)selectTableBtn
{
   NSMutableArray *array= [SQLite3Tools selectTableAll];
    for (Shop *shop in array) {
        NSLog(@"shop:name=%@,price=%f",shop.name,shop.price);
    }
}
//更新数据库
- (IBAction)updateTableBtn
{
    NSLog(@"更新前数据：");
    [self selectTableBtn];
    [SQLite3Tools updateTable];
    NSLog(@"更新后数据：");
    [self selectTableBtn];
}
//删除表格数据
- (IBAction)deleteTableBtn
{
    NSLog(@"删除前数据：");
    [self selectTableBtn];
    [SQLite3Tools deleteTable];
    NSLog(@"删除后数据：");
    [self selectTableBtn];
}

@end
