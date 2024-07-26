import { GoodsList } from '../viewmodel/ResponseData'
import { goodsDetail, goodsRelated, goodsScount } from '../api/index'
import { ResData } from '../viewmodel/ResponseData'
import { GoodsDetailDialog } from '../components/GoodsDetailDialog'
import {
  GoodsDetail as GoodsDetailModel,
  GoodsRelated,
  GoodsScount,
  Gallery,
  Attribute,
  Issue
} from '../viewmodel/GoodsDetailModel'
import { router } from '@kit.ArkUI'
import text from '@ohos.graphics.text'

@Entry
@Component
struct GoodsDetail {
  goods: GoodsList = router.getParams() as GoodsList
  @State goodsDetail: GoodsDetailModel = {} as GoodsDetailModel
  @State goodsRelated: GoodsRelated = {} as GoodsRelated
  @State goodsScount: GoodsScount = {} as GoodsScount
  private mydialog:CustomDialogController = new CustomDialogController({
    builder:GoodsDetailDialog({
      good_info:this.goodsDetail.info
    }),
    alignment:DialogAlignment.BottomEnd,
    width:'100%'
  })

  aboutToAppear(): void {
    this.loadNet()
  }

  async loadNet() {
    let detail: ResData<GoodsDetailModel> = await goodsDetail<GoodsDetailModel>(this.goods.id)
    this.goodsDetail = detail.data

    let related: ResData<GoodsRelated> = await goodsRelated<GoodsRelated>(this.goods.id)
    this.goodsRelated = related.data

    let scount: ResData<GoodsScount> = await goodsScount<GoodsScount>()
    this.goodsScount = scount.data

  }

  build() {
    Column() {
      List() {
        ListItem() {
          Swiper() {
            ForEach(this.goodsDetail.gallery, (item: Gallery) => {
              Image(item.img_url).width('100%').height('100%')
                .backgroundColor(Color.Gray)
            })
          }.autoPlay(true).indicator(
            DigitIndicator.digit()
              .right(15)
              .digitFont({
                size: 20,
              })
              .selectedDigitFont({
                size: 20
              })
          )
          .height(300)
          .indicatorStyle({
            color: Color.White,
            size: 20,

          })
        }

        ListItem() {
          Row({ space: 5 }) {

            Row({ space: 5 }) {
              Image($rawfile("goodsDetail/Tick.png")).width(20)
              Text('30天无忧退货').fontSize(15)
            }.width('33%').margin({ left: 5 })

            Row({ space: 5 }) {
              Image($rawfile("goodsDetail/Tick.png")).width(20)
              Text('48小时快速退货').fontSize(15)
            }.width('33%')

            Row({ space: 5 }) {
              Image($rawfile("goodsDetail/Tick.png")).width(20)
              Text('满88元免邮费').fontSize(15)
            }.width('33%').margin({ right: 5 })
          }.width('100%').height('7%').backgroundColor('rgb(241,241,241)')
        }

        ListItem() {
          Column({ space: 10 }) {
            Text(this.goodsDetail.info?.name).fontSize(30)
            Text(this.goodsDetail.info?.goods_brief).fontSize(22).fontColor(Color.Gray)
            Row() {
              Text(`￥${this.goodsDetail.info?.retail_price.toFixed(2)}元`).fontSize(30).fontColor(Color.Red)
              Text(`库存:${this.goodsDetail.info?.goods_number}`).fontSize(20).fontColor(Color.Gray)
            }.width('100%').justifyContent(FlexAlign.SpaceBetween)
          }.padding({ left: 15, right: 20 })
          .margin({ top: 10 })
          .alignItems(HorizontalAlign.Start)
        }

        ListItem() {
          Column() {
            this.grayBar()
            Row() {
              Text('售后保障').fontSize(20)
              Text('>').fontSize(30)
            }
            .width('100%')
            .padding({
              left: 15,
              top: 10,
              bottom: 10,
              right: 20
            })
            .justifyContent(FlexAlign.SpaceBetween)

            this.grayBar()
          }.margin({ top: 10 })
        }

        ListItem() {
          Column() {
            Text('产品规格').fontSize(27).padding({ left: 15, top: 10, bottom: 10 })
            Divider().strokeWidth(1)
            ForEach(this.goodsDetail.attribute, (item: Attribute, index: number) => {
              Row() {
                Text(item.name).width('25%').fontSize(20).lineHeight(30)
                Text(item.value).fontSize(20).layoutWeight(1).lineHeight(30)
              }
              .padding({
                left: 15,
                top: 10,
                bottom: 10,
                right: 10
              })
              .width('100%')
              .alignItems(VerticalAlign.Top)
              .backgroundColor(index % 2 === 1 ? 'rgb(241,241,241)' : Color.White)
            })
            this.grayBar()
          }.alignItems(HorizontalAlign.Start)
        }

        ListItem() {
          Column({ space: 10 }) {
            Text('产品详情').fontSize(30).width('100%').textAlign(TextAlign.Center)

            RichText(`<div style="font-size:0;text-align:center;">${this.goodsDetail.info?.goods_desc}</div>`)
              .width('100%')


          }.margin({ top: 15 })
        }

        ListItem() {
          Column() {
            this.grayBar()
            Row({ space: 10 }) {
              Divider().strokeWidth(1).width(50)
              Text('常见问题').fontSize(30)
              Divider().strokeWidth(1).width(50)
            }.padding({ top: 15, bottom: 20 })

            ForEach(this.goodsDetail.issue, (item: Issue) => {
              Column({ space: 10 }) {
                Row() {
                  Text(`• ${item.question}`).fontSize(20).width('100%')
                }

                Text(item.answer).fontSize(15).width('100%').lineHeight(30)
              }.padding({ left: 10 })
              .margin({ top: 15 })
              .alignItems(HorizontalAlign.Start)
            })
          }
        }

        ListItem() {
          Column() {
            this.grayBar()
            Row({ space: 10 }) {
              Divider().strokeWidth(1).width(50)
              Text('猜你喜欢').fontSize(30)
              Divider().strokeWidth(1).width(50)
            }.padding({ top: 15, bottom: 20 })

            Flex({ wrap: FlexWrap.Wrap }) {
              ForEach(this.goodsRelated.goodsList, (item: GoodsList) => {
                Column() {
                  Image(item.list_pic_url).width('50%')
                  this.imgTxtBehind(item.name, item.retail_price)
                }
                .onClick(() => {
                  router.pushUrl({
                    url: 'views/GoodsDetail',
                    params: item
                  })
                })
              })
            }
            .margin({
              top: -10
            })
          }
        }
      }.layoutWeight(1)

      Row(){
        Column({space:5}){
          Image($rawfile("goodsDetail/collection.png")).width('50%')
          Text('未收藏')
        }.width('15%')
        Column({space:5}){
          Image($rawfile("goodsDetail/cart.png")).width('50%')
            .overlay(this.overTxt(this.goodsScount.cartTotal?.goodsCount.toString()))
          Text('购物车')
        }.width('15%')
        .onClick(()=>{
          router.pushUrl({
            url:'pages/index',
            params:{
              tab_index:3
            }
          })
        })
        Row(){
          Button('加入购物车').width("50%")
            .fontSize(18)
            .height('60%')
            .type(ButtonType.Normal)
            .borderRadius({topLeft:'50%',bottomLeft:'50%'})
            .linearGradient({
              colors:[
                ['#ffd01e',0],
                ['#ff8917',1]
              ],
              direction:GradientDirection.Right
            })
            .onClick(()=>{
              this.mydialog.open()
            })
          Button('立即购买').width('50%')
            .height('60%')
            .padding({top:10,bottom:10})
            .type(ButtonType.Normal)
            .borderRadius({topRight:'50%',bottomRight:'50%'})
            .linearGradient({
              colors:[
                ['#ff6034',0],
                ['#ee0a24',1]
              ],
              direction:GradientDirection.Right
            })
        }.layoutWeight(1).margin({right:5}).zIndex(999)
      }.width('100%').height('10%').justifyContent(FlexAlign.SpaceAround)
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  overTxt(title:string){
    Text(title).backgroundColor(Color.Red).fontColor(Color.White)
      .width(20).height(20).borderRadius(20)
      .textAlign(TextAlign.Center)
      .position({top:-7,right:-5})
      .zIndex(10)
  }
  @Builder
  grayBar() {
    Row().width('100%').height(15).backgroundColor('rgb(235,237,240)')
  }

  @Builder
  imgTxtBehind(name: string, price: number) {
    Column({ space: 5 }) {
      Text(name)
        .fontSize(15)
        .maxLines(1)
        .textOverflow({
          overflow: TextOverflow.Ellipsis
        })
        .width('50%')
        .textAlign(TextAlign.Center)
      Text(`￥ ${price.toString()}元`).fontSize(15).fontColor(Color.Red)
    }
  }
}