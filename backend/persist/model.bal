import ballerina/persist as _;
import ballerina/time;
import ballerinax/persist.sql;

# User entity for the agricultural export platform.
#
# + id - user id (Primary Key)
# + email - user email address (unique)
# + passwordHash - hashed password for authentication
# + role - user role (admin, farmer, buyer_agent)
# + status - user account status (pending, active, suspended)
# + createdAt - user account creation timestamp
# + updatedAt - user account last update timestamp
# + farmer - relation to farmer profile if user is a farmer
# + buyerAgent - relation to buyer agent profile if user is a buyer agent
public type User record {|
    readonly string id;
    string email;
    @sql:Name {value: "password_hash"}
    string? passwordHash;
    UserRole role;
    UserStatus status;
    @sql:Name {value: "created_at"}
    time:Civil createdAt;
    @sql:Name {value: "updated_at"}
    time:Civil updatedAt;
    
    // Relations
    Farmer? farmer;
    BuyerAgent? buyerAgent;
|};

# Farmer entity for agricultural producers.
#
# + id - farmer id (Primary Key)
# + firstName - farmer's first name
# + lastName - farmer's last name
# + phone - farmer's contact phone number
# + address - farmer's residential address
# + farmLocation - location of the farm
# + farmSize - size of the farm in acres/hectares
# + verificationStatus - farmer verification status by admin
# + createdAt - farmer profile creation timestamp
# + user - relation to user account
# + crops - relation to crops listed by this farmer
public type Farmer record {|
    readonly string id;
    @sql:Name {value: "first_name"}
    string firstName;
    @sql:Name {value: "last_name"}
    string lastName;
    string? phone;
    string? address;
    @sql:Name {value: "farm_location"}
    string? farmLocation;
    @sql:Name {value: "farm_size"}
    decimal? farmSize;
    @sql:Name {value: "verification_status"}
    VerificationStatus verificationStatus;
    @sql:Name {value: "created_at"}
    time:Civil createdAt;
    
    // Relations
    User user;
    Crop[] crops;
|};

# Buyer Agent entity for export company representatives.
#
# + id - buyer agent id (Primary Key)
# + companyName - name of the export company
# + contactPerson - primary contact person name
# + phone - company contact phone number
# + businessLicense - business license number or identifier
# + verificationStatus - buyer agent verification status by admin
# + createdAt - buyer agent profile creation timestamp
# + user - relation to user account
# + orders - relation to orders placed by this buyer agent
public type BuyerAgent record {|
    readonly string id;
    @sql:Name {value: "company_name"}
    string companyName;
    @sql:Name {value: "contact_person"}
    string contactPerson;
    string? phone;
    @sql:Name {value: "business_license"}
    string? businessLicense;
    @sql:Name {value: "verification_status"}
    VerificationStatus verificationStatus;
    @sql:Name {value: "created_at"}
    time:Civil createdAt;
    
    // Relations
    User user;
    Order[] orders;
|};

# Crop entity for agricultural products listed for export.
#
# + id - crop id (Primary Key)
# + cropType - type of crop (rice, wheat, vegetables, etc.)
# + variety - specific variety of the crop
# + grade - quality grade of the crop (A, B, C, etc.)
# + quantity - available quantity for sale
# + unit - unit of measurement (kg, tons, bags, etc.)
# + pricePerUnit - price per unit in local currency
# + harvestDate - date when the crop was harvested
# + expiryDate - expiry or best before date
# + description - detailed description of the crop
# + status - crop availability status
# + createdAt - crop listing creation timestamp
# + farmer - relation to the farmer who listed this crop
# + orderItems - relation to order items containing this crop
public type Crop record {|
    readonly string id;
    @sql:Name {value: "crop_type"}
    string cropType;
    string? variety;
    string? grade;
    decimal quantity;
    string unit;
    @sql:Name {value: "price_per_unit"}
    decimal pricePerUnit;
    @sql:Name {value: "harvest_date"}
    time:Date? harvestDate;
    @sql:Name {value: "expiry_date"}
    time:Date? expiryDate;
    string? description;
    CropStatus status;
    @sql:Name {value: "created_at"}
    time:Civil createdAt;
    
    // Relations
    Farmer farmer;
    OrderItem[] orderItems;
|};

# Order entity for purchase orders from buyer agents.
#
# + id - order id (Primary Key)
# + totalAmount - total amount for the entire order
# + status - current status of the order
# + createdAt - order creation timestamp
# + updatedAt - order last update timestamp
# + buyerAgent - relation to the buyer agent who placed this order
# + orderItems - relation to items included in this order
public type Order record {|
    readonly string id;
    @sql:Name {value: "total_amount"}
    decimal totalAmount;
    OrderStatus status;
    @sql:Name {value: "created_at"}
    time:Civil createdAt;
    @sql:Name {value: "updated_at"}
    time:Civil updatedAt;
    
    // Relations
    BuyerAgent buyerAgent;
    OrderItem[] orderItems;
|};

# Order Item entity for individual items within an order.
#
# + id - order item id (Primary Key)
# + quantity - quantity of the crop ordered
# + unitPrice - price per unit at the time of order
# + totalPrice - total price for this line item
# + order - relation to the parent order
# + crop - relation to the crop being ordered
public type OrderItem record {|
    readonly string id;
    decimal quantity;
    @sql:Name {value: "unit_price"}
    decimal unitPrice;
    @sql:Name {value: "total_price"}
    decimal totalPrice;
    
    // Relations
    Order 'order;
    Crop crop;
|};

# User role enumeration.
public enum UserRole {
    ADMIN = "admin",
    FARM_USER = "farmer",
    BUYER_USER = "buyer_agent"
}

# User account status enumeration.
public enum UserStatus {
    PENDING = "pending",
    ACTIVE = "active",
    SUSPENDED = "suspended"
}

# Verification status enumeration for farmers and buyer agents.
public enum VerificationStatus {
    PENDING = "pending",
    VERIFIED = "verified",
    REJECTED = "rejected"
}

# Crop availability status enumeration.
public enum CropStatus {
    AVAILABLE = "available",
    RESERVED = "reserved",
    SOLD = "sold",
    EXPIRED = "expired"
}

# Order status enumeration.
public enum OrderStatus {
    PENDING = "pending",
    CONFIRMED = "confirmed",
    IN_PROGRESS = "in_progress",
    SHIPPED = "shipped",
    DELIVERED = "delivered",
    CANCELLED = "cancelled"
}
