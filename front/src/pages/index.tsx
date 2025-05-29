// defalut import
import React, { useEffect } from 'react';
import { useRecoilValue, useRecoilState, useSetRecoilState, useRecoilCallback } from 'recoil'

// componnet
import AppHeader from 'src/components/header';
import AppCard from 'src/components/card';
import { Box, CssBaseline } from '@mui/material';

// recoils
import { index, IndexResponseType, GoodsSearch } from 'src/apis/v1/goodApi'
import { goodListState } from 'src/recoils/atoms/goodList'

const useInitializeGoods = () => {
  return useRecoilCallback(({ set }) => async () => {
    const res = await index({})
    set(goodListState, res.goods);
  });
};

// JSX
const Home = (): JSX.Element => {
  let ignoreInitialFetch = false
  const initializeGoods = useInitializeGoods();

  useEffect(() => {
    if(!ignoreInitialFetch) {
      initializeGoods()
      ignoreInitialFetch = true
    }
  }, []);

  const goodList = useRecoilValue(goodListState)

  console.log(goodListState, goodList)
  
  return(
    <>
      <Box sx={{ display: 'flex', flexDirection: 'column', minHeight: "100vh" }}>
        <AppHeader />
        <CssBaseline/>
        {
          goodList.map((good) => (
            <Box key={good.id}>
              <AppCard
                key={good.id}
                name={good.name}
              />
            </Box>
          ))
        }
      </Box>
    </>
  )
}

export default Home;
