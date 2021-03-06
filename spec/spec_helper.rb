require File.dirname(__FILE__)+'/../lib/roboto.rb'


# from google.com no less
LONG_ROBOTS_TXT = <<-TXT
      User-agent: *
      Allow: /searchhistory/
      Disallow: /search
      Disallow: /groups
      Disallow: /images
      Disallow: /catalogs
      Disallow: /catalogues
      Disallow: /news
      Disallow: /nwshp
      Allow: /news?btcid=
      Disallow: /news?btcid=*&
      Allow: /news?btaid=
      Disallow: /news?btaid=*&
      Disallow: /setnewsprefs?
      Disallow: /index.html?
      Disallow: /?
      Disallow: /addurl/image?
      Disallow: /pagead/
      Disallow: /relpage/
      Disallow: /relcontent
      Disallow: /sorry/
      Disallow: /imgres
      Disallow: /keyword/
      Disallow: /u/
      Disallow: /univ/
      Disallow: /cobrand
      Disallow: /custom
      Disallow: /advanced_group_search
      Disallow: /googlesite
      Disallow: /preferences
      Disallow: /setprefs
      Disallow: /swr
      Disallow: /url
      Disallow: /default
      Disallow: /m?
      Disallow: /m/?
      Disallow: /m/ig
      Disallow: /m/images?
      Disallow: /m/lcb
      Disallow: /m/news?
      Disallow: /m/news/i?
      Disallow: /m/setnewsprefs?
      Disallow: /m/search?
      Disallow: /m/trends
      Disallow: /wml?
      Disallow: /wml/?
      Disallow: /wml/search?
      Disallow: /xhtml?
      Disallow: /xhtml/?
      Disallow: /xhtml/search?
      Disallow: /xml?
      Disallow: /imode?
      Disallow: /imode/?
      Disallow: /imode/search?
      Disallow: /jsky?
      Disallow: /jsky/?
      Disallow: /jsky/search?
      Disallow: /pda?
      Disallow: /pda/?
      Disallow: /pda/search?
      Disallow: /sprint_xhtml
      Disallow: /sprint_wml
      Disallow: /pqa
      Disallow: /palm
      Disallow: /gwt/
      Disallow: /purchases
      Disallow: /hws
      Disallow: /bsd?
      Disallow: /linux?
      Disallow: /mac?
      Disallow: /microsoft?
      Disallow: /unclesam?
      Disallow: /answers/search?q=
      Disallow: /local?
      Disallow: /local_url
      Disallow: /froogle?
      Disallow: /products?
      Disallow: /froogle_
      Disallow: /product_
      Disallow: /products_
      Disallow: /print
      Disallow: /books
      Allow: /booksrightsholders
      Disallow: /patents?
      Disallow: /scholar?
      Disallow: /complete
      Disallow: /sponsoredlinks
      Disallow: /videosearch?
      Disallow: /videopreview?
      Disallow: /videoprograminfo?
      Disallow: /maps?
      Disallow: /mapstt?
      Disallow: /mapslt?
      Disallow: /maps/stk/
      Disallow: /maps/br?
      Disallow: /mapabcpoi?
      Disallow: /center
      Disallow: /ie?
      Disallow: /sms/demo?
      Disallow: /katrina?
      Disallow: /blogsearch?
      Disallow: /blogsearch/
      Disallow: /blogsearch_feeds
      Disallow: /advanced_blog_search
      Disallow: /reader/
      Disallow: /uds/
      Disallow: /chart?
      Disallow: /transit?
      Disallow: /mbd?
      Disallow: /extern_js/
      Disallow: /calendar/feeds/
      Disallow: /calendar/ical/
      Disallow: /cl2/feeds/
      Disallow: /cl2/ical/
      Disallow: /coop/directory
      Disallow: /coop/manage
      Disallow: /trends?
      Disallow: /trends/music?
      Disallow: /notebook/search?
      Disallow: /music
      Disallow: /musica
      Disallow: /musicad
      Disallow: /musicas
      Disallow: /musicl
      Disallow: /musics
      Disallow: /musicsearch
      Disallow: /musicsp
      Disallow: /musiclp
      Disallow: /browsersync
      Disallow: /call
      Disallow: /archivesearch?
      Disallow: /archivesearch/url
      Disallow: /archivesearch/advanced_search
      Disallow: /base/search?
      Disallow: /base/reportbadoffer
      Disallow: /base/s2
      Disallow: /urchin_test/
      Disallow: /movies?
      Disallow: /codesearch?
      Disallow: /codesearch/feeds/search?
      Disallow: /wapsearch?
      Disallow: /safebrowsing
      Allow: /safebrowsing/diagnostic
      Disallow: /reviews/search?
      Disallow: /orkut/albums
      Disallow: /jsapi
      Disallow: /views?
      Disallow: /c/
      Disallow: /cbk
      Disallow: /recharge/dashboard/car
      Disallow: /recharge/dashboard/static/
      Disallow: /translate_c
      Disallow: /translate_suggestion
      Disallow: /s2/profiles/me
      Allow: /s2/profiles
      Disallow: /s2
      Disallow: /transconsole/portal/
      Disallow: /gcc/
      Disallow: /aclk
      Disallow: /cse?
      Disallow: /tbproxy/
      Disallow: /MerchantSearchBeta/
      Disallow: /imesync/
      Disallow: /websites?
      Disallow: /shenghuo/search?
      Disallow: /support/forum/search?
      Disallow: /reviews/polls/
      Disallow: /hosted/images/
      Disallow: /hosted/life/
      Disallow: /ppob/?
      Disallow: /ppob?
      Disallow: /ig/add?
      Disallow: /adwordsresellers
      Sitemap: http://www.gstatic.com/s2/sitemaps/profiles-sitemap.xml
      Sitemap: http://www.google.com/hostednews/sitemap_index.xml
      
    TXT
    
MULTIPLE_AGENTS= <<-TXT
  User-agent: *
  Disallow: /cgi/
  Disallow: /gi/
  Disallow: /library/nosearch/
  Disallow: /zadz/
  Disallow: /zdynahubz/
  Disallow: /zeventsz/
  Disallow: /zfrequentz/
  Disallow: /zhomez/
  Disallow: /zimages70z/
  Disallow: /zpicsz/
  Disallow: /zscriptz/
  Disallow: /zshare70z/
  Disallow: /z/
  Allow: /z/cg/vp.htm
  Disallow: /check.htm
  Disallow: /mevents.htm
  Disallow: /mcurrent.htm
  Disallow: /README.txt
  Disallow: /sitesearch.htm
  Disallow: /testmyboards.htm

  Disallow: /clk.about.com/

  User-agent: Mediapartners-Google*
  Disallow:

  User-agent: Yahoo-MMCrawler*
  Allow: /z/cg/

  User-agent: BecomeBot
  Crawl-Delay: 10
TXT


NO_ACCESS = <<-TXT
 User-agent: *
 Disallow: /
TXT

BLOCK_ROBOTO1 = <<-TXT
  User-agent: *
  Disallow: /cgi/
  Disallow: /gi/
  Disallow: /library/nosearch/
  Disallow: /zadz/
  Disallow: /zdynahubz/
  Disallow: /zeventsz/
  
  User-agent: mr-roboto
  Disallow: /
TXT

BLOCK_ROBOTO2 = <<-TXT
  User-agent: *
  Disallow: /cgi/
  Disallow: /gi/
  Disallow: /library/nosearch/
  Disallow: /zadz/
  Disallow: /zdynahubz/
  Disallow: /zeventsz/
  
  User-agent: mr-roboto*
  Disallow: /mchammer/*
  Disallow: /thisisabeat/youanttouch/
  Disallow: /cant/touch/this.html
TXT

BLOCK_ROBOTO3 = <<-TXT
  User-agent: mr-roboto
  Disallow:
TXT