import { router } from '@kit.ArkUI';
import { AppBrandList } from '../components/AppBrandList'
import { brandList, ResData } from '../viewmodel/ResponseData'
import { brandDetail } from '../api/index'

@Entry
@Component
export struct BrandDetail {
  brand: brandList = {} as brandList;

  aboutToAppear(): void {
    this.brand = router.getParams() as brandList
  }

  async loadNet() {
    let res: ResData<brandList> = await brandDetail<brandList>(this.brand.id)
    if (res.errno === 0) {
      this.brand = res.data
    }
  }

  build() {
    Column() {
      this.title(this.brand.name)
      Image(this.brand.list_pic_url).width('100%').height(200).backgroundColor(Color.Gray)
      Row() {
        Text(this.brand.name).fontSize(30)
        Text(`￥${this.brand.floor_price.toFixed(2)}元`).fontColor(Color.Red).fontSize(20)
      }
      .padding({
        left:15,
        right:15
      })
      .margin({top:15})
      .justifyContent(FlexAlign.SpaceBetween)
      .width("100%")
      Row(){
        Text(`订单排名:${this.brand.sort_order}`).fontSize(20).fontColor(Color.Gray)
      }.width('100%').margin({top:5}).padding({left:15})
      Row(){
        Text(this.brand.simple_desc).fontSize(21).fontColor(Color.Gray)
      }.width('100%').margin({top:15}).padding({left:15})
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  title(title: string) {
    Row() {
      Button('<').fontSize(25)
        .position({
          left: 5,
          top: '15%'
        }).backgroundColor(Color.Transparent)
        .zIndex(999)
        .onClick(()=>{
          router.back()
        })
        .fontColor(Color.Black)
      Text(title).width('100%').textAlign(TextAlign.Center).fontSize(21)
    }.width('100%').height('7%')
    .alignItems(VerticalAlign.Center)
  }
}