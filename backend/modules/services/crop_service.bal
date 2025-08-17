import agri_backend.store;
import agri_backend.auth;
import ballerina/log;

public type CropCreateRequest record {
    string cropType;
    string? variety;
    decimal quantity;
    string unit;
    decimal pricePerUnit;
};

public class CropService {
    private final store:Client dbClient;

    public function init(store:Client dbClient) {
        self.dbClient = dbClient;
    }

    public function getCrops(auth:AuthContext authContext) returns json[]|error {
        stream<store:Crop, error?> cropStream = self.dbClient->/crops;
        return from store:Crop crop in cropStream
               select {
                   "id": crop.id,
                   "cropType": crop.cropType,
                   "variety": crop.variety,
                   "quantity": crop.quantity,
                   "pricePerUnit": crop.pricePerUnit,
                   "status": crop.status
               };
    }

    public function createCrop(CropCreateRequest request, auth:AuthContext authContext) returns json|error {
        // Use string concatenation instead of template literals
        string logMessage = "User " + authContext.email + " creating crop: " + request.cropType;
        log:printInfo(logMessage);
        
        // Implementation for creating crops would go here
        return {"message": "Crop creation endpoint - implementation needed"};
    }
}
