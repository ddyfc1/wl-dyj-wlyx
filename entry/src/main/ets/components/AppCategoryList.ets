import { CategoryList, GoodsList } from '../viewmodel/ResponseData'
import { router } from '@kit.ArkUI'

@Component
export struct AppCategoryList {
  @Prop CategoryList: Array<CategoryList>
  build() {
    Column({space:10}){
      ForEach(this.CategoryList,(item:CategoryList)=>{
        this.barTitleDivider(item.name)
        Flex({wrap:FlexWrap.Wrap}){
          ForEach(item.goodsList,(item: GoodsList)=>{
            Column(){
              Image(item.list_pic_url).width('50%')
              this.imgTxtBehind(item.name,item.retail_price)
            }
            .onClick(()=>{
              router.pushUrl({
                url:'views/GoodsDetail',
                params:item
              })
            })
          })
        }
        .margin({
          top:-10
        })
      })
    }
  }
  @Builder
  barTitleDivider(title:string){
    Row(){
      Divider().width(40).strokeWidth(1)
      Text(title).fontSize(30)
        .margin({
          left:10,
          right:10
        })
      Divider().width(40).strokeWidth(1)
    }.width('100%')
    .justifyContent(FlexAlign.Center)
    .margin({
      top:10
    })
  }
  @Builder
  imgTxtBehind(name:string,price:number){
    Column({space:5}){
      Text(name).fontSize(15)
        .maxLines(1)
        .textOverflow({
          overflow:TextOverflow.Ellipsis
        })
        .width('50%')
        .textAlign(TextAlign.Center)
      Text(`￥ ${price.toString()}元`).fontSize(15).fontColor(Color.Red)
    }
  }
}
