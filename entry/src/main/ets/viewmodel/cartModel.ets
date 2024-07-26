@Observed
export class Cart {
  cartList: CartList[] = [];
  cartTotal: CartTotal = {} as CartTotal;
  constructor(cartList:CartList[],cartTotal:CartTotal) {
    this.cartList = cartList
    this.cartTotal = cartTotal
  }
}
@Observed
export class  CartList {
  checked: number = 0;
  goods_id: number = 0;
  goods_name: string = '';
  goods_sn: string= '';
  goods_specifition_ids: string= '';
  goods_specifition_name_value: string= '';
  id: number= 0;
  list_pic_url: string= '';
  market_price: number= 0;
  number: number= 0;
  product_id: number= 0;
  retail_price: number= 0;
  session_id: string =  '';
  user_id: number = 0;
}
@Observed
export class  CartTotal {
  checkedGoodsAmount: number = 0;
  checkedGoodsCount: number = 0;
  goodsAmount: number =0;
  goodsCount: number =0;
}