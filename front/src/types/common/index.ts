export type AuthInfo = {
  client: string
  'access-token': string
  uid: string
}

export type PaginationMeta = {
  nextPage: boolean
  page: number
  per: number
  prevPage: boolean
  totalCount: number
}
