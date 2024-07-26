import { banner } from '../viewmodel/ResponseData';

@Entry
@Component
export struct AppSwiper {
  @Prop banner:Array<banner>=[];
  build() {
    Swiper() {
      ForEach(this.banner, (item: banner) => {
        Image(item.image_url).width("100%")
      })
    }.autoPlay(true)
    .interval(2000)

    .indicator(new DotIndicator()
      .color(Color.White)
      .selectedColor("rgb(183,93,18)"))
  }
}