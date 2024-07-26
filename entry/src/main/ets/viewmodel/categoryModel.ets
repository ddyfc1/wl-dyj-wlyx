export interface CategoryInfo{
  categoryList: CategoryList[];
  currentCategory: CategoryList;
}
export interface CategoryDetail{
  currentCategory: CategoryList;
}
export interface CategoryList {
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
  subCategoryList?: CategoryList[];
  type: number;
  wap_banner_url: string;
}



