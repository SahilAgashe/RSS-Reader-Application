//
//  RssFeedParser.m
//  RSS-Reader
//
//  Created by Sahil Agashe on 06/03/23.
//


#import "RssFeedParser.h"

@interface RssFeedParser()

@property NSXMLParser *parser;
@property NSString *currentElement;

//Rss Item Properties
@property (nonatomic,strong) UIImage *currentRssItemImage;
@property (nonatomic,strong) NSString *currentRssItemtitle;
@property (nonatomic,strong) NSString *currentRssItemdescription;

@end


@implementation RssFeedParser

- (id)initWithArray: (NSMutableArray *)rssItemArray
{
    self = [super init];
   if(self)
   {
       self.rssItemArray = rssItemArray;
   }
    return self;
}

- (void)parseFile{
    
    NSURL *url = [NSURL URLWithString:@"https://developer.apple.com/news/rss/news.rss"];
    self.parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    self.parser.delegate = self;
    [self.parser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    self.currentElement = elementName;
    if ([self.currentElement isEqualToString:@"item"]) {
        NSLog(@"item is found");
        self.currentRssItemtitle = @"";
        self.currentRssItemtitle = @"";
        self.currentRssItemImage = [UIImage imageNamed:@""];
        NSLog(@"didStart");
    }
    
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string {
    if ([self.currentElement isEqualToString:@"title"]) {
        self.currentRssItemtitle = string;
        NSLog(@"title is found");
    }
    else if ([self.currentElement isEqualToString:@"description"]) {
        self.currentRssItemdescription = string;
    }
    else if ([self.currentElement isEqualToString:@"image"]) {
        self.currentRssItemImage = [UIImage imageNamed:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"]) {
        RssItem *item = [[RssItem alloc] initWithTitle:self.currentRssItemtitle description:self.currentRssItemdescription image:self.currentRssItemImage];
        [self.rssItemArray addObject:item];
        NSLog(@"let us check");
        NSLog(@"%@",self.currentRssItemtitle);
        NSLog(@"%ld",self.rssItemArray.count);
    }
}

@end
