const lambda = require("../src/index");

test("Lambda returns status 200", async () => {
  const result = await lambda.handler({});
  expect(result.statusCode).toBe(200);
  expect(JSON.parse(result.body).message).toBe("Lambda deployed successfully!");
});
