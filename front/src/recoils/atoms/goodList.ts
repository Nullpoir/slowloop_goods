import { atom } from 'recoil';
import { Good } from 'src/types/good'

export const goodListState = atom<Good[]>({
  key: 'goodListState',
  default: [], // 初期値は空
});
