from bs4 import BeautifulSoup, SoupStrainer
import requests
from lxml import html
import time
import string
import re
# awk -F "\"*,\"*" '{print $6}' Linkedin.csv >> LinkedinLinks.csv

##############################################################
#The code below is now working
string1 = "https://www.brainyquote.com/topics"
"""Good, better, best. Never let it rest. 'Til your good is better and your better is best.
"""
# page = requests.get(string1)
# soup = BeautifulSoup(page.content, 'html.parser')
# for script in soup(["script", "style"]):
#     script.decompose()
# link = soup.find_all("a", class_="topicIndexChicklet")
# topics = [link.get_text() for link in link]
# correctopics = []
# for i in topics:
#     if "\n" in i:
#         removed = i.replace("\n", "")
#         correctopics.append(removed)


#############################################################
##The code below s now working
# string2 = "https://www.brainyquote.com/authors"
# page = requests.get(string2)
# soup = BeautifulSoup(page.content, 'html.parser')
# for script in soup(["script", "style"]):
#     script.decompose()
# link = soup.find_all("span", class_="authorContentName")
# authors = [link.get_text() for link in link]
# print(authors)

###########################################################

# page_link = "https://www.brainyquote.com/topics/motivational/?paged1={}"
# page_no = 0

# while page_no<=5:
page_link ="https://www.brainyquote.com/topics/motivational/?paged1=1"
page = requests.get(page_link)
soup = BeautifulSoup(page.content, 'html.parser')

for script in soup(["script", "style"]):
    script.decompose()
link = soup.select('a[class*="b-qt qt_"]')
quotes = [link.get_text() for link in link]
link1 = soup.select('a[class*="bq-aut qa_"]')
authors = [link.get_text() for link in link1]
mydict = dict(zip(quotes, authors))
    
    # if len(mydict) == 2000:
    #     break
    # time.sleep(2)
print(mydict)


# print(correcauthors)

#  sed -n 's/.*href="\([^"]*\).*/\1/p' LinkedinLinks.csv
# def fetch_links(topic):
#     url = "http://brainyquote.com"+topic
#     page = requests.get(url)
#     print (page.url,"\n")
#     tree = html.fromstring(page.text)
#     end = tree.xpath('/html/body/div[4]/div/div/div[1]/div[2]/div/ul[2]/li[1]/div/ul/li[last()-1]/a/text()')
#     #print end[0],"\n"
#     for link in range(1,int(end[0])+1):
#         if link == 1:
#             fetch_quotes(url)
#         else:
#             blink = url.split('.html')
#             fetch_quotes(string.replace(url,url,"%s%s.html"%(blink[0],link)))

# def fetch_quotes(url):
#     page = requests.get(url)
#     print ("\t\tFetching quotes from ",page.url,"\n")
#     tree = html.fromstring(page.text)
#     f = open("quotes.txt","a+")
#     for quotes in tree.xpath('//div[@id="quotesList"]//span[@class="bqQuoteLink"]/a/text()'):
#         #print quotes,"\n"
#         f.write(quotes.encode('utf-8')+"\n")
#     f.close()

# def get_topics():
#     page = requests.get('http://www.brainyquote.com/quotes/topics.html')
#     tree = html.fromstring(page.text)
#     topics = tree.xpath('//div[@class="bqLn"]/div[@class="bqLn"]/a/@href')
#     for topic in topics:
#         #print topic,"\n"
#         fetch_links(topic)
#         time.sleep(5)

# if __name__ == '__main__':
#     get_topics()