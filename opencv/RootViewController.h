//
//  RootViewController.h
//  opencv
//
//  Created by t_akaishi on 2014/06/05.
//  Copyright (c) 2014年 t_akaishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (nonatomic, retain) UIImageView* imageView;

@end
