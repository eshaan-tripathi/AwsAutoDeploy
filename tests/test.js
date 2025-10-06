const { handler } = require("../src/index");

test("Lambda handler returns expected response", async () => {
  const event = { key: "value" };
  const result = await handler(event);

  expect(result).toHaveProperty("statusCode", 200);
  expect(result).toHaveProperty("body");

  const body = JSON.parse(result.body);
  expect(body).toHaveProperty("message", "Lambda executed successfully!");
  expect(body).toHaveProperty("input", event);
});
