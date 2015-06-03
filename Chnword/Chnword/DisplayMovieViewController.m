//
//  DisplayMovieViewController.m
//  Chnword
//
//  Created by khtc on 15/5/9.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "DisplayMovieViewController.h"
#import "CoverFlowView.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "UIButton+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import <ImageIO/ImageIO.h>

#import "ScanViewController.h"

@interface DisplayMovieViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, retain) CoverFlowView *gifCoverFlowView;
@property (nonatomic, retain) MPMoviePlayerController *movieController;

@property (nonatomic, retain) NSArray *gifImages;

@property (nonatomic, assign) BOOL isInitView;

@end

@implementation DisplayMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isInitView = false;
    [self initGifImagesWith:nil];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self initViews];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initGifImagesWith:(NSURL *) url {
    
//    UIImage *image = [[SDWebImageManager sharedManager] downloadImageWithURL:url options:nil progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        
//    }];
    
    NSString *name = @"sample.gif";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.backgroundColor = [UIColor clearColor];
    
    //SCGIFimage
    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef) imageData, NULL);
    size_t count = CGImageSourceGetCount(source);
    
    NSMutableArray *tempArray = [NSMutableArray array];
    NSLog(@"the source images count is %ld", count);
    for (size_t i = 0; i < count; i ++) {
        NSLog(@"the source image at index %ld", count);
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
        [tempArray addObject:[UIImage imageWithCGImage:imageRef]];
        CGImageRelease(imageRef);
    }
    CFRelease(source);
    NSLog(@"the final images count %d", tempArray.count);
    self.gifImages = tempArray;
    
}


- (void) initViews {
    
    
    if (self.isInitView) {
        return ;
    }
    
    CGRect coverViewRect = self.gifView.bounds;
    coverViewRect.size.height -= 20;
    
    
    self.gifCoverFlowView = [CoverFlowView coverFlowViewWithFrame:self.gifView.bounds andImages:self.gifImages sideImageCount:2 sideImageScale:0.35 middleImageScale:0.6];
    [self.gifView addSubview:self.gifCoverFlowView];
    NSLog(@"%@", NSStringFromCGRect(self.gifView.frame));
    
    
    NSString *xftPath = [[NSBundle mainBundle] pathForResource:@"cft" ofType:@"mp4"];
    NSURL *videoUrl = [NSURL URLWithString:@""];
    videoUrl = [NSURL fileURLWithPath:xftPath];
//    self.movieController = [[MPMoviePlayerController alloc] initWithContentURL:videoUrl];
    self.movieController = [[MPMoviePlayerController alloc] init];
    
    self.movieController.contentURL = videoUrl;
    self.movieController.view.frame = self.videoView.bounds;
    [self.videoView addSubview:self.movieController.view];
    [self.movieController play];
    
//    [self showGif];
    [self showVideo];
    
    
    self.isInitView = true;
    
}

- (void) showVideo {
    self.videoView.hidden = NO;
    self.gifView.hidden = YES;
}

- (void) showGif {
    self.videoView.hidden = YES;
    self.gifView.hidden = NO;
}


#pragma mark - UIAction Event Handler

- (IBAction) goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) quickLook:(id)sender
{
    [self.movieController pause];
    [self showGif];
}

- (IBAction) scan:(id)sender
{
//    ScanViewController *scanViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ScanViewController"];
//    [self presentViewController:scanViewController animated:YES completion:^{
//        
//    }];
    
//    UIImagePickerController *imgPicker = [UIImagePickerController new];
//    imgPicker.delegate = self;
//    
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:imgPicker animated:YES completion:nil];
//    }
}

#pragma -mark UIImagePickerController Delegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
    
    UIImage *image = nil;
    
    if ([type isEqualToString:@"public.image"])
    {
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
    }else if ([type isEqualToString:@"public.movie"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"Sorry, 人家不支持视频啦，讨厌！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    self.navigationController.navigationBar.barStyle = self.navBarStyle;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
