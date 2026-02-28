# Helpdesk Management System

## Overview
The Helpdesk Management System allows staff members with helpdesk privileges to manage FAQ content for the Lanka Epassport Service website. Only staff with the `helpdesk` section can access the management interface.

## Features

### Staff Helpdesk Management (`staff-helpdesk.jsp`)
- **Authentication Required**: Only staff with `helpdesk` section can access
- **FAQ Management**: Add, edit, delete, and toggle FAQ status
- **Category Management**: Organize FAQs by categories (application, documents, payment, processing, technical)
- **Search & Filter**: Find FAQs by content or category
- **Statistics Dashboard**: View total FAQs, active FAQs, categories count, and recent updates
- **Real-time Updates**: Changes are immediately reflected on the public helpdesk page

### Public Helpdesk (`helpdesk.jsp`)
- **Dynamic Content**: FAQs are loaded from the database
- **Interactive Interface**: Expandable FAQ items with smooth animations
- **Search Functionality**: Search through questions and answers
- **Category Filtering**: Filter FAQs by category
- **Responsive Design**: Works on all devices

## Database Schema

### `helpdesk_faq` Table
```sql
CREATE TABLE helpdesk_faq (
    faq_id INT AUTO_INCREMENT PRIMARY KEY,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    category VARCHAR(50) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_by VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES staff_credentials(username)
);
```

### Staff Credentials
- **Username**: `staff_helpdesk`
- **Password**: `555`
- **Section**: `helpdesk`

## API Endpoints

### HelpdeskServlet
- `GET /HelpdeskServlet?action=getFaqs` - Get all FAQs for management
- `POST /HelpdeskServlet` - Manage FAQs (add, update, toggle status, delete)

### PublicFaqServlet
- `GET /PublicFaqServlet` - Get active FAQs for public display

## Usage Instructions

### For Staff (Helpdesk Management)
1. Go to `staff-login.jsp`
2. Select "Help Desk" section
3. Login with credentials: `staff_helpdesk` / `555`
4. You'll be redirected to `staff-helpdesk.jsp`
5. Use the interface to:
   - Add new FAQs with questions, answers, and categories
   - Edit existing FAQs
   - Toggle FAQ status (active/inactive)
   - Delete FAQs
   - Search and filter FAQs

### For Public Users
1. Visit `helpdesk.jsp`
2. Browse FAQs by category or search
3. Click on questions to expand answers
4. Use live chat for additional support

## Categories
- **Application Process**: General application procedures
- **Documents**: Document requirements and uploads
- **Payment & Fees**: Payment methods and pricing
- **Processing Times**: Timeline information
- **Technical Support**: Technical issues and troubleshooting

## Security Features
- Staff authentication required for management access
- Session-based authentication with timeout
- Input validation and sanitization
- SQL injection prevention with prepared statements
- XSS protection with HTML escaping

## File Structure
```
src/main/webapp/
├── helpdesk.jsp              # Public FAQ page
├── staff-helpdesk.jsp        # Staff management interface
└── staff-login.jsp           # Staff login page

src/main/java/com/example/passport_issuing/controller/
├── HelpdeskServlet.java      # FAQ management API
├── PublicFaqServlet.java     # Public FAQ API
└── StaffLoginServlet.java    # Staff authentication

src/main/resources/
└── init.sql                  # Database schema and sample data
```

## Sample FAQ Data
The system comes with pre-loaded sample FAQs covering common passport application topics including:
- Application process steps
- Document requirements
- Payment information
- Processing times
- Technical support

## Future Enhancements
- FAQ analytics and usage statistics
- Multi-language support
- FAQ templates
- Automated FAQ suggestions based on common queries
- Integration with ticketing system
