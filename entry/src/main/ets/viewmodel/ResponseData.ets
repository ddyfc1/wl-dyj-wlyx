//轮播图数据结构
export interface banner {
  id: number;
  ad_position_id: number;
  media_type: number;
  name: string;
  link: string;
  image_url: string;
  content: string;
  end_time: number;
  enabled: number;
}

//通道结构
export interface channel {
  id: number;
  name: string;
  url: string;
  icon_url: string;
  sort_order: number;
}

//人气推荐
export interface HotGoodsList {
  goods_brief: string;
  id: number;
  list_pic_url: string;
  name: string;
  retail_price: number;
}

//品牌直供
export interface brandList {
  id: number,
  name: string,
  list_pic_url: string,
  simple_desc: string,
  pic_url: string,
  sort_order: number,
  is_show: number,
  floor_price: number,
  app_list_pic_url: string,
  is_new: number,
  new_pic_url: string,
  new_sort_order: number
}

//新品首发
export interface newGoodsList {
  id: number;
  name: string;
  list_pic_url: string;
  retail_price: number;
}

//专题精选
export interface topicList {
  id: number;
  title: string;
  content: string;
  avatar: string;
  item_pic_url: string;
  subtitle: string;
  topic_category_id: number;
  price_info: number;
  read_count: string;
  scene_pic_url: string;
  topic_template_id: number;
  topic_tag_id: number;
  sort_order: number;
  is_show: number;
}

export interface CategoryList {
  goodsList: GoodsList[];
  id: number;
  name: string;
}

export interface GoodsList {
  id: number;
  list_pic_url: string;
  name: string;
  retail_price: number | number;
}


//响应首页具体数据
export interface IndexData {
  hotGoodsList: Array<HotGoodsList>;
  banner: Array<banner>;
  channel: Array<channel>;
  brandList: Array<brandList>;
  newGoodsList: Array<newGoodsList>;
  topicList: Array<topicList>;
  categoryList: Array<CategoryList>;
}

//专题
export interface CatalogData {
  categoryList: Array<categoryList>;
  currentCategory: currentCategory;
}

//专题明细,只返回了一个对象
export interface CurrentCatalogData {
  currentCategory: currentCategory;
}

export interface currentCategory {
  id: number,
  name: string,
  keywords: string,
  front_desc: string,
  parent_id: number,
  sort_order: number,
  show_index: number,
  is_show: number,
  banner_url: string,
  icon_url: string,
  img_url: string,
  wap_banner_url: string,
  level: string,
  type: 0,
  front_name: string,
  subCategoryList: Array<subCategoryList>
}

export interface categoryList {
  id: number;
  name: string;
  keywords: string;
  front_desc: string,
  parent_id: number;
  sort_order: number;
  show_index: number;
  is_show: number;
  banner_url: string;
  icon_url: string;
  img_url: string;
  wap_banner_url: string;
  level: string;
  type: number;
  front_name: string;
  subCategoryList: Array<subCategoryList>
}

export interface subCategoryList {
  id: number,
  name: string,
  keywords: string,
  front_desc: string,
  parent_id: number,
  sort_order: number,
  show_index: number,
  is_show: number,
  banner_url: string,
  icon_url: number
  img_url: number,
  wap_banner_url: string,
  level: string,
  type: number,
  front_name: string
}


//响应结果的结构
export interface ResData<T> {
  errno: number;
  errmsg: string;
  data: T
}

//购物车
export interface cartList{
  checked: number,
  goods_id: number
  goods_name: string,
  goods_sn: string,
  goods_specifition_ids: string,
  goods_specifition_name_value: string,
  id: number,
  list_pic_url: string,
  market_price: number,
  number: number,
  product_id: number,
  retail_price: number,
  session_id: string,
  user_id: number
}

export interface cartTotal{
  checkedGoodsAmount: number,
  checkedGoodsCount: number,
  goodsAmount: number,
  goodsCount: number
}

//响应购物车具体数据
export interface cart{
  cartTotal: cartTotal;
  cartList: Array<cartList>;
}

//专题
export interface data{
  data: Array<dataList>
}

export interface dataList{
  id: number,
  price_info: number,
  scene_pic_url: string,
  subtitle: string,
  title: string
}

export interface tab_index{
  id: number;
}

