<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.example.passport_issuing.dao.Database" %>
<%@ page import="java.sql.*" %>
<%
String action = request.getParameter("action");
String transactionIdStr = request.getParameter("transactionId");
String notes = request.getParameter("notes");

if (action != null && transactionIdStr != null) {
    int transactionId = Integer.parseInt(transactionIdStr);
    
    try (Connection conn = Database.getConnection()) {
        conn.setAutoCommit(false);
        
        try {
            if ("approve".equals(action)) {
                // Update transaction to VERIFIED (staff approved)
                String sql1 = "UPDATE payment_transactions SET transaction_status = 'verified' WHERE transaction_id = ?";
                PreparedStatement stmt1 = conn.prepareStatement(sql1);
                stmt1.setInt(1, transactionId);
                stmt1.executeUpdate();
                stmt1.close();
                
                // Get application_id and update application payment_status
                String sql2 = "SELECT application_id FROM payment_transactions WHERE transaction_id = ?";
                PreparedStatement stmt2 = conn.prepareStatement(sql2);
                stmt2.setInt(1, transactionId);
                ResultSet rs = stmt2.executeQuery();
                if (rs.next()) {
                    int appId = rs.getInt("application_id");
                    String sql3 = "UPDATE applications SET payment_status = 'paid' WHERE application_id = ?";
                    PreparedStatement stmt3 = conn.prepareStatement(sql3);
                    stmt3.setInt(1, appId);
                    stmt3.executeUpdate();
                    stmt3.close();
                }
                rs.close();
                stmt2.close();
                
                conn.commit();
                response.sendRedirect("payment-approval.jsp?msg=verified");
                
            } else if ("reject".equals(action)) {
                // Update transaction to REJECTED (staff rejected)
                String sql = "UPDATE payment_transactions SET transaction_status = 'rejected' WHERE transaction_id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, transactionId);
                stmt.executeUpdate();
                stmt.close();
                
                conn.commit();
                response.sendRedirect("payment-approval.jsp?msg=rejected");
            }
        } catch (SQLException e) {
            conn.rollback();
            throw e;
        } finally {
            conn.setAutoCommit(true);
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("payment-approval.jsp?msg=error");
    }
} else {
    response.sendRedirect("payment-approval.jsp");
}
%>

