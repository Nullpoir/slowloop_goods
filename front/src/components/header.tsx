import { styled } from '@mui/material/styles'
import { AppBar } from '@mui/material';



const Header = styled(AppBar)(({ theme }) => ({
  height: "50px",
  position: "sticky",
  display: "flex",
  justifyContent: "center",
  alignItems: "left",
  padding: "0 20px"
}))

const AppHeader = (): JSX.Element => {
  return(
    <Header>
      SlowLoop Goods
    </Header>
  )
}

export default AppHeader;
