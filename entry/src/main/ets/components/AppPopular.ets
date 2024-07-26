import { router } from '@kit.ArkUI'
import { HotGoodsList } from '../viewmodel/ResponseData'

@Component
export struct AppPopular {
  @Prop hotGoodsList:Array<HotGoodsList>
  build() {
    Column({space:10}){
      this.barTitle('人气推荐')
      ForEach(this.hotGoodsList,(item:HotGoodsList)=>{
        Row(){
          Image(item.list_pic_url).layoutWeight(1)
            .margin({
              left:10
            })
          Column({space:5}){
            this.imgTwoTxt(item.name,item.goods_brief,item.retail_price)
          }
          .layoutWeight(2)
          .alignItems(HorizontalAlign.Start)
        }
        .onClick(()=>{
          router.pushUrl({
            url:'views/GoodsDetail',
            params:item
          })
        })
      })
      this.grayBar()
    }
  }
  @Builder
  barTitle(title:string){
    Row() {
      Text(title).fontSize(30)
    }.width('100%')
    .margin({
      top: 10
    })
    .justifyContent(FlexAlign.Center)
  }
  @Builder
  grayBar(){
    Row().width('100%').height(15).backgroundColor('rgb(235,237,240)')
  }
  @Builder
  imgTwoTxt(name:string,brief:string,price:number){
    Text(name).fontSize(20)
    Text(brief).fontSize(15).fontColor(Color.Gray)
      .width('80%')
      .maxLines(1)
      .textOverflow({overflow:TextOverflow.Ellipsis})
    Text(`￥${price}元`).fontSize(15).fontColor(Color.Red)
      .margin({
        top:5
      })
  }
}
