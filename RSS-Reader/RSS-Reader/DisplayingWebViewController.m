//
//  DisplayingWebViewController.m
//  RSS-Reader
//
//  Created by Sahil Agashe on 07/03/23.
//

#import "DisplayingWebViewController.h"


@interface DisplayingWebViewController ()
@property NSString *givenUrl;
@property WKWebView *webView;
@property (nonatomic,strong) UIButton *backButton;
@end

@implementation DisplayingWebViewController

- (instancetype)initWithWebUrl:(NSString *)givenWebURL
{
    self = [super init];
    if (self) {
        _givenUrl = givenWebURL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupWebView];
    [self setupBackButton];
}

-(void)setupWebView
{
    self.webView = [[WKWebView alloc ] initWithFrame:CGRectZero];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *str = [[self.givenUrl componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:nsrequest];
    [self.view addSubview:self.webView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.webView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.webView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:35],
        [self.webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-30]
    ]];
}

-(void)setupBackButton
{
    self.backButton = [[UIButton alloc] init];
    self.backButton.backgroundColor = [UIColor whiteColor];
    [self.backButton setTitle:@"Back" forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    self.backButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.backButton.leadingAnchor
         constraintEqualToAnchor:self.view.leadingAnchor],
        [self.backButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.backButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.1],
        [self.backButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor ]
    ]];
}

- (void)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
