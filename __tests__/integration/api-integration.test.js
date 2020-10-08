https = require('https')
test('API should return 200 exit code and expected content', async () => {
    // const apiEndpoint = 'https://txstv0tj9c.execute-api.us-east-1.amazonaws.com/'
    const apiEndpoint = process.env.COFFEE_API_ENDPOINT
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