//
//  ViewController.m
//  RSS-Reader
//
//  Created by Sahil Agashe on 06/03/23.
//

#import "ViewController.h"
#import "RssItemsViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UIButton *addButton;
@property (nonatomic,strong) UITextField *urlTextField;
@property (nonatomic,strong) UITableView *urlTableView;
@property(nonatomic) NSMutableArray *urlArray;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.urlArray = [[NSMutableArray alloc] init];
    
    [self setupAddButton];
    [self setupUrlTextField];
    [self setupUrlTableView];
}

- (void)setupAddButton {
    self.addButton = [[UIButton alloc] init];
    self.addButton.backgroundColor = [UIColor blackColor];
    [self.addButton setTitle:@"ADD URL" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addButton];
    self.addButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.addButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.addButton.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:30],
        [self.addButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.3]
    ]];
}

- (void)setupUrlTextField {
    self.urlTextField = [[UITextField alloc] init];
    self.urlTextField.backgroundColor = [UIColor whiteColor];
    self.urlTextField.placeholder = @"ENTER URL HERE";
    [self.view addSubview:self.urlTextField];
    self.urlTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.urlTextField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.urlTextField.topAnchor constraintEqualToAnchor:self.addButton.bottomAnchor constant: 50],
        [self.urlTextField.widthAnchor
         constraintEqualToAnchor:self.view.widthAnchor multiplier:0.8]
    ]];
}

- (void)setupUrlTableView {
    self.urlTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain ];
    self.urlTableView.dataSource = self;
    self.urlTableView.delegate = self;
    [self.urlTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    self.urlTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.urlTableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.urlTableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20],
        [self.urlTableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-20],
        [self.urlTableView.topAnchor constraintEqualToAnchor:_urlTextField.bottomAnchor constant:30],
        [self.urlTableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-10]
    ]];
}

- (void)addButtonAction:(id)sender {
    [self.urlArray addObject:self.urlTextField.text];
    [self.urlTableView reloadData];
    self.urlTextField.text = @"";
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.urlArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.urlTableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    cell.textLabel.text = self.urlArray[indexPath.row];
    cell.textLabel.textColor = [UIColor blueColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *rssItemsVC = [[RssItemsViewController alloc] initWithUrl:self.urlArray[indexPath.row]];
    rssItemsVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:rssItemsVC animated:true completion:nil];
}

@end


