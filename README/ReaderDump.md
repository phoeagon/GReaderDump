Reader Dump -- 一個Google Reader導出工具以及 Reader琥珀計劃
===========================

phoeagon

*Apr 25, 2013*

## 簡介
Reader Dump是一個用與從Google Reader中導出現有所有已訂閱feed的文章的工具

###Reader琥珀計劃
衆所周知，在Google Reader上存檔了許多網站既有的RSS發佈內容。**其中某些頁面，某些網站可能
已經因爲技術原因或者非技術原因被刪除、關閉，而Google Reader保存了既有的內容。**事實上，Google
Reader保存了第一個帳號在reader上開始訂閱該訂閱點（feed）開始的所有內容（假設沒有刪過？）。此後
新加入的用戶都可以藉此查閱更早前的文章資料。

Reader關閉以後，如果這些內容丟失，很可能將無處訪問。許多有價值的內容也將因此喪失。

我們呼籲大家，把Reader上的資料導出出來，將不涉及個人隱私的內容發送給我們。我們志願整理一個
Feed導出的歸檔。這個歸檔類似與博物館性質，把Reader上曾經記錄過的文章內容完整的下載和保存。
以供後來友需要者查閱。

默認在此處下載已上傳Feed（所有Feed來自用戶）(http://db.tt/lHrtv5t4)

>>####我成功用本工具下載了我的feed。我願意支持Reader琥珀計劃
>> 請讓附帶的工具正常上傳完下載的rss文件，謝謝！

>>####我已經遷移到其他的閱讀器上，但是我願意支持Reader琥珀計劃
>>請考慮將您的subscriptions.xml文件發送給我們。

            bash dropbox_uploader.sh subscriptions.xml Public/`md5sum subscriptions.xml`_subscriptions.xml

>>####我願意協助維護本計劃
>>謝謝。請通過郵件聯繫作者。

### Reader Dump的開源許可證

       Copyright 2013

       Licensed under the Apache License, Version 2.0 (the "License");
       you may not use this file except in compliance with the License.
       You may obtain a copy of the License at

           http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing, software
       distributed under the License is distributed on an "AS IS" BASIS,
       WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
       See the License for the specific language governing permissions and
       limitations under the License.

       This package contains a script distributed under GPL.
       dropbox_uploader is invoked by commandline in this package. dropbox_uploader
       is an open source project by Andrea Fabrizi <andrea.fabrizi@gmail.com>.
       The script has been adapted and is released under GPL. We believe such
       should be interpreted as an ["aggregate"]       (http://www.gnu.org/licenses/gpl-faq.html#MereAggregation)
       and therefore the project itself,
       which could run independently without this uploader, could be distributed
       under Apache.

## 安裝
###環境要求
本工具在Ubuntu 12.04+curl 7.22.0+Python 2+下測試通過。

組建要求：
+ Linux作業環境
+ bash命令解釋器（絕大多數linux發行版默認的shell）
+ curl
+ Python

###Ubuntu下安裝上述依賴包

開啓terminal控制檯，輸入sudo apt-get install curl python。根據提示完成安裝操作。

###本工具本身安裝使用

解壓到linux文件系統（NTFS/FAT系列不支持linux下的權限標誌可執行位）。

## 使用

###生成Cookies.txt文件
對Firefox用戶，請安裝[Export Cookies](https://addons.mozilla.org/en-us/firefox/addon/export-cookies)插件。對於Chrome用戶，請安裝[Cookies.txt Export](https://chrome.google.com/webstore/detail/cookietxt-export/lopabhfecdfhgogdbojmaicoicjekelh?hl=en)插件。

請在瀏覽器上登錄Google Reader後，根據插件的指示，導出cookies.txt文件。

（這個步驟或許不是必須的，但無登錄抓取Feed未經測試；有之前類似項目指出抓到的feed有bug。**未經驗證。**）

###從Google Reader導出訂閱的feed的地址

從Google Takeout下載到一個壓縮包文件(*youraccount*`@gmail.com-takeout.zip`)，解出裏面的subscriptions.xml到程序目錄。

###執行程序
打開terminal。定位到程序文件夾。運行./python reader_dump.py subscriptions.xml

你的feed會自動下載到下面的data文件夾中。對於cnBeta等很長的feed可能需要很長一段時間。你不需要理會這個控制檯，甚至可以關閉控制檯，所有的下載工作會在後臺完成（但若關閉控制檯，將無法直接查看下載進程）

### 請支持我們，將你拉取下載的文件送給我們。
默認腳本會將下載的文件上傳到本計劃的Dropbox文件夾。如果涉及隱私內容，請中斷Dropbox上傳程序(./dropbox_uploader.sh)

### 特殊使用說明
#### 代理設置
打開new.sh文件，找到Proxy setting對應的註釋，裏面提供了幾個模板。

關閉代理服務器，請去掉PROXY=""前的#。需要激活服務器，請編輯形如PROXY="http://127.0.0.1:8087/"一行，去掉#，並修改端口和IP。

#### HTTPS證書問題
本工具默認啓用證書驗證的SSL連接Google Reader服務器。
強制關閉證書檢測，請將下面對應設置配置：

        #    uncomment the following line if you want to use insecure HTTPS( ignore cert error )
        url="-k https://www.google.com/reader/atom/feed/"
        #   uncomment the following line if you want to force HTTPS
        #url="https://www.google.com/reader/atom/feed/"
        #   uncomment the following line if you want to use HTTP
        #url="http://www.google.com/reader/atom/feed/"

使用HTTP，或者帶證書檢驗的HTTPS，請去掉對應行前面的#，並在其他行前加一個#。
修改完成後，你需要重新運行本程序。

## FAQ
### 這個工具有不少bug耶
是有不少bug。有更多的bug已經在一開始的測試中排除了。我也完全清楚存在同名feed相互覆蓋的問題。
但是，相對於Google Reader將在7月1日關閉來說，我實在沒有太多的時間和經歷進行除Bug的工作。
也許如果我有空，我會接着improve這個工具。如果在關閉之前沒空，也許就沒有更新了。
我很清楚這個工具基本上處於「剛剛好可以用」的拼湊狀態。如果你有時間精力和能力優化這個工具，非常歡迎

### 這東西好難折騰啊
我相信你有能力在國內用google reader一定有能力把這個小工具折騰出來:）

### 缺乏XXX的功能
參見上一條。

暫時來說，提供一個已經剛好“勉強”能用的版本比起再過很久發佈一個更完整的版本更有意義。
畢竟估計這個導出大部分人也不會需要重複做。

### 有哪些小問題可以手工解決？
+ 同名feed的rss相互覆蓋。請手工編輯subscriptions.xml文件，給對應的feed改個名字。
+ 選擇性導出一些feed。請手工打開subscriptions.xml文件，刪除你不需要導出的feed對應的<outline>標籤。

### 會不會有非*Nix版本？
恐怕不會有。衆所周知尤其是這個工具中使用bash的部分。。。。移植shell腳本非常痛苦。

### 爲什麼是Reader琥珀而不是Reader方舟計劃？
很可能Reader不會回來，很可能也不會有能夠無縫導入這些存檔資料讓Reader重生的替代產品了。
我們所做的只是試圖挽救許多珍貴的、即將消逝的資料和信息。好像將昆蟲封閉於琥珀之中，也許昆蟲再無
復生之日（侏羅紀公園看多了吧），但是至少可以讓後來者有機會一睹昆蟲芳容。

### 能推薦Reader替代品嗎？
如果你有VPS的話，架設NewsBlur是一個不錯的方案。
