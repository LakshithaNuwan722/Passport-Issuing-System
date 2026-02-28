# Quick Fix: MySQL Connection Error

## Current Error
```
Could not create connection to database server. 
Attempted reconnect 3 times. Giving up.
Connection URL: jdbc:mysql://localhost:3306/lanka_epassport_system
```

## Problem
MySQL server is **not running** or **not accessible** on localhost:3306.

## Solution Steps

### Step 1: Check if MySQL is Installed

#### Option A: Check Services
1. Press `Win + R`
2. Type `services.msc` and press Enter
3. Look for services named:
   - `MySQL`
   - `MySQL80`
   - `MySQL57`
   - `MySQL Server`
   - Any service with "MySQL" in the name

#### Option B: Check via Command Line
```powershell
# Run in PowerShell (as Administrator)
Get-Service | Where-Object {$_.DisplayName -like "*mysql*"}
```

### Step 2: Start MySQL Service

#### If MySQL Service Exists:

**Method 1: Using Services Manager**
1. Open Services (`services.msc`)
2. Find MySQL service
3. Right-click → **Start**
4. Set Startup Type to **Automatic** (so it starts on boot)

**Method 2: Using Command Line (Run as Administrator)**
```powershell
# Start MySQL service
net start MySQL

# Or if service name is different:
net start MySQL80
# or
net start MySQL57
```

**Method 3: Using PowerShell (Run as Administrator)**
```powershell
# Find MySQL service name first
Get-Service | Where-Object {$_.DisplayName -like "*mysql*"}

# Then start it (replace MySQL80 with actual service name)
Start-Service MySQL80
```

### Step 3: Verify MySQL is Running

```powershell
# Check if port 3306 is listening
netstat -an | findstr 3306

# Should show: TCP    0.0.0.0:3306    LISTENING
```

### Step 4: Test MySQL Connection

```powershell
# Test connection (if MySQL is in PATH)
mysql -u root -p

# Or test with specific host
mysql -h localhost -P 3306 -u root -p
```

**If this works:** MySQL is running. Try your application again.

**If this fails:** Continue to Step 5.

### Step 5: If MySQL is NOT Installed

#### Install MySQL:

1. **Download MySQL:**
   - Go to: https://dev.mysql.com/downloads/installer/
   - Download "MySQL Installer for Windows"
   - Choose "Full" or "Developer Default" installation

2. **Install MySQL:**
   - Run the installer
   - Choose "Developer Default" or "Server only"
   - Set root password: `12345` (or update connection in Database.java)
   - Port: `3306` (default)
   - Complete installation

3. **Create Database:**
   ```sql
   -- After installation, open MySQL Command Line Client
   CREATE DATABASE IF NOT EXISTS lanka_epassport_system;
   ```

4. **Import Schema:**
   ```sql
   USE lanka_epassport_system;
   -- Then run the contents of src/main/resources/init.sql
   ```

### Step 6: Use Diagnostic Tool

After starting MySQL, test the connection:

1. **Start your Tomcat server**
2. **Open browser:**
   ```
   http://localhost:8080/Passport_Issuing_war_exploded/db-diagnostic.jsp
   ```
3. **Check connection status**

### Step 7: Alternative - Use Different Database

If you can't install MySQL, you can:

1. **Use XAMPP/WAMP** (includes MySQL):
   - Download XAMPP: https://www.apachefriends.org/
   - Install and start MySQL from XAMPP Control Panel
   - Default port: 3306

2. **Use Docker MySQL:**
   ```powershell
   docker run --name mysql-passport -e MYSQL_ROOT_PASSWORD=12345 -e MYSQL_DATABASE=lanka_epassport_system -p 3306:3306 -d mysql:8.0
   ```

## Quick Commands Reference

```powershell
# Check MySQL services
Get-Service | Where-Object {$_.DisplayName -like "*mysql*"}

# Start MySQL (replace MySQL80 with your service name)
net start MySQL80

# Check if port 3306 is listening
netstat -an | findstr 3306

# Test MySQL connection
mysql -u root -p

# Check MySQL error logs (if installed)
# Usually at: C:\ProgramData\MySQL\MySQL Server X.X\Data\*.err
```

## Common MySQL Service Names

- `MySQL`
- `MySQL80` (MySQL 8.0)
- `MySQL57` (MySQL 5.7)
- `MySQL Server`
- `MySQL Server 8.0`

## After Starting MySQL

1. **Wait 10-15 seconds** for MySQL to fully start
2. **Test connection** using diagnostic tool
3. **Restart your application** if needed
4. **Check application logs** for connection success

## Still Having Issues?

1. **Check MySQL error logs:**
   - Location: `C:\ProgramData\MySQL\MySQL Server X.X\Data\*.err`
   - Look for startup errors

2. **Verify MySQL configuration:**
   - Config file: `C:\ProgramData\MySQL\MySQL Server X.X\my.ini`
   - Check `port=3306`
   - Check `bind-address=0.0.0.0` or `127.0.0.1`

3. **Check firewall:**
   - Ensure port 3306 is not blocked
   - Windows Firewall → Allow MySQL through firewall

4. **Try different connection:**
   - Update `Database.java` to use different port if MySQL uses non-standard port

## Next Steps

Once MySQL is running:

1. ✅ Verify connection: `netstat -an | findstr 3306`
2. ✅ Test with diagnostic tool: `/db-diagnostic.jsp`
3. ✅ Create database if missing: `CREATE DATABASE lanka_epassport_system;`
4. ✅ Import schema: Run `src/main/resources/init.sql`
5. ✅ Restart your application

---

**Need more help?** See `DATABASE_CONNECTION_TROUBLESHOOTING.md` for detailed guide.


