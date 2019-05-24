//
//Created by ESJsonFormatForMac on 18/11/27.
//

#import "ESRootClass.h"
@implementation ESRootClass

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [Data class]};
}


@end

@implementation Data


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


