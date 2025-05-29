import { styled } from '@mui/material/styles'
import { Card, Box, CssBaseline, Button  } from '@mui/material';
import Image from 'next/image';

const StyledCard = styled(Card)(({ theme }) => ({
  margin: theme.spacing(1),
  boxShadow: theme.shadows[3],
  color: theme.palette.error.main,
  minHeight: "250px",
  flexBasis: "250px",
  display: "flex",
  flexDirection: "column"
}))

type Props = {
  name: String
}

const AppCard = (prop: Props): JSX.Element => {
  return(
    <StyledCard>
      <div>
        { prop.name }
      </div>
      <Image src="" height="100%"/>
      <div>
        <Button>
          詳細
        </Button>
      </div>
    </StyledCard>
  )
}

export default AppCard;
