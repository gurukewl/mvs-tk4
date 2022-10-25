# A docker container containing a fully running MVS 3.8j
This is the September 2022 Update of MVS 3.8 TK4 with ISPF, BREXX, NJE38, Intercomm. Also, several bug fixes for Algol, Cobol and JCC. New ISPF panels.  New version of Revedit, RPF, and IMON.  This is in many ways the update to MVS 3.8 TK4-v8. 

## Thank you to the following.
* TK3 created by Volker Bandke       vbandke@bsp-gmbh.com http://www.bsp-gmbh.com/turnkey
* TK4- update by Juergen Winkelmann  winkelmann@id.ethz.ch https://wotho.ethz.ch/tk4-/

## Usage

```
docker run -dit --name tk4- \
           -p 3270:3270 -p 8038:8038 \
```

Connect a 3270 terminal to port 3270 on the docker host.
To get the http://docker.host:8038 for the Hercules console.

## Persistence
To run with persistence so that you don't lose your data after stopping the docker container please use the following command to start it up.
```
docker run -d \
--mount source=tk4-conf,target=/tk4/conf \
--mount source=tk4-local_conf,target=/tk4/local_conf \
--mount source=tk4-local_scripts,target=/tk4/local_scripts \
--mount source=tk4-prt,target=/tk4/prt \
--mount source=tk4-dasd,target=/tk4/dasd \
--mount source=tk4-pch,target=/tk4/pch \
--mount source=tk4-jcl,target=/tk4/jcl \
--mount source=tk4-log,target=/tk4/log \
-p 3270:3270 \
-p 8038:8038 tk4
```
## Description of persisted directories
```
/tk4/conf : This is where the master configuration file tk4-.cnf is stored
/tk4/local_conf : Scripts for initialization and unattended operations
/tk4/local_scripts : There are 10 files located here that are meant for user applied modifications and are run after Hercules initialization, when operating in manual mode or after MVS 3.8j initialization when operating in unattended mode
/tk4/prt : Used for simulated line printer devices
/tk4/pch : Card punch devices output stored here
/tk4/dasd : This contains all of the simulated CKD DASD volumes. Count key data or CKD is a direct-access storage device (DASD)
/tk4/jcl : contains the SYSGEN Job Control Files
/tk4/log : contains log files created during sysgen
```
## Add Full Function Console when Running in Unattended Mode

Point a web browser to port 8038 of the host system running TK4-. This will typically
be 127.0.0.1, aka localhost.

Enter ```attach 010 3270 CONS``` in the command field of the web browser session.

Connect a tn3270 emulator of your choice to port 3270 of the host system running
TK4- (which typically will be docker host IP). Use CONS for the LUNAME (or equivalent)
connection parameter of the tn3270 client. A panel showing the TK4- logo and
information about Hercules and the host operating system will be displayed.

Enter ```/v 010,console,auth=all``` in the command field of the web browser session. An MVS console will now be
activated in the tn3270 session.

It is recommended to press PF11 at the newly activated console at this point. This will remove the annoying default display area which occupies most of the console’s output area. Alternatively PF23 can be used if in addition the popular ```mn jobnames,t``` and ```mn sess,t``` commands are to be issued

For more information see http://wotho.ethz.ch/tk4-/MVS_TK4-_v1.00_Users_Manual.pdf

### Users

- HERC01 is a fully authorized user with full access to the RAKF users and profiles
tables. The logon password is CUL8TR.
- HERC02 is a fully authorized user without access to the RAKF users and profiles
tables. The logon password is CUL8TR.
- HERC03 is a regular user. The logon password is PASS4U.
- HERC04 is a regular user. The logon password is PASS4U.
- IBMUSER is a fully authorized user without access to the RAKF users and profiles
tables. The logon password is IBMPASS. This account is meant to be used for
recovery purposes only.

## Documentation

Brief documentation is included in /opt/hercules/tk4/doc
Also found at http://wotho.ethz.ch/tk4-/MVS_TK4-_v1.00_Users_Manual.pdf

## Basic TCP/IP Support

Jason Winter’s TCPIP instruction (opcode X’75’) has been re-fitted to work with the Hercules version that comes with TK4-. The instruction dates back to 2002 and was last updated around 2009. It allows the Hercules guest to access the IP stack of the host system on which Hercules is running. The current implementation provides the complete functionality as
designed in 2002/2009.

However, from today’s point of view, the given implementation may compromise the TK4- security concept and attract risks from the network. Before trying to use TCP/IP connectivity it is strongly recommended to read TSO HELP member TCPIP. Besides providing detailed usage instructions it also explains possible risks and strategies to avoid them.

## Getting started notes

PFKEYS

* F3 - Exit
* F7 - Page Back
* F8 - Page Forward

## About the Hardware
The MVS 3.8j Tur(n)key 4- System runs on an IBM 3033 mainframe emulated by the Hercules System/370, ESA/390, and z/Architecture emulator which is Copyrighted (c) by Roger Bowler and others.

Hercules is licensed and distributed under the terms of the Q Public License Version 1.0. See http://www.hercules-390.eu/herclic.html for license details. According to the terms of the license an unmodified copy of the license is available as file /opt/hercules/tk4/hercules/httproot/herclic.html and all patches applied to Hercules to adapt it to the needs of TK4- have been placed in folder /opt/hercules/tk4/hercules/patches of the MVS 3.8j Tur(n)key 4- distribution.

## About the Operating System
For the present implementation IBM's OS/VS2 (MVS) operating system (Program-Number 5752-VS2, Release 3.8j, Service Level approx. 8505) was chosen, which is in the public domain.

## About the MVS 3.8j Tur(n)key 4- Distribution
The MVS 3.8j Tur(n)key 4- distribution itself is put into the public domain without claiming any copyright by the author as far as no third party copyrights are affected.
