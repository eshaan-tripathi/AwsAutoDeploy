// CommonJS format
exports.handler = async (event) => {
  // Sample logic
  const response = {
    statusCode: 200,
    body: JSON.stringify({ message: "Lambda executed successfully!", input: event }),
  };

  return response;
};
