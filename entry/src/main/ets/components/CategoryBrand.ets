import { router } from '@kit.ArkUI'
import { CategoryList } from '../viewmodel/categoryModel'
import { categoryBrand, cateBrandList } from '../api/index'
import { CategoryBrand as cateBrand, Category, BrandList} from '../viewmodel/categoryBrandModel'
import { ResData } from '../viewmodel/ResponseData'
import { GoodsList } from '../viewmodel/ResponseData'

@Entry
@Component
export struct CategoryBrand {

  category:CategoryList = router.getParams() as CategoryList
  @State title_index:number = 1
  @State brand_info:cateBrand = {} as cateBrand
  @State current_brand:Category = {} as Category
  @State goodsList:Array<GoodsList> = []

  aboutToAppear(): void {
    this.loadNet()
  }
  async loadNet(){
    let brand:ResData<cateBrand> = await categoryBrand<cateBrand>(this.category.id)
    this.brand_info = brand.data
    this.title_index = this.brand_info.currentCategory.sort_order
    this.current_brand = this.brand_info.currentCategory
    this.initBrandList()
  }
  async initBrandList(){
    let list:ResData<BrandList> = await cateBrandList<BrandList>(this.current_brand.id,1,1000)
    this.goodsList = list.data.goodsList
    console.log(JSON.stringify(this.goodsList))
  }
  build() {
    Column(){
      List(){
        ListItem(){
          Row(){
            List({space:20}){
              ForEach(this.brand_info.brotherCategory,(item:Category)=>{
                ListItem(){
                  this.titleBuilder(item)
                }
              })
            }.listDirection(Axis.Horizontal).scrollBar(BarState.Off).padding({left:15,right:15})
          }.width('100%').height('9%')
        }

        ListItem(){
          Image(this.current_brand?.banner_url)
            .width('100%').height('25%').margin({top:10}).objectFit(ImageFit.Fill)
            .overlay(this.overText(this.current_brand))
        }

        ListItem(){
          Flex({wrap:FlexWrap.Wrap}){
            ForEach(this.goodsList,(item:GoodsList)=>{
              Row(){
                Column(){
                  Image(item.list_pic_url).width('100%')
                  Text(item.name).width('100%').maxLines(1)
                    .textOverflow({overflow:TextOverflow.Ellipsis})
                    .padding({left:10,right:10}).fontSize(20)
                  Text(`￥${item.retail_price.toFixed(2)}元`).fontColor(Color.Red)
                    .margin({top:5})
                }.width("100%").height('100%')
                .onClick(()=>{
                  router.pushUrl({
                    url:'views/GoodsDetail',
                    params:item
                  })
                })
              }.width('50%').height('25%').margin({bottom:30})
            })
          }
        }
      }.layoutWeight(1)

    }.width('100%').height('100%')
  }

  @Builder
  titleBuilder(item:Category){
    Column({space:15}){
      Text(item.name).fontSize(22)
      Divider().width(70).strokeWidth(5).color(Color.Red).margin({bottom:5})
        .visibility(this.title_index===item.sort_order?Visibility.Visible:Visibility.Hidden)
    }.height('100%').justifyContent(FlexAlign.End)
    .onClick(()=>{
      this.title_index = item.sort_order
      this.current_brand = item
      this.initBrandList()
    })
  }

  @Builder
  overText(item:Category){
    Column({space:10}){
      Text(item.name).fontSize(28).fontColor(Color.White)
        .textShadow({
          color:Color.Red,
          radius:5
        })
      Text(item.front_desc).fontSize(22).fontColor(Color.White)
        .textShadow(({
          color:Color.Red,
          radius:5
        }))
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}