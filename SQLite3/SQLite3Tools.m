//
//  SQLite3Tools.m
//  SQLite3
//
//  Created by zxc on 2022/4/22.
//

#import "SQLite3Tools.h"
#import <sqlite3.h>
#import "Shop.h"

@implementation SQLite3Tools
static sqlite3 *db;
+(void)initialize
{
    //打开数据库(连接数据库)
    NSString *filename=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"shops.sqlite"];
    //如果数据库文件不存在，系统会自动创建文件自动初始化数据库

    int status=sqlite3_open(filename.UTF8String, &db);
    if (status==SQLITE_OK) {//打开成功
        NSLog(@"打开数据库成功");
    }else{
        NSLog(@"打开数据库失败");
    }
}
//创建表
+(void)createTable
{
        //创建表
        const char *sql="create table if not exists t_shop(id integer primary key,name text not null,price real);";
        char *errmsg=NULL;
        sqlite3_exec(db, sql, NULL, NULL, &errmsg);
        if (errmsg) {
            NSLog(@"创表失败---%s",errmsg);
        }else{
            NSLog(@"创表成功---%s",errmsg);
        }
}
//插入数据
+(void)insertTable:(Shop *)shop
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_shop(name, price) VALUES ('%@', %f);",shop
                     .name, shop.price];
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
}
//查询数据
+(NSMutableArray *)selectTableAll
{
    NSMutableArray *array=[NSMutableArray array];
    
    const char *sql="select name,price from  t_shop;";
    //stmt用来取出查询结果的
    sqlite3_stmt *stmt=NULL;
    int status=sqlite3_prepare(db, sql, -1, &stmt, NULL);
    if (status==SQLITE_OK) { //准备成功-- SQL语句正确
        while(sqlite3_step(stmt)==SQLITE_ROW) {
            Shop *shop=[[Shop alloc]init];
            const unsigned char *name=sqlite3_column_text(stmt, 0);
            const unsigned char *price=sqlite3_column_text(stmt, 1);
            shop.name=[NSString stringWithUTF8String:name];
            shop.price=[[NSString stringWithUTF8String:price] floatValue];
            [array addObject:shop];
        }
    }
    return array;
}

//更新数据
+(void)updateTable
{
    NSString *sql = [NSString stringWithFormat:@"update t_shop set price=%u;",arc4random()%5];
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
}
//删除表格数据
+(void)deleteTable
{
    
    NSString *sql = [NSString stringWithFormat:@"delete from t_shop"];
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
}
@end
