//
//  KHERedditPost.m
//  Reddit-ObjC
//
//  Created by Kaden Hendrickson on 5/22/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

#import "KHERedditPost.h"

@implementation KHERedditPost

- (instancetype)initWithTitle:(NSString *)title andThumbnail:(NSString *)thumbnail
{
    self = [super init];
    if(self){
        _title = title;
        _thumbnail = thumbnail;
    }
    return self;
}


@end

@implementation KHERedditPost (JsonConvertible)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSDictionary *data = dictionary[@"data"];
    NSString *title = data[@"title"];
    NSString *thumbnail = data[@"thumbnail"];
    
    return [self initWithTitle:title andThumbnail:thumbnail];
}


@end
