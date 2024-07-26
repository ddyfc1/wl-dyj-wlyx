import { topicList } from '../viewmodel/ResponseData';
import { AppHomeTitle } from './AppHomeTitle';
import { router } from '@kit.ArkUI';


@Component
export struct AppTopicList {
  @Prop topicList: Array<topicList>;

  build() {
    Column() {
      AppHomeTitle({ title: "专题精选" })
      List() {
        ForEach(this.topicList, (item: topicList) => {
          ListItem() {
            Column() {
              Image(item.item_pic_url)
                .objectFit(ImageFit.Cover)
                .width("90%").height(200)
              Text(item.subtitle).width("90%")
                .textAlign(TextAlign.Start)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
              Text(`￥${item.price_info.toFixed(2)}元`)
                .textAlign(TextAlign.Start)
                .width("90%")
                .fontColor("#8b0000")
            }.width("100%")
            .justifyContent(FlexAlign.Start)
          }.padding(5)
        })
      }.listDirection(Axis.Horizontal)
    }
  }
}