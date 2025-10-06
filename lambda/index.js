exports.handler = async (event) => {
  console.log("Lambda invoked with event:", event);
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: "Hello from automated Lambda deployment!",
    }),
  };
};
