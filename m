Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D46159F4D
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2020 04:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgBLC5D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 21:57:03 -0500
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:58336
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727565AbgBLC5D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Feb 2020 21:57:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRIm1fqksWDldUOTuQr+5svalbWjMglGKuAONNGGaCuSITY32CJUjH5oLK7VwThVvmpQw2Z6pEUH3Pruewehb3uh+rFKIE3Ajk/oKkxN9Y9A760YkEh7+ImjU+E6Sz4il/OKfjNYnHCRbvlpd8+mXnrOuHJzR9nPLftFKcSodhCduvw7YeJ1c4uGDJEImsclLsaQeZz608it1rTG19cjAKtCc5jzRo7EPu7xBH4ZWaxmGkLDJX6bPubnAcTgSqKORR8jvuNYg5dsB0YyDsuzHMsQC3WoSZwjOCGA9YRPdXpI1CudcHzufK0pDKpIdFo6lyn6DkxbIGU+Ltm2UGfQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tade87Pz3iSU2tsqcZYvJjSLs0oqGejqPBjPq1m9A2Y=;
 b=BD500QXJdLVsL/S5iZSjR+6tk6DyyalT/Lq1xn9SoZBi2XpH03HWQGDFGjKtZxv0fd8eb8aV2Y2RKMkAy+deI24A8f2N9zKQtq6jkDOpWEnBMZ8nhkBH2SpdNfprkXPWlghP8S/0g96EGweGAhPjDryvN30rGO9kgVCz4xXdEz+ROKF6ciA6lsx+AU+4iFWveMOQ5ZlyHNupD8prgy+wgvqLeegOO72JtA7eEOL0ihIyF95yh93mB19a8GZw1Tk3mClis4yxC3R7mwi/w0xul5dCYTq2AywFdhMXN3V+E7r8eBONfsLzS9Fk5h6VWjtciUou033fC1WcRQNdl4EW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tade87Pz3iSU2tsqcZYvJjSLs0oqGejqPBjPq1m9A2Y=;
 b=0cQowtTrrHfIhWpHJNzEZSVjgyQB9gMrfvF0MK+pFq/JyS3iNQfkIxgBSJpP0zO6ILvoOJIaETxaqyxTnxLxbRuA5KDZGcoTg6pibgB5hEL55oJZkrk4OkucdTMz1j2rVgv7od189/+J73pksNSwrAPwTDK8PheYlQXiWZHZo9I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3343.namprd12.prod.outlook.com (20.178.240.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Wed, 12 Feb 2020 02:56:59 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 02:56:59 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, Nehal-bakulchandra.Shah@amd.com
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v3 1/5] SFH: Add maintainers and documentation for AMD SFH based on HID framework
Date:   Wed, 12 Feb 2020 08:26:33 +0530
Message-Id: <1581476197-25854-2-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
References: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=n
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::26) To MN2PR12MB3598.namprd12.prod.outlook.com
 (2603:10b6:208:d1::20)
MIME-Version: 1.0
Received: from andbang2.amd.com (165.204.156.251) by MA1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend Transport; Wed, 12 Feb 2020 02:56:56 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0508ab3c-5783-4a7b-461c-08d7af673a71
X-MS-TrafficTypeDiagnostic: MN2PR12MB3343:|MN2PR12MB3343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB33438BB0EC96B03BE827FD30E01B0@MN2PR12MB3343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(6636002)(81166006)(6666004)(2906002)(81156014)(8676002)(6486002)(8936002)(86362001)(956004)(36756003)(66946007)(66556008)(4326008)(5660300002)(7696005)(66476007)(2616005)(52116002)(16526019)(316002)(26005)(478600001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3343;H:MN2PR12MB3598.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYPABVrOqcpJIzvGhJxEwTrdweK7Rs419SJ5xlJ1Rp04jB+Zx6EUSKfeTMlP5IrOxVj9ZrdiywjWcKbR8yOd/4bvAy+BWEcrYbgzlV1xejMGYY/8hpshKbSWpCfRB/aBBpfEmLbSbZlHpej3uFeXU9rFw4tV9Sqkb+8Cxu5M/ooc0uK/7XdjoVHlTYRqHGOZn/P+2HP62/Cssx7NK5ugdSU3hCJgs8kOWGzj+J8fRGycR8PWjYOq8uUyDxbZyQZKROz3JR7UPgXynH/MXLACC2hG/7GlTP6TrYj1OzOxCjGjtuIB/H4h5psl2WwbNLOwmRR4HSFPKT3csUcNPIEORy+9qhV3aS4Cmar/8qxlrZz+v6A9iJwGCx8xJMKnBZhu7dfO+Cf3XdzS9IkclcfC4YaieVRMYsiKxrlYXY3VacRfYqUadZJDudCazlJvnwXB
X-MS-Exchange-AntiSpam-MessageData: iMn281zsy0dM/IiTwrKIrf5zFiKrGXh8vzXXxDKUaMm1ZUepu153Vlphe1RZC3Ii5aeFqGHiLJ/Dez1qnYgL5nfiiXha0+fspxTs/RklxARXbgc40kmmtTlJt8ahAxWGO4+QUkcVKBSdx7yJM7fxNw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0508ab3c-5783-4a7b-461c-08d7af673a71
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 02:56:59.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYI+vTDXYYvkRCIWaxVZ2VqprZ4ASl4xryF0ZLJD0W9lAEf8ywuT01O2Cbwgzh+J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3343
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

