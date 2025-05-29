import axios from 'src/utils/axios'
import { PaginationMeta } from 'src/types/common'
import { Good } from 'src/types/good'

export type GoodsSearch = {
  page?: Number
  per?: Number,
  name?: String | null
}

export type IndexResponseType = {
  goods: Good[],
  meta: PaginationMeta
}

export const index = async (params: GoodsSearch): Promise<IndexResponseType> => {
  const { data } = await axios.get('/v1/goods', {
    params: {
      ...params,
      'q[name_cont]': params.name
    }
  })

  return {
    goods: data.goods,
    meta: data.meta
  }
}
