export async function handler(event) {
  console.log("Event received:", event);

  // Example logic
  return {
    success: true,
    message: "Lambda executed successfully!",
    input: event,
  };
}
//Hihihihih