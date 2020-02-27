Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39820170FDE
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 05:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgB0E7e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Feb 2020 23:59:34 -0500
Received: from mail-eopbgr760047.outbound.protection.outlook.com ([40.107.76.47]:53188
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728273AbgB0E7e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Feb 2020 23:59:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1DWtWZvBdJYjxljUrIqTF6Htotv85cZi8Ee4RI/tYi6bcGUWpy1TRfTYF62aZQv7S91SGwXXSfXN7dFBen3z1LiI/DL8T/dEtmD5Fi3tIQ7e7QUmaxhz2K2CjeA4Q3ERq2fz/UdtKj2v6fVPYqLt+d5NBM0XlbQbZ0gethNChcE+v+wWackBhvsUGISF2VQW2rix1pXi9bQHa2BEO7UzDdJVEuMp9dhdi6TM4Wjr4r4RlMocFInEWpdx/TA1f8q26fOYypzXmpL7hS/wYRvVHryPUasXhNW0gjWuQzex+p8rrcKSk2DlFT4SCfFEorXieM93c6JPBrygXQ50DgUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tade87Pz3iSU2tsqcZYvJjSLs0oqGejqPBjPq1m9A2Y=;
 b=aG8GWKsQCQIMLdVj5ikGacdbwVgHxruznhPgnRKH2Be78Z/ERPXvfNQZ7V4bnXtsnzKoSNTAsAUWfr5CPjWkw/wKMncq6b9znvPxi2Ge5YdDfDUBkHUbhu71jp0CPTIC3HaodhwdA2sfHLBxOEhGHb3f7NtcJEt4aUJXI+rhurJq2pLGnmk1TGb8iTqpdjGLR8DRdiJlfOAITkZRV+vskCqvlr/UVQ5ozDa7WckMeGmEQJFngwF1b0ehpDd91Q2mVIb2LU50T4gQMKeNVbxkjfV5Yoak6V6RqorthctHtf5M73BVmdhGJuxwL5+JSSue0SVHqq1MYP3BRTYv532/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tade87Pz3iSU2tsqcZYvJjSLs0oqGejqPBjPq1m9A2Y=;
 b=rfKYDZrTiqLntu8McSC7k6BWLNseZovE5QexP+sabBRh7NmIzQBvU+Y+YqRIsVcmSz/k6avnUeraWDCMWjagq2Pomw9L1pa8Kq2N7XYwdWBM8deOg0ubc8Qktzcdn14OXQx+zrPR9DIzQy98NOYW1lKzA65Wntse9yojR6xXV2g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 by MN2PR12MB2912.namprd12.prod.outlook.com (2603:10b6:208:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 04:59:29 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 04:59:29 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v4 1/4] SFH: Add maintainers and documentation for AMD SFH based on HID framework
Date:   Thu, 27 Feb 2020 10:28:54 +0530
Message-Id: <1582779537-25662-2-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com>
References: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::17) To MN2PR12MB3598.namprd12.prod.outlook.com
 (2603:10b6:208:d1::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from andbang2.amd.com (165.204.156.251) by MA1PR0101CA0055.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 04:59:26 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7da17868-5bd6-43b1-a90c-08d7bb41d37d
X-MS-TrafficTypeDiagnostic: MN2PR12MB2912:|MN2PR12MB2912:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2912DBFA02094BB3313AC4D4E0EB0@MN2PR12MB2912.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(26005)(66476007)(66556008)(8936002)(186003)(16526019)(2906002)(4326008)(6486002)(8676002)(7696005)(52116002)(86362001)(66946007)(316002)(81156014)(81166006)(6666004)(6636002)(5660300002)(36756003)(478600001)(956004)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2912;H:MN2PR12MB3598.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJHtLzO69SIdAt5JvYTSdFHRdymOzOnaM//4TGfUeDh5wFGO3j01nPLd/eJ1+56R4UWf4WE4cHjXbK74atVcUXiZTWRmapQIlNoipXmzcod4b2/HsO4IR9FeDF02T/KLcussRoMlBzGunFx9Nk/N3MrBI7mGD3ofpRhm/ZBh1/+jGth7XIXnoHbwa6TlbQ0TMXMA3v1VlzGAKQDL+XiBOxmWb+lEcrvLNGNO19wRrT1wVfnhejMglfZhYQd9xXM9d9k/kaFfoQiQM3LIL0FQVv95jeH/ljmi9CKGKBmFhFGvkWQegvrL2aidYXAjUZHOmryUQiJJx+VygIN6+ST3p1ALpSJ3boelGsPRCEuKwfKtaEj4dEAWSpWdrWc2Rv7+1qwq2xVlgQjkOaiMKZqSxLpyA00Z1+OdppkxEAj2j4cCY4rXJ7TBxL/L2Vo0ss71
X-MS-Exchange-AntiSpam-MessageData: xtLMWoNZXXj/PJWx+S8OxrM+rP3y4OJi3ONPs/AyoWv4xk/LI/HWNGlBX8Zhl/Rvn0DIT6d9Nc+YMN9QjRthiN2uoHp2Mdd0TMgg00V3ICslovYnTemXLyH5ZTSzConUUhtDxgCsrmAB0BImSzoLqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da17868-5bd6-43b1-a90c-08d7bb41d37d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 04:59:29.5188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JK3/b3GsCs3vFkp/A8/DdGhoRE21MA4KDSKx0XBBdMDqO1MNDZ9vxAuv3bo5cGUo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2912
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

