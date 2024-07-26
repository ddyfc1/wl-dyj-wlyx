
import { GoodsList } from './ResponseData';

export interface SearchParams{
  keyword:string;
  page:number;
  size:number;
  order:string;
  categoryId:number;
  sort:string;
}

export interface SearchResult{
  count: number;
  currentPage: number;
  data: GoodsList[];
  filterCategory: FilterCategory[];
  goodsList: GoodsList[];
  pageSize: number;
  totalPages: number;
}

export interface SearchModel {
  defaultKeyword: DefaultKeyword;
  historyKeywordList: string[];
  hotKeywordList: HotKeywordList[];
}

export interface DefaultKeyword {
  id: number;
  is_default: number;
  is_hot: number;
  is_show: number;
  keyword: string;
  "scheme _url": string;
  sort_order: number;
  type: number;
}

export interface HotKeywordList {
  is_hot: number;
  keyword: string;
}
export interface PriceParams{
  name:string;
  checked:boolean,
  order:string
}

export interface FilterCategory {
  checked: boolean;
  id: number;
  name: string;
}