//
//  RssItemsViewController.m
//  RSS-Reader
//
//  Created by Sahil Agashe on 06/03/23.
//

#import "RssItemsViewController.h"
#import "RssItemTableViewCell.h"
#import "DisplayingWebViewController.h"


@interface RssItemsViewController () <UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate>
{
    NSXMLParser *parser;
    NSMutableArray<NSMutableDictionary *> *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *description;
    NSMutableString *imageUrlString;
    NSMutableString *link;
    NSString *element;
}
@property (nonatomic,strong) NSString *itemUrl;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UITableView *rssItemsTableView;
@property (nonatomic,strong) UILabel *msgLabel;
@end

@implementation RssItemsViewController

- (instancetype)initWithUrl:(NSString *)givenURL
{
    self = [super init];
    if (self) {
        _itemUrl = givenURL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.activityIndicatorForLoadRow = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityIndicatorForLoadRow.color = [UIColor blackColor];
    
    self.activityIndicatorForParsingData = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityIndicatorForParsingData.color = [UIColor blackColor];
    self.activityIndicatorForParsingData.center = self.view.center;
    [self.view addSubview:self.activityIndicatorForParsingData];
    [self.activityIndicatorForParsingData startAnimating];
    
    //Parser starts fetching data
    [self fetchDataUsingParser];
    
    //After fetching data ,if size of array is non zero
    if (feeds.count != 0)
    {
        [self setupRssItemsTableView];
        
    }
    //After fetching data,if size of array is zero
    else
    {
        [ self.activityIndicatorForParsingData stopAnimating];
        [self setupMsgLabel];
    }
    
    [self setupBackButton];
}

- (void)fetchDataUsingParser {
    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:self.itemUrl];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}

- (void)setupBackButton {
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
        [self.backButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}


- (void)setupRssItemsTableView {
    self.rssItemsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.rssItemsTableView.dataSource = self;
    self.rssItemsTableView.delegate = self;
    [self.rssItemsTableView registerClass:[RssItemTableViewCell class] forCellReuseIdentifier:@"rssItemCellIdentifier"];
    self.rssItemsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.rssItemsTableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.rssItemsTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.rssItemsTableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.rssItemsTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:35],
        [self.rssItemsTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-50]
    ]];
}

- (void)setupMsgLabel {
    self.msgLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.msgLabel.text = @"Sorry! Data is not available.";
    self.msgLabel.textColor = [UIColor redColor];
    [self.msgLabel setFont:[UIFont systemFontOfSize:20]];
    self.msgLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.msgLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.msgLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.msgLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
}

- (void)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    element = elementName;
    if ([element isEqualToString:@"item"]) {
        item = [[NSMutableDictionary alloc] init];
        title = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        imageUrlString = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"]) {
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:description forKey:@"description"];
        [item setObject:imageUrlString forKey:@"image"];
        [feeds addObject:item];
    }
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string {
    
    if([element isEqualToString:@"title"]) {
        [title appendString:string];
    }
    else if([element isEqualToString:@"link"]) {
        [link appendString:string];
    }
    else if([element isEqualToString:@"description"]) {
        [description appendString:string];
    }
    else if([element isEqualToString:@"image"]) {
        [imageUrlString appendString:string];
    }
}

-(void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.activityIndicatorForParsingData stopAnimating];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RssItemTableViewCell *cell = [self.rssItemsTableView dequeueReusableCellWithIdentifier:@"rssItemCellIdentifier"];
    cell.titleLabel.text= [[feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
    NSString *descriptionStr = [[feeds objectAtIndex:indexPath.row] objectForKey:@"description"];
    cell.descriptionLabel.text = [self stringByStrippingHTML:descriptionStr];
    
    NSMutableString *imgUrlString = [[feeds objectAtIndex:indexPath.row] objectForKey:@"image"] ;
    
    //Adding default image from online url if imgUrlString is empty
    if([imgUrlString isEqualToString:@""])
    {
        imgUrlString = @"https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Blue_question_mark_icon.svg/100px-Blue_question_mark_icon.svg.png";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.itemImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrlString]]];
    return  cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.rssItemsTableView.tableFooterView = self.activityIndicatorForLoadRow;
    [self.activityIndicatorForLoadRow startAnimating];
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.activityIndicatorForLoadRow stopAnimating];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  100.0;
}

-(void)loadTable
{
    [self.rssItemsTableView reloadData];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str =[[feeds objectAtIndex:indexPath.row] objectForKey:@"link"];
    UIViewController *webVC = [ [DisplayingWebViewController alloc] initWithWebUrl:str];
    webVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:webVC animated:true completion:nil];
}

- (NSString *)stringByStrippingHTML:(NSString*)str
{
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location!= NSNotFound)
    {
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    }
    return str;
}

@end
