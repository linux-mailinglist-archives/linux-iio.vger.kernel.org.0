Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F53414C532
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2020 05:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgA2E1z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 23:27:55 -0500
Received: from mail-bn8nam12on2073.outbound.protection.outlook.com ([40.107.237.73]:1633
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbgA2E1y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Jan 2020 23:27:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPfa6QthMoXE0nEyYgmIHaXMcMUsRAWK9K0MX8L0k5vOyCUHuO2oTYq9PGxyZZhEMcVYMZX4nw1jUHatwBaOU+Y5LwmDzhswlv/jx5Vf8gG4xKu+nOL8u77hktH0CmeGNhfN1xM4tRcbvTmvglBsaFWVDWYtq1IdyYArZe3zpoXy/Gv2Y+4VzcDlvLJF97XvLpznYYPL9fmYvH91PvIXHBMfR6CczjUYfX4RZ8iOuDHBg0DdtRHSlHQ9osu1Lfg9OhnXoQOj4WOAl8f4zQbGNjHww3/PUoMnKm/n7DM3uLKI47AkL+NglppwrJ9rH7vvb8kbKwzwYHFDmwGLnKUKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhibI3wKRG7eVi7tQUnFa7CArJGmyTQxJvbyR/oilfY=;
 b=J5SWheJqJWXByc7rrc5EK+jQ9n4zJCMM3nCKNyjFu/SEdi8xxIJQb6iiNuL9iOisuPUdP6zTnIA8qnAcwZoi+kOX6sWUGDWhEihjepEbhk2FbvqWGDWcJ8RvXxpvvrpiyGRg7q2zdZnVCv5eD1QS6Q3+N3hvpUF/uxmPOCk1Tmu1/rw2slFM+TT+eX/g+CcSI9+Q5PjFW/nD+PgLRAM/QjkaDx4+eSzYOwH2+gu8VrmTdFIxSMKyvA8DkW+Av7opDfII18be9lXw4p5fOVHC3gMqrvihpGeDtCzmCu+SYGG9M8zTMjEDCoWx+qwcvJEyuz0D80IUhIMKBz4ja0Auxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhibI3wKRG7eVi7tQUnFa7CArJGmyTQxJvbyR/oilfY=;
 b=SCF6NUFcrUZe25bMGHn3fjpWwGYy/ojEnICuDlCgAQAsnbnYZiTCsOo0Bi7G71D/vOyKJuzkR2sLeuuqjdM/FRQBh0j6585PfkDsilTmanh9pqvIxk/0o+VptO5u6jIgn1rZXhAe6j9Jy+MkAs7ww/393VM5i4ZAijawSDXkZVM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3501.namprd12.prod.outlook.com (20.178.241.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Wed, 29 Jan 2020 04:27:51 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::10ce:b4fb:586d:8b9c%3]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 04:27:51 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Subject: [PATCH v2 1/4] SFH: Add maintainer list and documentation for AMD SFH based on HID framework
Date:   Wed, 29 Jan 2020 09:57:23 +0530
Message-Id: <1580272046-32101-2-git-send-email-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580272046-32101-1-git-send-email-Sandeep.Singh@amd.com>
References: <1580272046-32101-1-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::16) To MN2PR12MB3598.namprd12.prod.outlook.com
 (2603:10b6:208:d1::20)
MIME-Version: 1.0
Received: from andbang2.amd.com (165.204.156.251) by MA1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.22 via Frontend Transport; Wed, 29 Jan 2020 04:27:48 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51c014c2-0bec-4434-ee1c-08d7a4739a37
X-MS-TrafficTypeDiagnostic: MN2PR12MB3501:|MN2PR12MB3501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB350109FA9967C50062A8D020E0050@MN2PR12MB3501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02973C87BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(2906002)(4326008)(5660300002)(66556008)(66476007)(16526019)(956004)(2616005)(26005)(186003)(66946007)(36756003)(6486002)(8676002)(81156014)(81166006)(478600001)(7696005)(8936002)(316002)(86362001)(6666004)(52116002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3501;H:MN2PR12MB3598.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWv+UDhOyem0U5ZNAbVcJYtkBf3lTWp17TfayDYDmxVV4Gr/NvIZmvuIm3YMZ0Kr4DH3IzuUYiJoE/4fHR0cmZlov6W92xDuSlkRnpbyIIoYoYyPsTGm1t1PcNMT63+sy4Yi4nB53cImscA3r3kEzbc3ttiG6CQIBZ2bh/mWAORYm1A5zkNFljCjfpSKk8RF1pKWokSr4YJO3NNzO/atgBAZevbOkK+3iqa0lH5V3EBNXP7TJ3Rlhog8a8G7+E3elYI7GMWXfLPfTr7x5EUc4Yc5QpcblNgVgzFyYv9XhUTx4Cry4jIqrCtGq4zvvCfmku+ZyTBn7DPXVNWyArfE4pt8smHt5ywToQT054gSnCDOA1wTRwDMFJQSl28Y95qmhf4R6uF+qzkNAIkYCVaRjFhkL4Z7cmVgS8eSbla0BGpxWgHnFSWH8cK0HHduQK3w
X-MS-Exchange-AntiSpam-MessageData: 16iVnkvOyZX9K/yp+gXoASYi+CDlCRtH1kPjj9683NFVYHiQ7/SEGFIFX0fhfxXdnURRPwlcqyjdFahAci+KJM2kHM2+HOXr481nFfKCw2Pe3OTb1EoMUXmxQn1ftbnfRLGQLdHGCeRYJgDzI7kA1Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c014c2-0bec-4434-ee1c-08d7a4739a37
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2020 04:27:51.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB6gFv4/SkyI+bGztXtot5b94F8TUqVeeQnA/AVCXa2U0wKg6mRCXyjKz092fd84
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3501
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

