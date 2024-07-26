import { CategoryInfo, CategoryDetail, CategoryList} from '../viewmodel/categoryModel'
import { getCategoryInfo,getCategoryDetail} from '../api/index'
import { ResData} from '../viewmodel/ResponseData'
import { router } from '@kit.ArkUI'

@Entry
@Component
export struct topicView{
  @State categoryInfo:CategoryInfo = {
    currentCategory:{} as CategoryList,
    categoryList:[]
  }
  @State currentCategory:CategoryList = {} as CategoryList
  @State tab_index:number = 0;

  aboutToAppear(): void {
    this.loadNet()
  }
  async loadNet(){
    let res:ResData<CategoryInfo>= await getCategoryInfo<CategoryInfo>()
    this.categoryInfo = res.data
    this.currentCategory = this.categoryInfo.currentCategory
    console.log(JSON.stringify(this.categoryInfo))
  }
  async changeCurrentCategory(index:number){
    let res:ResData<CategoryDetail> = await getCategoryDetail<CategoryDetail>(this.categoryInfo.categoryList[index].id)
    this.currentCategory = res.data.currentCategory
  }
  build() {
    Column(){
      Tabs({index:this.tab_index}){
        ForEach(this.categoryInfo.categoryList,(item:CategoryList,index:number)=>{
          TabContent(){
            if(index === this.tab_index){
              Column({space:10}){
                Image(this.currentCategory.banner_url)
                  .width('100%')
                  .height('20%')
                  .objectFit(ImageFit.Cover)
                  .overlay(this.OverText(this.currentCategory.front_name))

                this.barTitleDivder(this.currentCategory.name)

                Flex({wrap:FlexWrap.Wrap}){
                  ForEach(this.currentCategory.subCategoryList,(item:CategoryList)=>{
                    Column({space:5}){
                      Image(item.banner_url).width('50%')
                      Text(item.name).fontSize(20).width('100%').maxLines(1)
                        .textOverflow({
                          overflow:TextOverflow.Ellipsis
                        })
                        .textAlign(TextAlign.Center)

                    }
                    .width('33%')
                    .height('15%')
                    .border({
                      width:1,
                      color:'rgb(177,159,123)',
                    })
                    .justifyContent(FlexAlign.Center)
                    .onClick(()=>{
                      router.pushUrl({
                        url:'components/CategoryBrand',
                        params:item
                      })
                    })

                  })
                }
              }.width('100%')
              .height('100%')
            }
          }.tabBar(this.TabItem(index,item.name))
        })
      }
      .scrollable(false)
      .onChange(async (index)=>{
        await this.changeCurrentCategory(index)
        this.tab_index = index
      })
      .barWidth('22%')
      .vertical(true)
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  TabItem(index:number,name:string){
    Row(){
      Divider().vertical(true).strokeWidth(5).backgroundColor(Color.Red).height(30)
        .visibility(index === this.tab_index?Visibility.Visible:Visibility.Hidden)
      Text(name).fontSize(20).margin({
        left:10
      })
    }.width('100%').height('100%')
    .justifyContent(FlexAlign.Start)
    .backgroundColor(index === this.tab_index?Color.White:'rgb(247,248,250)')
  }
  @Builder
  OverText(title:string){
    Row(){
      Text(title).fontSize(20).fontColor(Color.White)
        .textShadow({
          color:Color.Pink,
          radius:5
        })
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }

  @Builder
  barTitleDivder(title:string){
    Row(){
      Divider().width(40).strokeWidth(1.5)
      Text(title).fontSize(30)
        .margin({
          left:10,
          right:10
        })
      Divider().width(40).strokeWidth(1.5)
    }.width('100%')
    .justifyContent(FlexAlign.Center)
    .margin({
      top:10
    })

  }
}