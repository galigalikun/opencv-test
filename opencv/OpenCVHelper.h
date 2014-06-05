//
//  OpenCVHelper.h
//  opencv
//
//  Created by t_akaishi on 2014/06/05.
//  Copyright (c) 2014年 t_akaishi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <opencv2/opencv.hpp>


@interface OpenCVHelper : NSObject

+ (UIImage *)detect:(UIImage *)srcImage cascade:(NSString *)cascadeFilename;

@end
