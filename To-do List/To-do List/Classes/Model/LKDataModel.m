//
//  LKDataModel.m
//  To-do List
//
//  Created by likai on 2017/9/20.
//  Copyright © 2017年 yinbake. All rights reserved.
//

#import "LKDataModel.h"

@implementation LKDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadChecklists];
    }
    return self;
}

- (NSString *)documentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths firstObject];
    return documentPath;
}

- (NSString *)dataFilePath
{
    NSString *documentPath = [self documentDirectory];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"AllLists.plist"];
    return filePath;
}

- (void)saveDataToFile
{
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:self.lists forKey:@"AllLists"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void)loadChecklists
{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        self.lists = [unarchiver decodeObjectForKey:@"AllLists"];
        [unarchiver finishDecoding];
    }else{
        self.lists = [NSMutableArray array];
    }
}

@end
