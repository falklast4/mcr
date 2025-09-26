## Pre-requisites

### mmm
- Administrator Access to Servers as Services will be needing Restart
- Inventory for DC - DR Servers with their corresponding IPs, Subnets, Gateway
- Database Backup and Restore before starting the DR - DC switch (backup from Active instance and Restore on Passive to validate DB data)
### DC/DR
- Port Opening between servers as planned architecture 
- Health Check (Storage and Network Connectivity)
- DB backup for (SAST SSC SERVER - ssc)
- DB backup for (DAST SSC SERVER - ssc_wi)
- Jobfiles from Controller to be backed up (.ZIP)
- LIM DAST License Removal before DR Drill start 

### DR/DC
- Port Opening between servers as planned architecture
- Health Check (Storage and Network Connectivity)
- DB Restore for (SAST SSC SERVER - ssc)
- DB Restore for (DAST SSC SERVER - ssc_wi)
- Jobfiles from Controller (.ZIP) Extract
- LIM, SSC(SAST-DAST), Controller


## DR DRILL FLOW
### DB Server
- **Backup/replicate** the SSC DB from DC to DR. Options:
	- Full DB backup/restore (if it’s a one-time drill).
- Validate DB integrity at DR (check size, test queries).
- Ensure user permissions in DR DB are consistent with DC.
### Application Server
- Validate both the Environments are using the correct SSL Certificate and on same tomcat version
- Copy controller\jobFiles from Active server to Passive Server
- Re-Deploy .WAR file & Re-Initialize Fortify SSC portal if the .WAR file doesn't load automatically
### Sensor Servers
- (SAST) Restart the Sensor Services to reconnect the sensor to SSC & Controller
- (DAST) WI Sensor are standalone, so need only need to activate the sensor using the LIM (Pool Name and Pool Password)

## Step 1. Take Necessary Backup of Critical Servers
SSC DB SERVER for SAST and DAST Servers
JobFiles from Controller
DAST Licenses from LIM Portal

## Step 2. Restore and Validate the DB Data on Passive Servers
For SSC SAST and DAST Server access via PAM
- Open SSC Portal on DC Server ADMINSTRATION > CONFIGURATION > MAINTENANCE
- Enable Maintenance Mode & Restart the Tomcat Service 
- Access the SSC URL via Browser click on Administration > Copy the init.token from c:\Fortify\ssc\init.token
- Click Next > validate the DB Connection Strings and Credentials > Next > Next > Finish
- Restart the Tomcat Service and verify the SSC DASHBOARD Count
## Step 3. Restore Licenses from LIM & reconnect WI Sensors
- Open LIM portal on Passive Server > Login via admin > POOL > ADD LICENSE > add the token license token (make sure the License was removed from active server to avoid license errors)
- Open WI Sensor (WebInspect) validate the database connect string (IP, Port, Credentials)
- Activate the WI Sensor via LIM approach > enter LIM URL https://<lim.url>:8081/LIM.API
- Enter Credentials for LIM pool.
