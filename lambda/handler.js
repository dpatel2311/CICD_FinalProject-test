exports.handler = async (event) => {
    const responseText = "Thank You Prof. Aagam for your unwavering Support!!!";
    
    const response = {
        statusCode: 200,
        body: JSON.stringify({ message: responseText }),
        headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*", // Add this header for CORS
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Allow-Methods": "OPTIONS,GET"
        }
    };
    
    return response;
};