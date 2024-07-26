import { LengthMetrics, promptAction, router } from '@kit.ArkUI';
import { searchInit, getSearchHelper, getSearchList, delSearchHistory } from '../api/index'
import { GoodsList } from '../viewmodel/ResponseData';
import { ResData } from '../viewmodel/ResponseData';
import {
  SearchModel,
  HotKeywordList,
  SearchParams,
  PriceParams,
  SearchResult
} from '../viewmodel/searchModel';
import { SearchDialog } from '../components/SearchDialog'
import { SearchList } from '../components/SearchList'

@Entry
@Component
struct SearchViews {
  @State isSearch: boolean = false
  @State searchDone: boolean = false
  @State @Watch('searchChange') search_info: string = '';
  @State init_info: SearchModel = {} as SearchModel
  @State resultList: Array<string> = []
  @State goodsList: Array<GoodsList> = []
  @State @Watch('priceChange') price_params: PriceParams[] = [
    { name: '从低到高', checked: true, order: 'asc' },
    { name: '从高到低', checked: false, order: 'desc' }
  ]
  @State @Watch('paramsChange') params: SearchParams = {
    page: 1,
    size: 10,
    order: 'asc',
    sort: 'price',
    categoryId: 0,
    keyword: ''
  } as SearchParams
  private myDialog: CustomDialogController = new CustomDialogController({
    builder: SearchDialog({
      price_params: this.price_params
    }),
    width: '100%',
    alignment: DialogAlignment.Top,
    offset: { dx: 0, dy: '16.5%' }
  })

  aboutToAppear(): void {
    this.loadNet()
  }

  priceChange() {
    this.price_params.forEach((item: PriceParams) => {
      if (item.checked) {
        this.params.order = item.order
      }
    })
  }

  paramsChange() {
    this.getGoodsList()
    this.myDialog.close()
  }

  async loadNet() {
    let res: ResData<SearchModel> = await searchInit<SearchModel>()
    this.init_info = res.data
  }

  async getGoodsList() {
    let res: ResData<SearchResult> = await getSearchList<SearchResult>(this.params)
    this.goodsList = res.data.data
    console.log(JSON.stringify(this.goodsList))
  }
  async searchChange() {
    if (this.isSearch) {
      let res: ResData<Array<string>> = await getSearchHelper<Array<string>>(this.search_info)
      this.resultList = res.data
    }
  }

  build() {
    Column() {
      Row() {
        Search({ placeholder: this.init_info.defaultKeyword?.keyword, value: $$this.search_info })
          .layoutWeight(1)
          .margin({ left: 10 })
          .onChange((value) => {
            this.search_info = value
          })
          .onKeyEvent(() => {
            this.isSearch = true
            this.searchDone = false
          })

          .height('6%')

        Button('取消').backgroundColor(Color.Transparent).fontColor(Color.Black)
          .onClick(() => router.back())
      }.margin({ top: 10, bottom: 15 })

      Column() {
        Row() {
          Text('搜索历史').fontSize(25)
          Image($rawfile('search/delete.png')).width('10%')
            .onClick(async ()=>{
              let res:ResData<string> = await delSearchHistory<string>()
              if(res.errno === 0){
                promptAction.showToast({
                  message:'删除成功'
                })
                this.loadNet()
              }
            })
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ top: 30, bottom: 30 })
        .padding({ left: 10, right: 10 })

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.lpx(20), cross: LengthMetrics.lpx(20) } }) {
          ForEach(this.init_info.historyKeywordList, (item: string) => {
            Text(item)
              .fontSize(20)
              .padding(7)
              .border({
                width: 1,
                color: Color.Gray
              })
              .borderRadius(5)
              .onClick(() => {
                this.searchDone = true
                this.isSearch = false
                this.search_info = item
                this.params.keyword = item
              })
          })
        }.width('100%').padding({ left: 20, right: 10 }).margin({ bottom: 50 })

        Divider().strokeWidth(1)
      }.visibility(this.isSearch || this.searchDone ? Visibility.None : Visibility.Visible)

      Column() {
        Row() {
          Text('热门搜索').fontSize(25)
        }.width('100%').justifyContent(FlexAlign.Start).margin({ top: 30, bottom: 30 })
        .padding({ left: 10, right: 10 })

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.lpx(20), cross: LengthMetrics.lpx(20) } }) {
          ForEach(this.init_info.hotKeywordList, (item: HotKeywordList) => {
            Text(item.keyword)
              .fontSize(20)
              .padding(7)
              .border({
                width: 1,
                color: item.is_hot > 0 ? Color.Red : Color.Gray
              })
              .borderRadius(5)
              .onClick(() => {
                this.searchDone = true;
                this.isSearch = false
                this.params.keyword = item.keyword
                this.search_info = item.keyword
              })
          })
        }.width('100%').padding({ left: 20, right: 10 }).margin({ bottom: 50 })
      }.visibility(this.isSearch || this.searchDone ? Visibility.None : Visibility.Visible)


      Column() {
        ForEach(this.resultList, (item: string) => {
          Column({ space: 10 }) {
            Text(item).fontSize(22).margin({ left: 20 }).fontWeight(1)
            Divider().strokeWidth(1)
          }.width('100%').alignItems(HorizontalAlign.Start).margin({ top: 20 })
          .onClick(() => {
            this.searchDone = true
            this.isSearch = false
            this.params.keyword = item
            this.search_info = item
          })
        })
      }.visibility(this.isSearch && !this.searchDone ? Visibility.Visible : Visibility.None)

      Column() {
        Divider().strokeWidth(1)
        Row() {
          Row() {
            Text('综合').fontSize(25).fontColor(Color.Gray)
            Image($rawfile("search/down.png")).width(20).fillColor(Color.Gray)
          }

          Row() {
            Text('价格').fontSize(25)
            Image($rawfile('search/down.png')).width(20)
          }.onClick(() => {
            this.myDialog.open()
          })

          Row() {
            Text('分类').fontSize(25)
            Image($rawfile('search/down.png')).width(20)
          }
        }.width('100%').justifyContent(FlexAlign.SpaceAround)
        .padding({ top: 15, bottom: 15 })

        Column() {
          SearchList({ goodsList: this.goodsList })
        }.width('100%').layoutWeight(1)

      }.visibility(!this.isSearch && this.searchDone ? Visibility.Visible : Visibility.None)
      .layoutWeight(1)

      Column() {
        Text('没有更多了').fontSize(25).fontColor(Color.Gray).margin({ top: 20 })
          .visibility(this.isSearch || this.searchDone ? Visibility.Visible : Visibility.None)
      }.width('100%').layoutWeight(1).backgroundColor('rgb(238,238,238)')
      .visibility(!this.isSearch && this.searchDone ? Visibility.None : Visibility.Visible)
    }
    .height('100%')
    .width('100%')
  }
}