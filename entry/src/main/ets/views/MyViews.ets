export interface Mine{
  name: string;
  icon: Resource
}
@Entry
@Component
export struct myViews {
  @State arr : Array<Mine> = [{name: "我的订单", icon:$rawfile("mine/myOrder.png")},
    {name: "优惠卷", icon:$rawfile("mine/coupons.png")},{name: "礼品卡", icon:$rawfile("mine/giftCard.png")},
    {name: "我的收藏", icon:$rawfile("mine/myFavorites.png")}, {name: "我的足迹", icon:$rawfile("mine/myFootprints.png")},
    {name: "会员福利", icon:$rawfile("mine/MembershipBenefits.png")},{name: "地址管理", icon:$rawfile("mine/placeManager.png")},
    {name: "账号安全", icon:$rawfile("mine/accountSecurity.png")},{name: "联系客服", icon:$rawfile("mine/contact.png")},
    {name: "帮助中心", icon:$rawfile("mine/helpCenter.png")},{name: "意见反馈", icon:$rawfile("mine/feedback.png")}]
  build() {
    Column(){
      Row(){
        Image($rawfile("mine/avatar.jpg")).width(80).margin(30).borderRadius(40)
        Text("邓彦家").fontSize(25)
        Text(">").fontSize(30)
          .margin({left: 80})
      }.width("100%").height(200).backgroundColor("rgb(183,93,18)")
      Grid() {
        ForEach(this.arr, (item: Mine) => {
          GridItem() {
            Column(){
              Image(item.icon).height("50%").width("40%")
              Text(item.name)
                .fontSize(16)
                .width('100%')
                .height('25%')
                .textAlign(TextAlign.Center)
            }.width("100%").height("100%").justifyContent(FlexAlign.Center)
          }.width("100%").height("100%")
          .border({
            width: 1,
            color:"rgb(245, 245, 250)"
          })
        })
      }
      .rowsTemplate('1fr 1fr 1fr 1fr')
      .columnsTemplate('1fr 1fr 1fr')
      .width('98%').height(400)

    }
  }
}