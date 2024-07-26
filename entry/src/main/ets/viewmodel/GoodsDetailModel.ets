import { GoodsList } from '../viewmodel/ResponseData'

export interface GoodsDetail{
  attribute: Attribute[];
  brand: Brand;
  comment: Comment;
  gallery: Gallery[];
  info: Info;
  issue: Issue[];
  productList: ProductList[];
  specificationList: string[];
  userHasCollect: number;
}
export interface GoodsRelated{
  goodsList: GoodsList[];
}

export interface GoodsScount{
  cartTotal: CartTotal;
}

export interface CartTotal {
  goodsCount: number;
}
export interface Attribute {
  name: string;
  value: string;
}

export interface Brand {
  app_list_pic_url: string;
  floor_price: number;
  id: number;
  is_new: number;
  is_show: number;
  list_pic_url: string;
  name: string;
  new_pic_url: string;
  new_sort_order: number;
  pic_url: string;
  simple_desc: string;
  sort_order: number;
}

export interface Comment {
  count: number;
  data: CommentData;
}

export interface CommentData {
  add_time: string;
  content: string;
  pic_list: PicList[];
}

export interface PicList {
  comment_id: number;
  id: number;
  pic_url: string;
  sort_order: number;
}

export interface Gallery {
  goods_id: number;
  id: number;
  img_desc: string;
  img_url: string;
  sort_order: number;
}

export interface Info {
  add_time: number;
  app_exclusive_price: number;
  attribute_category: number;
  brand_id: number;
  category_id: number;
  counter_price: number;
  extra_price: number;
  goods_brief: string;
  goods_desc: string;
  goods_number: number;
  goods_sn: string;
  goods_unit: string;
  id: number;
  is_app_exclusive: number;
  is_delete: number;
  is_hot: number;
  is_limited: number;
  is_new: number;
  is_on_sale: number;
  keywords: string;
  list_pic_url: string;
  name: string;
  primary_pic_url: string;
  primary_product_id: number;
  promotion_desc: string;
  promotion_tag: string;
  retail_price: number;
  sell_volume: number;
  sort_order: number;
  unit_price: number;
}

export interface Issue {
  answer: string;
  goods_id: string;
  id: number;
  question: string;
}

export interface ProductList {
  goods_id?: number;
  goods_number?: number;
  goods_sn?: string;
  goods_specification_ids?: string;
  id?: number;
  retail_price?: number;
}