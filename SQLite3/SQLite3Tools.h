//
//  SQLite3Tools.h
//  SQLite3
//
//  Created by zxc on 2022/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Shop;

@interface SQLite3Tools : NSObject

//创建表格
+(void)createTable;
//插入数据
+(void)insertTable:(Shop *)shop;
//查询数据
+(NSMutableArray *)selectTableAll;
//更新数据
+(void)updateTable;
//删除表格数据
+(void)deleteTable;

@end

NS_ASSUME_NONNULL_END
