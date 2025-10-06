exports.handler = async (event) => {
  console.log("Event:", event);

  // simple response
  return {
    statusCode: 200,
    body: JSON.stringify({ message: "Lambda deployed successfully!" }),
  };
};
