exports.handler = async (event) => {
    // Example Lambda function
    console.log("Event:", event);
    return {
        statusCode: 200,
        body: JSON.stringify({ message: "Lambda executed successfully!" }),
    };
};
