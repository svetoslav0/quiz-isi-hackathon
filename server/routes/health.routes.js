import express from 'express';
import { getHealth } from '../controllers/health.controller.js';

const router = express.Router();

router.get('/', getHealth);

export default router;
