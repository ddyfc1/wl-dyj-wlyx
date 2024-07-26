import { GetData } from '../api';
import { data, dataList, ResData } from '../viewmodel/ResponseData'

@Entry
@Component
export struct specialViews {
  @State arr: Array<dataList> = [];
  async aboutToAppear() {
    let res: ResData<data> = await GetData();
    console.log(JSON.stringify(res));
    this.arr = res.data.data
  }
  build() {
    List(){
      ForEach(this.arr,(item: dataList) => {
        ListItem() {
          Column() {
            Image(item.scene_pic_url)
            Text(item.title).width("100%").textAlign(TextAlign.Start)
              .margin({top:10,left:5}).fontSize(22)
            Text(item.subtitle).width("100%").textAlign(TextAlign.Start)
              .margin({left:5,top:8}).fontSize(16).fontColor("rgb(166,195,232)")
            Text(){
              Span("￥").fontColor(Color.Red)
              Span(item.price_info.toFixed(2)).fontColor(Color.Red).fontSize(25)
              Span("元").fontColor(Color.Red)
            }.width("100%").textAlign(TextAlign.Start)
              .margin({top:15,left:5,bottom:15})
          }
        }
      })
    }
  }
}