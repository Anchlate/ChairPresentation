//
//  NSString+BPString.m
//  FaceKTV
//
//  Created by PENG BAI on 15/4/13.
//  Copyright (c) 2015年 bp1010. All rights reserved.
//

#import "NSString+BPString.h"

@implementation NSString (BPString)

/***
 功能：得到一个文件存储的路径
 
 fileName: 文件名称
 
 返回值：返回一个文件存储的路径，其中文件名是fileName，后缀是.archive
 */

#pragma mark cachesDirectoryPathWithFileName
+ (NSString *)cachesDirectoryPathWithFileName:(NSString *)fileName
{
    NSString * str = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString * pih = [fileName stringByAppendingString:@".archive"];
    NSString * path = [str stringByAppendingPathComponent: pih];
    
    return path;
}

/**
 *
 *
 *  @param fileName <#fileName description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)documentDirectoryPathWithFileName:(NSString *)fileName
{
    NSString *str = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *path = [str stringByAppendingPathComponent:fileName];
    
    return path;
}

/**
 *  create the path of pdf
 *
 *  @param fileName: name of the pdf file
 *
 *  @return the path of pdf file
 */
+ (NSString *)pdfFilePathInDoucumentDirectoryWithFileName:(NSString *)fileName
{
    // 1
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    // 2
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 3
    NSString *pdfFoldName = @"/PDF";
    
    // 4
    NSString *pdfFoldPath = [documentPath stringByAppendingString:pdfFoldName];
    
    // 5 如果不存在PDF文件夹就创建
    if (![fileManager fileExistsAtPath:pdfFoldPath]) {
        
        // 第二个参数：YES创建目录中不包含的父目录
        // NO如果目录中包含不存在的父目录，则失败
        [fileManager createDirectoryAtPath:pdfFoldPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    Log(@",,,%@", pdfFoldName);
    NSString *path = [pdfFoldPath stringByAppendingPathComponent:fileName];
    
    fileManager = nil;
    
    return path;
}

+ (NSString *)pdfDownloadMessagePathInDocumentDirectoryWithFileName:(NSString *)fileName
{
    // 1
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    // 2
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 3
    NSString *pdfFoldName = @"/PDF";
    
    // 4
    NSString *pdfFoldPath = [documentPath stringByAppendingString:pdfFoldName];
    
    // 5 如果不存在PDF文件夹就创建
    if (![fileManager fileExistsAtPath:pdfFoldPath]) {
        
        // 第二个参数：YES创建目录中不包含的父目录
        // NO如果目录中包含不存在的父目录，则失败
        [fileManager createDirectoryAtPath:pdfFoldPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *path = [pdfFoldPath stringByAppendingPathComponent:fileName];
    
    fileManager = nil;
    
    return path;
}




/**
 *  create the path of video in DocumentDirectory
 *
 *  @param videoName: the video name
 *
 *  @return the path of video file
 */
+ (NSString *)videoFilePathInDocumentDirectoryWithFileName:(NSString *)videoName
{
    
    // 1
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    // 2
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 3
    NSString *videoFoldName = @"/VIDEO";
    
    // 4
    NSString *videoFoldPath = [documentPath stringByAppendingString:videoFoldName];
    
    // 5 如果不存在VIDEO文件夹就创建
    if (![fileManager fileExistsAtPath:videoFoldPath]) {
        
        // 第二个参数：YES创建目录中不包含的父目录
        // NO如果目录中包含不存在的父目录，则失败
        [fileManager createDirectoryAtPath:videoFoldPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *path = [videoFoldPath stringByAppendingPathComponent:videoName];
    
    fileManager = nil;
    
    return path;
}


/***
 功能：判断是否是16进制字符串
 
 string: 16进制字符串
 
 返回值是BOOL型的值: YES表示该字符串是16进制字符串，NO则不是
 */
#pragma mark is0XNumber
+ (BOOL)is0XNumber:(NSString *)string
{
    if (string.length % 2) {
        return NO;
    }

    for (int i = 0 ; i < string.length; i++) {
        unichar ch = [string characterAtIndex:i];
        
        if ((ch >= 48 && ch <=57) || (ch >= 65 && ch <= 70) || (ch >= 97 && ch <= 102)) {
            continue;
        } else {
            return NO;
        }
    }
    return YES;
}

/***
 功能：将16进制字符串转换为ip
 
 string：16进制字符串
 
 返回值：将16进制字符串按异或操作得到的ip
 */

#pragma mark IPWith0XNumber
+ (NSString *)IPWith0XNumber:(NSString *)string
{
    static NSString *ip = nil;
    ip = @"";
    NSString *str = [string substringWithRange:NSMakeRange(0, 2)];
    
    long secretNum = strtoul([[NSString stringWithFormat:@"0x%@", str] UTF8String], 0, 16);
    
    for (int i = 2; i < string.length; i += 2) {
        NSString *subStr = [string substringWithRange:NSMakeRange(i, 2)];
        long field = strtoul([[NSString stringWithFormat:@"0x%@", subStr] UTF8String], 0, 16);
        long result = secretNum ^ field;
        ip = [ip stringByAppendingString:[NSString stringWithFormat:@"%ld.", result]];
    }
    
    ip = [ip substringWithRange:NSMakeRange(0, ip.length - 1)];
    
    return ip;
}

/***
 功能：获得一个urlString
 
 serverIP：ip地址
 
 port：服务器端口号
 
 function：请求该URL实现的功能
 
 plat：平台（iPhone，iPad，...）
 
 */
+ (NSString *)urlWithServierIP:(NSString *)serverIP port:(int)port function:(NSString *)function plat:(int)plat
{
    NSString *string = [NSString stringWithFormat:@"http://%@:%d/%@?plat=%d", serverIP, port,function, plat];
    return string;
}

/***
 功能：将一个中文字符串转换为对应拼音字符串
 
 chinese：中文字符串
 
 返回值：中文相对应的拼音，否则返回空
 
 */
+ (NSString *)spellStringChangeFromChinese:(NSString *)chinese
{
    NSMutableString *str = [[NSMutableString alloc] initWithString:chinese];
    if (CFStringTransform((__bridge CFMutableStringRef)str, 0, kCFStringTransformMandarinLatin, NO)) {
        if (CFStringTransform((__bridge CFMutableStringRef)str, 0, kCFStringTransformStripCombiningMarks, NO)) {
            NSString *s = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
            return s;
        }
    }
    return nil;
}


/***
 功能：将一个ip地址与一个随机数（9e,即：158）进行加密，得到一个加密后的16进制字符串
 
 iP：类似于192.18.1.175
 
 */

+ (NSString *)OXStringFromIP:(NSString *)ip
{
    NSArray *array = [ip componentsSeparatedByString:@"."];
    
    NSInteger reandNum = 158;
    
    NSMutableString *mutStr = [NSMutableString string];
    
    for (NSString *str in array) {
        
        NSInteger inte = [str integerValue] ^ reandNum;
        [mutStr appendString:[NSString stringWithFormat:@"%lx", inte]];
    }
    
    [mutStr insertString:[NSString stringWithFormat:@"%lx", reandNum] atIndex:0];
    
    return mutStr;
}

/***
 字典类型的字符串转字典
 */

+(NSDictionary *)BPParseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

/***
 将URL进行encode
 */
- (NSString *)URLEncodedString
{
    NSString *encodedString = (__bridge NSString *)
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"\"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8);
    return encodedString;
}

/***
 将post请求的参数和值转换成字符串
 */
+ (NSString *)parseParams:(NSDictionary *)params{
    
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    if (params) {
        //实例化一个key枚举器用来存放dictionary的key
        NSEnumerator *keyEnum = [params keyEnumerator];
        id key;
        while (key = [keyEnum nextObject]) {
            keyValueFormat = [NSString stringWithFormat:@"&%@=%@",key,[params valueForKey:key]];
            [result appendString:keyValueFormat];
        }
    }
    return result;
}

#pragma mark 考试答案缓存
+ (NSString *)examAnswerFilePathInDoucumentDirectoryWithExamId:(NSString *)examId
{
    // 1
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    // 2
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 3
    NSString *pdfFoldName = @"/examAnswer";
    
    // 4
    NSString *pdfFoldPath = [documentPath stringByAppendingString:pdfFoldName];
    
    // 5 如果不存在PDF文件夹就创建
    if (![fileManager fileExistsAtPath:pdfFoldPath]) {
        
        // 第二个参数：YES创建目录中不包含的父目录
        // NO如果目录中包含不存在的父目录，则失败
        [fileManager createDirectoryAtPath:pdfFoldPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *fileName = [examId stringByAppendingString:@".archive"];
    
    NSString *path = [pdfFoldPath stringByAppendingPathComponent:fileName];
    
    fileManager = nil;
    
    return path;
}

- (NSArray *)words
{
#if ! __has_feature(objc_arc)
    NSMutableArray *words = [[[NSMutableArray alloc] init] autorelease];
#else
    NSMutableArray *words = [[NSMutableArray alloc] init];
#endif
    
    const char *str = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    char *word;
    for (int i = 0; i < strlen(str);) {
        int len = 0;
        if (str[i] >= 0xFFFFFFFC) {
            len = 6;
        } else if (str[i] >= 0xFFFFFFF8) {
            len = 5;
        } else if (str[i] >= 0xFFFFFFF0) {
            len = 4;
        } else if (str[i] >= 0xFFFFFFE0) {
            len = 3;
        } else if (str[i] >= 0xFFFFFFC0) {
            len = 2;
        } else if (str[i] >= 0x00) {
            len = 1;
        }
        
        word = malloc(sizeof(char) * (len + 1));
        for (int j = 0; j < len; j++) {
            word[j] = str[j + i];
        }
        word[len] = '\0';
        i = i + len;
        
        NSString *oneWord = [NSString stringWithCString:word encoding:NSUTF8StringEncoding];
        free(word);
        [words addObject:oneWord];
    }
    
    return words;
}


+ (NSString *)documentDirectoryPath
{
    NSString *str = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    return str;
}


@end
