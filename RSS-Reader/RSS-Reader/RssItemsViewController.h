//
//  RssItemsViewController.h
//  RSS-Reader
//
//  Created by Sahil Agashe on 06/03/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RssItemsViewController : UIViewController
- (instancetype)initWithUrl:(NSString *)givenURL;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorForParsingData;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorForLoadRow;
@end

NS_ASSUME_NONNULL_END
