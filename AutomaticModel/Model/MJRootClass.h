//
//Created by ESJsonFormatForMac on 18/11/27.
//

#import <Foundation/Foundation.h>

@class MJData;
@interface MJRootClass : NSObject

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, copy) NSString *order;

@property (nonatomic, copy) NSString *headerline;

@property (nonatomic, copy) NSString *totalRecord;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) BOOL rs;

@property (nonatomic, assign) NSInteger totalPage;

@property (nonatomic, assign) NSInteger pageNum;

@end
@interface MJData : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *commentUrl;

@property (nonatomic, copy) NSString *ymz_id;

@property (nonatomic, copy) NSString *destUrl;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, assign) NSInteger commentSum;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *srcPhoto;

@property (nonatomic, copy) NSString *readCount;

@property (nonatomic, copy) NSString *artId;

@property (nonatomic, assign) NSInteger hasVideo;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *video;

@end

