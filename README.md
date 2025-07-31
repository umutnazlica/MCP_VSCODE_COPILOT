# 🧪 SQLcl MCP with using VS Code and CoPilot

> 💡 Steps to create SQLcl MCP environment with VS Code and CoPilot on Macos


## 🌟 Introduction

The Oracle SQLcl Model Context Protocol (MCP) Server transforms how you interact with the Oracle Database by enabling seamless communication with Artificial Intelligence (AI) applications.<br>
It enables you to perform operations, create reports, and run queries on Oracle Database using natural language through AI-powered interactions.<br>
This guide includes information related to how to run initialize and test SQLcl MCP feature with VSCode and Copliot on a MacBook. And to test capabilities of SQLcl MCP with some sample prompts.<br>

This guide includes information related how to:

- 📦 Download and install SQLcl for MAC.
- 📦 Download and install VS Code for MAC.
- 📦 Install SQL Developer extension in VS Code.
- 📦 Configure CoPilot Chat.
- ✅ Connect to database and test the functionality.

> Ideal for DBAs, developers, whom are exploring SQLcl MCP capabilities with VS Code and CoPilot.


## 🌟 Assumptions

- We need Oracle database connection (In my case Oracle Database 23ai Free image running on Podman on my Mac Notebook, You can use other Oracle Database options as well, like Autonomous Database).<br>
Instructions related to how to provision Oracle Database 23ai Free container image using Podman on Mac can be found: <br>
https://github.com/umutnazlica/Podman_Mac_DB23AI_APEX
- A working directory including a basic sql script to create a EMPLOYEE table and insert few sample records.<br>
In my case : /Users/umutnazlica/git/MCP/MCP_VSCODE_COPILOT/runsql.sql (included in github repository)<br>

## 🌟 Additional Resources

https://docs.oracle.com/en/database/oracle/sql-developer-command-line/25.2/sqcug/using-oracle-sqlcl-mcp-server.html<br>
https://connor-mcdonald.com/2025/07/14/first-dabblings-with-sqlcl-mcp-server/<br>
https://blogs.oracle.com/database/post/introducing-mcp-server-for-oracle-database<br>
https://www.thatjeffsmith.com/archive/2025/07/getting-started-with-our-mcp-server-for-oracle-database/<br>
https://youtu.be/hj6WoZVGUBg <br>
https://blogs.oracle.com/database/post/how-can-developers-and-dbas-benefit-from-mcp-server-for-oracle-database <br>


---

### ⚙️ Setup Instructions for SQLcl

- Download the latest version of Oracle SQLcl (version 25.2+ required for MCP) and Install. I use brew to install SQLcl. <br>
  If already installed please upgrade SQLcl to latest version, while creating the document latest version is 25.2.2)<br>

  ```bash
  brew install SQLcl
  ```
  SQLcl requires Java 11+. You can install the latest version with:<br>
  ```bash
  brew install --cask temurin
  ```
  ```bash
  export PATH=/opt/homebrew/Caskroom/SQLcl/25.2.2.199.0918/SQLcl/bin:"$PATH"
  ```
  If you prefer manual download of SQLcl downlod link: <br>
  https://www.oracle.com/database/sqldeveloper/technologies/SQLcl/download/ <br>
  please download, extract and copy SQLcl folder to your working directory, and modify export PATH command.<br>

  Check if this version of SQLcl supports MCP? <br>
  ```bash
  ./sql -mcp 
  ```
 > ---------- MCP SERVER STARTUP ----------<br>
 > MCP Server started successfully on Mon Jul 28 13:43:39 GMT+03:00 2025<br>
 > Press Ctrl+C to stop the server <br>
 > ----------------------------------------<br>

---

### ⚙️ Setup Instructions for VS Code and Copilot.

- Download and install VS Code : https://code.visualstudio.com/download <br>
  Extract the zip file and copy Visual Studio Code to Applications. <br>

- Start VS Code, Hover over the Copilot icon in the Status Bar and select Set up Copilot. Instructions:<br>
  https://code.visualstudio.com/docs/copilot/setup <br>
  https://code.visualstudio.com/docs/copilot/setup-simplified <br>

- Install latest version of SQL Developer Extension for VSCode:<br>
  https://marketplace.visualstudio.com/items?itemName=Oracle.sql-developer <br>

- Open a new terminal window on VS Code. (Terminal -> New Terminal)<br>
- Export path (modify to correct path which SQLcl located if necessary!), and run sqlcl
  ```bash
  export PATH=/opt/homebrew/Caskroom/SQLcl/25.2.2.199.0918/SQLcl/bin:"$PATH"
  ```
  ```bash
  sql /nolog
  ```
- Create a connection to your container database using sysdba privilages. We will use this connection to test some dba operations. <br>
  ```bash
  CONNECT -save oracledb_mcp_sys -savepwd sys/YourPasswordHere@//localhost:1521/FREE as sysdba;
  ```
  ```bash
  commit;
  ```
 >You should be able to see new connection from VS Code -> SQL Developer -> Connections <br>

#### 🌟 Now fun part starts, first we connect to database with dba priviliges and do some dba work.

- From VS Code, list the MCP servers to make sure you see SQLcl, and ensure that it is started and running.<br>
  From VS Code Menu, View -> Command Palette -> MCP:List Servers (verify sqlcl is running) <br>
- Set Copilot Chat to Agent mode and pick the model you want to use. (I use GPT-4.1)<br>
  <img width="1020" height="572" alt="Image" src="https://github.com/user-attachments/assets/d871cce9-11a8-4f9e-a4e0-001c37131e86" />
- From VS Code open CoPilot Chat and start interaction with chat by giving prompts. <br>
  ```bash
  connect to database oracledb_mcp_sys
  ```

  >You are now connected to the oracledb_mcp_sys database. The database is in READ WRITE mode and ready for administrative or development tasks. Let me know what you would like to do next!

  ```bash
    I have several request from you to complete: first please create me a pluggable database called hrpdb, put hrpdb read write mode, and save hrpdb state, create a new user HR with password YourPasswordHere in hrpdb, put HR user to db_developer_role, create a new tablespace HR_TS in hrpdb,make HR_TS as default tablespace for user HR, set quote unlimited to HR user for HR_TS 
  ```

  >Pluggable database hrpdb has been created, opened in read-write mode, and its state saved.<br>
  >Tablespace HR_TS has been created in hrpdb.<br>
  >User HR has been created with password YourPasswordHere, default tablespace HR_TS, and unlimited quota on HR_TS.<br>
  >The db_developer_role has been granted to user HR.

  ```bash
  sql /nolog
  ```
   ```bash
  CONNECT -save oracledb_mcp_hr -savepwd hr/YourPasswordHere@//localhost:1521/hrpdb;
  ```
  ```bash
  cm list
  ```
  >├── oracledb_mcp_hr<br>
  >└── oracledb_mcp_sys

 
#### 🌟 Then we disconnect and reconnect with developer priviliges and do some development work.

```bash
disconnect and connect to oracledb_mcp_hr
```
```bash
i want to create new objects in hrpdb in hr schema using script /Users/umutnazlica/git/MCP/MCP_VSCODE_COPILOT/runsql.sql
```

>The script runsql.sql has been executed in the hrpdb database under the HR schema. The EMPLOYEES table was created and populated with 5 rows. Let me know if you want to create more objects or need further actions!

```bash
please create me more comprehensive data model based on using existing EMPLOYEES table under HR schema
```
> A comprehensive HR data model has been created in the HR schema:
> DEPARTMENTS, JOBS, and LOCATIONS tables have been created.
> The EMPLOYEES table has been altered to add foreign keys and a primary key.
> The JOB_HISTORY table has been created with references to EMPLOYEES and JOBS.
> Your HR schema is now ready for more advanced HR scenarios. Let me know if you want to insert sample data or need further actions!
```bash
please insert sample data to other tables using sample data inserted in EMPLOYEE table with keeping referential integrity
```
>Sample data has been inserted into the DEPARTMENTS, JOBS, LOCATIONS, and JOB_HISTORY tables, and the EMPLOYEES table has been updated to >maintain referential integrity. All relationships are consistent with the existing employee data.
>Let me know if you need to view the data, add more records, or perform further actions!

```bash
show me the records of all user tables
```
```bash
i want to create table create scripts including drop if exists for all user tables in HR schema, and insert scripts for all user table records considering referential integrity, save the scipts to /Users/umutnazlica/git/MCP/MCP_VSCODE_COPILOT/runsql2.sql file, if file not exists you can create the file. If file exists you can update the file.
```
> New created file is included in github repository as well for you to review.

### 🌟 Monitoring and Security

All queries being executed via database connection user performed by SQLcl MCP are logged in DBTOOLS$MCP_LOG table in that schema. <br>

```bash
select * from DBTOOLS$MCP_LOG;
```
```bash
select * from HR.DBTOOLS$MCP_LOG;
```

I used and test the SQLcl MCP functionality with connecting to a containerized Oracle23ai database running on Podman on my Mac. <br>
In order to test some admin tasks i connect with account that has admin priviliges. Since this is a play ground for me to test the capabilities of SQLcl MCP. <br>

Some recommendations as suggested in the blogs and official documentation:
  - Think twice and hard before ever letting the tool connect to a production or any critical database environment.
  - Don’t let the tool connect to an account with any kind of privilege that could damage your data/database. Use least privilage principal! This will limit what is accessible to the LLM.
  - Always review requested actions before approving them. Do not use 'Always Allow' when asked for confirmation, verify first.


### 🔧 Configuration

1. **Clone this repository**  
   ```bash
   git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
   cd YOUR_REPO

  ```
