import { GoodsList } from './ResponseData';

export interface CategoryBrand {
  brotherCategory: Category[];
  currentCategory: Category;
  parentCategory: Category;
}

export interface Category {
  banner_url: string;
  front_desc: string;
  front_name: string;
  icon_url: string;
  id: number;
  img_url: string;
  is_show: number;
  keywords: string;
  level: string;
  name: string;
  parent_id: number;
  show_index: number;
  sort_order: number;
  type: number;
  wap_banner_url: string;
}

export interface BrandList{
  count: number;
  currentPage: number;
  data: GoodsList[];
  filterCategory: FilterCategory[];
  goodsList: GoodsList[];
  pageSize: number;
  totalPages: number;
}
export interface FilterCategory {
  checked: boolean;
  id: number;
  name: string;
}
