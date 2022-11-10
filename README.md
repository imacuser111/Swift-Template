---
title: 'Xcode Template'
tags: Templates
disqus: hackmd
---

Xcode Template
===

## Table of Contents

[TOC]

## Creat custom template folder

- 如果以下路徑底下沒有template資料夾，需先創建

### path
```shell=
~/Library/Developer/Xcode/
```

- Custom為自定義資料夾，可以取任何名稱

![](https://imgur.com/6sjwqu1.png)

- 叫Custom新增時就會被分類到Custom

![](https://imgur.com/HrFZmCn.png)

## 原生template

- 利用xcode應用程式裡面原有的template來改寫

### path
```shell=
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/File\ Templates/iOS/Source/Cocoa\ Touch\ Class.xctemplate
```

## Custom template

### xctemplate 的內容

#### xctemplate 下主要有三種檔案:
- ___FILEBASENAME(也可以加上其他自定義名稱，例如Model) ___.swift -> 樣版的程式內容。
- TemplateInfo.plist -> 控制樣版選擇時設定的欄位。
- TemplateIcon.png -> 樣版選擇時顯示的 icon。

---

### 複製原生template

1. 先在剛剛Custom資料夾底下創建一個副檔名為.xctemplate的folder(名稱自訂)，名稱就是以下圖片的名稱

![](https://imgur.com/eLt2YGg.png)

2. 複製剛剛原生template底下的.swift檔、TemplateInfo.plist到剛剛創建的.xctemplate folder底下

- 有幾個.swift檔就會一次生成幾個檔案(例：可以一次創建出view, viewModel, viewController...等)

![](https://imgur.com/IuJt3Ol.png)

---

### 修改原生template

#### 首先打開TemplateInfo.plist

- 設定 Options 欄位

![](https://imgur.com/vKAekqo.png)

#### Options 的型別是 array，裡面的 item 是 dictionary，包含了以下欄位。
1. Name: 使用者看到的欄位名稱。
2. Identifier: ___FILEBASENAME ___.swift 程式讀取欄位內容時採用的名字。
3. Required: 是否必填。
4. Description: 欄位的說明。
5. Type: 欄位的輸入方式，text 表示要以文字輸入，將變成文字輸入框。

---

- 設定DefaultCompletionName

> 此欄位決定檔案建立後存檔時預設的檔名，我們希望檔名以 Coordinator 結尾，然後使用者再於 Coordinator 前加上自訂名稱，比方 Test 的 Coordinator 檔將是 TestCoordinator.swift。

![](https://imgur.com/FChtV1s.png)

#### 再來設定.swift檔

- 我們希望生成下圖的樣式

![](https://imgur.com/RrNSFiY.png)

#### 常用的格式

- ___PROJECTNAME ___：專案名
- ___FILENAME ___： 包含後綴的文件名
- ___FILEBASENAME ___: 文件名
- ___FILEBASENAMEASIDENTIFIER ___： 不包含後綴的c格式文件名
- ___VARIABLE_xxx ___： 將 xxx 換成當初 options 裡設定的 Identifier。
- ___FULLUSERNAME ___： 用户名
- ___ORGANIZATIONNAME ___： 公司名
- ___COPYRIGHT ___： 版權説明
- ___DATE ___： 當前日期
- ___TIME ___： 當前時間
- ___YEAR ___： 當前年
- ___FILEHEADER ___： 默認的開頭

#### 下圖為最終完成品

- 添加 placeholder 在 code 中

```shell=
<#placeholder#>
```

以下圖為例則是：

```shell=
<#Observable<[___VARIABLE_productName:identifier___SectionModel]>#>
```

![](https://imgur.com/YVC2Q7v.png)

### Shell檔

> 將template推至git，分享給團隊成員使用

- <span style="color:red">不過這邊要注意，他會先刪掉原先的template folder，再添加上去，所以本來就有template不建議使用<span>

```shell=
cd ~/Desktop
git clone "YOURER GIT LINK"
cd ~/Library/Developer/Xcode
rm -r -f Templates
mv ~/Desktop/"你的檔案名稱" ~/Library/Developer/Xcode/Templates
```
