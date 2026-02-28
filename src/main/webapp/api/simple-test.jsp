<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

try {
    String test = request.getParameter("test");
    String nicNumber = request.getParameter("nicNumber");
    
    out.println("{");
    out.println("\"success\": true,");
    out.println("\"message\": \"Payment JSP is working!\",");
    out.println("\"timestamp\": \"" + java.time.LocalDateTime.now().toString() + "\",");
    out.println("\"test\": \"" + (test != null ? test : "null") + "\",");
    out.println("\"nicNumber\": \"" + (nicNumber != null ? nicNumber : "null") + "\"");
    out.println("}");
    
} catch (Exception e) {
    out.println("{");
    out.println("\"success\": false,");
    out.println("\"message\": \"Error: " + e.getMessage().replace("\"", "\\\"") + "\",");
    out.println("\"errorDetails\": \"" + e.getClass().getSimpleName() + ": " + e.getMessage().replace("\"", "\\\"") + "\"");
    out.println("}");
    e.printStackTrace();
}
%>
