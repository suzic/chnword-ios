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

#import <TesseractOCR.h>

//#import "ScanViewController.h"

@interface DisplayMovieViewController () <G8TesseractDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, retain) CoverFlowView *gifCoverFlowView;
@property (nonatomic, retain) MPMoviePlayerController *movieController;

@property (nonatomic, retain) NSArray *gifImages;

@property (nonatomic, assign) BOOL isInitView;


//TESSOCR
@property (nonatomic, strong) NSOperationQueue *operationQueue;

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
    
    UIImagePickerController *imgPicker = [UIImagePickerController new];
    imgPicker.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imgPicker animated:YES completion:nil];
    }
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
    //处理图像并生成字符串
    
    
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIAction
-(void)recognizeImageWithTesseract:(UIImage *)image
{
    // Preprocess the image so Tesseract's recognition will be more accurate
    UIImage *bwImage = [image g8_blackAndWhite];
    
    // Animate a progress activity indicator
//    [self.activityIndicator startAnimating];
    
    // Display the preprocessed image to be recognized in the view
//    self.imageToRecognize.image = bwImage;
    
    // Create a new `G8RecognitionOperation` to perform the OCR asynchronously
    // It is assumed that there is a .traineddata file for the language pack
    // you want Tesseract to use in the "tessdata" folder in the root of the
    // project AND that the "tessdata" folder is a referenced folder and NOT
    // a symbolic group in your project
    //    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] initWithLanguage:@"chi_sim"];
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] initWithLanguage:@"en"];
    
    // Use the original Tesseract engine mode in performing the recognition
    // (see G8Constants.h) for other engine mode options
    operation.tesseract.engineMode = G8OCREngineModeTesseractOnly;
    
    // Let Tesseract automatically segment the page into blocks of text
    // based on its analysis (see G8Constants.h) for other page segmentation
    // mode options
    operation.tesseract.pageSegmentationMode = G8PageSegmentationModeAutoOnly;
    
    // Optionally limit the time Tesseract should spend performing the
    // recognition
    //operation.tesseract.maximumRecognitionTime = 1.0;
    
    // Set the delegate for the recognition to be this class
    // (see `progressImageRecognitionForTesseract` and
    // `shouldCancelImageRecognitionForTesseract` methods below)
    operation.delegate = self;
    
    // Optionally limit Tesseract's recognition to the following whitelist
    // and blacklist of characters
    //operation.tesseract.charWhitelist = @"01234";
    //operation.tesseract.charBlacklist = @"56789";
    
    // Set the image on which Tesseract should perform recognition
    operation.tesseract.image = bwImage;
    
    // Optionally limit the region in the image on which Tesseract should
    // perform recognition to a rectangle
    //operation.tesseract.rect = CGRectMake(20, 20, 100, 100);
    
    // Specify the function block that should be executed when Tesseract
    // finishes performing recognition on the image
    operation.recognitionCompleteBlock = ^(G8Tesseract *tesseract) {
        // Fetch the recognized text
        NSString *recognizedText = tesseract.recognizedText;
        
        NSLog(@"%@", recognizedText);
        
        // Spawn an alert with the recognized text
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OCR Result"
                                                        message:recognizedText
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    };
    
    // Finally, add the recognition operation to the queue
    [self.operationQueue addOperation:operation];
}

#pragma mark -G8TesseractDelegate
/**
 *  An optional method to be called periodically during recognition so
 *  the recognition's progress can be observed.
 *
 *  @param tesseract The `G8Tesseract` object performing the recognition.
 */
- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract
{
    NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}

/**
 *  An optional method to be called periodically during recognition so
 *  the user can choose whether or not to cancel recognition.
 *
 *  @param tesseract The `G8Tesseract` object performing the recognition.
 *
 *  @return Whether or not to cancel the recognition in progress.
 */
- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract
{
    return NO;
}

/**
 *  An optional method to provide image preprocessing. To perform default
 *  Tesseract preprocessing return `nil` in this method.
 *
 *  @param tesseract   The `G8Tesseract` object performing the recognition.
 *  @param sourceImage The source `UIImage` to perform preprocessing.
 *
 *  @return Preprocessed `UIImage` or nil to perform default preprocessing.
 */
- (UIImage *)preprocessedImageForTesseract:(G8Tesseract *)tesseract sourceImage:(UIImage *)sourceImage
{
    return nil;
}

@end
