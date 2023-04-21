//
//  DisplayingWebViewController.h
//  RSS-Reader
//
//  Created by Sahil Agashe on 07/03/23.
//

#import <UIKit/UIKit.h>
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>

NS_ASSUME_NONNULL_BEGIN

@interface DisplayingWebViewController : UIViewController
- (instancetype)initWithWebUrl:(NSString*)givenWebURL;
@end

NS_ASSUME_NONNULL_END
