import assert from "assert";
import { handler } from "../index.js";

(async () => {
  const result = await handler({ test: true });
  assert.ok(result.success, "Lambda did not return success");
  console.log("✅ Lambda test passed");
})();
