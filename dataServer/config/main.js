module.exports = {
  environments: {
    mainnet: 'mainnet'
  },
  rpcEndpoint: {
    mainnet: process.env.RPC_ENDPOINT || "wss://mainnet.infura.io/ws",
    kovan: process.env.RPC_ENDPOINT || "wss://kovan.infura.io/ws",
  },
  dbConnection: {
    mainnet: process.env.DB_CONNECTION || 'mongodb://localhost:27017/cryptographics',
    kovan: process.env.DB_CONNECTION || 'mongodb://localhost:27017/cryptographics',
  },
  domain: process.env.API_DOMAIN || 'http://localhost:3030',
  lastEndpointVersion: '0.0.1',
  version: 'v1',
  port: process.env.PORT || 3030
};