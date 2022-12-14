import express, { urlencoded } from 'express';
import dotenv from 'dotenv';
import colors from 'colors';
import helmet from 'helmet';
import cors from 'cors';
import healthRoutes from './routes/health.routes.js';
import userRoutes from './routes/user.routes.js';

dotenv.config();

const corsOptions = {
  origin: 'http://localhost:3000'
};

const app = express();

app.use(cors(corsOptions));
app.use(helmet());
app.use(express.json());
app.use(express.urlencoded({extended: true}));

app.use(express.static('public'));

app.use('/api/health', healthRoutes);
app.use('/api/user', userRoutes);


const PORT = process.env.PORT || 5000;

app.listen(PORT, () => console.log(`Server running in ${ process.env.NODE_ENV } on port ${ PORT }`.yellow.bold));
