// defalut import
import * as React from 'react';
import { useRecoilState } from 'recoil'

// componnet
import AppHeader from 'src/components/header';
import { Box, CssBaseline } from '@mui/material';

// JSX
const Home = (): JSX.Element => {
  return(
    <>
      <Box sx={{ display: 'flex', flexDirection: 'column', minHeight: "100vh" }}>
        <AppHeader />
        <CssBaseline/>
        <Box sx={{ display: 'flex', flexWrap: "wrap", minWidth: "100vw"}}>
 
        </Box>
      </Box>
    </>
  )
}

export default Home;
