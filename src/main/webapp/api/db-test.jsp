<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.passport_issuing.dao.Database" %>
<%@ page import="java.sql.*" %>

<%
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

try {
    System.out.println("=== Database Test JSP called ===");
    
    // Test database connection
    try (Connection conn = Database.getConnection()) {
        out.println("{");
        out.println("\"success\": true,");
        out.println("\"message\": \"Database connection successful\",");
        out.println("\"databaseProduct\": \"" + conn.getMetaData().getDatabaseProductName() + "\",");
        out.println("\"databaseVersion\": \"" + conn.getMetaData().getDatabaseProductVersion() + "\"");
        out.println("}");
    }
    
} catch (Exception e) {
    out.println("{");
    out.println("\"success\": false,");
    out.println("\"message\": \"Database connection failed: " + e.getMessage().replace("\"", "\\\"") + "\",");
    out.println("\"errorDetails\": \"" + e.getClass().getSimpleName() + ": " + e.getMessage().replace("\"", "\\\"") + "\"");
    out.println("}");
    e.printStackTrace();
    System.err.println("Database Test JSP Error: " + e.getMessage());
}
%>
