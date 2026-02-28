<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.passport_issuing.dao.Database" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Database Connection Diagnostic Tool</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
            min-height: 100vh;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            overflow: hidden;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .header h1 {
            font-size: 2em;
            margin-bottom: 10px;
        }
        .content {
            padding: 30px;
        }
        .section {
            margin-bottom: 30px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }
        .section h2 {
            color: #333;
            margin-bottom: 15px;
            font-size: 1.5em;
        }
        .status {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: bold;
            margin: 10px 0;
        }
        .status.success {
            background: #28a745;
            color: white;
        }
        .status.error {
            background: #dc3545;
            color: white;
        }
        .status.warning {
            background: #ffc107;
            color: #333;
        }
        .info-box {
            background: white;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            border: 1px solid #dee2e6;
        }
        .info-box strong {
            color: #667eea;
        }
        .code-block {
            background: #2d2d2d;
            color: #f8f8f2;
            padding: 15px;
            border-radius: 5px;
            font-family: 'Courier New', monospace;
            overflow-x: auto;
            margin: 10px 0;
        }
        .troubleshooting {
            background: #fff3cd;
            border: 1px solid #ffc107;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
        }
        .troubleshooting h3 {
            color: #856404;
            margin-bottom: 10px;
        }
        .troubleshooting ul {
            margin-left: 20px;
            color: #856404;
        }
        .troubleshooting li {
            margin: 5px 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 15px 0;
            background: white;
        }
        table th, table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }
        table th {
            background: #667eea;
            color: white;
            font-weight: bold;
        }
        table tr:hover {
            background: #f8f9fa;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin: 10px 5px;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background: #5568d3;
        }
        .btn-secondary {
            background: #6c757d;
        }
        .btn-secondary:hover {
            background: #5a6268;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🔍 Database Connection Diagnostic Tool</h1>
            <p>Comprehensive database connectivity analysis</p>
        </div>
        
        <div class="content">
            <%
                Map<String, Object> diagnostics = new HashMap<>();
                String connectionStatus = "UNKNOWN";
                String errorMessage = null;
                SQLException sqlException = null;
                
                // Get connection parameters
                String dbUrl = System.getenv("DB_URL");
                if (dbUrl == null || dbUrl.isBlank()) {
                    dbUrl = System.getProperty("db.url", "jdbc:mysql://localhost:3306/lanka_epassport_system");
                }
                String dbUser = System.getenv("DB_USER");
                if (dbUser == null || dbUser.isBlank()) {
                    dbUser = System.getProperty("db.user", "root");
                }
                String dbPassword = System.getenv("DB_PASSWORD");
                if (dbPassword == null || dbPassword.isBlank()) {
                    dbPassword = System.getProperty("db.password", "12345");
                }
                
                diagnostics.put("url", dbUrl);
                diagnostics.put("user", dbUser);
                diagnostics.put("password", "****");
                
                // Test connection
                try {
                    Connection conn = Database.getConnection();
                    connectionStatus = "SUCCESS";
                    
                    // Get database metadata
                    DatabaseMetaData metaData = conn.getMetaData();
                    diagnostics.put("databaseProduct", metaData.getDatabaseProductName());
                    diagnostics.put("databaseVersion", metaData.getDatabaseProductVersion());
                    diagnostics.put("driverName", metaData.getDriverName());
                    diagnostics.put("driverVersion", metaData.getDriverVersion());
                    diagnostics.put("catalog", conn.getCatalog());
                    
                    // Check tables
                    List<String> tables = new ArrayList<>();
                    try (ResultSet rs = metaData.getTables(null, null, "%", new String[]{"TABLE"})) {
                        while (rs.next()) {
                            tables.add(rs.getString("TABLE_NAME"));
                        }
                    }
                    diagnostics.put("tables", tables);
                    diagnostics.put("tableCount", tables.size());
                    
                    // Test query
                    try (PreparedStatement stmt = conn.prepareStatement("SELECT 1")) {
                        try (ResultSet rs = stmt.executeQuery()) {
                            if (rs.next()) {
                                diagnostics.put("queryTest", "SUCCESS");
                            }
                        }
                    }
                    
                    conn.close();
                    
                } catch (SQLException e) {
                    connectionStatus = "FAILED";
                    sqlException = e;
                    errorMessage = e.getMessage();
                    diagnostics.put("sqlState", e.getSQLState());
                    diagnostics.put("errorCode", e.getErrorCode());
                    diagnostics.put("errorMessage", errorMessage);
                } catch (Exception e) {
                    connectionStatus = "FAILED";
                    errorMessage = e.getMessage();
                    diagnostics.put("exceptionType", e.getClass().getName());
                    diagnostics.put("errorMessage", errorMessage);
                }
            %>
            
            <!-- Connection Status -->
            <div class="section">
                <h2>Connection Status</h2>
                <% if ("SUCCESS".equals(connectionStatus)) { %>
                    <span class="status success">✓ CONNECTION SUCCESSFUL</span>
                    <p style="margin-top: 10px; color: #28a745;">Database connection is working correctly!</p>
                <% } else { %>
                    <span class="status error">✗ CONNECTION FAILED</span>
                    <p style="margin-top: 10px; color: #dc3545;">Unable to connect to the database.</p>
                <% } %>
            </div>
            
            <!-- Connection Parameters -->
            <div class="section">
                <h2>Connection Parameters</h2>
                <div class="info-box">
                    <strong>URL:</strong> <%= diagnostics.get("url") %><br>
                    <strong>User:</strong> <%= diagnostics.get("user") %><br>
                    <strong>Password:</strong> <%= diagnostics.get("password") %><br>
                </div>
            </div>
            
            <% if ("SUCCESS".equals(connectionStatus)) { %>
                <!-- Database Information -->
                <div class="section">
                    <h2>Database Information</h2>
                    <table>
                        <tr>
                            <th>Property</th>
                            <th>Value</th>
                        </tr>
                        <tr>
                            <td>Database Product</td>
                            <td><%= diagnostics.get("databaseProduct") %></td>
                        </tr>
                        <tr>
                            <td>Database Version</td>
                            <td><%= diagnostics.get("databaseVersion") %></td>
                        </tr>
                        <tr>
                            <td>Driver Name</td>
                            <td><%= diagnostics.get("driverName") %></td>
                        </tr>
                        <tr>
                            <td>Driver Version</td>
                            <td><%= diagnostics.get("driverVersion") %></td>
                        </tr>
                        <tr>
                            <td>Current Database</td>
                            <td><%= diagnostics.get("catalog") %></td>
                        </tr>
                        <tr>
                            <td>Total Tables</td>
                            <td><%= diagnostics.get("tableCount") %></td>
                        </tr>
                    </table>
                </div>
                
                <!-- Tables List -->
                <% if (diagnostics.get("tables") != null) { %>
                    <div class="section">
                        <h2>Database Tables</h2>
                        <div class="info-box">
                            <% 
                                List<String> tables = (List<String>) diagnostics.get("tables");
                                if (tables != null && !tables.isEmpty()) {
                                    for (String table : tables) {
                                        out.println("• " + table + "<br>");
                                    }
                                } else {
                                    out.println("No tables found in database.");
                                }
                            %>
                        </div>
                    </div>
                <% } %>
                
            <% } else { %>
                <!-- Error Details -->
                <div class="section">
                    <h2>Error Details</h2>
                    <div class="info-box">
                        <% if (diagnostics.get("sqlState") != null) { %>
                            <strong>SQL State:</strong> <%= diagnostics.get("sqlState") %><br>
                        <% } %>
                        <% if (diagnostics.get("errorCode") != null) { %>
                            <strong>Error Code:</strong> <%= diagnostics.get("errorCode") %><br>
                        <% } %>
                        <strong>Error Message:</strong><br>
                        <div class="code-block"><%= errorMessage != null ? errorMessage.replace("<", "&lt;").replace(">", "&gt;") : "Unknown error" %></div>
                    </div>
                </div>
                
                <!-- Troubleshooting Guide -->
                <div class="section">
                    <h2>Troubleshooting Guide</h2>
                    <div class="troubleshooting">
                        <h3>Common Solutions:</h3>
                        <ul>
                            <li><strong>MySQL Server Not Running:</strong>
                                <div class="code-block">
# Windows - Check MySQL service status
net start | findstr MySQL

# Start MySQL service (run as Administrator)
net start MySQL

# Or use Services Manager (services.msc)
# Look for "MySQL" service and start it
                                </div>
                            </li>
                            <li><strong>Check if MySQL is listening on port 3306:</strong>
                                <div class="code-block">
# Windows
netstat -an | findstr 3306

# Should show: TCP    0.0.0.0:3306    LISTENING
                                </div>
                            </li>
                            <li><strong>Verify MySQL Configuration:</strong>
                                <div class="code-block">
# Connect to MySQL using command line
mysql -u root -p

# Check if database exists
SHOW DATABASES;

# Create database if missing
CREATE DATABASE IF NOT EXISTS lanka_epassport_system;
                                </div>
                            </li>
                            <li><strong>Check Firewall:</strong>
                                <div class="code-block">
# Windows Firewall - Allow MySQL through firewall
# Control Panel → Windows Defender Firewall → Advanced Settings
# Add inbound rule for port 3306 (TCP)
                                </div>
                            </li>
                            <li><strong>Verify Connection Parameters:</strong>
                                <ul>
                                    <li>URL: <%= diagnostics.get("url") %></li>
                                    <li>User: <%= diagnostics.get("user") %></li>
                                    <li>Password: Check if password is correct</li>
                                </ul>
                            </li>
                            <li><strong>Test Connection Manually:</strong>
                                <div class="code-block">
# Using MySQL command line client
mysql -h localhost -P 3306 -u root -p

# Or using MySQL Workbench
# Create new connection with same parameters
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                
                <!-- Environment Variables -->
                <div class="section">
                    <h2>Environment Configuration</h2>
                    <div class="info-box">
                        <p><strong>Note:</strong> You can override connection parameters using environment variables:</p>
                        <div class="code-block">
DB_URL=jdbc:mysql://localhost:3306/lanka_epassport_system
DB_USER=root
DB_PASSWORD=your_password
                        </div>
                        <p style="margin-top: 10px;">Or using JVM system properties:</p>
                        <div class="code-block">
-Ddb.url=jdbc:mysql://localhost:3306/lanka_epassport_system
-Ddb.user=root
-Ddb.password=your_password
                        </div>
                    </div>
                </div>
            <% } %>
            
            <!-- Actions -->
            <div class="section">
                <h2>Actions</h2>
                <a href="db-diagnostic.jsp" class="btn">🔄 Refresh Diagnostics</a>
                <a href="index.jsp" class="btn btn-secondary">← Back to Home</a>
                <% if ("SUCCESS".equals(connectionStatus)) { %>
                    <a href="api/health" class="btn btn-secondary">View Health Endpoint</a>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>

