@Component
export struct AppHomeTitle {
  title:string="品牌制造商直供"
  build() {
    Row() {
      Text(this.title)
        .fontSize(22)
        .height(60)
    }.width("100%").justifyContent(FlexAlign.Center)
  }
}