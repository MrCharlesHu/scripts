#!/usr/local/bin/python
import itchat
itchat.login()
#爬取自己好友相关信息， 返回一个json文件
friends = itchat.get_friends(update=True)[0:]
print friends
