import { GoodsList } from '../viewmodel/ResponseData'
import { router } from '@kit.ArkUI'

@Component
export struct SearchList {

  @Prop goodsList:GoodsList[]
  build() {
    List(){
      ListItem(){
        Flex({wrap:FlexWrap.Wrap,justifyContent:FlexAlign.Start}){
          ForEach(this.goodsList,(item:GoodsList)=>{
            Column({space:10}){
              Image(item.list_pic_url).width('100%')
              Text(item.name).width('100%').maxLines(1).textOverflow({overflow:TextOverflow.Ellipsis})
                .textAlign(TextAlign.Center).fontSize(20)
              Text(`￥${item.retail_price}元`).fontSize(18).fontColor(Color.Red).margin({bottom:10})
            }.width('45%').backgroundColor(Color.White).borderRadius(10).margin({top:10,left:'3.3%'})
            .onClick(()=>{
              router.pushUrl({
                url:'pages/conmonComponent/GoodsDetail',
                params:item
              })
            })
          })
        }
      }
    }.width('100%').height('100%').backgroundColor('rgb(238,238,238)')
  }
}