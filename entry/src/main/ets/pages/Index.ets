import { GetIndex } from '../api'
import { AppBrandList } from '../components/AppBrandList';
import { AppCategoryList } from '../components/AppCategoryList';
import { AppChannel } from '../components/AppChannel';
import { AppNewGoodsList } from '../components/AppNewGoodsList';
import { AppSearch } from '../components/AppSearch';
import { AppSwiper } from '../components/AppSwiper';
import { AppTopicList } from '../components/AppTopicList';
import { banner, brandList,
  CategoryList,
  channel,
  GoodsList,
  HotGoodsList,
  IndexData, newGoodsList, ResData,
  tab_index,
  topicList } from '../viewmodel/ResponseData';
import { Cart } from '../views/cartViews';
import { myViews } from '../views/MyViews';
import { specialViews } from '../views/SpecialViews';
import { topicView } from '../views/topicView';
import { router } from '@kit.ArkUI';
import { AppPopular } from '../components/AppPopular';

@Entry
@Component
struct Index {
  @State isShow: boolean = false; //默认不显示
  @State curTabIndex: number =0;
  @State banner: Array<banner> = [];
  @State channel: Array<channel> = [];
  @State brandList: Array<brandList> = [];
  @State newGoodsList: Array<newGoodsList> = [];
  @State topicList: Array<topicList> = [];
  @State categoryList:Array<CategoryList> = []
  @State hotGoodsList: Array<HotGoodsList> = []
  tab_index: tab_index = router.getParams() as tab_index
  private listContr: Scroller = new Scroller();

  async aboutToAppear(){
    let res: ResData<IndexData> = await GetIndex();
    this.banner = res.data.banner;
    this.channel = res.data.channel;
    this.brandList = res.data.brandList;
    this.newGoodsList = res.data.newGoodsList;
    this.topicList = res.data.topicList;
    this.categoryList = res.data.categoryList;
    this.hotGoodsList = res.data.hotGoodsList;
    console.log(this.tab_index.id.toString())
    if(this.tab_index !== undefined) this.curTabIndex = this.tab_index.id
  }


  build() {
    Column() {
      Tabs({barPosition: this.curTabIndex, index: this.curTabIndex}){
        //首页
        TabContent() {
          Column(){
            AppSearch()
            Stack({
              alignContent: Alignment.BottomEnd
            }) {
              //列表
              List({ scroller: this.listContr }) {
                //轮播图区域
                ListItem() {
                  AppSwiper({ banner: this.banner })
                }

                //通道区域
                ListItem() {
                  AppChannel({ channel: this.channel })
                }

                //品牌直供
                ListItem() {
                  AppBrandList({ brandList: this.brandList });
                }

                //新品首发
                ListItem() {
                  AppNewGoodsList({ newGoodsList: this.newGoodsList });
                }
                //人气推荐
                ListItem(){
                  AppPopular({ hotGoodsList: this.hotGoodsList })
                }
                //专题精选
                ListItem() {
                  AppTopicList({ topicList: this.topicList })
                }
                ListItem() {
                  AppCategoryList({ CategoryList: this.categoryList })
                }
              }.listDirection(Axis.Vertical)
              .onScrollIndex((startIndex, endIndex, centerIndex) => {
                this.isShow = startIndex >= 1
              });
              //回到顶部
              if (this.isShow) {
                Row() {
                  Image($rawfile("backtop/backtop.svg")).width(30)
                    .fillColor(Color.Black)
                }
                .width(40)
                .height(40)
                .backgroundColor("rgba(0,0,0,0.3)")
                .borderRadius(20)
                .justifyContent(FlexAlign.Center)
                .margin({ right: 10, bottom: 20 })
                .position({right:10,bottom:60})
                .onClick(this.scrollToTop.bind(this));
              }
            }.width("100%").height("100%");
          }
        }.tabBar(this.barItem(0, "首页", $rawfile("bar/home.svg")));
        //专题
        TabContent() {
          Column(){
            AppSearch()
            specialViews()
          }
        }.tabBar(this.barItem(1, "专题", $rawfile("bar/zhaunti.svg")))

        TabContent() {
          Column(){
            AppSearch()
            topicView()
          }
        }.tabBar(this.barItem(2, "分类", $rawfile("bar/fenlei.svg")))

        TabContent() {
          Cart()
        }.tabBar(this.barItem(3, "购物车", $rawfile("bar/cart.svg")))

        TabContent() {
          myViews().position({top: 0})
        }.tabBar(this.barItem(4, "我的", $rawfile("bar/me.svg")))

      }
      .barPosition(BarPosition.End)
      .scrollable(false)
      .layoutWeight(1)
      .onChange((index) => this.curTabIndex = index)
    }
    .height('100%')
    .width('100%')
  }

  //方法区
  scrollToTop() {
    this.listContr.scrollToIndex(0);
  }

  @Builder
  barItem(index: number, title: string, icon: Resource) {
    Column() {
      Image(icon)
        .width(23).fillColor(this.curTabIndex === index ? Color.Red : Color.Black)
      Text(title).fontSize(13).width(40).textAlign(TextAlign.Center)
        .fontColor(this.curTabIndex === index ? Color.Red : Color.Black)
    }
  }
}
