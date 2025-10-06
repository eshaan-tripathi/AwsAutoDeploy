const { handler } = require("../src/index");

test("Lambda returns 200", async () => {
  const response = await handler({});
  expect(response.statusCode).toBe(200);
  const body = JSON.parse(response.body);
  expect(body.message).toBe("Lambda executed successfully");
});
