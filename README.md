# RSS-Reader-Application Completely in Objective-C.
there are three screens in application,
In first, need to add rss/xml link.
In second, need to select rss feed.
Third is WebView for selected rss feed.

1]This RSS Reader Application supports both .rss and .xml links.

2]sample xml and rss links , I have tried and successfully worked. ===>

https://developer.apple.com/news/rss/news.rss

https://feeds.bbci.co.uk/news/video_and_audio/world/rss.xml

https://www.cnet.com/rss/news/

3]Extra Situations, I have taken into consideration ==>
 1.I have added feature for displaying "no data available" when user enters link not supporting xml.
 2.I have added default image url which is from online url "https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Blue_question_mark_icon.svg/100px-Blue_question_mark_icon.svg.png" whenever there is not image url available in RSS Item.
 3.I have added Indicator for loading Rss Item table rows.
 4.Able to run on any iOS Device in both horizontal and portrait mode.
