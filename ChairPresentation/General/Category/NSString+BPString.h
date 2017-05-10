//
//  NSString+BPString.h
//  FaceKTV
//
//  Created by PENG BAI on 15/4/13.
//  Copyright (c) 2015年 bp1010. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BPString)

+ (NSString *)cachesDirectoryPathWithFileName:(NSString *)fileName;

+ (NSString *)documentDirectoryPathWithFileName:(NSString *)fileName;

+ (NSString *)pdfFilePathInDoucumentDirectoryWithFileName:(NSString *)fileName;

+ (NSString *)pdfDownloadMessagePathInDocumentDirectoryWithFileName:(NSString *)fileName;

+ (NSString *)videoFilePathInDocumentDirectoryWithFileName:(NSString *)videoName;

+ (BOOL)is0XNumber:(NSString *)string;

+ (NSString *)IPWith0XNumber:(NSString *)string;

+ (NSString *)urlWithServierIP:(NSString *)serverIP port:(int)port function:(NSString *)function plat:(int)plat;

+ (NSString *)spellStringChangeFromChinese:(NSString *)chinese;

+(NSDictionary *)BPParseJSONStringToNSDictionary:(NSString *)JSONString;

- (NSString *)URLEncodedString;

+ (NSString *)parseParams:(NSDictionary *)params;

+ (NSString *)examAnswerFilePathInDoucumentDirectoryWithExamId:(NSString *)examId;

- (NSArray *)words;

+ (NSString *)documentDirectoryPath;

@end
