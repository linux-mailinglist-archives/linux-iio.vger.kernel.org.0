Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D871E7EFB
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 15:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgE2Nmx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 09:42:53 -0400
Received: from mail-eopbgr680055.outbound.protection.outlook.com ([40.107.68.55]:63554
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726827AbgE2Nmw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 May 2020 09:42:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHXcZXTugH2Us4GZm3TV/xDc5AX8EFd6tIZQeldMmN66+dHgC2x1n1it8fnTg35GmwBiTlOEakqlv8CGaC8mQGhrnh4azKSBimIUKpggg/S14+MbWiphKDXysPfehLxTgri6SV4MWpU6pC7ugzmJvd6jRa7Zd6FcamBL05oswlbWuboN8aUmVNqhk780CA6TRX0TVha5kbp7GumVAjVq+pa6KQBpPUMdjpLRSuwshoZCZO8x8wvk1tFOPLiQ2vywcYSJ6BU4NMqElUuYOYrF0Cf5sPms9YcO+8KmPRWLtSoJsRfuFlv8Tmv3OOgWjvxHMn6U4MwoKho1eHM1XnlYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tade87Pz3iSU2tsqcZYvJjSLs0oqGejqPBjPq1m9A2Y=;
 b=ZOx8jKkB2fxsD5+v813pm3r2+RThFSG39SpRQVioYTXLCJsyzDjTfRPurmIfY3o6ycaJYpu3Ce1hjg8tO9Q6fZ19RDL9ZOFOL2OuATDEo+Os4Nn04rNCBcVQXesKJLC83G8hZ5szJIXpGlbKK9Boxzr3kpdX7Imyaf/nQnqakI5pDHZV9bTnnlodSsjtLhYe2p/EDgJFNc7RwGXfnj0vghhYebyJldpnCMMkOdKzoD1AZ/zyBNmmDbDc+nB+VIa4vTmlocHe/dOnbJWBWRYJkzrwxpnlmdUblneZPnVCvutacuaLlrEF3VoE23I632j8fA50eXTq1+prCG58GndNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tade87Pz3iSU2tsqcZYvJjSLs0oqGejqPBjPq1m9A2Y=;
 b=fPTMVo2dXNLkUUmZU/3+O70iSR5gq5rcfCEqawRWJ9XybLD8DFEjCpKpcc38CGjp4zFlezWwndtyu4nScC+PNujONQ+X/PiWHqWC7yZ2UYSlORNWTuAEO68NHZrvegYWjWPxsOITalICwcm0ojlp/1nJ8nKpAtA0WLYlOGQDpjQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 by BYAPR12MB2805.namprd12.prod.outlook.com (2603:10b6:a03:72::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 29 May
 2020 13:42:48 +0000
Received: from BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::a984:b7cb:3ad0:7508]) by BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::a984:b7cb:3ad0:7508%6]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 13:42:48 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v5 1/4] SFH: Add maintainers and documentation for AMD SFH based  on HID framework
Date:   Fri, 29 May 2020 19:12:07 +0530
Message-Id: <1590759730-32494-2-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590759730-32494-1-git-send-email-Sandeep.Singh@amd.com>
References: <1590759730-32494-1-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::17) To BYAPR12MB2726.namprd12.prod.outlook.com
 (2603:10b6:a03:66::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from andbang2.amd.com (165.204.156.251) by MAXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 13:42:45 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed8e0198-50fc-469d-afbf-08d803d62cdd
X-MS-TrafficTypeDiagnostic: BYAPR12MB2805:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2805FF83DFEC9F6EFC9B0551E08F0@BYAPR12MB2805.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oeMl+KKZJJ8c/kD7pAt651AtpzYJueqelS+wlTdGB2gAL2+JhWWhxBvFd9+qQV/yHUhTLN+zxikJWK6wCuu4Yz3P8vYUdHXPLONTDRos7Hsv624KS+33PORoOjF9r5ep8h/X6zbwTdhkxYhMHvWrFkiSsr/pu9Q0R+yi90nQ8fp6rmP3i+/ujYXDacozrMpFvjiQ8tpT5Nu9lDHzPYzAWd8+Yv7BI0umPL1AcIVcMLYfvkujRqmQjKFSTdl64+bvi2q4NLQzfUKzlQD0/qIo7IUH/KxlHnjNW8FlQ1Bg12F7XVpcv9UC5HqNE1atWuGmm3ne2NQN9Ow4QuZ1at4To/TE45uauODhxi45tQhLBB938A5vAOlEkF5HrVavIkD/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(316002)(86362001)(83380400001)(478600001)(66476007)(7696005)(52116002)(2906002)(6666004)(66946007)(6486002)(66556008)(36756003)(5660300002)(7416002)(2616005)(16526019)(186003)(956004)(4326008)(26005)(8936002)(8676002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UL646KCjrNbP/fHwOKkN+cbPewJbmPE31Ff0KvE4pk8eqD9s4+gT0//uJL6kXvSMSKU9wdIGxPn3jJWCp9bnoSaTlGreHq19IAAC3KFYQ5asmAvXKKAy1ootBmvQPx/rLP8Qji8ttG8t/2rrz4dM2u0Zs18cRkkDu4oKVjMo2uplTx6D5cE2T8REp7NAfdDkkr+K+D2yccOgPvR0j7FKqWLLScB95MLcQPXq89817q0PBMKi4O7izgLMbmxcqs839uyPUyLu/LF97IkMBb2AaRpul0+vi9yWD4nfRtUgx2U5NYjs1HOI5VvCrdCU/PR/4YysEUcHcwt7HPPO8mCpATxltAgYNmRFK8oDcD0gEgRCuqGDGipVzZlE7GPRvqI5EWqUj6Ios7SiIIZN84qn81JWHArZNVN7Gu9/KooR/ndGJ9QmwF13jJXBjkbF+O+BnUNqt2JFBikMOlhO3hAZ3fbZLGnRPfcS+Og2fa7U6kZSArrP33newYTbhj2yDo5+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8e0198-50fc-469d-afbf-08d803d62cdd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 13:42:48.5774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhUVqgzqstCW/H7d0jEhJwx3lj5X79XIlWSHlCQCNXKvuPD+MsBBXIcX5stEUUO2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2805
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

Add Maintainers for AMD SFH(SENSOR FUSION HUB) Solution and work flow
document.

Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
---
 Documentation/hid/amd-sfh-hid.rst | 160 ++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                       |   8 ++
 2 files changed, 168 insertions(+)
 create mode 100644 Documentation/hid/amd-sfh-hid.rst

diff --git a/Documentation/hid/amd-sfh-hid.rst b/Documentation/hid/amd-sfh-hid.rst
new file mode 100644
index 0000000..eb60ac1
--- /dev/null
+++ b/Documentation/hid/amd-sfh-hid.rst
@@ -0,0 +1,160 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+AMD Sensor Fusion Hub:-
+======================
+AMD Sensor Fusion Hub is part of a SOC starting from Ryzen based platforms.
+The solution is working well on several OEM products. AMD
+SFH uses HID over PCIe bus. In terms of architecture
+it is much more resembles like ISH .However the major diffrence is all
+The hid reports are generated as part of kernel driver.
+
+Block Diagram:-
+=============
+	-------------------------------
+	|  HID User Space Applications  |
+	-------------------------------
+---------------------------------------------
+	 ---------------------------------
+	|		HID Core          |
+	 ---------------------------------
+
+	 ---------------------------------
+	|     AMD HID Transport Driver    |
+	 ---------------------------------
+
+	 --------------------------------
+	|     AMD HID Client Driver      |
+	|	with HID Report Generator|
+	 --------------------------------
+
+	 --------------------------------
+	|     AMD MP2 PCIe Driver         |
+	 --------------------------------
+---------------------------------------------
+	  -------------------------------
+	|     SFH MP2 Processor         |
+	 --------------------------------
+
+
+AMD HID Transport Layer :-
+***************************
+AMD SFH transport is also implemented as a bus. Each client application
+executing in the AMD MP2 is registered as a device on this bus.
+MP2 which is an ARM® Cortex-M4 core based co-processor to x86.
+The driver, which binds each device (AMD SFH HID driver) identifies
+the device type and registers with the hid core. Transport drivers
+attach a constant "struct hid_ll_driver" object with each device.
+Once a device is registered with HID core, the callbacks provided via
+this struct are used by HID core to communicate with the device.
+AMD HID Transport driver implements the synchronous calls.
+
+AMD HID Client Driver:-
+**********************
+This driver is responsible to implement HID request and descriptors.
+As firmware is OS agnostic, HID client driver fills the HID request
+structure and descriptors. HID client driver is in complex in nature
+as it is interface between MP2 PCIe driver and HID. HID client driver
+initialized the MP2 PCIe driver and holds the instance of MP2 driver.
+It identified the number of sensors connected using MP2-PCIe driver and
+based on that allocate the DRAM address for each and every sensor and
+pass it to MP2-PCIe driver.
+On enumeration of each sensor, client driver fills out the HID Descriptor
+structure and HID input report structure. HID Feature report structure can
+be optional.  The report descriptor structure varies sensor to sensor.
+Now on enumeration client driver does two major things
+1.	Register the HID sensor client to virtual bus (Platform driver) and bind it.
+2.	Probes the AMD HID transport driver. Which in turns register device to the core.
+
+AMD MP2 PCIe Driver:-
+********************
+MP2 PCIe driver is responsible for making all transaction with the firmware over
+PCIe.The connection establishment between firmware and MP2 PCIe driver happens here.
+
+The communication between X86 and MP2 is spilt into three parts.
+1. Command Transfer => C2P Mailbox Register are used
+2. Data Transfer => DRAM
+
+Commands are sent to MP2 using C2P Mail Box registers. These C2P  registers
+are common between x86 and MP2. Writing into C2P Message register generate
+interrupt to MP2.  The client driver allocates the physical memory and send
+the same to MP2 for data transfer. MP2 firmware uses HUBIF interface
+to access DRAM memory. For Firmware always write minimum 32 bytes
+into DRAM.So it is expected that driver shall allocate minimum 32 bytes DRAM space.
+
+Enumeration and Probing flow:-
+*****************************
+       HID             AMD            AMD                       AMD -PCIe             MP2
+       Core         Transport      Client Driver                 Driver               FW
+	|		|	       |                           |                 |
+	|		|       on Boot Driver Loaded	  	   |                 |
+	|		|	       |                           |                 |
+	|		|	       |----MP2-PCIe Int---------> |                 |
+	|		|              |			   |                 |
+	|		|	       |---Get Number of sensors-> |                 |
+	|		|              |                       Read P2C              |
+	|		|	       |			Register             |
+	|		|              |                           |                 |
+	|               |              | Loop(for No of Sensors)   |                 |
+	|		|	       |----------------------|    |                 |
+	|		|              | Create HID Descriptor|    |                 |
+	|		|	       | Create Input  report |    |                 |
+	|		|              |  Descriptor Map      |    |                 |
+	|		|	       |  the MP2 FW Index to |    |                 |
+	|		|              |   HID Index          |    |                 |
+	|		|	       | Allocate the DRAM    |  Enable              |
+        |		|	       |	address       |  Sensors             |
+	|		|              |----------------------|    |                 |
+	|		| HID transport|                           |    Enable       |
+	|	        |<--Probe------|                           |---Sensor CMD--> |
+	|		| Create the   |			   |                 |
+	|		| HID device   |                           |                 |
+	|               |    (MFD)     |                           |                 |
+	|		| by Populating|			   |                 |
+        |               |  the HID     |                           |                 |
+	|               |  ll_driver   |                           |                 |
+	| HID           |	       |			   |                 |
+	|  add          |              |                           |                 |
+	|Device         |              |                           |                 |
+	|<------------- |	       |			   |                 |
+
+
+Data Flow from Application to the AMD SFH Driver:-
+*************************************************
+
+	|	       |              |	  	 	          |		    |
+Get   	|	       |	      |			          |                 |
+Input 	|	       |	      |			          |                 |
+Report	|              |              |                           |                 |
+--->  	|              |              |                           |                 |
+	|HID_req       |              |                           |                 |
+	|get_report    |              |                           |                 |
+	|------------->|              |                           |                 |
+	|              | HID_get_input|                           |                 |
+	|              |  report      |                           |                 |
+	|              |------------->|------------------------|  |                 |
+	|              |              |  Read the DRAM data for|  |                 |
+	|              |              |  requsted sensor and   |  |                 |
+	|              |              |  create the HID input  |  |                 |
+	|              |              |  report                |  |                 |
+	|              |              |------------------------|  |                 |
+	|              |Data received |                           |                 |
+	|              | in HID report|                           |                 |
+ To	|<-------------|<-------------|                           |                 |
+Applications           |              |                           |                 |
+<-------|              |              |                           |                 |
+
+
+Data Flow from AMD SFH Driver to Application:-
+**********************************************
+      |		  |               |	            	          |		    |
+      |           |               |------------------------|      |                 |
+      |           |               |Periodically Read       |      |                 |
+      |           |               |the data for all        |      |                 |
+      |           |               |enumerated sensors      |      |                 |
+      |           |               |from the dram and create|      |                 |
+      |           |               | HID Input reports      |      |                 |
+      |           |               |------------------------|      |                 |
+      |           |HID Input      |                               |                 |
+      |           |Input report   |                               |                 |
+   <----submit to Application-----|                               |                 |
+      |           |               |                               |                 |
diff --git a/MAINTAINERS b/MAINTAINERS
index 56765f5..7cfeb5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -884,6 +884,14 @@ S:	Supported
 F:	drivers/net/ethernet/amd/xgbe/
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 
+AMD SENSOR FUSION HUB DRIVER
+M:	Nehal Shah <nehal-bakulchandra.shah@amd.com>
+M:	Sandeep Singh <sandeep.singh@amd.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/hid/amd-sfh*
+F:	drivers/hid/amd-sfh-hid/
+
 ANALOG DEVICES INC AD5686 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-pm@vger.kernel.org
-- 
2.7.4

