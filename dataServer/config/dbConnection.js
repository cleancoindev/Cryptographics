'use strict';

const mongoose = require('mongoose');
const config = require('./main');
const env = require('./main').environments;
const logger = require('./logger');

process.env.NODE_ENV = env.mainnet;

// Service Database
logger.info('Connecting to the Mongo DB: ' + config.dbConnection[process.env.NODE_ENV]);
mongoose.connect(config.dbConnection[process.env.NODE_ENV]);

const db = mongoose.connection;
db.on('error', (err) => {
  logger.error('Error connecting to Mongo DB');
  logger.error(err)
});
db.once('open', () => {
  logger.info('Connection to API service DB ok!')
});

process.on('unhandledRejection', (err) => {
  logger.error(err)
});

mongoose.db = db;

module.exports = mongoo;