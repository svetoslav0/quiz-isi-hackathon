import asyncHandler from 'express-async-handler';


// @desc Check health status
// @route GET /api/health
// @access Public
const getHealth = asyncHandler(async (req, res) => {
  const healthObj = {
    status: 'healthy'
  }

  res.status(200).json(healthObj);
});


export {
  getHealth
};
