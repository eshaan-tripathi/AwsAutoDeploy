const { handler } = require("../index");

test("Lambda returns 200", async () => {
  const response = await handler({});
  expect(response.statusCode).toBe(200);
  expect(JSON.parse(response.body).message).toBe("Lambda executed successfully!");
});
