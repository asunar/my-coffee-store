const lambda = require('../../src/api.js')

describe('Test Web API handler', () => {
    it('should return expected message', async () => {
        const result = await lambda.handler({});

        const expectedResult = {
            statusCode: 200,
            body: "Hello world episode 2!"
        };

        expect(result).toEqual(expectedResult)
    })
})