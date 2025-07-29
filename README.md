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

## 🌟 Warning 

Vibe Coding is becoming a very popular trend, but introduces some security risks. Like any MCP tool SQLcl MCP poses the same risks as well. I used and test the SQLcl MCP functionality with connecting to a containerized Oracle23ai database running on Podman on my Mac. In order to test some admin tasks i connect with account that has admin priviliges. Since this is a play ground for me to test the capabilities of SQLcl MCP. Please
  - Think twice and hard before ever letting the tool connect to a production or any critical database environment.
  - Don’t let the tool connect to an account with any kind of privilege that could damage your data/database.

## 🌟 Assumptions

- We need Oracle database connection (in my case Oracle Database 23ai Free image running on Podman on my Mac Notebook, You can use other Oracle Database Connection options as well like Autonomous Database.). More instructions can be found: <br>
https://github.com/umutnazlica/Podman_Mac_DB23AI_APEX

---

### ⚙️ Setup Instructions for SQLcl

- Download the latest version of Oracle SQLcl version 25.2+ and Install (I use brew to install SQLcl, if already installed please upgrade SQLcl to latest version, while creating the document latest version is 25.2.2)<br>

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
If you prefer manual download, SQLcl downlod link: https://www.oracle.com/database/sqldeveloper/technologies/SQLcl/download/), please download, extract and copy to your working directory, and modify export PATH command.<br>

Check if this version of SQLcl supports MCP? <br>
```bash
./sql -mcp 
```
---------- MCP SERVER STARTUP ----------<br>
MCP Server started successfully on Mon Jul 28 13:43:39 GMT+03:00 2025<br>
Press Ctrl+C to stop the server
----------------------------------------<br>


---

### ⚙️ Setup Instructions for VS Code and Copilot.

- Download and install VS Code : https://code.visualstudio.com/download <br>

Extract the zip file and copy Visual Studio Code to Applications. <br>

- Start VS Code, Hover over the Copilot icon in the Status Bar and select Set up Copilot. Instructions:<br>
https://code.visualstudio.com/docs/copilot/setup <br>
https://code.visualstudio.com/docs/copilot/setup-simplified <br>

- Download latest version of SQL Developer Extension for VSCode:<br>
https://marketplace.visualstudio.com/items?itemName=Oracle.sql-developer <br>

- Open a new terminal window on VS Code. (Terminal->New Terminal)<br>
export path (modify to correct path which SQLcl located if necessary!)
```bash
  export PATH=/opt/homebrew/Caskroom/SQLcl/25.2.2.199.0918/SQLcl/bin:"$PATH"
```
```bash
  sql /nolog
```
Create a connection to your container database using sysdba privilages. We will use this connection to test some dba operations. <br>
```bash
CONNECT -save oracledb_mcp_sys -savepwd sys/YourPasswordHere@//localhost:1521/FREE as sysdba;
```
```bash
commit;
```
You should be able to see new connection from VS Code -> SQL Developer -> Connections <br>

connect to database oracledb_mcp_sys

You are now connected to the oracledb_mcp Oracle database. The connection is active, and the database is in READ WRITE mode (Oracle 23.0.0.0.0). NLS parameters are set, including character set AL32UTF8. You can proceed with your queries or admin tasks.

please create me a user in pluggabe database FREEPDB1 named testuser with password "TypeYourPasswordHere" which has enough priviliges for developer to create and manage database objects only in FREEPDB1 pluggable database

{
  "mcp_client": "GitHub Copilot",
  "model": "gpt-4.1",
  "sql": "ALTER SESSION SET CONTAINER=FREEPDB1;\nCREATE /* LLM in use is gpt-4.1 */ USER testuser IDENTIFIED BY \"P4ssw0rd1234\";\nGRANT CONNECT, RESOURCE TO testuser;\nGRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TRIGGER, CREATE TYPE, CREATE SYNONYM TO testuser;"
}

The user testuser has been created in the pluggable database FREEPDB1 with the password "YourPassword". This user has privileges to create and manage database objects (tables, views, procedures, sequences, triggers, types, synonyms) only within FREEPDB1. You can now use this account for development tasks in that pluggable database.

Please keep the user but revoke permissions, assign testuser to db_developer_role which is available with Oracle Database 23ai, more information can be found in https://blogs.oracle.com/database/post/oracle-database-23c-new-feature-db-developer-role

{
  "mcp_client": "GitHub Copilot",
  "model": "gpt-4.1",
  "sql": "ALTER SESSION SET CONTAINER=FREEPDB1;\nREVOKE CONNECT, RESOURCE, CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TRIGGER, CREATE TYPE, CREATE SYNONYM FROM testuser;\nGRANT db_developer_role TO testuser;"
}

The permissions for testuser have been revoked, and the user has been assigned the db_developer_role in the FREEPDB1 pluggable database. This role is available in Oracle Database 23ai and provides appropriate privileges for development tasks.

I am done with the connectiopn can you please close it





### 🔧 Configuration

1. **Clone this repository**  
   ```bash
   git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
   cd YOUR_REPO

  ```
