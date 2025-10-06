exports.handler = async (event) => {
  console.log("Event:", event);

  return {
    statusCode: 201,
    body: JSON.stringify({
      message: "Lambda executed successfully", 
    }),
  };
};
