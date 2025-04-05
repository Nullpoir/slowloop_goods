import { styled } from '@mui/material/styles'
import { Card, Box, CssBaseline, Button  } from '@mui/material';


const StyledCard = styled(Card)(({ theme }) => ({
  margin: theme.spacing(1),
  boxShadow: theme.shadows[3],
  color: theme.palette.error.main,
  minHeight: "250px",
  flexBasis: "250px"
  
}))

type Props = {
  name: string
}

const AppCard = (prop: Props): JSX.Element => {
  return(
    <StyledCard>
      { prop.name }
      <Button>
        詳細
      </Button>
    </StyledCard>
  )
}

export default AppCard;
