Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2038D23FDAA
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 12:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgHIKZx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 06:25:53 -0400
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:19265
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgHIKZw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 06:25:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjiOmOIz2qJZWojRW0ly7v1zDjcI2k1urWkW04T4KGG3vZoGe7mWciGLVrEkrfCkVYeUQOzpe7r8Cdy9V/uC7x430xmMX10xByaH6i0g4gYG25DUiVBRPDxynC7BrjSfQxa2M3kxfg8vL+oJ8rMF0gDVjAQBkqn8XO1JnQt0zfOzLjn0YAc1+/QSYXFkWZN0dilwbG8b6dkkAg9qE3+Pwb//KjayLKplUSJpXsOxmT0+9PTqFh76WiNd+VlurlKyKZKd4jsHIvkyqEHhH4DA268nnhGzLdwgAtH04/5GgsRF2PzZT/lCTeocr/iJYhUWaUvjKpCLw1wifAlrW49dmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yv8pEQqlT0Q9ZMr1zBBMj5HC+xnStEschhTKQ5f9mmY=;
 b=V6QQaHySssxUzW/5SlNE6sOB/cq2CsN3ifqm0DXtFLr5NAx0gMHKFJkg0uh5Mbmzvq2ZvOTgDcZKGyt9KRAqgC1yS+G6ig7Psb+IzmTIfvkzEWrBippqxIyC6b2EUMXOV8bWYy3d6kh8L0jOsKdEfvyirqhAr3svRMxe8qdoAcXkUsEtdC1VXhoy+mQyjZAyeK2HU2nm9N0lRPvPG/OGuNft0/aCMtilG4HCPkfKPnm/WFmbN449Tuvzw1pRfkLVv1dMdwKgC85g12XCN/hznEDYCKIBSEp6tWSSu7SDq0KM7D5B5Lld2jYC4UY6CRDXLjcKhsYRXIcCXnXKGDC2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yv8pEQqlT0Q9ZMr1zBBMj5HC+xnStEschhTKQ5f9mmY=;
 b=vUrrcC967hA3ayVaa3IoU8sJTU+XOsMcHmSHe8AP2P9ewGCVstiOk9tOOf9lynOtAB1bOopuJP8f48x2/oDfiGz1yrAixp4X6bJ586b+VxdyfmzBs30wE3K1ygJxW+xXRgJAdT98/pKimSz3XN7+eC8iMHSVANkg/semxYdrevU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2726.namprd12.prod.outlook.com (2603:10b6:a03:66::17)
 by BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Sun, 9 Aug
 2020 10:25:46 +0000
Received: from BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09]) by BYAPR12MB2726.namprd12.prod.outlook.com
 ([fe80::8503:3713:6ed0:af09%6]) with mapi id 15.20.3261.022; Sun, 9 Aug 2020
 10:25:46 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v6 1/4] SFH: Add maintainers and documentation for AMD SFH based on HID framework
Date:   Sun,  9 Aug 2020 10:25:08 +0000
Message-Id: <20200809102511.2657644-2-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200809102511.2657644-1-Sandeep.Singh@amd.com>
References: <20200809102511.2657644-1-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::30) To BYAPR12MB2726.namprd12.prod.outlook.com
 (2603:10b6:a03:66::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MA1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend Transport; Sun, 9 Aug 2020 10:25:42 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: afff717e-1918-4bfb-0199-08d83c4e93ef
X-MS-TrafficTypeDiagnostic: BY5PR12MB3778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3778F1379F2BDD2EA873D68FE0470@BY5PR12MB3778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJjCRU/I4L//gSBVn2u0chwyknb1wTuEeU2zbRAkcf41cwu70tnvDOh/jsBdmdjptnTSoSgsluQ85QHZEZxvRJskkIH+IJRQ+jEXBqe3Eoylu5MxTSl1H7pG6PTkyM6z2f3KZj/Lf4k7AxMrVkRHmV2QGPb1rmx+QyudhVCEu4qRtYwiuc0VyL7HfWZQJ5Y135Jv+GJLCWvqHgJZW2/AGakMPgqTbWQ71udF+SIbVGlCjgjhFuu9f62pqiOuxW1TqEBKc+NlqKU2R6ixNkNVjH86rGXhJr1ubn+uwCr12M33/3EgrswASwU+qn/QHirGkyoNUcM7EjWA7ULP41iYAl3Uv5/19hdsFH+nNMOlyJfFlt2PJps8cCw27vBDpmLo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(1076003)(7416002)(956004)(5660300002)(83380400001)(2616005)(66556008)(66476007)(16526019)(6486002)(66946007)(26005)(186003)(7696005)(8676002)(8936002)(36756003)(316002)(2906002)(6666004)(86362001)(478600001)(4326008)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: i6MyQOJWUUNz1G+0n8aEQ0w/5QSSrzJA0O6UXiyKXQJUi9Itp7sMY3Mz5EQ0Mkej7CXHWLlPvOlMUJp7mu2EaGoy0um8XBbDFckdrWm+ykwGDHLoR7z7Z8ozRyW2N64Wc0UsqJy+id7CU/FFoRlDpmmUYr7q5JjIU39+D/8qxsgO2+Wli1qzLF4EzaXho8VGIWK5mr9fM26yq0EfAlRkm+/leiV8cV+sZOgf0y8HPM0HlcFEq04IRtugyd/lKIOHt4bfj3b7ntno+bkHvgWcOYwpA+BPjGYqGWYRQ+5/hfqSbfTIff8P3meIJFGZUcgz2fSCekRT3lg6S0CIWxTcDKGexP6FFfkeNSftU4mnLpXLILFp+P1gNor9Wzmc4HmgaaOz2kmW5o8SiD+x7nvXL6pGGBAiGwdL1TqBLILkX03q9AAlYJuXkpOCKJfH7ea5R2k/jw2eAeoNhnp2X7+Mu1u6/Hf1Qbc2zatm3LkwSg5vc0TA+ijFkwpgAPgTzImuuh1wEbQXPniwkpMwmutTTVBGQbg/N8KgbRa61cTAugZauIFXIoYoYeYXhs4AYMta5frqbYY7F0IWdCKgC0JUAXl9nZwy0tB1LBceS9wXLDpb9B714dk/1nQgPBA0TVh8/eQslZqVJhM2qjSHSxpmDw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afff717e-1918-4bfb-0199-08d83c4e93ef
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2020 10:25:46.1664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9II9yXMpy7yuB4xq4W2fIyoMjkaic5cnjj4D/ZbOfvbNnCwyqPNsdAM051IGhfmH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3778
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

