import axios from 'src/utils/axios'
import { PaginationMeta, Good } from 'src/types/common'

export type GoodsSearch = {
  page?: number
  per?: number,
  name?: string | null
}

export type IndexResponseType = {
  goods: Good[],
  meta: PaginationMeta
}

export const index = async (params: GoodsSearch): Promise<IndexResponseType> => {
  const { data } = await axios.get('/goods', {
    params: {
      ...params,
      'q[name_cont': params.name
    }
  })

  return {
    goods: [data.goods],
    meta: data.meta
  }
}


export const show = async (goodId: number): Promise<IndexResponseType> => {
  const { data } = await axios.get(`/goods/${goodId}`)

  return data.trainingContent
}
