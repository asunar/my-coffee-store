const 
    AWS = require("aws-sdk"),
    https = require('https')

let apiEndpoint

beforeAll(async () => {
    const apiName = process.env.hasOwnProperty('API_NAME') ? process.env['API_NAME'] : 'sam-app'
    console.log(`Looking for API Gateway named [${apiName}]`)

    const apis = await new AWS.ApiGatewayV2().getApis().promise()

    const apiEndpoints = apis.Items
    apiEndpoint = apis.Items.find(api => api.Name === apiName).ApiEndpoint
    console.log(`Using Coffee Store API at [${apiEndpoint}]`)
})

test('API should return 200 exit code and expected content', async () => {
    expect(apiEndpoint).toBeDefined()

    const result = await getWithBody(`${apiEndpoint}/`)

    expect(result.statusCode).toBe(200)
    expect(result.body).toBe("Hello World Episode 4!")
})

function getWithBody(url) {
    return new Promise((resolve, reject) => {
        https.get(url, (response) => {
            let body = ''
            response.on('data', (chunk) => body += chunk)
            response.on('end', () => resolve({...response, ...{body: body}}))
        }).on('error', reject)
    })}