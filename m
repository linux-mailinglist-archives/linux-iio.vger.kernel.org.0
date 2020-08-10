Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E8D241264
	for <lists+linux-iio@lfdr.de>; Mon, 10 Aug 2020 23:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgHJVbi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 17:31:38 -0400
Received: from mail-bn8nam08on2048.outbound.protection.outlook.com ([40.107.100.48]:25249
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726809AbgHJVbh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Aug 2020 17:31:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3u5pOOtU6Kdx9djmxAeXfUhJK1Cwrll9PyBhhnrvW8cOmRyxXTBvkG/J+mGhymDJNF6unkiIGzFY+fhXLc3Zgzwad/wjMbwah+VKZK8ZVYpYIu724CO74wM6q1bR8zcGnGPMfILGAJrPn9scnTBrCIG19NxVjmCgz5y8B0RUVmMzr6OS62KQQNCyrDZGUqXvel5tvUYvVB+F7DV9e06lLDPh1NEz4tQHSHGiaM2tiU0I5f6kTB4/YmkR5zXf+Uld364FAhkZ8wE313mavMHv8kazWwMPmUXcIxhaiPaKKj6nrAewclahtzCX3HJG2dWrTywjbIDcKPZk3CGuBebhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yv8pEQqlT0Q9ZMr1zBBMj5HC+xnStEschhTKQ5f9mmY=;
 b=XJ1EkeWdOCKmihl9fhYO4qPsxpUdpNLxCb4vr1vRVSEhH2AiwFzgMp+4dKBrZOGDtpfgamKYY6ko0g21pJ00KJ1VmmWG52+UoBmZiglnyRJ5TvDSyuuw1dPohpBKLbNdVsLl2APepKxFSjXd/cAasIf5yh4Ncf6R0DQSVA5M6HjsQ4PLWqzAhS92ytmgTJ3Tq9rwH91qnw42MHrlXXPAmPII4O86WudcZ6GRqVE1ApXTbTajTuXWvoT6+yYpgyoQh1OwAcRk92fXo1NluhmPDdDFH+H2G2EEfe1pHngoqDv21iS/wDCX/fnoGEUtigvMbpWRV0Zx/4+BD3PNC8SNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yv8pEQqlT0Q9ZMr1zBBMj5HC+xnStEschhTKQ5f9mmY=;
 b=a3vCBPQ50l+jCs5iYhiNzpQp66e0sQBUMhWSjriEZvdxlJi4W+LbEFDvLJ751YOL9JVh4hEkzh319j0X9p/4lkquCE/cGDtTeHgLy2fpkg3ZV5NOn4BGdJe0Vg3qwJvjQdU8d8v0TwQE5Rn3uyH5uTgNwXyK5ieRscxVaKvC8d0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 by BY5PR12MB3714.namprd12.prod.outlook.com (2603:10b6:a03:1a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Mon, 10 Aug
 2020 21:31:32 +0000
Received: from BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09]) by BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09%6]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 21:31:32 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v7 1/4] SFH: Add maintainers and documentation for AMD SFH based on HID framework
Date:   Mon, 10 Aug 2020 21:30:52 +0000
Message-Id: <20200810213055.103962-2-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810213055.103962-1-Sandeep.Singh@amd.com>
References: <20200810213055.103962-1-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::11) To BYAPR12MB2726.namprd12.prod.outlook.com
 (2603:10b6:a03:66::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend Transport; Mon, 10 Aug 2020 21:31:29 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36f08ab5-a323-4ebf-f6e0-08d83d74c058
X-MS-TrafficTypeDiagnostic: BY5PR12MB3714:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB37148CBD11055836142CBFE2E0440@BY5PR12MB3714.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHwzkcMuHTR3IjJTTXnCzw2RYdBF/lKsriMmSa8WKh2feTBFVO01yLi0N57FfqU/UV2vSPyQbxxfi8Tnc5FgjNnWxn/3hVw7mo8oz1dqOQfnBbRml4UWKozK4DubyODbxLP4oaKJWy/qFlxo3QQoQsZxUjIo7U9Y2bMDQVL5AOdXTYamdm5H+A7qC9GQYO1GmBxddozn08qk4dPxN+mNyc+GkpxjPsTwieorVMCz4AoQvKpQd20+MD02pJ8pVopOWqcO/TV//Hco+lfCdqYsVGc7ePuyJJYBVu8mJeWPhV589tBTOmuggCsyVAGet310nOCo7wZkp0b0RTlLnaekPo0bnh6I97QQgIlCOv7xxmi9U77m8JApiXWVIAciidZ/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(2906002)(1076003)(7416002)(83380400001)(478600001)(6666004)(52116002)(66946007)(7696005)(8676002)(66476007)(66556008)(26005)(6486002)(5660300002)(8936002)(36756003)(956004)(2616005)(316002)(16526019)(4326008)(86362001)(186003)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: W0nL9Mdc2cbbX2i45T2GYrTyrvGYZNC7xmcjpUNowdJPc71hskM5ph3mB4Saf+ZYI6VTxvJ4q7sjaOboL1/U2jXI+IQDnJsh+LU+K9c9jUGOALLSxehbnskUXk2fRdVonUUyn4LXFqW5eqx++X415NoPi4XWH04lW1KTbqwQgZTbLuvT6J/MU+6ucJvW6BWUt/sOteHARUSr3OuVF1ceqEsAD+KSaWGElN1vEAkjbVDqD1Gqh13/kNRhf4agdUVXIKZpmtBDBLIWR5tJ96Yu+kzZm7HybW5LDIFgHw2MPTHFJL3KA1Tbkd29aN0l7hEJg3fuBCiwjd3SZQnolb5eQgIxx+ZtFjqSJ8iHihp7Jxcnd895ia8XJQjzZU5XZlY47cg/7m/3e4vMeJa6uj8MMGJqsHeznEGAVtV/9IhRCcg+NBc7+0XNfNZC60fTKMR+kwDh/SPp/PhEHFpPvEAWU/0cYTbRVGEs096EAEf0BQxciv9cfpoMoyK/isnGrxpdrGuppBruBvgmG7tXnCN3pX/ZKFgmfzaApjuPuj/5eTk4BcnIeZ31ecZ9EEZoLSfAr83rX0G5oNU8ZsKhwrf0R3FzbvkEKqKO6F4DeS43TNoEx+1p3U2LpztP2h5lcFj/N2TJ+JLCtVcFb5vWoBh+Rg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f08ab5-a323-4ebf-f6e0-08d83d74c058
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 21:31:32.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GX4rQkZf7FXKeYQe8+bc77xPIj5Z/Q1rPgKdP5tptanmMO/3uiwmOIwj41P5uWX5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3714
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

Add Maintainers for AMD SFH(SENSOR FUSION HUB) Solution and work flow
document.

Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
 Documentation/hid/amd-sfh-hid.rst | 153 ++++++++++++++++++++++++++++++
 MAINTAINERS                       |   8 ++
 2 files changed, 161 insertions(+)
 create mode 100644 Documentation/hid/amd-sfh-hid.rst

diff --git a/Documentation/hid/amd-sfh-hid.rst b/Documentation/hid/amd-sfh-hid.rst
new file mode 100644
index 000000000000..0ee9003013f2
--- /dev/null
+++ b/Documentation/hid/amd-sfh-hid.rst
@@ -0,0 +1,153 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+AMD Sensor Fusion Hub:-
+======================
+AMD Sensor Fusion Hub is part of a SOC starting from Ryzen based platforms.
+The solution is working well on several OEM products. AMD SFH uses HID over PCIe bus.
+In terms of architecture it resembles ISH .However the major difference is all
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
+	|     AMD HID Transport           |
+	 ---------------------------------
+
+	 --------------------------------
+	|             AMD HID Client     |
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
+AMD SFH transport is also implemented as a bus. Each client application executing in the AMD MP2
+is registered as a device on this bus. MP2 which is an ARM® Cortex-M4 core based co-processor to
+x86. The driver, which binds each device (AMD SFH HID driver) identifies the device type and
+registers with the hid core. Transport drivers attach a constant "struct hid_ll_driver" object with
+each device. Once a device is registered with HID core, the callbacks provided via this struct are
+used by HID core to communicate with the device. AMD HID Transport driver implements the synchronouscalls.
+
+AMD HID Client Layer:-
+**********************
+This layer is responsible to implement HID request and descriptors. As firmware is OS agnostic,
+HID client layer fills the HID request structure and descriptors. HID client layer is in complex
+in nature as it is interface between MP2 PCIe driver and HID. HID client layer initialized
+the MP2 PCIe driver and holds the instance of MP2 driver.It identified the number of sensors
+connected using MP2-PCIe driver and based on that allocate the DRAM address for each and every
+sensor and pass it to MP2-PCIe driver.On enumeration of each sensor, client layer fills out the HID
+Descriptor structure and HID input report structure. HID Feature report structure can be optional.
+The report descriptor structure varies sensor to sensor. Now on enumeration client layer does
+two major things
+1.	Register the HID sensor client to virtual bus (Platform driver) and bind it.
+2.	Probes the AMD HID transport driver. Which in turns register device to the core.
+
+AMD MP2 PCIe layer:-
+********************
+MP2 PCIe Layer is responsible for making all transaction with the firmware over PCIe.
+The connection establishment between firmware and PCIe happens here.
+
+The communication between X86 and MP2 is spilt into three parts.
+1. Command Transfer => C2P Mailbox Register are used
+2. Data Transfer => DRAM
+3. Supported sensor info => P2C Register
+
+Commands are sent to MP2 using C2P Mail Box registers. These C2P  registers are common between x86
+and MP2. Writing into C2P Message register generate interrupt to MP2.  The client layer allocates
+the physical memory and send the same to MP2 for data transfer. MP2 firmware uses HUBIF interface
+to access DRAM memory. For Firmware always write minimum 32 bytes into DRAM.So it is expected that
+driver shall allocate minimum 32 bytes DRAM space.
+
+Enumeration and Probing flow:-
+*****************************
+       HID             AMD            AMD                       AMD -PCIe             MP2
+       Core         Transport      Client layer                   layer                FW
+	|		|	       |                           |                 |
+	|		|              |                 on Boot Driver Loaded       |
+	|		|	       |                           |                 |
+	|		|	       |                        MP2-PCIe Int         |
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
+	|              |              |  requested sensor and  |  |                 |
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
index d53db30d1365..fc6a712893fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -934,6 +934,14 @@ S:	Supported
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 F:	drivers/net/ethernet/amd/xgbe/
 
+AMD SENSOR FUSION HUB DRIVER
+M:	Nehal Shah <nehal-bakulchandra.shah@amd.com>
+M:	Sandeep Singh <sandeep.singh@amd.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/hid/amd-sfh*
+F:	drivers/hid/amd-sfh-hid/
+
 ANALOG DEVICES INC AD5686 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-pm@vger.kernel.org
-- 
2.25.1

