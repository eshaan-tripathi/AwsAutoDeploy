exports.handler = async (event) => {
  // Intentional syntax error
  const result = await someFunction();
  return result;
};
