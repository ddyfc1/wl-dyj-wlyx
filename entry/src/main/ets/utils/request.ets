import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from "@ohos/axios";

export const httpRequest=axios.create({
  baseURL:"http://youker.net:8360",
  // timeout:2000
})

httpRequest.interceptors.request.use((config:InternalAxiosRequestConfig)=>{
  config.headers['Accept-Encoding'] = "gzip, deflate"
  config.headers['Accept-Language'] = "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6"
  config.headers['Connection'] = "keep-alive"
  config.headers["Accept"] = "application/json, text/plain, */*"
  config.headers["Content-Type"] = "application/json"
  config.headers['Host'] = "youker.net:8360"
  config.headers["Origin"] = "http://youker.net"
  config.headers["Referer"] = "http://youker.net/"
  config.headers["User-Agent"] = "Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1 Edg/122.0.0.0"
  config.headers["X-Nideshop-Token"] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMTQ5OSwiaWF0IjoxNjM4Mjc3NzM0fQ.H9WYp2_DpafR3o8l8UT2bb2WSAiHsPI5rcwOEFJGnNQ"
  // config.headers["token"]="xxx"
  return config;
},(err:AxiosError)=>Promise.reject(err))

httpRequest.interceptors.response.use((response:AxiosResponse)=>{
  // 提前判断 response.status  进行提示
  return response.data;
},(err:AxiosError)=>Promise.reject(err))

