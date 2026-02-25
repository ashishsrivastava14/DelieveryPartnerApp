class MockData {
  // ─── STORES ─────────────────────────────────────────────
  static final List<Map<String, dynamic>> stores = [
    {
      'id': '1',
      'name': 'Burger Kingdom',
      'image': 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400',
      'coverImage': 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800',
      'category': 'Food',
      'rating': 4.5,
      'reviews': 1246,
      'eta': '25-35 min',
      'distance': '2.3 km',
      'isOpen': true,
      'timing': '9:00 AM - 11:00 PM',
      'freeDelivery': true,
    },
    {
      'id': '2',
      'name': 'Pizza Paradise',
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400',
      'coverImage': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800',
      'category': 'Food',
      'rating': 4.8,
      'reviews': 2340,
      'eta': '30-40 min',
      'distance': '1.8 km',
      'isOpen': true,
      'timing': '10:00 AM - 12:00 AM',
      'freeDelivery': false,
    },
    {
      'id': '3',
      'name': 'Green Basket Grocery',
      'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400',
      'coverImage': 'https://images.unsplash.com/photo-1488459716781-31db52582fe9?w=800',
      'category': 'Grocery',
      'rating': 4.3,
      'reviews': 890,
      'eta': '15-25 min',
      'distance': '0.8 km',
      'isOpen': true,
      'timing': '7:00 AM - 10:00 PM',
      'freeDelivery': true,
    },
    {
      'id': '4',
      'name': 'MediCare Pharmacy',
      'image': 'https://images.unsplash.com/photo-1585435557343-3b092031a831?w=400',
      'coverImage': 'https://images.unsplash.com/photo-1576602976047-174e57a47881?w=800',
      'category': 'Pharmacy',
      'rating': 4.7,
      'reviews': 567,
      'eta': '20-30 min',
      'distance': '3.1 km',
      'isOpen': true,
      'timing': '8:00 AM - 9:00 PM',
      'freeDelivery': false,
    },
    {
      'id': '5',
      'name': 'Sushi Sensation',
      'image': 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=400',
      'coverImage': 'https://images.unsplash.com/photo-1553621042-f6e147245754?w=800',
      'category': 'Food',
      'rating': 4.6,
      'reviews': 1823,
      'eta': '35-45 min',
      'distance': '4.2 km',
      'isOpen': true,
      'timing': '11:00 AM - 11:00 PM',
      'freeDelivery': false,
    },
  ];

  // ─── MENU ITEMS ─────────────────────────────────────────
  static final List<Map<String, dynamic>> menuItems = [
    {'id': '1', 'name': 'Classic Cheeseburger', 'price': 199.0, 'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300', 'category': 'Burgers', 'description': 'Juicy beef patty with melted cheddar, lettuce, tomato & special sauce', 'isVeg': false, 'isAvailable': true, 'orderCount': 342},
    {'id': '2', 'name': 'Veggie Supreme Burger', 'price': 179.0, 'image': 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=300', 'category': 'Burgers', 'description': 'Crispy veggie patty with fresh veggies and tangy mayo', 'isVeg': true, 'isAvailable': true, 'orderCount': 278},
    {'id': '3', 'name': 'Margherita Pizza', 'price': 299.0, 'image': 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=300', 'category': 'Pizza', 'description': 'Classic tomato sauce, fresh mozzarella, and basil', 'isVeg': true, 'isAvailable': true, 'orderCount': 456},
    {'id': '4', 'name': 'Pepperoni Pizza', 'price': 349.0, 'image': 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=300', 'category': 'Pizza', 'description': 'Loaded with spicy pepperoni and extra cheese', 'isVeg': false, 'isAvailable': true, 'orderCount': 389},
    {'id': '5', 'name': 'Coca Cola', 'price': 59.0, 'image': 'https://images.unsplash.com/photo-1554866585-cd94860890b7?w=300', 'category': 'Drinks', 'description': 'Chilled 330ml can', 'isVeg': true, 'isAvailable': true, 'orderCount': 890},
    {'id': '6', 'name': 'Chicken Wings (6pc)', 'price': 249.0, 'image': 'https://images.unsplash.com/photo-1608039829572-9b0189250bcc?w=300', 'category': 'Burgers', 'description': 'Crispy fried wings with hot sauce', 'isVeg': false, 'isAvailable': false, 'orderCount': 234},
    {'id': '7', 'name': 'Caesar Salad', 'price': 189.0, 'image': 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=300', 'category': 'Pizza', 'description': 'Fresh romaine with parmesan and croutons', 'isVeg': true, 'isAvailable': true, 'orderCount': 156},
    {'id': '8', 'name': 'Fresh Lime Soda', 'price': 79.0, 'image': 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=300', 'category': 'Drinks', 'description': 'Refreshing lime with soda and mint', 'isVeg': true, 'isAvailable': true, 'orderCount': 567},
    {'id': '9', 'name': 'Double Decker Burger', 'price': 329.0, 'image': 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=300', 'category': 'Burgers', 'description': 'Two patties, double cheese, and all the toppings', 'isVeg': false, 'isAvailable': true, 'orderCount': 445},
    {'id': '10', 'name': 'Mango Smoothie', 'price': 129.0, 'image': 'https://images.unsplash.com/photo-1546173159-315724a31696?w=300', 'category': 'Drinks', 'description': 'Fresh mango blended with yogurt and ice', 'isVeg': true, 'isAvailable': true, 'orderCount': 321},
  ];

  // ─── CATEGORIES ─────────────────────────────────────────
  static final List<Map<String, dynamic>> categories = [
    {'name': 'Food', 'icon': '🍔', 'color': 0xFFFF6B35},
    {'name': 'Grocery', 'icon': '🛒', 'color': 0xFF2ECC71},
    {'name': 'Pharmacy', 'icon': '💊', 'color': 0xFF3498DB},
    {'name': 'Flowers', 'icon': '💐', 'color': 0xFFE91E63},
    {'name': 'Pet Care', 'icon': '🐾', 'color': 0xFF9B59B6},
    {'name': 'Electronics', 'icon': '📱', 'color': 0xFF1ABC9C},
  ];

  // ─── SEARCH RESULTS ─────────────────────────────────────
  static final List<Map<String, dynamic>> searchResults = [
    {'name': 'Chicken Biryani', 'store': 'Spice Garden', 'price': 249.0, 'rating': 4.5, 'image': 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=300'},
    {'name': 'Paneer Tikka', 'store': 'Punjab Grill', 'price': 199.0, 'rating': 4.3, 'image': 'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=300'},
    {'name': 'Masala Dosa', 'store': 'South Express', 'price': 129.0, 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1630383249896-424e482df921?w=300'},
    {'name': 'Butter Naan', 'store': 'Tandoor House', 'price': 49.0, 'rating': 4.1, 'image': 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=300'},
    {'name': 'Chocolate Cake', 'store': 'Sweet Delights', 'price': 399.0, 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=300'},
    {'name': 'Veg Fried Rice', 'store': 'Wok Express', 'price': 179.0, 'rating': 4.2, 'image': 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=300'},
    {'name': 'Mango Lassi', 'store': 'Lassi Corner', 'price': 89.0, 'rating': 4.4, 'image': 'https://images.unsplash.com/photo-1527585743534-7113e3211270?w=300'},
    {'name': 'Garlic Bread', 'store': 'Pizza Paradise', 'price': 149.0, 'rating': 4.0, 'image': 'https://images.unsplash.com/photo-1619531040576-f9416740661b?w=300'},
    {'name': 'Pav Bhaji', 'store': 'Mumbai Street', 'price': 159.0, 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1626132647523-66f5bf380027?w=300'},
    {'name': 'Ice Cream Sundae', 'store': 'Frozen Fantasy', 'price': 199.0, 'rating': 4.5, 'image': 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=300'},
  ];

  // ─── ADDRESSES ──────────────────────────────────────────
  static final List<Map<String, dynamic>> addresses = [
    {
      'id': '1',
      'label': 'Home',
      'address': '42, Rose Garden Apartments, MG Road, Kozhikode, Kerala 673001',
      'icon': 'home',
    },
    {
      'id': '2',
      'label': 'Office',
      'address': 'Floor 3, Cyber Tower, Palazhi Road, Kozhikode, Kerala 673004',
      'icon': 'work',
    },
  ];

  // ─── ORDERS ─────────────────────────────────────────────
  static final List<Map<String, dynamic>> orders = [
    {
      'id': 'ORD-2026-001',
      'store': 'Burger Kingdom',
      'items': ['Classic Cheeseburger x2', 'Coca Cola x1'],
      'total': 457.0,
      'status': 'Delivered',
      'date': '2026-02-20',
      'time': '7:30 PM',
      'customerName': 'Rahul Sharma',
      'merchantName': 'Burger Kingdom',
      'riderName': 'Arjun K',
      'paymentMethod': 'UPI',
    },
    {
      'id': 'ORD-2026-002',
      'store': 'Pizza Paradise',
      'items': ['Margherita Pizza x1', 'Pepperoni Pizza x1', 'Coca Cola x2'],
      'total': 766.0,
      'status': 'In Progress',
      'date': '2026-02-21',
      'time': '12:15 PM',
      'customerName': 'Priya Nair',
      'merchantName': 'Pizza Paradise',
      'riderName': 'Deepak M',
      'paymentMethod': 'Card',
    },
    {
      'id': 'ORD-2026-003',
      'store': 'Green Basket Grocery',
      'items': ['Milk 1L x2', 'Bread x1', 'Eggs (12) x1'],
      'total': 285.0,
      'status': 'Delivered',
      'date': '2026-02-19',
      'time': '9:00 AM',
      'customerName': 'Anil Kumar',
      'merchantName': 'Green Basket Grocery',
      'riderName': 'Suresh P',
      'paymentMethod': 'COD',
    },
    {
      'id': 'ORD-2026-004',
      'store': 'Sushi Sensation',
      'items': ['Salmon Roll x2', 'Miso Soup x1'],
      'total': 649.0,
      'status': 'Cancelled',
      'date': '2026-02-18',
      'time': '8:00 PM',
      'customerName': 'Meera R',
      'merchantName': 'Sushi Sensation',
      'riderName': 'Vijay S',
      'paymentMethod': 'UPI',
    },
    {
      'id': 'ORD-2026-005',
      'store': 'MediCare Pharmacy',
      'items': ['Paracetamol x1', 'Vitamin C x1', 'Band-Aid x2'],
      'total': 320.0,
      'status': 'Delivered',
      'date': '2026-02-17',
      'time': '3:45 PM',
      'customerName': 'Rajesh T',
      'merchantName': 'MediCare Pharmacy',
      'riderName': 'Arjun K',
      'paymentMethod': 'Card',
    },
  ];

  // ─── RIDER DATA ─────────────────────────────────────────
  static final Map<String, dynamic> riderProfile = {
    'name': 'Arjun Kumar',
    'phone': '+91 98765 43210',
    'email': 'arjun.rider@email.com',
    'rating': 4.7,
    'totalDeliveries': 1532,
    'joinedDate': 'March 2024',
    'vehicleType': 'Bike',
    'vehicleNumber': 'KL-11-AB-1234',
    'licenseStatus': 'Verified',
    'rcStatus': 'Pending',
    'bankAccount': '****4521',
    'ifsc': 'ICIC****890',
  };

  static final List<Map<String, dynamic>> riderDeliveryHistory = [
    {'id': 'DEL-001', 'customer': 'Rahul S.', 'address': 'MG Road, Kozhikode', 'amount': 45.0, 'tip': 10.0, 'date': '2026-02-21', 'time': '1:30 PM'},
    {'id': 'DEL-002', 'customer': 'Priya N.', 'address': 'Palazhi, Kozhikode', 'amount': 55.0, 'tip': 20.0, 'date': '2026-02-21', 'time': '12:45 PM'},
    {'id': 'DEL-003', 'customer': 'Anil K.', 'address': 'Beach Road, Kozhikode', 'amount': 40.0, 'tip': 0.0, 'date': '2026-02-20', 'time': '7:00 PM'},
    {'id': 'DEL-004', 'customer': 'Meera R.', 'address': 'Mavoor Road, Kozhikode', 'amount': 50.0, 'tip': 15.0, 'date': '2026-02-20', 'time': '6:15 PM'},
    {'id': 'DEL-005', 'customer': 'Suresh M.', 'address': 'Thondayad, Kozhikode', 'amount': 35.0, 'tip': 5.0, 'date': '2026-02-20', 'time': '2:30 PM'},
    {'id': 'DEL-006', 'customer': 'Ajay P.', 'address': 'Civil Station, Kozhikode', 'amount': 60.0, 'tip': 25.0, 'date': '2026-02-19', 'time': '8:00 PM'},
  ];

  static final List<double> weeklyEarnings = [320, 450, 380, 520, 410, 600, 490];

  // ─── MERCHANT DATA ──────────────────────────────────────
  static final Map<String, dynamic> merchantProfile = {
    'storeName': 'Burger Kingdom',
    'ownerName': 'Vikram Menon',
    'phone': '+91 98765 12345',
    'email': 'vikram@burgerkingdom.com',
    'address': 'Shop 12, City Mall, MG Road, Kozhikode',
    'rating': 4.5,
    'totalOrders': 8450,
    'joinedDate': 'January 2024',
  };

  static final List<Map<String, dynamic>> merchantOrders = [
    {'id': 'ORD-101', 'items': ['Classic Burger x2', 'Fries x1'], 'total': 447.0, 'status': 'New', 'time': '2 min ago', 'customerName': 'Rahul S.'},
    {'id': 'ORD-102', 'items': ['Veggie Burger x1', 'Cola x2'], 'total': 297.0, 'status': 'New', 'time': '5 min ago', 'customerName': 'Priya N.'},
    {'id': 'ORD-103', 'items': ['Double Decker x1', 'Wings x1'], 'total': 578.0, 'status': 'Preparing', 'time': '12 min ago', 'customerName': 'Anil K.'},
    {'id': 'ORD-104', 'items': ['Chicken Burger x3'], 'total': 597.0, 'status': 'Preparing', 'time': '18 min ago', 'customerName': 'Meera R.'},
    {'id': 'ORD-105', 'items': ['Classic Burger x1', 'Shake x1'], 'total': 328.0, 'status': 'Ready', 'time': '25 min ago', 'customerName': 'Suresh M.'},
    {'id': 'ORD-106', 'items': ['Veggie Wrap x2'], 'total': 358.0, 'status': 'Ready', 'time': '30 min ago', 'customerName': 'Ajay P.'},
  ];

  // ─── ADMIN DATA ─────────────────────────────────────────
  static final Map<String, dynamic> adminStats = {
    'totalOrdersToday': 1247,
    'totalRevenue': 287650.0,
    'activeRiders': 89,
    'activeMerchants': 156,
    'totalCustomers': 45200,
    'totalRiders': 320,
    'totalMerchants': 450,
  };

  static final List<Map<String, dynamic>> adminUsers = [
    {'id': 'U001', 'name': 'Rahul Sharma', 'email': 'rahul@email.com', 'role': 'Customer', 'status': 'Active', 'orders': 45, 'joinedDate': '2024-06-15'},
    {'id': 'U002', 'name': 'Priya Nair', 'email': 'priya@email.com', 'role': 'Customer', 'status': 'Active', 'orders': 78, 'joinedDate': '2024-03-20'},
    {'id': 'U003', 'name': 'Anil Kumar', 'email': 'anil@email.com', 'role': 'Customer', 'status': 'Suspended', 'orders': 12, 'joinedDate': '2025-01-10'},
    {'id': 'U004', 'name': 'Arjun K', 'email': 'arjun@rider.com', 'role': 'Rider', 'status': 'Active', 'deliveries': 1532, 'rating': 4.7, 'joinedDate': '2024-03-01'},
    {'id': 'U005', 'name': 'Deepak M', 'email': 'deepak@rider.com', 'role': 'Rider', 'status': 'Active', 'deliveries': 987, 'rating': 4.5, 'joinedDate': '2024-07-15'},
    {'id': 'U006', 'name': 'Suresh P', 'email': 'suresh@rider.com', 'role': 'Rider', 'status': 'Suspended', 'deliveries': 234, 'rating': 3.8, 'joinedDate': '2025-02-01'},
    {'id': 'U007', 'name': 'Vikram Menon', 'email': 'vikram@merchant.com', 'role': 'Merchant', 'status': 'Active', 'storeName': 'Burger Kingdom', 'orders': 8450, 'joinedDate': '2024-01-15'},
    {'id': 'U008', 'name': 'Sarah Khan', 'email': 'sarah@merchant.com', 'role': 'Merchant', 'status': 'Active', 'storeName': 'Pizza Paradise', 'orders': 6230, 'joinedDate': '2024-02-20'},
    {'id': 'U009', 'name': 'Ravi Pillai', 'email': 'ravi@merchant.com', 'role': 'Merchant', 'status': 'Suspended', 'storeName': 'Green Basket', 'orders': 3120, 'joinedDate': '2024-05-10'},
  ];

  static final List<Map<String, dynamic>> zones = [
    {'id': 'Z001', 'name': 'Kozhikode Central', 'city': 'Kozhikode', 'radius': 5.0, 'baseFee': 30.0, 'active': true},
    {'id': 'Z002', 'name': 'Kozhikode East', 'city': 'Kozhikode', 'radius': 8.0, 'baseFee': 45.0, 'active': true},
    {'id': 'Z003', 'name': 'Kozhikode Beach', 'city': 'Kozhikode', 'radius': 4.0, 'baseFee': 25.0, 'active': true},
    {'id': 'Z004', 'name': 'Calicut University Area', 'city': 'Kozhikode', 'radius': 6.0, 'baseFee': 35.0, 'active': false},
    {'id': 'Z005', 'name': 'Ramanattukara', 'city': 'Kozhikode', 'radius': 7.0, 'baseFee': 40.0, 'active': true},
  ];

  static final List<Map<String, dynamic>> payouts = [
    {'id': 'P001', 'name': 'Arjun K', 'type': 'Rider', 'amount': 12500.0, 'status': 'Processed', 'date': '2026-02-20'},
    {'id': 'P002', 'name': 'Deepak M', 'type': 'Rider', 'amount': 9800.0, 'status': 'Pending', 'date': '2026-02-21'},
    {'id': 'P003', 'name': 'Suresh P', 'type': 'Rider', 'amount': 4500.0, 'status': 'Pending', 'date': '2026-02-21'},
    {'id': 'P004', 'name': 'Burger Kingdom', 'type': 'Merchant', 'amount': 45600.0, 'status': 'Processed', 'date': '2026-02-20'},
    {'id': 'P005', 'name': 'Pizza Paradise', 'type': 'Merchant', 'amount': 38900.0, 'status': 'Pending', 'date': '2026-02-21'},
    {'id': 'P006', 'name': 'Green Basket', 'type': 'Merchant', 'amount': 22100.0, 'status': 'Processed', 'date': '2026-02-19'},
  ];

  static final List<Map<String, dynamic>> promoCodes = [
    {'id': 'PR001', 'code': 'WELCOME50', 'discount': 50, 'type': 'Percentage', 'maxDiscount': 100.0, 'minOrder': 200.0, 'expiry': '2026-03-31', 'usageCount': 1245, 'active': true},
    {'id': 'PR002', 'code': 'FLAT100', 'discount': 100, 'type': 'Flat', 'maxDiscount': 100.0, 'minOrder': 500.0, 'expiry': '2026-04-15', 'usageCount': 890, 'active': true},
    {'id': 'PR003', 'code': 'FREEDEL', 'discount': 0, 'type': 'Free Delivery', 'maxDiscount': 50.0, 'minOrder': 150.0, 'expiry': '2026-02-28', 'usageCount': 2340, 'active': true},
    {'id': 'PR004', 'code': 'SUMMER25', 'discount': 25, 'type': 'Percentage', 'maxDiscount': 200.0, 'minOrder': 300.0, 'expiry': '2026-05-31', 'usageCount': 567, 'active': false},
    {'id': 'PR005', 'code': 'NEWUSER', 'discount': 30, 'type': 'Percentage', 'maxDiscount': 150.0, 'minOrder': 0.0, 'expiry': '2026-12-31', 'usageCount': 4521, 'active': true},
  ];

  static final List<Map<String, dynamic>> supportTickets = [
    {'id': 'TKT-001', 'user': 'Rahul Sharma', 'role': 'Customer', 'issue': 'Order not delivered on time', 'priority': 'High', 'status': 'Open', 'date': '2026-02-21', 'messages': [
      {'sender': 'Rahul Sharma', 'message': 'My order ORD-2026-001 was supposed to be delivered by 7 PM but it arrived at 7:45 PM. The food was cold.', 'time': '7:50 PM'},
      {'sender': 'Support Agent', 'message': 'We apologize for the delay. We have issued a credit of ₹50 to your wallet.', 'time': '8:05 PM'},
      {'sender': 'Rahul Sharma', 'message': 'Thank you, but I think the compensation should be more given the food quality was affected.', 'time': '8:10 PM'},
    ]},
    {'id': 'TKT-002', 'user': 'Arjun K', 'role': 'Rider', 'issue': 'Payment not received for last week', 'priority': 'High', 'status': 'In Progress', 'date': '2026-02-20', 'messages': [
      {'sender': 'Arjun K', 'message': 'I haven\'t received my payout for the week of Feb 10-16. Please check.', 'time': '10:00 AM'},
      {'sender': 'Support Agent', 'message': 'We are looking into this. Your payout is being processed and should reflect within 48 hours.', 'time': '11:30 AM'},
    ]},
    {'id': 'TKT-003', 'user': 'Vikram Menon', 'role': 'Merchant', 'issue': 'Menu items not updating', 'priority': 'Medium', 'status': 'Open', 'date': '2026-02-21', 'messages': [
      {'sender': 'Vikram Menon', 'message': 'I tried updating prices for 3 items but the changes are not reflecting in the app.', 'time': '2:00 PM'},
    ]},
    {'id': 'TKT-004', 'user': 'Priya Nair', 'role': 'Customer', 'issue': 'Wrong items delivered', 'priority': 'Medium', 'status': 'Resolved', 'date': '2026-02-19', 'messages': [
      {'sender': 'Priya Nair', 'message': 'I ordered Paneer Tikka but received Chicken Tikka. I am vegetarian!', 'time': '1:00 PM'},
      {'sender': 'Support Agent', 'message': 'We sincerely apologize. A full refund has been processed and an additional ₹100 credit has been added.', 'time': '1:20 PM'},
    ]},
    {'id': 'TKT-005', 'user': 'Deepak M', 'role': 'Rider', 'issue': 'App GPS not working properly', 'priority': 'Low', 'status': 'Open', 'date': '2026-02-21', 'messages': [
      {'sender': 'Deepak M', 'message': 'The GPS keeps showing wrong location. Makes it difficult to navigate to customer address.', 'time': '4:00 PM'},
    ]},
  ];

  // ─── CHART DATA ─────────────────────────────────────────
  static final List<double> revenueLastWeek = [18500, 22300, 19800, 25600, 21400, 28700, 24500];
  static final List<double> revenueLast30Days = [
    15000, 18000, 17500, 22000, 19500, 21000, 25000,
    23000, 20000, 24000, 26000, 22500, 28000, 27000,
    24500, 29000, 31000, 26500, 30000, 28500, 32000,
    27500, 33000, 29500, 35000, 31500, 34000, 30500,
    36000, 33500,
  ];
  static final List<double> ordersPerDayOfWeek = [145, 178, 156, 189, 234, 312, 287];
  static final List<double> userGrowth = [
    1200, 1350, 1500, 1680, 1820, 2100, 2350,
    2600, 2850, 3100, 3400, 3700, 4050, 4300,
    4600, 4900, 5200, 5500, 5800, 6100, 6500,
    6900, 7200, 7600, 8000, 8400, 8800, 9200,
    9600, 10000,
  ];
  static final List<Map<String, dynamic>> categoryWiseSales = [
    {'category': 'Burgers', 'value': 35.0, 'color': 0xFFFF6B35},
    {'category': 'Pizza', 'value': 28.0, 'color': 0xFFE74C3C},
    {'category': 'Drinks', 'value': 20.0, 'color': 0xFF3498DB},
    {'category': 'Sides', 'value': 12.0, 'color': 0xFF2ECC71},
    {'category': 'Desserts', 'value': 5.0, 'color': 0xFF9B59B6},
  ];

  static final List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
}
