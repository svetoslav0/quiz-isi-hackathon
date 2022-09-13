import express from 'express';
import { register, login } from '../controllers/user.controller.js';

const router = express.Router();

router.post('/', register);
router.post('/login', login);

export default router;
