import { newGoodsList } from '../viewmodel/ResponseData'
import { AppHomeTitle } from './AppHomeTitle';
import { router } from '@kit.ArkUI';


@Component
export struct AppNewGoodsList {
  @Prop newGoodsList: Array<newGoodsList>;

  build() {
    Column() {
      AppHomeTitle({title:"周一周四·新品首发"})

      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.newGoodsList, (item: newGoodsList) => {
          Column() {
            Image(item.list_pic_url).width("100%")
            Text(item.name);
            Text() {
              Span(`￥${item.retail_price.toFixed(2)}元`)
                .fontColor("#8b0000")
            }
          }.width("50%")
           .onClick(()=>{
            router.pushUrl({
              url:'views/GoodsDetail',
              params:item
            })
          })
        })
      }
    }.borderWidth({
      bottom: 12,
    }).borderColor("#ebedf0")

  }
}