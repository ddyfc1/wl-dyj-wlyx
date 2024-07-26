import { Info } from '../viewmodel/GoodsDetailModel'
import { cartAdd } from '../api/index'
import { ResData} from '../viewmodel/ResponseData'
import { Cart } from '../viewmodel/cartModel'
import { router } from '@kit.ArkUI'

@Component
@CustomDialog
export struct GoodsDetailDialog{
  controller:CustomDialogController;
  good_info:Info = {} as Info
  @State number:number = 1
  build() {
    Column({space:10}){
      Row({space:20}){
        Image(this.good_info.list_pic_url).width('30%').margin({top:20})
        Column({space:10}){
          Text(`￥${this.good_info.retail_price}`).fontColor(Color.Red).fontSize(30)
          Text(`剩余 ${this.good_info.goods_number}`).fontColor(Color.Gray).fontSize(18)
          Text('请选择').fontColor(Color.Gray).fontSize(18)
        }.width('25%').height('100%').justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Start).margin({top:20})
        Row(){
          Image($rawfile('goodsDetail/Cancel.png')).width(20).margin({top:20,right:20})
            .onClick(()=>this.controller.close())
        }.layoutWeight(1).height('100%').justifyContent(FlexAlign.End).alignItems(VerticalAlign.Top)
      }.width('100%').height('45%')

      Row(){
        Text('购买数量').fontSize(20)

        Row({space:5}){
          Button('-',{stateEffect:this.number>1}).width('15%').fontColor(Color.Gray)
            .type(ButtonType.Normal).fontSize(25)
            .backgroundColor('rgb(242,243,245)')
            .enabled(this.number > 1)
            .onClick(async ()=>{
              this.number --
            })

          TextInput({
            text:this.number.toString(),
          })
            .type(InputType.Number)
            .focusable(false)
            .textAlign(TextAlign.Center)
            .borderRadius('50%')
            .width('20%')
            .onChange((value)=>{
              this.number = Number(value)
            })
          Button('+').width('15%').fontColor(Color.Gray)
            .type(ButtonType.Normal).fontSize(25)
            .backgroundColor('rgb(242,243,245)')
            .enabled(this.number<this.good_info.goods_number)
            .margin({right:10})
            .onClick(async ()=>{
              this.number++
            })
        }
      }.width('100%').justifyContent(FlexAlign.SpaceBetween).padding({left:15,right:15})

      Row(){
        Button('取消').width('50%').fontSize(20)
          .backgroundColor(Color.Transparent).fontColor(Color.Black)
          .onClick(()=>this.controller.close())
        Divider().vertical(true).height(50).strokeWidth(1)
        Button("加入购物车").width(('50%')).fontSize(20)
          .backgroundColor(Color.Transparent).fontColor('rgb(255,145,23)')
          .onClick(async ()=>{
            let res:ResData<Cart> = await cartAdd<Cart>(this.good_info.goods_sn,this.number,this.good_info.id)
            console.log(JSON.stringify(this.good_info.goods_sn+"  "+this.good_info.id+"  "+this.number))
            console.log(JSON.stringify(res))
            if(res.errno === 0){
              router.pushUrl({
                url:'pages/Index',
                params:{
                  id:3
                }
              })
              this.controller.close()
            }

          })
      }.position({bottom:10})
    }.width('100%').height(300)
  }
}