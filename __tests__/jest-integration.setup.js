const jestIntegrationConfig = require("./jest-integration.config");

//5 minute timeout - necessary for CloudFormation operations
jest.setTimeout(300000) //in miliseconds