package com.example.passport_issuing.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Central JDBC helper used by servlets to obtain DB connections.
 * Defaults to MySQL database "lanka_epassport_system" on localhost:3306.
 * You can override URL/user/password with environment variables DB_URL/DB_USER/DB_PASSWORD
 * or with JVM system properties db.url/db.user/db.password.
 */
public final class Database {
    private static final String ENV_URL = "jdbc:mysql://localhost:3306/lanka_epassport_system";
    private static final String ENV_USER = "root";
    private static final String ENV_PASSWORD = "12345";

    private static volatile boolean driverLoaded = false;

    private Database() {}

    private static void loadDriverIfNeeded() throws SQLException {
        if (driverLoaded) return;
        synchronized (Database.class) {
            if (driverLoaded) return;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                driverLoaded = true;
                System.out.println("[Database] MySQL JDBC Driver loaded successfully");
            } catch (ClassNotFoundException e) {
                throw new SQLException("MySQL JDBC Driver not found on classpath. Ensure mysql-connector-java is on the WAR classpath.", e);
            }
        }
    }

    private static String getEnvOrProperty(String envKey, String propKey, String defaultValue) {
        String v = System.getenv(envKey);
        if (v != null && !v.isBlank()) return v;
        v = System.getProperty(propKey);
        if (v != null && !v.isBlank()) return v;
        return defaultValue;
    }

    /**
     * Gets a database connection with improved error handling and connection properties.
     * 
     * @return A database connection
     * @throws SQLException If connection fails, with detailed error message
     */
    public static Connection getConnection() throws SQLException {
        loadDriverIfNeeded();

        String url = getEnvOrProperty("DB_URL", "db.url", ENV_URL);
        String user = getEnvOrProperty("DB_USER", "db.user", ENV_USER);
        String password = getEnvOrProperty("DB_PASSWORD", "db.password", ENV_PASSWORD);

        // Log connection attempt (without password)
        System.out.println("[Database] Attempting connection to: " + url.replaceAll(":[^:@]+@", ":****@"));
        System.out.println("[Database] User: " + user);

        Properties props = new Properties();
        props.setProperty("user", user);
        props.setProperty("password", password);
        
        // SSL and security settings
        props.setProperty("useSSL", "false");
        props.setProperty("allowPublicKeyRetrieval", "true");
        
        // Timezone and encoding
        props.setProperty("serverTimezone", "UTC");
        props.setProperty("characterEncoding", "UTF-8");
        props.setProperty("useUnicode", "true");
        
        // Connection timeout settings (in milliseconds)
        props.setProperty("connectTimeout", "5000");  // 5 seconds to establish connection
        props.setProperty("socketTimeout", "60000");   // 60 seconds for socket operations
        
        // Connection reliability
        props.setProperty("autoReconnect", "true");
        props.setProperty("failOverReadOnly", "false");
        
        // Additional reliability settings
        props.setProperty("maxReconnects", "3");
        props.setProperty("initialTimeout", "2");

        try {
            Connection conn = DriverManager.getConnection(url, props);
            System.out.println("[Database] Connection established successfully");
            return conn;
        } catch (SQLException e) {
            // Provide detailed error message based on error type
            String errorMessage = getDetailedErrorMessage(e, url);
            System.err.println("[Database] Connection failed: " + errorMessage);
            System.err.println("[Database] SQL State: " + e.getSQLState());
            System.err.println("[Database] Error Code: " + e.getErrorCode());
            
            // Create a new SQLException with enhanced message
            SQLException enhancedException = new SQLException(errorMessage, e.getSQLState(), e.getErrorCode());
            enhancedException.initCause(e);
            throw enhancedException;
        }
    }

    /**
     * Provides detailed error messages based on the SQLException type.
     */
    private static String getDetailedErrorMessage(SQLException e, String url) {
        String message = e.getMessage();
        
        if (message != null) {
            // Communications link failure - MySQL server not running or not accessible
            if (message.contains("Communications link failure") || 
                message.contains("The last packet sent successfully")) {
                return String.format(
                    "Cannot connect to MySQL server. " +
                    "Possible causes:\n" +
                    "1. MySQL server is not running. Start MySQL service.\n" +
                    "2. MySQL server is not accessible at %s\n" +
                    "3. Firewall is blocking port 3306\n" +
                    "4. MySQL server is not configured to accept connections\n\n" +
                    "To fix:\n" +
                    "- Windows: Open Services (services.msc) and start 'MySQL' service\n" +
                    "- Check if MySQL is running: netstat -an | findstr 3306\n" +
                    "- Verify connection URL: %s\n" +
                    "Original error: %s",
                    extractHostPort(url), url, message
                );
            }
            
            // Access denied - wrong credentials
            if (message.contains("Access denied") || message.contains("authentication")) {
                return String.format(
                    "Authentication failed. Check username and password.\n" +
                    "Connection URL: %s\n" +
                    "Original error: %s",
                    url, message
                );
            }
            
            // Unknown database
            if (message.contains("Unknown database") || message.contains("does not exist")) {
                return String.format(
                    "Database does not exist. Create the database first.\n" +
                    "Connection URL: %s\n" +
                    "Original error: %s",
                    url, message
                );
            }
            
            // Connection timeout
            if (message.contains("timeout") || message.contains("timed out")) {
                return String.format(
                    "Connection timeout. MySQL server may be slow or unreachable.\n" +
                    "Connection URL: %s\n" +
                    "Original error: %s",
                    url, message
                );
            }
        }
        
        // Generic error message
        return String.format("Database connection error: %s\nConnection URL: %s", 
                           message != null ? message : e.toString(), url);
    }

    /**
     * Extracts host:port from JDBC URL for display purposes.
     */
    private static String extractHostPort(String url) {
        try {
            // Format: jdbc:mysql://host:port/database
            int start = url.indexOf("://") + 3;
            int end = url.indexOf("/", start);
            if (end == -1) end = url.length();
            return url.substring(start, end);
        } catch (Exception e) {
            return "localhost:3306";
        }
    }

    /**
     * Simple health check to verify connectivity.
     */
    public static void assertConnection() throws SQLException {
        try (Connection c = getConnection()) {
            // ok
        }
    }
}