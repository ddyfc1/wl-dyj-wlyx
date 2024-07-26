import { PriceParams} from '../viewmodel/searchModel'

@Component
@CustomDialog
export struct SearchDialog{
  controller:CustomDialogController;
  @Link price_params:PriceParams[]
  build() {
    Column(){
      ForEach(this.price_params,(item:PriceParams,index:number)=>{
        Row(){
          Text(item.name).fontSize(20).fontColor(item.checked?Color.Red:Color.Black)

          Radio({value:item.order,group:'order'})
            .checked(item.checked)
            .onChange(value=>{
              // console.log(item.name + '  ' + value)
              item.checked = value
              if(value){
                this.price_params[index] = JSON.parse(JSON.stringify(item))
                // console.log(JSON.stringify(this.price_params));
              }
            })
            .radioStyle({
              checkedBackgroundColor: Color.Red
            })
        }.width('100%').height('10%').justifyContent(FlexAlign.SpaceBetween)
        .padding({left:10,right:10})
      })
      Image($rawfile('goodsDetail/Cancel.png')).width(40).backgroundColor(Color.White)
        .padding(10).borderRadius(20)
        .onClick(()=>this.controller.close())
    }.width('100%')
  }
}