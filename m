Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAD7135448
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2020 09:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgAII1g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jan 2020 03:27:36 -0500
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:51104
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728347AbgAII1f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 9 Jan 2020 03:27:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lno0DCSnYu3G/NYajIgCRoteMEXOveQP2s2roY9vhri/VE95TVUu8hZq4tlTcH3nMOnLJLCeSmpYs+coWIVnpJg0bpX4rW3EJxbRMTH3fGVuK5kOc5GYL4ZwrW8oWtLwbS4GzMV43/weslxKuxOXutDkcb1PpALkohKZe/U+SqWUX4FNgT/YrNeFjPghRB/QiHJM2dMs3Bta4o054XiMLAPhO+00eTijXDdMxngWPGDAQvVOezt2ZpB3erjGXpvw7aJrYKIPFi6xeAAi9O3ko7Ra+HvzLlUNCTmiKitT9g0XOsTex1L3k0AGff/j4jUDXEhraBV7gAm6K6176ENOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI0b9+6q2d1CEaFCXeex8lyzuJVx0SyHg4UbXo8AfE8=;
 b=LN8hkhDVW/LiUI4tpoftzfXDAak22GR9YJ7NQNgIFrxplgDn6Lf8577NNmMoE+E6ETJlBa+YL/vM16wpopWPyutHQmBBsk0+IwcFa95uEZhcrQOxQNiSGgSxA+88lhYlfclTVHaGf/ORpvKOF3bxCANLrT/c9VknZblVOGGIWml+fQ0t6WzZ2TYIpxdB8lZCQdNc4jlcrj17Qo5e7goF+JZWDle+vFYiVq0wsy5u1965ITey86duenZk7vAIslYlGeXDw9PhHJoxsDwyJMIpOuG47TVA3oMn8i7+F32efaEwjT2Icw1Ze7Td5q51Ks81a6do1PuJJi0wCYTG8aLASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI0b9+6q2d1CEaFCXeex8lyzuJVx0SyHg4UbXo8AfE8=;
 b=vM39ft6zcyS99qlyrkXO3W6Jy+LMwql88n1+XCWisAv0sc/8GoTBVmEQyPJB/WOujESDZ3TMiOR7yU97yw0j8gzR/Eu6djJ4mo1KhJ4XiPqrwhQjHK/xvniACiTycYClc4SqSI9NwxDAIU9l14Vu9DWc6yfqwBpBF4wmDGmftnI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3871.namprd12.prod.outlook.com (10.255.238.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 08:27:32 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 08:27:32 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Subject: [PATCH 1/4] SFH: Add maintainer list and documentation for AMD SFH based  on HID framework
Date:   Thu,  9 Jan 2020 13:57:10 +0530
Message-Id: <1578558430-10024-1-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578558077-9798-1-git-send-email-Sandeep.Singh@amd.com>
References: <1578558077-9798-1-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::19) To MN2PR12MB3598.namprd12.prod.outlook.com
 (2603:10b6:208:d1::20)
MIME-Version: 1.0
Received: from andbang2.amd.com (165.204.156.251) by MA1PR01CA0103.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.9 via Frontend Transport; Thu, 9 Jan 2020 08:27:29 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4657f4f-43e0-4e08-093f-08d794ddc5a1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3871:|MN2PR12MB3871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3871E0A13240DB2C7B11A355E0390@MN2PR12MB3871.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(6666004)(4326008)(6486002)(8676002)(81166006)(54906003)(26005)(66556008)(81156014)(36756003)(2906002)(8936002)(66476007)(316002)(16526019)(7696005)(66946007)(2616005)(186003)(956004)(86362001)(5660300002)(478600001)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3871;H:MN2PR12MB3598.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coS+Ux36BBfL7p1/vWuSlFxIq5K8jtiTWYeZKGhygJ8TLmXcRy1iMm3ft2A2/l7gmO4K1M+mAwEc5fbyL1bmIANnhuvVe14TqiLus3xl8A02gNzAZxKnOomws+mLXQ9pAFKq/ZCd9KW1Q9fnvzjc5Svqg3vsyFR+KAKk8hgN9R36fLikX6OLUojLHSmn3whrgNqYt/F6Ng1LxLs9+/WdaPmcPcKgAM3kbiXW1gi0zyHtzySB8VqSxIshWx+CnDY5MCed74w8FQY1KApwPw0KtGR3KvUu07lnE9E94UHZGho4EgJqEpB45qrLV1EItrZ08gQOhNLqUEgLYH/5mn/+HWMC6j2RCr15za9H96+NpZE8+Nq62/EdSEbkV6M/3ue/5/uMA6Z4mxbUehQ+3BhKyLybO0KduTSLwXxBk/dUGwG5wa+Ytm84IrhQjv1yPKtA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4657f4f-43e0-4e08-093f-08d794ddc5a1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 08:27:32.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9guDBfkVycWoubJeHYjr/9U942RlyhjWAWEI5SBMX9OHhwxhJn5Esk2f2typODc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

Add Maintainer list for AMD SFH Solution and work flow
document.

Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
 Documentation/hid/amd-sfh-hid.rst | 159 ++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                       |   8 ++
 2 files changed, 167 insertions(+)
 create mode 100644 Documentation/hid/amd-sfh-hid.rst

diff --git a/Documentation/hid/amd-sfh-hid.rst b/Documentation/hid/amd-sfh-hid.rst
new file mode 100644
index 0000000..1183350
--- /dev/null
+++ b/Documentation/hid/amd-sfh-hid.rst
@@ -0,0 +1,159 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+AMD Sensor Fusion Hub:-
+======================
+AMD sensor fushion Hub is part of a SOC starting from ryzon based platforms.
+The solution is working well on windows OS in several
+OEM products. AMD SFH uses HID over PCIe bus. In terms of architecture
+it is much more resmebles like ISH .However the major diffrence is all
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
+The driver, which binds each device (AMD SFH  HID driver) identifies
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
+It identified the number of sensors connected using MP2- PCIe driver and
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
+are mapped in PCIe address space.Writing into C2P Message register generate
+interrupt to MP2.  The client driver allocates the physical memory and send
+the same to MP2 for data transfer. MP2 firmware uses DRAM interface registers
+to indirectly access DRAM memory. For Firmware always write minimum 32 bytes
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
index 8982c6e..7b282af 100644
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

