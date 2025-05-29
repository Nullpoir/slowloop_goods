import axios, { AxiosError, AxiosRequestConfig, AxiosResponse } from 'axios';

const axiosApi = axios.create();
axiosApi.defaults.baseURL = 'http://localhost:3000/api';
axiosApi.defaults.timeout = 30000;

axiosApi.interceptors.response.use(
  (response: any) => response,
  (error: AxiosError) => {
    let status: number | undefined = error.response?.status
  
    if (status && status === 401) {
      console.log('API error 401')
    } else if (status && status >= 500) {
      console.log('API error with status', status)
    }
    return Promise.reject(error.response);
  }
);

export default axiosApi;
