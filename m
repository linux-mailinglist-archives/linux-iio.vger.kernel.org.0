Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE262897D0
	for <lists+linux-iio@lfdr.de>; Fri,  9 Oct 2020 22:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgJIUFT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Oct 2020 16:05:19 -0400
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:43745
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731587AbgJIUCk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Oct 2020 16:02:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAJQdFtzoww3Ssm0jfHrYfib1YBI5Ayyj2ckjHuee0vZfG0/j8loAaJhUFD6fYQqhVRONzDAYLQWMuZYl6cyWCWAiUT3zYHztjkn6j6zRgX7NQoVpit5YEuV4B9oWGfxvrfF0yIGd1e0KgiQ/UkfkFgHBlKk7muvFV8E9U/EFYIQgGGkyEHNSZaOwPjO4dtAIG14v5DQMfR1q16Ys01zD14wUj4fOXnlpl+Hq1P/+cwm0z2Tuuz0L1ePpmQrTpJw1itfIBp7PV//MOa6yb+6CHT3t/mDPa4UtNeskk3BMh72GXcU1UDqs/NVEtfEW5E/L27UJHyalOvawAO9kGvWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1Egr01VUP6mPHyXh+kOLgBHWSab0MaBDOuz8jzllRo=;
 b=WQd8dg2lWjJmELeKDgeZIzq5kE7yrnDHBbPEHhSfqz3XhLwLBoRk/uG2ned5sK5JiT7ifcoa+3O+xJaExmP+cdf/oPokhw2DZsdTa4tB0f4WDI1OwCT94Cx6nAUhVXgRU8MwtVXm2FTL5I2C0ROX0ozAzY4VJas+U3e6bdP4G578iU+ceJBbROSvQ1dCnO0znOQf32UCdsg/rQD/ogUODz5IjMtOkSakkrNmyzhlIpSQChZODJoPS9iOzkW7Vy5FUFa1Ajhwd+whOggksPRPmJfDmy/2s16OODrWEjBeNdXsVH3EBM4dYgLwZmxjXmr8DT8LidOk7jykvQNmNSzx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1Egr01VUP6mPHyXh+kOLgBHWSab0MaBDOuz8jzllRo=;
 b=2CqmTyhSepN9UxJrFx+r/G1ik+kMjICrQwxJCPWxJfWP7IWBkOe2dDS0RK5dPFDOq0/mVqFzokKfjrKZHrfhEGOsPESYLAPmEWoIae6WGMNSk1bSSQfwqGv/9C5XarJACC2nXNSmee1slIAZCejkRCygPfAFBrMRvCuKNqKEVkY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4859.namprd12.prod.outlook.com (2603:10b6:610:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 9 Oct
 2020 20:02:21 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::a110:b7c8:73bd:d60]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::a110:b7c8:73bd:d60%8]) with mapi id 15.20.3455.027; Fri, 9 Oct 2020
 20:02:21 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>
Subject: [PATCH v8 1/4] SFH: Add maintainers and documentation for AMD SFH based on HID framework
Date:   Sat, 10 Oct 2020 01:31:35 +0530
Message-Id: <20201009200138.1847317-2-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201009200138.1847317-1-Sandeep.Singh@amd.com>
References: <20201009200138.1847317-1-Sandeep.Singh@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::24) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MAXPR0101CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Fri, 9 Oct 2020 20:02:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f193f1f0-bef8-4c24-5bfc-08d86c8e3b32
X-MS-TrafficTypeDiagnostic: CH2PR12MB4859:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB48591F84F4C39D54C3E3D42BE0080@CH2PR12MB4859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CK8BMp8+fTCfHI3gxpUOfzqeN/q1wSJMDqiANRVoqtBOeVK9Vu2+tNxPdGPLEh+VWSmJl0JMMaANVc95NQmxPUu3T70gSK/9AplJDr/Gz96Zm2XAner8HeHYqtknUyoNxjP8LP3SgxS97GofTOW5auaZU8aOD9+6iWUaqYPgLsStNZzFWQC6JkNDPAzWv8j3JV5EYLp4IGUZSvNmbyJRTWPlZ2mA+kw2Cg/Ps1mXNIi7UHT6rbj90QcnEfPHLDdA7HUu7X1FmKffMhsHoxHPE4JSt04u6C5a/+DC0rFDutPDzaUdCVKiYM9GbEtWcJeWEuppctsIkP2a+YVGW1TKbONWbXgDrxRTq5tTMp2ObEixDdlLwykLTm9i3KH09Sun
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(16526019)(86362001)(956004)(7696005)(52116002)(6486002)(26005)(186003)(2616005)(4326008)(83380400001)(66476007)(6666004)(36756003)(5660300002)(66946007)(316002)(8936002)(478600001)(66556008)(8676002)(1076003)(7416002)(2906002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: j10C3EPCBe2Sr9/q0e5mbt75olApcydFeGZ4FvunI7V9bwq4HIUztv5a0ZOr+A4KCpBOvqft3Bc1A/3C7QhF3ndDsX0AjwFOgWmibKhz2spSk7UKLFKsP+anwgoKffExFFayNGrk7WQpMZ0WUaxQRh6nc60iuFVl/rHnc0XGVzRUOKOOEB9/u3Eex+T2cDMDvfJybSx/EYBOYoX6Qn8sY0aPg9APYVaSCyl9iEgzY+t/ugWPATIvaLhvStCytInwbvfXz6Cxi0gT0odimxw3Sgg9rtd2wptB8tyDdL5nzRbgdwLVwaUCq/gfLCXdTOLDpVpomNZ7a8QHlfDZyoAwBbxKpUaZ2+FZhPEuiQXGAMH351pmOqIHcwWVaavi1TwaGTau1tIJgFzKLJU3GJKgnwC6h0AnxG27Tgi2FxXs2DWrePKuy4dlHnmhgGLHC59Npa0cMTOWhU75wHH7ouCvPlGfJtB1efYXCvmPP9XzrptoRaKs44v7dTgd4I9xWv0IUh27JJHAP/FZkyWo4ITf5cTKtLDTVEgBWovy8ZfJ5OqRJR/ERO43lqb3D2r7ZPnYH/yJytKKEErkpl1QZfxaFXS0751zg1RCa7zVLi5cup1p8GqbnaDstWRSs+Q8zMqKiLVd9ezomDmSTs9J6St25Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f193f1f0-bef8-4c24-5bfc-08d86c8e3b32
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 20:02:20.8511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SciGPg4tyE2owgMrsD2OIcIDYeEO3NeqEB+1dLx6q6pBm0tITkBRRd9f/LVTdiO7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4859
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

Add Maintainers for AMD SFH(SENSOR FUSION HUB) Solution and work flow
document.

Co-developed-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
 Documentation/hid/amd-sfh-hid.rst | 145 ++++++++++++++++++++++++++++++
 Documentation/hid/index.rst       |   1 +
 MAINTAINERS                       |   8 ++
 3 files changed, 154 insertions(+)
 create mode 100644 Documentation/hid/amd-sfh-hid.rst

diff --git a/Documentation/hid/amd-sfh-hid.rst b/Documentation/hid/amd-sfh-hid.rst
new file mode 100644
index 000000000000..1f2fe29ccd4f
--- /dev/null
+++ b/Documentation/hid/amd-sfh-hid.rst
@@ -0,0 +1,145 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+
+AMD Sensor Fusion Hub
+=====================
+AMD Sensor Fusion Hub (SFH) is part of an SOC starting from Ryzen based platforms.
+The solution is working well on several OEM products. AMD SFH uses HID over PCIe bus.
+In terms of architecture it resembles ISH, however the major difference is all
+the HID reports are generated as part of the kernel driver.
+
+1. Block Diagram
+================
+
+::
+
+	---------------------------------
+	|  HID User Space Applications  |
+	- -------------------------------
+
+    ---------------------------------------------
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
+	|     AMD MP2 PCIe Driver        |
+	 --------------------------------
+    OS
+    ---------------------------------------------
+    Hardware + Firmware
+         --------------------------------
+         |     SFH MP2 Processor         |
+         --------------------------------
+
+
+AMD HID Transport Layer
+-----------------------
+AMD SFH transport is also implemented as a bus. Each client application executing in the AMD MP2 is
+registered as a device on this bus. Here: MP2 which is an ARM core connected to x86 for processing
+sensor data. The layer, which binds each device (AMD SFH HID driver) identifies the device type and
+registers with the hid core. Transport layer attach a constant "struct hid_ll_driver" object with
+each device. Once a device is registered with HID core, the callbacks provided via this struct are
+used by HID core to communicate with the device. AMD HID Transport layer implements the synchronous calls.
+
+AMD HID Client Layer
+--------------------
+This layer is responsible to implement HID request and descriptors. As firmware is OS agnostic, HID
+client layer fills the HID request structure and descriptors. HID client layer is complex as it is
+interface between MP2 PCIe layer and HID. HID client layer initialized the MP2 PCIe layer and holds
+the instance of MP2 layer. It identifies the number of sensors connected using MP2-PCIe layer. Base
+on that allocates the DRAM address for each and every sensor and pass it to MP2-PCIe driver.On
+enumeration of each the sensor, client layer fills the HID Descriptor structure and HID input repor
+structure. HID Feature report structure is optional. The report descriptor structure varies from
+sensor to sensor.
+
+AMD MP2 PCIe layer
+------------------
+MP2 PCIe Layer is responsible for making all transactions with the firmware over PCIe.
+The connection establishment between firmware and PCIe happens here.
+
+The communication between X86 and MP2 is split into three parts.
+1. Command transfer via the C2P mailbox registers.
+2. Data transfer via DRAM.
+3. Supported sensor info via P2C registers.
+
+Commands are sent to MP2 using C2P Mailbox registers. Writing into C2P Message registers generate
+interrupt to MP2. The client layer allocates the physical memory and the same is sent to MP2 via
+the PCI layer. MP2 firmware writes the command output to the access DRAM memory which the client
+layer has allocated. Firmware always writes minimum of 32 bytes into DRAM. So as a protocol driver
+shall allocate minimum of 32 bytes DRAM space.
+
+Enumeration and Probing flow
+----------------------------
+::
+
+       HID             AMD            AMD                       AMD -PCIe             MP2
+       Core         Transport      Client layer                   layer                FW
+        |		|	       |                           |                 |
+        |		|              |                 on Boot Driver Loaded       |
+        |		|	       |                           |                 |
+        |		|	       |                        MP2-PCIe Int         |
+        |		|              |			   |                 |
+        |		|	       |---Get Number of sensors-> |                 |
+        |		|              |                       Read P2C              |
+        |		|	       |			Register             |
+        |		|              |                           |                 |
+        |               |              | Loop(for No of Sensors)   |                 |
+        |		|	       |----------------------|    |                 |
+        |		|              | Create HID Descriptor|    |                 |
+        |		|	       | Create Input  report |    |                 |
+        |		|              |  Descriptor Map      |    |                 |
+        |		|	       |  the MP2 FW Index to |    |                 |
+        |		|              |   HID Index          |    |                 |
+        |		|	       | Allocate the DRAM    |  Enable              |
+        |		|	       |	address       |  Sensors             |
+        |		|              |----------------------|    |                 |
+        |		| HID transport|                           |    Enable       |
+        |	        |<--Probe------|                           |---Sensor CMD--> |
+        |		| Create the   |			   |                 |
+        |		| HID device   |                           |                 |
+        |               |    (MFD)     |                           |                 |
+        |		| by Populating|			   |                 |
+        |               |  the HID     |                           |                 |
+        |               |  ll_driver   |                           |                 |
+        | HID           |	       |			   |                 |
+        |  add          |              |                           |                 |
+        |Device         |              |                           |                 |
+        |<------------- |	       |			   |                 |
+
+
+Data Flow from Application to the AMD SFH Driver
+------------------------------------------------
+
+::
+
+	        |	       |              |	  	 	          |		    |
+                |	       |	      |			          |                 |
+                |	       |	      |			          |                 |
+                |              |              |                           |                 |
+                |              |              |                           |                 |
+                |HID_req       |              |                           |                 |
+                |get_report    |              |                           |                 |
+                |------------->|              |                           |                 |
+	        |              | HID_get_input|                           |                 |
+	        |              |  report      |                           |                 |
+	        |              |------------->|------------------------|  |                 |
+	        |              |              |  Read the DRAM data for|  |                 |
+	        |              |              |  requested sensor and  |  |                 |
+	        |              |              |  create the HID input  |  |                 |
+	        |              |              |  report                |  |                 |
+	        |              |              |------------------------|  |                 |
+	        |              |Data received |                           |                 |
+	        |              | in HID report|                           |                 |
+    To	        |<-------------|<-------------|                           |                 |
+    Applications|              |              |                           |                 |
+        <-------|              |              |                           |                 |
diff --git a/Documentation/hid/index.rst b/Documentation/hid/index.rst
index 737d66dc16a1..e50f513c579c 100644
--- a/Documentation/hid/index.rst
+++ b/Documentation/hid/index.rst
@@ -16,3 +16,4 @@ Human Interface Devices (HID)
 
    hid-alps
    intel-ish-hid
+   amd-sfh-hid
diff --git a/MAINTAINERS b/MAINTAINERS
index 0d0862b19ce5..a3d3115939b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -943,6 +943,14 @@ S:	Supported
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

