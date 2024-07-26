import {
  getCartList,
  cartChecked,
  cartDelete,
  cartUpdate
} from '../api/index'
import { Cart as CartModel, CartList, CartTotal} from '../viewmodel/cartModel'
import { ResData } from '../viewmodel/ResponseData'
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
export struct Cart {
  @State CartList:CartModel = new CartModel([],{} as CartTotal)
  @State goodsCount:number = 0
  @State isEdit:boolean = false
  @State cartList:Array<CartList> = []
  previousNames:Array<string> = []
  allNames:Array<string> = []
  init_time:number = 0
  aboutToAppear(): void {
    this.loadNet()
  }
  async loadNet(){
    let res:ResData<CartModel> = await getCartList<CartModel>()
    this.CartList = res.data
    this.cartList = this.CartList.cartList
    this.goodsCount = this.CartList.cartTotal.goodsCount
    this.initNames()
  }
  initNames(){
    this.cartList.forEach((item:CartList)=>{
      if(item.checked>0){
        this.previousNames.push(item.goods_id.toString())
      }
      this.allNames.push(item.goods_id.toString())
    })
    this.init_time = this.CartList.cartList.length +1
  }
  async checkedChange(event:CheckboxGroupResult){

    let currentNames = event.name
    let previousNames = new Set(this.previousNames)
    let result:string = ''
    let isChecked:number = 0
    if(this.init_time > 0){
      this.init_time--
    }else{
      console.log(JSON.stringify(event))
      if(event.status === SelectStatus.Part){
        console.log(this.previousNames.join(','))
        try {
          currentNames.forEach((name:string)=>{
            if(!previousNames.has(name)){
              isChecked = 1
              result = name
              throw new Error()
            }
          })
          previousNames.forEach((name:string)=>{
            if(!currentNames.includes(name)){
              isChecked = 0
              result = name
              throw new Error()
            }
          })
        }catch(e){

        }
      }
      else{
        isChecked = event.status === SelectStatus.All?1:0
        result = this.allNames.join(',')
      }
      let res:ResData<CartModel> = await cartChecked<CartModel>(isChecked,result)
      if(res.errno === 0){
        this.CartList.cartTotal = res.data.cartTotal
        this.previousNames = currentNames
      }
    }
  }
  build() {
    Column({space:15}) {
      Row(){
        Text('购物车').fontSize(25)
      }
      .margin({
        top:15
      })
      Divider().strokeWidth(1)

      if(this.goodsCount === 0){
        Column({space:80}){
          Image($rawfile('cart/emptyCart.png')).width(150)
            .fillColor(Color.Gray)
          Text('购物车空空如也').fontSize(30)
        }.layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }else{
        Column(){
          List(){
            ForEach(this.cartList,(item:CartList,index:number)=>{
              ListItem(){
                Column(){
                  Row({space:10}){
                    Checkbox({
                      name:item.goods_id.toString(),
                      group:'cartlist'
                    }).select(item.checked>0).onChange(value=>{
                      item.checked = value?1:0
                    }).margin({left:10})
                      .enabled(!this.isEdit)
                    Image(item.list_pic_url).width(88).height(88).objectFit(ImageFit.Fill)

                    Column(){
                      Row(){
                        Text(item.goods_name).fontSize(15)
                          .maxLines(2).textOverflow({overflow:TextOverflow.Ellipsis})
                      }.justifyContent(FlexAlign.Start).width('100%')
                      Row(){
                        Text(`￥${item.retail_price}`).fontSize(18)
                        Text(`×${item.number}`).fontColor(Color.Gray).fontSize(15)
                      }.width('100%')
                      .justifyContent(FlexAlign.SpaceBetween)
                    }.layoutWeight(1)
                    .justifyContent(FlexAlign.SpaceBetween)
                    .height('90%')
                    .width('35%')
                    Column(){
                    }
                  }
                  .width('100%')
                  .height('15%')
                  .margin({bottom:10,top:10})


                  Row({space:5}){
                    Button('-',{stateEffect:item.number>1}).width('15%').fontColor(Color.Gray)
                      .type(ButtonType.Normal).fontSize(25)
                      .backgroundColor('rgb(242,243,245)')
                      .enabled(item.number > 1)
                      .onClick(async ()=>{
                        this.init_time ++
                        item.number--
                        this.cartList[index] = JSON.parse(JSON.stringify(item))
                        let res:ResData<CartModel> = await cartUpdate<CartModel>(item)
                        if(res.errno === 0 && res.data.cartTotal){
                          this.CartList.cartTotal = res.data.cartTotal
                        }
                      })

                    TextInput({
                      text:item.number.toString(),
                    })
                      .type(InputType.Number)
                      .focusable(false)
                      .textAlign(TextAlign.Center)
                      .borderRadius('50%')
                      .width('20%')
                      .onChange((value)=>{
                        item.number = Number(value)
                      })
                    Button('+').width('15%').fontColor(Color.Gray)
                      .type(ButtonType.Normal).fontSize(25)
                      .backgroundColor('rgb(242,243,245)')
                      .margin({right:10})
                      .onClick(async ()=>{
                        this.init_time ++
                        item.number++
                        this.cartList[index] = JSON.parse(JSON.stringify(item))
                        let res:ResData<CartModel> = await cartUpdate<CartModel>(item)
                        if(res.errno === 0 && res.data.cartTotal){
                          this.CartList.cartTotal = res.data.cartTotal
                        }
                      })
                  }.width('100%')
                  .justifyContent(FlexAlign.End)
                  .margin({bottom:10})
                  .visibility(this.isEdit?Visibility.Visible:Visibility.None)

                  Divider().strokeWidth(1)
                }
              }
              .swipeAction({
                end:this.deleteItem(item.goods_id,index)
              })
            })
          }.layoutWeight(1)
          Row(){
            Text(`累加共${this.CartList.cartTotal.checkedGoodsCount}件商品，可点击`).fontSize(13)
            Text('编辑').fontSize(13).backgroundColor(Color.Green).fontColor(Color.White)
              .padding(4)
              .borderRadius(5)
              .onClick(()=>{
                this.init_time = this.CartList.cartList.length
                this.isEdit = true

              })
              .visibility(this.isEdit?Visibility.None:Visibility.Visible)
            Text('完成编辑').fontSize(13).backgroundColor(Color.Red).fontColor(Color.White)
              .padding(4)
              .borderRadius(5)
              .onClick(()=>{
                this.init_time = this.CartList.cartList.length
                this.isEdit = false
              })
              .visibility(this.isEdit?Visibility.Visible:Visibility.None)
            Text(`按钮，进行商品数量修改`).fontSize(13)
          }
          .justifyContent(FlexAlign.Center)
          .height('5%')
          .width('100%')
          .backgroundColor('rgb(255,247,204)')

          Row(){
            Row(){
              CheckboxGroup({group:'cartlist'})
                .onChange((event)=>{
                  this.checkedChange(event)
                })
                .enabled(!this.isEdit)
              Text('全选')
                .fontColor(this.isEdit?Color.Gray:Color.Black)
            }.margin({left:10})
            Row({space:10}){
              Text('合计:').fontColor(Color.Black)
              Text(`￥${this.CartList.cartTotal.checkedGoodsAmount.toFixed(2)}`)
                .fontColor(Color.Red).fontSize(20)
              Button('提交订单')
                .linearGradient({
                  colors:[['#ff6034',0],['#ee0a24',1]],
                  direction:GradientDirection.Right
                })
                .width('40%')
                .height('80%')
                .margin({right:10})
            }
            .justifyContent(FlexAlign.End)
            .layoutWeight(1)
          }
          .height('8%')
        }.layoutWeight(1)
        .margin({top:-10})
      }
    }
    .justifyContent(FlexAlign.Start)
    .height('100%')
    .width('100%')
  }

  @Builder
  deleteItem(id:number,index:number){
    Button('删除').type(ButtonType.Normal).backgroundColor(Color.Red).width(100)
      .onClick(()=>{
        promptAction.showDialog({
          title:'提示信息',
          message:'确认删除?',
          buttons:[
            {
              text:'取消',
              color:'green'
            },
            {
              text:'确定',
              color:'red'
            }
          ]
        }).then(async res=>{
          if(res.index === 1 ){
            let result:ResData<CartModel> = await cartDelete<CartModel>(id.toString())
            console.log(id.toString());
            console.log(JSON.stringify(result));
            if(result.errno === 0){
              this.cartList.splice(index,1)
              this.CartList.cartTotal = result.data.cartTotal
            }
          }
        })

      })
  }
}

