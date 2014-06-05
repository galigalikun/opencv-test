//
//  RootViewController.m
//  opencv
//
//  Created by t_akaishi on 2014/06/05.
//  Copyright (c) 2014年 t_akaishi. All rights reserved.
//

#import "RootViewController.h"
#import "OpenCVHelper.h"
#import "FilterTableViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController


@synthesize imageView = imageView_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:@"http://livedoor.blogimg.jp/nizigami/imgs/7/4/748da364.jpg"]];
    UIImage *image = [[UIImage alloc] initWithData:data];
     */
    
    imageView_ = [[UIImageView alloc] init]; // initWithImage:image];
    imageView_.contentMode = UIViewContentModeScaleAspectFit;
    [imageView_ setFrame:[UIScreen mainScreen].applicationFrame];
    [self.view addSubview:imageView_];
        
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(pic:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hoge:)];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)hoge:(UIButton*)sender
{
    FilterTableViewController* filterView = [[FilterTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:filterView animated:YES];
    // imageView_.image = [OpenCVHelper detect:imageView_.image cascade:@"haarcascade_eye.xml"];
}



- (void)pic:(UIButton*)sender
{
    if([UIImagePickerController
        isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

// select image
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"imagePickerController");
    /*
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0,0,image.size.width,image.size.height);
    [self.view addSubview:imageView];
    // view の背面画像にしてしまう
    [self.view sendSubviewToBack:imageView];
    
    [self dismissViewControllerAnimated:YES completion:nil];
     */
    
    imageView_.image = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


// cancel
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"imagePickerControllerDidCancel");
    // [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
