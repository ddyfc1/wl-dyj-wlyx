import { router } from '@kit.ArkUI';

@Component
export struct AppSearch {
  build() {
    Row() {
      Search({ placeholder: "请输入搜索关键字" }).borderRadius(5)
        .onSubmit((value)=>{
          router.pushUrl({
            url:'views/SearchViews'
          })
        })
    }
    .padding({
      left: 10,
      right: 10,
      top: 5,
      bottom: 0
    });

  }
}