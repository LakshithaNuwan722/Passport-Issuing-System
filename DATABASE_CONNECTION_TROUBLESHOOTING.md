# Database Connection Troubleshooting Guide

## Overview

This guide helps you diagnose and fix "Communications link failure" and other database connection errors in the Passport Issuing System.

## Common Error Messages

### "Communications link failure"
**Meaning:** The application cannot establish a connection to the MySQL server.

**Common Causes:**
1. MySQL server is not running
2. MySQL server is not accessible on the configured host/port
3. Firewall is blocking the connection
4. MySQL server is not configured to accept connections
5. Network connectivity issues

### "Access denied for user"
**Meaning:** Authentication failed with the provided credentials.

**Common Causes:**
1. Incorrect username
2. Incorrect password
3. User doesn't have permission to access the database

### "Unknown database"
**Meaning:** The specified database does not exist.

**Common Causes:**
1. Database hasn't been created
2. Wrong database name in connection URL

## Quick Diagnostic Tool

The application includes a built-in diagnostic tool:

**URL:** `http://localhost:8080/Passport_Issuing_war_exploded/db-diagnostic.jsp`

This tool will:
- Test database connection
- Display connection parameters
- Show database information
- Provide troubleshooting steps based on the error

## Step-by-Step Troubleshooting

### Step 1: Check if MySQL Server is Running

#### Windows:
```powershell
# Check MySQL service status
Get-Service | Where-Object {$_.Name -like "*mysql*"}

# Or using net command
net start | findstr MySQL

# Start MySQL service (run as Administrator)
net start MySQL
```

#### Using Services Manager:
1. Press `Win + R`
2. Type `services.msc` and press Enter
3. Look for "MySQL" service
4. Right-click → Start (if stopped)

#### Command Line Test:
```bash
# Test MySQL connection
mysql -u root -p

# If this fails, MySQL is not running or not in PATH
```

### Step 2: Verify MySQL Port is Listening

#### Windows:
```powershell
# Check if port 3306 is listening
netstat -an | findstr 3306

# Should show: TCP    0.0.0.0:3306    LISTENING
```

#### If port is not listening:
- MySQL service may not be running
- MySQL may be configured to use a different port
- Check MySQL configuration file (`my.ini` or `my.cnf`)

### Step 3: Verify Database Exists

```sql
-- Connect to MySQL
mysql -u root -p

-- List all databases
SHOW DATABASES;

-- Check if lanka_epassport_system exists
-- If not, create it:
CREATE DATABASE IF NOT EXISTS lanka_epassport_system;
```

### Step 4: Verify Connection Parameters

The application uses these default connection parameters:

- **URL:** `jdbc:mysql://localhost:3306/lanka_epassport_system`
- **User:** `root`
- **Password:** `12345`
- **Port:** `3306`

**To override these parameters:**

#### Option 1: Environment Variables
Set these environment variables before starting the application:
```powershell
# Windows PowerShell
$env:DB_URL = "jdbc:mysql://localhost:3306/lanka_epassport_system"
$env:DB_USER = "root"
$env:DB_PASSWORD = "your_password"
```

#### Option 2: JVM System Properties
Add these to your Tomcat startup:
```bash
-Ddb.url=jdbc:mysql://localhost:3306/lanka_epassport_system
-Ddb.user=root
-Ddb.password=your_password
```

### Step 5: Test Connection Manually

#### Using MySQL Command Line:
```bash
mysql -h localhost -P 3306 -u root -p
```

#### Using MySQL Workbench:
1. Open MySQL Workbench
2. Create new connection:
   - Host: `localhost`
   - Port: `3306`
   - Username: `root`
   - Password: `12345` (or your password)
3. Test connection

### Step 6: Check Firewall Settings

#### Windows Firewall:
1. Open Windows Defender Firewall
2. Go to Advanced Settings
3. Check Inbound Rules
4. Ensure MySQL (port 3306) is allowed

#### Add Firewall Rule (PowerShell as Administrator):
```powershell
New-NetFirewallRule -DisplayName "MySQL" -Direction Inbound -LocalPort 3306 -Protocol TCP -Action Allow
```

### Step 7: Verify MySQL Configuration

#### Check MySQL Configuration File:

**Windows:** `C:\ProgramData\MySQL\MySQL Server X.X\my.ini`

Look for these settings:
```ini
[mysqld]
port=3306
bind-address=0.0.0.0  # or 127.0.0.1 for localhost only
```

**Important:** If `bind-address` is set to `127.0.0.1`, MySQL only accepts local connections.

### Step 8: Check MySQL Error Logs

#### Windows:
```
C:\ProgramData\MySQL\MySQL Server X.X\Data\*.err
```

Look for:
- Connection errors
- Authentication errors
- Port binding errors

## Connection Timeout Issues

If you experience connection timeouts:

1. **Increase timeout values** (already configured in Database.java):
   - `connectTimeout=5000` (5 seconds)
   - `socketTimeout=60000` (60 seconds)

2. **Check network latency**:
   ```powershell
   # Test connection speed
   Test-NetConnection -ComputerName localhost -Port 3306
   ```

3. **Check MySQL server load**:
   ```sql
   SHOW PROCESSLIST;
   ```

## Common Solutions

### Solution 1: MySQL Service Not Running
**Problem:** MySQL service is stopped.

**Fix:**
```powershell
# Start MySQL service
net start MySQL

# Or use Services Manager
services.msc → MySQL → Start
```

### Solution 2: Wrong Port
**Problem:** MySQL is running on a different port.

**Fix:**
1. Check MySQL configuration file for port setting
2. Update connection URL: `jdbc:mysql://localhost:PORT/lanka_epassport_system`

### Solution 3: Wrong Credentials
**Problem:** Username or password is incorrect.

**Fix:**
1. Test credentials manually:
   ```bash
   mysql -u root -p
   ```
2. Update connection parameters if needed

### Solution 4: Database Doesn't Exist
**Problem:** Database `lanka_epassport_system` doesn't exist.

**Fix:**
```sql
CREATE DATABASE lanka_epassport_system;
USE lanka_epassport_system;
-- Run init.sql to create tables
SOURCE path/to/init.sql;
```

### Solution 5: Firewall Blocking
**Problem:** Windows Firewall is blocking port 3306.

**Fix:**
1. Add firewall rule (see Step 6)
2. Or temporarily disable firewall to test

### Solution 6: MySQL Not Accepting Connections
**Problem:** MySQL is configured to only accept localhost connections.

**Fix:**
1. Edit MySQL configuration file
2. Set `bind-address=0.0.0.0` (or comment it out)
3. Restart MySQL service

## Advanced Diagnostics

### Enable MySQL Connection Logging

Edit MySQL configuration file:
```ini
[mysqld]
general_log=1
general_log_file=C:/mysql_logs/general.log
```

### Test Connection with JDBC

Create a simple test:
```java
import java.sql.Connection;
import java.sql.DriverManager;

public class TestConnection {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/lanka_epassport_system";
        String user = "root";
        String password = "12345";
        
        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("Connection successful!");
            conn.close();
        } catch (Exception e) {
            System.out.println("Connection failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
```

## Using the Diagnostic Tool

1. **Access the tool:**
   ```
   http://localhost:8080/Passport_Issuing_war_exploded/db-diagnostic.jsp
   ```

2. **Review the results:**
   - Connection status
   - Connection parameters
   - Error details (if connection failed)
   - Troubleshooting steps

3. **Follow the suggested steps** based on the error type

## Prevention

To prevent connection issues:

1. **Ensure MySQL service starts automatically:**
   ```powershell
   Set-Service MySQL -StartupType Automatic
   ```

2. **Monitor MySQL service:**
   - Set up service monitoring
   - Configure alerts for service failures

3. **Regular backups:**
   - Backup database regularly
   - Test restore procedures

4. **Document connection parameters:**
   - Keep track of connection settings
   - Document any custom configurations

## Getting Help

If you've tried all the above steps and still have issues:

1. **Check application logs:**
   - Tomcat logs: `[TOMCAT_HOME]/logs/catalina.out`
   - Application console output

2. **Check MySQL error logs:**
   - Location: `C:\ProgramData\MySQL\MySQL Server X.X\Data\*.err`

3. **Use diagnostic tool:**
   - Access `/db-diagnostic.jsp`
   - Review detailed error information

4. **Verify system requirements:**
   - Java version compatibility
   - MySQL version compatibility
   - Sufficient system resources

## Quick Reference

| Issue | Quick Check | Quick Fix |
|-------|-------------|-----------|
| MySQL not running | `net start \| findstr MySQL` | `net start MySQL` |
| Port not listening | `netstat -an \| findstr 3306` | Check MySQL service |
| Wrong credentials | `mysql -u root -p` | Update connection params |
| Database missing | `SHOW DATABASES;` | `CREATE DATABASE ...` |
| Firewall blocking | Check firewall rules | Add rule for port 3306 |

## Connection Parameters Reference

### Default Configuration
```properties
db.url=jdbc:mysql://localhost:3306/lanka_epassport_system
db.user=root
db.password=12345
```

### Connection Properties (Auto-configured)
```properties
connectTimeout=5000
socketTimeout=60000
useSSL=false
allowPublicKeyRetrieval=true
serverTimezone=UTC
autoReconnect=true
```

## Related Files

- **Database.java:** `src/main/java/com/example/passport_issuing/dao/Database.java`
- **Diagnostic Tool:** `src/main/webapp/db-diagnostic.jsp`
- **Database Schema:** `src/main/resources/init.sql`
- **Health Endpoint:** `/api/health`

---

**Last Updated:** 2025-01-22
**Version:** 1.0

