import ballerina/persist as _;
import ballerina/time;
import ballerinax/persist.sql;

# User entity representing platform users
#
# + id - Unique identifier for the user (UUID)
# + email - User's email address used for authentication and communication
# + passwordHash - Hashed password for local users (null for Asgardeo authenticated users)
# + role - User's role in the system (admin, farmer, or buyer_agent)
# + status - Current account status (pending, active, or suspended)
# + createdAt - Timestamp when the user account was created
# + updatedAt - Timestamp when the user account was last updated
# + asgardeoUserId - Unique identifier from Asgardeo authentication provider
# + lastLogin - Timestamp of the user's last successful login
# + loginCount - Number of times the user has logged into the system
# + farmer - Associated farmer profile if the user is a farmer
# + buyerAgent - Associated buyer agent profile if the user is a buyer agent
public type User record {|
    readonly string id;
    string email;
    @sql:Name {value: "password_hash"}
    string? passwordHash; // null for Asgardeo users
    UserRole role;
    UserStatus status;
    @sql:Name {value: "created_at"}
    time:Civil createdAt;
    @sql:Name {value: "updated_at"}
    time:Civil updatedAt;
    
    // Authentication fields
    @sql:Name {value: "asgardeo_user_id"}
    string? asgardeoUserId;
    @sql:Name {value: "last_login"}
    time:Civil? lastLogin;
    @sql:Name {value: "login_count"}
    int loginCount;
    
    // Relations
    Farmer? farmer;
    BuyerAgent? buyerAgent;
|};

# Farmer entity representing agricultural producers
#
# + id - Unique identifier for the farmer (UUID)
# + firstName - Farmer's first name
# + lastName - Farmer's last name
# + phone - Contact phone number
# + address - Physical address of the farmer
# + farmLocation - Geographic location of the farm
# + farmSize - Size of the farm in hectares
# + verificationStatus - Account verification status (pending, verified, rejected)
# + createdAt - Timestamp when the farmer profile was created
# + user - Associated user account
# + crops - List of crops owned by this farmer
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

# Buyer Agent entity representing export company representatives
#
# + id - Unique identifier for the buyer agent (UUID)
# + companyName - Name of the export company
# + contactPerson - Primary contact person at the company
# + phone - Business contact phone number
# + businessLicense - License number for the export business
# + verificationStatus - Account verification status (pending, verified, rejected)
# + createdAt - Timestamp when the buyer agent profile was created
# + user - Associated user account
# + orders - List of orders placed by this buyer agent
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

# Crop entity representing agricultural products for export
#
# + id - Unique identifier for the crop listing (UUID)
# + cropType - Type of crop (e.g., Coffee, Tea, Spices)
# + variety - Specific variety of the crop
# + grade - Quality grade classification
# + quantity - Available quantity for sale
# + unit - Measurement unit (kg, lbs, bags)
# + pricePerUnit - Selling price per unit
# + harvestDate - Date when the crop was harvested
# + expiryDate - Best before/expiration date
# + description - Additional details about the crop
# + status - Current availability status (available, reserved, sold, expired)
# + createdAt - Timestamp when the crop was listed
# + farmer - Farmer who owns/produces this crop
# + orderItems - Order items associated with this crop
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

# Order entity representing purchase transactions
#
# + id - Unique identifier for the order (UUID)
# + totalAmount - Total value of the order
# + status - Current order status (pending, confirmed, in_progress, shipped, delivered, cancelled)
# + createdAt - Timestamp when the order was created
# + updatedAt - Timestamp when the order was last updated
# + buyerAgent - Buyer agent who placed the order
# + orderItems - Individual items included in this order
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

# Order Item entity representing individual products in an order
#
# + id - Unique identifier for the order item (UUID)
# + quantity - Quantity of the crop ordered
# + unitPrice - Price per unit at time of order
# + totalPrice - Total price for this item (quantity × unitPrice)
# + 'order - Parent order containing this item
# + crop - Crop being ordered
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

# User role enumeration
# + ADMIN - Platform administrator with full privileges
# + FARM_USER - Agricultural producer who lists crops for sale
# + BUYER_USER - Export company representative who purchases crops
public enum UserRole {
    ADMIN = "admin",
    FARM_USER = "farmer",
    BUYER_USER = "buyer_agent"
}

# User account status enumeration
# + PENDING - New account awaiting activation
# + ACTIVE - Active and enabled account
# + SUSPENDED - Temporarily disabled account
public enum UserStatus {
    PENDING = "pending",
    ACTIVE = "active",
    SUSPENDED = "suspended"
}

# Verification status enumeration
# + PENDING - Submitted documents awaiting review
# + VERIFIED - Successfully verified account
# + REJECTED - Verification failed or documents rejected
public enum VerificationStatus {
    PENDING = "pending",
    VERIFIED = "verified",
    REJECTED = "rejected"
}

# Crop availability status enumeration
# + AVAILABLE - Actively listed for sale
# + RESERVED - Temporarily reserved in an order
# + SOLD - Successfully sold and delivered
# + EXPIRED - No longer available for sale
public enum CropStatus {
    AVAILABLE = "available",
    RESERVED = "reserved",
    SOLD = "sold",
    EXPIRED = "expired"
}

# Order lifecycle status enumeration
# + PENDING - New order awaiting confirmation
# + CONFIRMED - Validated and accepted order
# + IN_PROGRESS - Being processed and prepared for shipment
# + SHIPPED - Dispatched to buyer
# + DELIVERED - Successfully received by buyer
# + CANCELLED - Canceled by buyer or seller
public enum OrderStatus {
    PENDING = "pending",
    CONFIRMED = "confirmed",
    IN_PROGRESS = "in_progress",
    SHIPPED = "shipped",
    DELIVERED = "delivered",
    CANCELLED = "cancelled"
}
