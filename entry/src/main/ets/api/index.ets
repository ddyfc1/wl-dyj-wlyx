import { httpRequest } from "../utils/request";
import { CartList } from '../viewmodel/cartModel';
import { ResData, IndexData, CatalogData, CurrentCatalogData, data, cart } from "../viewmodel/ResponseData"
import { SearchParams } from '../viewmodel/searchModel';

//获取首页的数据
export const GetIndex = (): Promise<ResData<IndexData>> => httpRequest({ url: "/api/index/index" });

//品牌直供商品详情
export function brandDetail<T>(id:number):Promise<ResData<T>>{
  return httpRequest({
    url:'/brand/detail',
    method:'get',
    params:{
      id
    }
  })
}

//分类
export const PostCatalog = (): Promise<ResData<CatalogData>> => {
  return httpRequest({
    method: "post",
    url: "/api/catalog/index"
  })
}

//分类的详情
export const GetCatalogCurrent = (id: number):Promise<ResData<CurrentCatalogData>> => {
  return httpRequest({
    url: "/api/catalog/current",
    method: "get",
    params: { id } //本质{id:id}
  })
}
export function getCategoryInfo<T>():Promise<ResData<T>>{
  return httpRequest({
    url:'/catalog/index',
    method:'get'
  })
}
export function getCategoryDetail<T>(id:number):Promise<ResData<T>>{
  return httpRequest({
    url:`/catalog/current`,
    method:'get',
    params:{
      id
    }
  })
}

//专题的数据
export const GetData = (): Promise<ResData<data>> => httpRequest({url: "api/topic/list?page=1&size=10"})

//购物车的数据
export const GetCart = (): Promise<ResData<cart>> => httpRequest({url: "api/cart/index"})

//获取商品详情
export function goodsDetail<T>(id:number):Promise<ResData<T>>{
  return httpRequest({
    url:'/goods/detail',
    method:'get',
    params:{
      id
    }
  })
}

export function goodsRelated<T>(id:number):Promise<ResData<T>>{
  return httpRequest({
    url:'/goods/related',
    method:'get',
    params:{
      id
    }
  })
}

export function goodsScount<T>():Promise<ResData<T>>{
  return httpRequest({
    url:'/cart/goodscount',
    method:'get'
  })
}

//商品详情页添加商品进入购物车
interface AddCart{
  goodsId:string;
  number:number;
  productId:number;
}
export function cartAdd<T>(goodsId:string,number:number,productId:number):Promise<ResData<T>>{
  return httpRequest({
    url:'/cart/add',
    method:'post',
    data:{
      goodsId,
      number,
      productId
    } as AddCart
  })
}

//分类详情
export function categoryBrand<T>(id:number):Promise<ResData<T>>{
  return httpRequest({
    url:'/goods/category',
    method:'get',
    params:{id}
  })
}
export function cateBrandList<T>(categoryId:number,page:number,size:number):Promise<ResData<T>>{
  return httpRequest({
    url:'/goods/list',
    method:'get',
    params:{
      categoryId,
      page,
      size
    }
  })
}

//对购车进行操作
export function cartChecked<T>(isChecked:number,productIds:string):Promise<ResData<T>>{
  return httpRequest({
    url:'/cart/checked',
    method:'POST',
    data:{
      isChecked,
      productIds
    } as responseData
  })
}
export function cartDelete<T>(productIds:string):Promise<ResData<T>>{
  return httpRequest({
    url:'/cart/delete',
    method:'post',
    data:{
      productIds
    } as responseData
  })
}
export function cartUpdate<T>(cart:CartList):Promise<ResData<T>>{
  return httpRequest({
    url:'/cart/update',
    method:'post',
    data:{
      'goodsId':cart.goods_id,
      'id':cart.id,
      'number':cart.number,
      'productId':cart.product_id
    } as cartData,
  })
}
interface  responseData{
}
interface  cartData{
  'goodsId': number,
  'id':number,
  'number':number,
  'productId':number
}
export function getCartList<T>():Promise<ResData<T>>{
  return httpRequest({
    url:'/cart/index',
    method:'get'
  })
}

//搜索数据
export function searchInit<T>():Promise<ResData<T>>{
  return httpRequest({
    method:'get',
    url:'/search/index'
  })
}
export  function getSearchHelper<T>(keyword:string):Promise<ResData<T>>{
  return httpRequest({·
    method:'get',
    url:'/search/helper',
    params:{
      keyword
    }
  })
}

export function getSearchList<T>(params:SearchParams):Promise<ResData<T>>{
  return httpRequest({
    method:'get',
    url:"/goods/list",
    params
  })
}
export function delSearchHistory<T>():Promise<ResData<T>>{
  return httpRequest({
    method:'post',
    url:'/search/clearhistory'
  })
}