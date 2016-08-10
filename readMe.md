#### DEMO 环境要求 xcode8 -- iOS10

# iMessage + Apps (Messages Extension)
#### iMessage App是一种全新的应用扩展，载体是iOS系统的Message应用，通过iMessage App，用户可以发送更加丰富的消息内容（即gif动图表情，图片，链接，音频等）,独立于Container App开发，并且提供了全新的消息模式，开始支持iap和Apple Pay等,我们也可以在现有的项目中添加iMessage App，系统会自动将其添加到Messages App Store。
### 部分官方解释：
Take advantage of the new Messages framework in iOS 10 to create an app extension that lets users interact with your app directly within Messages. Users can easily create and share content, add stickers, make payments, and more, without leaving Messages.


## 在iOS中新增了两种iMessage的方式：1.Stickers packs、2.iMessage Application

### Stickers packs

#### 这种创建方式，可在创建工程时直接选择，只需要将想要添加的图片或者gif等直接拖入**Stickers.xcstickers中的Sticker pack文件夹中** 即可，（简单、粗暴）***"0代码"*** 即可完成，iMessage的内置表情包添加,也可以被添加到Messages App Store中。
---
详细可参考一个国外链接: <https://www.appcoda.com/message-sticker-app/>

![StickerPack](http://oakbcmhd4.bkt.clouddn.com/StickerPack.png)

 图片类型必须是 png、apng、gif或者jpeg
文件大小必须 小于500K
图片大小必须在 **100 * 100** 到 **206 * 206** 之间
需要注意的是：必须要永远提供 @3x 大小的图片(即 **300 * 300** 到 **618 * 618**)。
系统可以根据当前设备通过 runtime 自动调整图片来呈现 @2x 和 @1x
系统能够自适应的展示贴纸，所以为了更好的展示贴纸，最好提供的贴纸是以下三种大小的类型:

* 小型 100*100
* 中型 136*136
* 大型 206*206

![StickerPack](http://oakbcmhd4.bkt.clouddn.com/StickerDetail.png)

### iMessage Application
 使用iMessage app能够在消息应用内呈现一个"自定义"的用户交互界面。需要自定义stricker时就需要创建iMessage Application。
 创建好一个iMessage Application 的工程之后你就能看到一个MessagesViewController，这个是MSMessagesAppViewController的子类，The root view controller shown by the Messages app
 * MSMessagesAppViewController
 MSMessagesAppViewController有两种展现方式：
 
  * Compact 
  * Expanded
  
在Compact模式下，不能访问键盘和相机，同时也不能使用横向滑动操作（Compact模式下，横向操作会由系统捕获），但是可以访问用户输入框

![compact](http://oakbcmhd4.bkt.clouddn.com/compact1.png)
  
  在Expanded模式下，我们不能访问用户输入框，但是可以访问键盘、相机，并且可以使用横向滑动操作(就像是图片点开放大的详细界面)'
  
![Expanded](http://oakbcmhd4.bkt.clouddn.com/expand1.png)

想进一步了解MSMessagesAppViewController之前我们先来了解一下这几个类：

### MSConversation
The MSConversation class represents a conversation in the Messages app. Use conversation objects to access information about the currently selected message, the conversation participants, or to send text, stickers, attachments, or message objects.

MSConversation指当前的会话，我们可以通过MSConversation“发送消息”--添加到发送输入框，我们可以通过MessagesViewController的 `activeConversation`这个属性获取到当前的The currently active conversation
通过下面几个方法向当前输入框插入不同的消息：

```
//插入NSMessage
- (void)insertMessage:(MSMessage *)message completionHandler:(nullable void (^)(NSError * _Nullable))completionHandler;

//插入Sticker
- (void)insertSticker:(MSSticker *)sticker completionHandler:(nullable void (^)(NSError * _Nullable))completionHandler;

//发送文本
- (void)insertText:(NSString *)text completionHandler:(nullable void (^)(NSError * _Nullable))completionHandler;

//发送音频等
- (void)insertAttachment:(NSURL *)URL withAlternateFilename:(nullable NSString *)filename completionHandler:(nullable void (^)(NSError * _Nullable))completionHandler;


```
### MSMessage
个人感觉这个类我们可以理解为一个消息的模板，主要包含两个部分：

* MSSession用来描述消息如何发送
* MSMessageLayout用来描述消息如何展示

消息的展现方式由MSMessageLayout决定，不过MSMessageLayout是一个抽象类，目前系统只提供了一种展现方法MSMessageTemplateLayout:
![MSMessageTemplateLayout](http://oakbcmhd4.bkt.clouddn.com/MSMessageTemplateLayout.png)

我们可以通过`mediaFileURL`这个属性来插入主要内容，如上图中所示可以是音频、视频、图片。至于其他的描述文本可看demo中。

### MSStickerBrowserViewController
MSStickerBrowserViewController 是用来管理，显示Stickers与CollectionView优点类似（Stickers对于MSStickerBrowserViewController就像是collectionView中的Cell一样），他们的使用方法也是类似，需要遵循`MSStickerBrowserViewDataSource`协议，重写下面的两个方法:

```
@protocol MSStickerBrowserViewDataSource <NSObject>

- (NSInteger)numberOfStickersInStickerBrowserView:(MSStickerBrowserView *)stickerBrowserView;//返回Sticker数量
- (MSSticker *)stickerBrowserView:(MSStickerBrowserView *)stickerBrowserView stickerAtIndex:(NSInteger)index;//返回MSSticker对象

```
##### 除此之外还有一部分就是MSMessagesAppViewController的iMessage App LifeCycle了，这个在你创建iMessage Application时，MessagesViewController下的#pragma mark - Conversation Handling下面的就是了，都有详细的英文注释

### 废话说的有点多了下面附上我结合collectionView做的演示demo的地址感兴趣的可以看看，用到了我上面提到的知识点，可帮助理解：[Demo](https://github.com/RookieTomWu/iMessageExentsions)（下附上demo图一张：）

![demo](http://oakbcmhd4.bkt.clouddn.com/demo1.png)

## 最后：
---
### 以下纯属个人YY
个人感觉Message Extensions 会是iOS10中一个**“风口”**吧，或许有人会说，不就是个表情包吗,微信，Messager等早就玩烂掉了没什么创新点，从这一点上看确实如此，但是个人感觉Message Extensions 还是有一些特别的地方的，就像是苹果在WWDC上演的Ice Cream demo(下面有WWDC demo下载链接)，可以进行简单的iMessage互动游戏，而且可以**“0代码”**直接通过Stickers packs导入表情包，相信iOS10即将Messages App Store会带来一些更有趣的东西吧。。。

---  
### [WWDC视频iMessage Apps and Stickers](https://developer.apple.com/videos/play/wwdc2016/204/)
### 苹果在08月01放出了WWDC上演示的IceCream Demo(swift3.0):<https://developer.apple.com/library/prerelease/content/samplecode/IceCreamBuilder/Introduction/Intro.html>
