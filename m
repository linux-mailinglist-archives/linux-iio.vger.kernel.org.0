Return-Path: <linux-iio+bounces-23760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAD0B451D8
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 10:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9088D1C81A62
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EEF3054D6;
	Fri,  5 Sep 2025 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OvcgfjhX"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F64280337;
	Fri,  5 Sep 2025 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061752; cv=fail; b=DXCQZjjrmGJEWlfd0ZzTV0+bZLTi60S24+i+Dw/9SvC2gWvzT7GYVts5R+7+3cUYc5FV1WQzWSfN1oagM3OriRI6curR8APzJf1ONLUKC6L0udvwTSEnXLKqws7riPscAheVEMHRTXx3U4dxFlpClx5SwljHCmQo9IA/PswMsyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061752; c=relaxed/simple;
	bh=DF/yuYoFujCJRkydvsNVVVonVgbTGo7eQRouTPsDXzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C12UzwvQLBOg+6taNk2YlnvzpEPOsL1yxb2Bdp78vZ1KUhlFQuIQ4BWA7ab8fUjY3zsb8A+unzQGLsoOd63mEfmZRfh5/slegtsRKHQOJSH9TlOZ9Slf3A5foOb+YuQeWVjaGHrLOCivIEwa2zjyA/TUzyEQzJ/LRb6RWCRn3EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OvcgfjhX; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/PO36vhfPr2MH5tCsC0Jo3Xj1g/wjQnxx8gMtku4OHPHWOkJRzAojMwHsxpmspxix4GGFbBAW4DEPun5UcqlkKX8M51NEDvD1F8BiQuBtbzNNq8GXK5xiTxrsk7TrI47K2ND/FdmMPydJqBNerKAhUP79gWFtlGkiO/YUaQcI5Ki/3Nych7D8GsbftWpVk5JI1aER3eFWI7CjVEXnjL4oBJ6io5F/hcVsYd9j7R3RDrvE0eFi++wDw85SBMTfeY5K18vPzxX6Ql9UcZeBvYgohekoV3a5FDxbTwQrC6hKbjsfvXEZqgW1PBgrCITd3PWdjeoykuxygoMkOnPpJ9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wApK5aA2rXU2dc+sa4VQ12BEggcCX1b1J5SLPbSn5ME=;
 b=GEODXR1NFW5pGd0dDf8UG+adv2Dwhofu9fWgEanQigq8IEqRkkDRsdkYxRUZLMj+f7iIG0+9meM65Rl9vIPpDbnf7ItDW8NctU9v5M94GoaN0oVUG+QxxsEB7vHEn//z3KqDjBxAxxW3Lt9O1o+WxeHpH2mNrRskAjDJH6SWlNmE2vWqyhNHZWfS44iUZtU8F5BOeJyYOc4WwSseGuh8cVH45l5Q59RZDMXq9dV0fPCVfj2k3FRsWK5IZi7yG6FoIMkbpOTAZm4y1QA64G3N1LF2VZX3e6jY2uZ2zqUoyWRk0ATCinxL3TBkRlvbOejodo3dgsqOOlOOC1FBbPa2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wApK5aA2rXU2dc+sa4VQ12BEggcCX1b1J5SLPbSn5ME=;
 b=OvcgfjhXEgqcFSizHpNFoesTOcNzZqrMRfIDxxsUY3OCi3ifBKHj8Ka/6c3Trk83twuM4JTHEmZ0X4aMAQVHiuFYHs62v1tGWATXPvkEwnU+NCHM3VpBInr52Furd63aLVm6Rt9OQTKLlDpOzIuH8o3R54X5lcCcTKgrtFf5oRA=
Received: from SJ0PR13CA0057.namprd13.prod.outlook.com (2603:10b6:a03:2c2::32)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 08:42:23 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::3a) by SJ0PR13CA0057.outlook.office365.com
 (2603:10b6:a03:2c2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.6 via Frontend Transport; Fri, 5
 Sep 2025 08:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 08:42:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 03:42:05 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 03:42:04 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Salih Erim <salih.erim@amd.com>, Anand Ashok Dumbre
	<anand.ashok.dumbre@xilinx.com>, Andy Shevchenko <andy@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>, "open list:IIO SUBSYSTEM AND
 DRIVERS" <linux-iio@vger.kernel.org>
Subject: [PATCH 2/6] iio: versal-sysmon: add driver for Versal Sysmon
Date: Fri, 5 Sep 2025 10:41:45 +0200
Message-ID: <2780986977702f126416ec442c5336bd541f475b.1757061697.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757061697.git.michal.simek@amd.com>
References: <cover.1757061697.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=61112; i=michal.simek@amd.com; h=from:subject:message-id; bh=vd/A2w/i51GYHy2uTWwv8Jr47QawunMHtWZTiIzKyeE=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTsWuS7hf2MA/+D3felpR5xxZtaTlBlnWOc/0BgXve32 vgUjYfaHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjAR4wKGPxz/ZZ8nWpT6mCfp ZS8J+fi34KL38YO7m6XPfnzytv3DETlGhjVeCYViBqoaqsLHhNR+bq5R3z1h6dY+x2slsl+trPu ecwMA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d2ef55-0cca-4746-19b0-08ddec582273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B9HLng7x3deUyo37gM+vvwtJOHAjylzxlnM6GkwwQECJz2J+6R+/3XBN0y1X?=
 =?us-ascii?Q?yATmcgWktLNqa33m+zdGDQiCLQTMvGBtvd+jdtOZENMv2k4KXUiXQdIlI9dD?=
 =?us-ascii?Q?694a6dfC/bdhw3NUEJuJ4NW9blw5K99tbSdtRzps5erKQy3yHBNWv5+ECrwh?=
 =?us-ascii?Q?qflsgH7NWDXOl9rY6WO771ExToLyfz9w0OGaZkhHwUnN3cFTQDhHzobvFYXr?=
 =?us-ascii?Q?3Isc+Q/K1Eg291brb7/mlOd6FwpQDpNE+rwRTDusXDDZ5Fde0Eq9sUAmkcp1?=
 =?us-ascii?Q?6fTnjNkOM8Sp/JMz2wEt4ZtoZaGHBbg0FRei1+X4uXFnu8dUFbssJTg28z8m?=
 =?us-ascii?Q?2Ct8lFHfqFeEesvBOSRceVt66o1B8S7Pu+wbTEnU6kw4k9FpSvy+Ycucnipx?=
 =?us-ascii?Q?LHsKH7AJZi2Xq8p4ys7axoqtRB1TO+lhfaURYWo2SGHMUtkM9ye1YZquBrZa?=
 =?us-ascii?Q?EcfdUBmGikNccpZsQIUvPQreEO2owGHMRLaRHCUhr+surVJlWAC3ZscVFOJX?=
 =?us-ascii?Q?HimXvOJiLk26WKUCD0n5z7gjGkJ31cKzDqOZ58I78bS/5GA01iGPc8fXgghs?=
 =?us-ascii?Q?gm4Y3DAQ+KRbY/pd/5SdSjkLOWn3tAGa8JEWXAaynEuFLwztw0NiYgEWnmbY?=
 =?us-ascii?Q?hrBE43JGGKOc9Sfa8DpmOtfp3Jsw7sbrrnHsc5F99NPkiCDZ0E0dVazD61/Y?=
 =?us-ascii?Q?0KV2jzUfrsG0VjSg8XCbk3eiRjV895Tct96N02R4PVvHo0UltSYJ5V3eVs1C?=
 =?us-ascii?Q?eMKJVb2DDsSHgLixpHDkmwZTGA7ux6RupCkKxccblXY+2yE6P/2ipLl2rYxH?=
 =?us-ascii?Q?BGT3Pgo3QpNhz4nyBp6CbIapC/I2yUH2+9vX7T/hIoriZsWBxfPVwUTcKzZ9?=
 =?us-ascii?Q?uCNIvRmBMbFNz/XATfo2+QgaUOuy7F7ebNUNtGFneqqLJabnUoETdWhU7cFo?=
 =?us-ascii?Q?YXvqEfjGaiZZ5Sa9gLEh/fK+Kziuy/6QQJrV/ztRQRBlKm69MbpOzV2E2Xp7?=
 =?us-ascii?Q?itS+akz2CA33zIC8tki6EjvD5E25V6CkjQF8Xx3xn3Ni+rA00yxw7oT0eCPv?=
 =?us-ascii?Q?yoZiVt7FLpn4LAOzMPl722w7sNzOk8MyuLd5LPOZtnaul6cGmIls+OGlhyxQ?=
 =?us-ascii?Q?C1MN88l8NmI4G1aCRNLMER6aogyXrhnOYN2thiTXA4H4+cgtdN5vZLLAhyBu?=
 =?us-ascii?Q?7und5OB7S43IgQv+x0tIbUOAkYgxrAN+7rheYfdDsKR6kUq86l3+17yKWZPH?=
 =?us-ascii?Q?4akE0Fm83dTMBjLeV5STMxOHtyZ+z8KBqI0K1QtUAtkxiQ4ek0ZnUctOfYD9?=
 =?us-ascii?Q?WslyyqkOT4esGySR3j1ah99jIoxo7rWfOP+VJ+7vKnbxV8XJFBv5nYrhPayo?=
 =?us-ascii?Q?1432ixppk2abhCfzoZv4uSytc13mvcJmmAtYLDaiTo9oDi9mFbPm34IvFmiJ?=
 =?us-ascii?Q?L0U2Heb/TNWQ1MIM3j0Xgus4fZ6vwmrPiGcOHw4WeHqtvfac+WeCPYaKD2n1?=
 =?us-ascii?Q?Bv1NG6ZIRMkGEVwUrjCSag6uHKS95lo7GZrB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 08:42:23.4367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d2ef55-0cca-4746-19b0-08ddec582273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075

From: Salih Erim <salih.erim@amd.com>

Sysmon Driver uses Linux IIO framework, which was used to abstract the
supply voltages and temperatures across the chip as Voltage and Temperature
Channels in the framework. Since there are only 160 supply voltage
registers and 184 measurement points, there is no constant mapping of
supply voltage registers and the measurement points. User has to select
the voltages to monitor in design tool. Depending on the selection, a
voltage supply gets mapped to one of the supply registers. So, this mapping
information is provided to the driver via a device tree. Depending on the
number of supplies enabled in the design, the device tree will contain the
information of name of the supply enabled and the supply register it maps
to.

Co-developed-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Signed-off-by: Salih Erim <salih.erim@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 MAINTAINERS                                  |    7 +
 drivers/iio/adc/Kconfig                      |   15 +
 drivers/iio/adc/Makefile                     |    2 +
 drivers/iio/adc/versal-sysmon-core.c         | 1334 ++++++++++++++++++
 drivers/iio/adc/versal-sysmon.c              |  264 ++++
 drivers/iio/adc/versal-sysmon.h              |  275 ++++
 include/linux/iio/adc/versal-sysmon-events.h |   56 +
 7 files changed, 1953 insertions(+)
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h
 create mode 100644 include/linux/iio/adc/versal-sysmon-events.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..1a9c5549d0dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27602,6 +27602,13 @@ F:	Documentation/misc-devices/xilinx_sdfec.rst
 F:	drivers/misc/xilinx_sdfec.c
 F:	include/uapi/misc/xilinx_sdfec.h
 
+XILINX VERSAL SYSMON DRIVER
+M:	Salih Erim <salih.erim@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
+F:	drivers/iio/adc/versal-sysmon*
+F:	include/linux/iio/adc/versal-sysmon-events.h
+
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-serial@vger.kernel.org
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6de2abad0197..7021ba4f5f12 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1821,4 +1821,19 @@ config XILINX_AMS
 	  The driver can also be built as a module. If so, the module will be called
 	  xilinx-ams.
 
+config VERSAL_SYSMON_CORE
+	tristate
+
+config VERSAL_SYSMON
+	tristate "Xilinx Sysmon driver for Versal"
+	depends on HAS_IOMEM
+	select VERSAL_SYSMON_CORE
+	help
+	  Say yes here to have support for the Xilinx Sysmon.
+	  The driver will enable users to monitor temperature and voltage on the
+	  Xilinx Versal platform.
+
+	  The driver can also be build as a module. If so, the module will be called
+	  versal-sysmon.
+
 endmenu
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 1c6ca5fd4b6d..2d29c3e60101 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -159,3 +159,5 @@ obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
 obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
 xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
 obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
+obj-$(CONFIG_VERSAL_SYSMON_CORE) += versal-sysmon-core.o
+obj-$(CONFIG_VERSAL_SYSMON) += versal-sysmon.o
diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
new file mode 100644
index 000000000000..21b6a413dccb
--- /dev/null
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -0,0 +1,1334 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx SYSMON for Versal
+ *
+ * Copyright (C) 2019 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
+ *
+ * Description:
+ * This driver is developed for SYSMON on Versal. The driver supports INDIO Mode
+ * and supports voltage and temperature monitoring via IIO sysfs interface and
+ * in kernel event monitoring for some modules.
+ */
+
+#include <linux/bits.h>
+#include "versal-sysmon.h"
+
+#define SYSMON_EVENT_WORK_DELAY_MS	1000
+#define SYSMON_UNMASK_WORK_DELAY_MS	500
+
+#define SYSMON_FRACTIONAL_SHIFT		7U
+
+#define SYSMON_HBM_TEMP_SHIFT	16U
+#define SYSMON_HBM_TEMP_MASK	GENMASK(6, 0)
+
+/* This structure describes temperature events */
+static const struct iio_event_spec sysmon_temp_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate =
+			BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+
+/* This structure describes voltage events */
+static const struct iio_event_spec sysmon_supply_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+/* Temperature channel attributes */
+static const struct iio_chan_spec temp_channels[] = {
+	SYSMON_CHAN_TEMP(TEMP_MAX, "temp"),
+	SYSMON_CHAN_TEMP(TEMP_MIN, "min"),
+	SYSMON_CHAN_TEMP(TEMP_MAX_MAX, "max_max"),
+	SYSMON_CHAN_TEMP(TEMP_MIN_MIN, "min_min"),
+};
+
+/* Temperature event attributes */
+static const struct iio_chan_spec temp_events[] = {
+	SYSMON_CHAN_TEMP_EVENT(TEMP_EVENT, "temp", sysmon_temp_events),
+	SYSMON_CHAN_TEMP_EVENT(OT_EVENT, "ot", sysmon_temp_events),
+};
+
+/* HBM temperature channel attributes */
+static const struct iio_chan_spec temp_hbm_channels[] = {
+	SYSMON_CHAN_TEMP_HBM(TEMP_HBM, "temp_hbm"),
+};
+
+int sysmon_read_reg(struct sysmon *sysmon, u32 offset, u32 *data)
+{
+	return sysmon->ops->read_reg(sysmon, offset, data);
+}
+EXPORT_SYMBOL(sysmon_read_reg);
+
+void sysmon_write_reg(struct sysmon *sysmon, u32 offset, u32 data)
+{
+	sysmon->ops->write_reg(sysmon, offset, data);
+}
+EXPORT_SYMBOL(sysmon_write_reg);
+
+static void sysmon_update_reg(struct sysmon *sysmon, u32 offset, u32 mask, u32 data)
+{
+	sysmon->ops->update_reg(sysmon, offset, mask, data);
+}
+
+static u32 sysmon_temp_offset(int address)
+{
+	switch (address) {
+	case TEMP_MAX:
+		return SYSMON_TEMP_MAX;
+	case TEMP_MIN:
+		return SYSMON_TEMP_MIN;
+	case TEMP_MAX_MAX:
+		return SYSMON_TEMP_MAX_MAX;
+	case TEMP_MIN_MIN:
+		return SYSMON_TEMP_MIN_MIN;
+	case TEMP_HBM:
+		return SYSMON_TEMP_HBM;
+	default:
+		return -EINVAL;
+	}
+	return -EINVAL;
+}
+
+static u32 sysmon_temp_thresh_offset(int address, enum iio_event_direction dir)
+{
+	switch (address) {
+	case TEMP_EVENT:
+		return (dir == IIO_EV_DIR_RISING) ? SYSMON_TEMP_TH_UP :
+						    SYSMON_TEMP_TH_LOW;
+	case OT_EVENT:
+		return (dir == IIO_EV_DIR_RISING) ? SYSMON_OT_TH_UP :
+						    SYSMON_OT_TH_LOW;
+	default:
+		return -EINVAL;
+	}
+	return -EINVAL;
+}
+
+static u32 sysmon_supply_offset(int address)
+{
+	return (address * 4) + SYSMON_SUPPLY_BASE;
+}
+
+static u32 sysmon_supply_thresh_offset(int address,
+				       enum iio_event_direction dir)
+{
+	if (dir == IIO_EV_DIR_RISING)
+		return (address * 4) + SYSMON_SUPPLY_TH_UP;
+	else if (dir == IIO_EV_DIR_FALLING)
+		return (address * 4) + SYSMON_SUPPLY_TH_LOW;
+
+	return -EINVAL;
+}
+
+/**
+ * sysmon_hbm_to_millicelsius() - The raw register value to milliDeg Celsius.
+ * @raw_data: Raw register value
+ * @val: The numerator of the fraction needed by IIO_VAL_INT
+ * @val2: Denominator of the fraction needed by IIO_VAL_INT
+ *
+ * The function returns a fraction which returns milliDeg celsius
+ */
+static void sysmon_hbm_to_millicelsius(int raw_data, int *val, int *val2)
+{
+	*val = ((raw_data >> SYSMON_HBM_TEMP_SHIFT) & SYSMON_HBM_TEMP_MASK) *
+		SYSMON_MILLI_SCALE;
+	*val2 = 0;
+}
+
+/**
+ * sysmon_q8p7_to_millicelsius() - converts fixed point Q8.7 format to a fraction.
+ * @raw_data: Raw ADC value
+ * @val: The numerator of the fraction needed by IIO_VAL_INT
+ * @val2: Denominator of the fraction needed by IIO_VAL_INT
+ *
+ * The function returns a fraction which returns milliDeg Celsius
+ */
+static void sysmon_q8p7_to_millicelsius(int raw_data, int *val, int *val2)
+{
+	*val = (((raw_data & 0x8000) ? -(twoscomp(raw_data)) : raw_data) *
+		SYSMON_MILLI_SCALE) >> SYSMON_FRACTIONAL_SHIFT;
+	*val2 = 0;
+}
+
+/**
+ * sysmon_millicelsius_to_q8p7() - converts value from IIO Framework to ADC Raw data
+ * @raw_data: Raw ADC value
+ * @val: The numerator of the fraction provided by the IIO Framework
+ * @val2: Denominator of the fraction provided by the IIO Framework
+ *
+ * The function takes in exponent and mantissa as val and val2 respectively
+ * of temperature value in milliDeg Celsius and returns raw adc value for the
+ * given temperature.
+ */
+static void sysmon_millicelsius_to_q8p7(u32 *raw_data, int val, int val2)
+{
+	(void)val2;
+
+	*raw_data = (val << SYSMON_FRACTIONAL_SHIFT) / SYSMON_MILLI_SCALE;
+}
+
+static void sysmon_supply_rawtoprocessed(int raw_data, int *val, int *val2)
+{
+	int mantissa, format, exponent;
+
+	mantissa = raw_data & SYSMON_MANTISSA_MASK;
+	exponent = 16 - ((raw_data & SYSMON_MODE_MASK) >> SYSMON_MODE_SHIFT);
+	format = (raw_data & SYSMON_FMT_MASK) >> SYSMON_FMT_SHIFT;
+
+	if (format && (mantissa >> SYSMON_MANTISSA_SIGN_SHIFT)) {
+		*val = ((~(mantissa) & SYSMON_MANTISSA_MASK) *
+			(-1 * SYSMON_MILLI_SCALE)) >> exponent;
+	} else {
+		*val = (mantissa * SYSMON_MILLI_SCALE) >> exponent;
+	}
+
+	*val2 = 0;
+}
+
+static void sysmon_supply_processedtoraw(int val, int val2, u32 reg_val,
+					 u32 *raw_data)
+{
+	int exponent = (reg_val & SYSMON_MODE_MASK) >> SYSMON_MODE_SHIFT;
+	int format = (reg_val & SYSMON_FMT_MASK) >> SYSMON_FMT_SHIFT;
+	int scale = 1 << (16 - exponent);
+	int tmp;
+
+	tmp = (val * scale) / SYSMON_MILLI_SCALE;
+
+	/* Set out of bound values to saturation levels */
+	if (format) {
+		if (tmp > SYSMON_UPPER_SATURATION_SIGNED)
+			tmp = 0x7fff;
+		else if (tmp < SYSMON_LOWER_SATURATION_SIGNED)
+			tmp = 0x8000;
+
+	} else {
+		if (tmp > SYSMON_UPPER_SATURATION)
+			tmp = 0xffff;
+		else if (tmp < SYSMON_LOWER_SATURATION)
+			tmp = 0x0000;
+	}
+
+	*raw_data = tmp & 0xffff;
+}
+
+static int sysmon_osr_write(struct sysmon *sysmon,
+			    int channel_type, int val)
+{
+	u32 mask, shift;
+
+	if (channel_type == IIO_TEMP) {
+		mask = SYSMON_TEMP_SAT_CONFIG_MASK;
+		shift = SYSMON_TEMP_SAT_CONFIG_SHIFT;
+	} else if (channel_type == IIO_VOLTAGE) {
+		mask = SYSMON_SUPPLY_CONFIG_MASK;
+		shift = SYSMON_SUPPLY_CONFIG_SHIFT;
+	} else {
+		return -EINVAL;
+	}
+
+	sysmon_update_reg(sysmon, SYSMON_CONFIG, mask, (val << shift));
+
+	return 0;
+}
+
+static int sysmon_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	u32 offset, regval;
+	u32 ret = -EINVAL;
+
+	mutex_lock(&sysmon->mutex);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_TEMP:
+			offset = sysmon_temp_offset(chan->address);
+			*val = sysmon->temp_read(sysmon, offset);
+			*val2 = 0;
+			ret = IIO_VAL_INT;
+			break;
+
+		case IIO_VOLTAGE:
+			offset = sysmon_supply_offset(chan->address);
+			sysmon_read_reg(sysmon, offset, &regval);
+			*val = (int)regval;
+			*val2 = 0;
+			ret = IIO_VAL_INT;
+			break;
+
+		default:
+			break;
+		}
+		break;
+
+	case IIO_CHAN_INFO_PROCESSED:
+		switch (chan->type) {
+		case IIO_TEMP:
+			/* In Deg C */
+			offset = sysmon_temp_offset(chan->address);
+			regval = sysmon->temp_read(sysmon, offset);
+			if (!sysmon->hbm_slr)
+				sysmon_q8p7_to_millicelsius(regval, val, val2);
+			else
+				sysmon_hbm_to_millicelsius(regval, val, val2);
+
+			ret = IIO_VAL_INT;
+			break;
+
+		case IIO_VOLTAGE:
+			/* In Volts */
+			offset = sysmon_supply_offset(chan->address);
+			sysmon_read_reg(sysmon, offset, &regval);
+			sysmon_supply_rawtoprocessed(regval, val, val2);
+			ret = IIO_VAL_INT;
+			break;
+
+		default:
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = sysmon->temp_oversampling;
+			ret = IIO_VAL_INT;
+			break;
+
+		case IIO_VOLTAGE:
+			*val = sysmon->supply_oversampling;
+			ret = IIO_VAL_INT;
+			break;
+
+		default:
+			break;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	mutex_unlock(&sysmon->mutex);
+	return ret;
+}
+
+static int sysmon_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	u32 ret = -EINVAL;
+	int i;
+
+	mutex_lock(&sysmon->mutex);
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		if (val2 != 0)
+			break;
+
+		switch (chan->type) {
+		case IIO_TEMP:
+			for (i = 0; i < sysmon->oversampling_num; i++) {
+				if (val == sysmon->oversampling_avail[i]) {
+					ret = sysmon_osr_write(sysmon,
+							       IIO_TEMP, val);
+					if (!ret)
+						sysmon->temp_oversampling = val;
+				}
+			}
+			break;
+
+		case IIO_VOLTAGE:
+			for (i = 0; i < sysmon->oversampling_num; i++) {
+				if (val == sysmon->oversampling_avail[i]) {
+					ret = sysmon_osr_write(sysmon,
+							       IIO_VOLTAGE, val);
+					if (!ret)
+						sysmon->supply_oversampling = val;
+				}
+			}
+			break;
+
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&sysmon->mutex);
+	return ret;
+}
+
+static int sysmon_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	struct sysmon *sysmon;
+
+	if (mask != IIO_CHAN_INFO_OVERSAMPLING_RATIO)
+		return -EINVAL;
+
+	sysmon = iio_priv(indio_dev);
+
+	*vals = sysmon->oversampling_avail;
+	*length = sysmon->oversampling_num;
+	*type = IIO_VAL_INT;
+
+	return IIO_AVAIL_LIST;
+}
+
+static int sysmon_get_event_mask(unsigned long address)
+{
+	if (address == TEMP_EVENT)
+		return BIT(SYSMON_BIT_TEMP);
+	else if (address == OT_EVENT)
+		return BIT(SYSMON_BIT_OT);
+
+	/* return supply */
+	return BIT(address / 32);
+}
+
+static int sysmon_read_alarm_config(struct sysmon *sysmon,
+				    unsigned long address)
+{
+	u32 reg_val;
+	u32 shift = REG32_SHIFT(address);
+	u32 offset = SYSMON_ALARM_REG + REG32_OFFSET(address);
+
+	sysmon_read_reg(sysmon, offset, &reg_val);
+
+	return reg_val & BIT(shift);
+}
+
+static void sysmon_write_alarm_config(struct sysmon *sysmon,
+				      unsigned long address, u32 val)
+{
+	u32 shift = REG32_SHIFT(address);
+	u32 offset = SYSMON_ALARM_REG + REG32_OFFSET(address);
+
+	sysmon_update_reg(sysmon, offset, BIT(shift), (val << shift));
+}
+
+static int sysmon_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	u32 config_value, imr;
+	u32 alarm_event_mask = sysmon_get_event_mask(chan->address);
+
+	sysmon_read_reg(sysmon, SYSMON_IMR, &imr);
+
+	/* Getting the unmasked interrupts */
+	imr = ~imr;
+
+	if (chan->type == IIO_VOLTAGE) {
+		config_value = sysmon_read_alarm_config(sysmon, chan->address);
+
+		return (config_value && (imr & alarm_event_mask));
+	}
+
+	return (imr & sysmon_get_event_mask(chan->address)) ? 1 : 0;
+}
+
+static int sysmon_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir, bool state)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	u32 offset = SYSMON_ALARM_REG + REG32_OFFSET(chan->address);
+	u32 shift = REG32_SHIFT(chan->address);
+	u32 ier = sysmon_get_event_mask(chan->address);
+	u32 alarm_config;
+	unsigned long flags;
+
+	mutex_lock(&sysmon->mutex);
+	spin_lock_irqsave(&sysmon->lock, flags);
+
+	if (chan->type == IIO_VOLTAGE) {
+		sysmon_write_alarm_config(sysmon, chan->address, state);
+
+		sysmon_read_reg(sysmon, offset, &alarm_config);
+
+		if (alarm_config & BIT(shift))
+			sysmon_write_reg(sysmon, SYSMON_IER, ier);
+		else
+			sysmon_write_reg(sysmon, SYSMON_IDR, ier);
+	} else if (chan->type == IIO_TEMP) {
+		if (state) {
+			sysmon_write_reg(sysmon, SYSMON_IER, ier);
+			sysmon->temp_mask &= ~ier;
+		} else {
+			sysmon_write_reg(sysmon, SYSMON_IDR, ier);
+			sysmon->temp_mask |= ier;
+		}
+	}
+
+	spin_unlock_irqrestore(&sysmon->lock, flags);
+	mutex_unlock(&sysmon->mutex);
+
+	return 0;
+}
+
+static int sysmon_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info, int *val,
+				   int *val2)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	u32 offset, reg_val;
+	u32 mask, shift;
+	u32 ret = -EINVAL;
+
+	mutex_lock(&sysmon->mutex);
+	if (chan->type == IIO_TEMP) {
+		if (info == IIO_EV_INFO_VALUE) {
+			offset = sysmon_temp_thresh_offset(chan->address, dir);
+			sysmon_read_reg(sysmon, offset, &reg_val);
+			sysmon_q8p7_to_millicelsius(reg_val, val, val2);
+			ret = IIO_VAL_INT;
+		} else if (info == IIO_EV_INFO_HYSTERESIS) {
+			mask = (chan->address == OT_EVENT) ? 0x1 : 0x2;
+			shift = mask - 1;
+			sysmon_read_reg(sysmon, SYSMON_TEMP_EV_CFG, &reg_val);
+			*val = (reg_val & mask) >> shift;
+			*val2 = 0;
+			ret = IIO_VAL_INT;
+		}
+	} else if (chan->type == IIO_VOLTAGE) {
+		offset = sysmon_supply_thresh_offset(chan->address, dir);
+		sysmon_read_reg(sysmon, offset, &reg_val);
+		sysmon_supply_rawtoprocessed(reg_val, val, val2);
+		ret = IIO_VAL_INT;
+	}
+
+	mutex_unlock(&sysmon->mutex);
+	return ret;
+}
+
+static int sysmon_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int val, int val2)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	u32 offset, raw_val, reg_val;
+	u32 mask, shift;
+
+	mutex_lock(&sysmon->mutex);
+	if (chan->type == IIO_TEMP) {
+		if (info == IIO_EV_INFO_VALUE) {
+			offset = sysmon_temp_thresh_offset(chan->address, dir);
+			sysmon_millicelsius_to_q8p7(&reg_val, val, val2);
+			sysmon_write_reg(sysmon, offset, reg_val);
+		} else if (info == IIO_EV_INFO_HYSTERESIS) {
+			/* calculating the mask value for OT and TEMP Alarms */
+			mask = (chan->address == OT_EVENT) ? 1 : 2;
+			shift = mask - 1;
+			sysmon_update_reg(sysmon, SYSMON_TEMP_EV_CFG, mask,
+					  (val << shift));
+		}
+	} else if (chan->type == IIO_VOLTAGE) {
+		offset = sysmon_supply_thresh_offset(chan->address, dir);
+		sysmon_read_reg(sysmon, offset, &reg_val);
+		sysmon_supply_processedtoraw(val, val2, reg_val, &raw_val);
+		sysmon_write_reg(sysmon, offset, raw_val);
+	}
+
+	mutex_unlock(&sysmon->mutex);
+	return 0;
+}
+
+static ssize_t supply_avg_en_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	int supply = this_attr->address;
+	u32 shift = REG32_SHIFT(supply);
+	u32 offset, reg_val;
+
+	offset = SYSMON_SUPPLY_EN_AVG_OFFSET + REG32_OFFSET(supply);
+	sysmon_read_reg(sysmon, offset, &reg_val);
+
+	/* Return the bit state */
+	return sprintf(buf, "%u\n", !!(reg_val & BIT(shift)));
+}
+
+static ssize_t tempsat_avg_en_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	int tempsat = this_attr->address;
+	u32 shift = REG32_SHIFT(tempsat);
+	u32 offset, reg_val;
+
+	offset = SYSMON_TEMP_SAT_EN_AVG_OFFSET + REG32_OFFSET(tempsat);
+	sysmon_read_reg(sysmon, offset, &reg_val);
+
+	/* Return the bit state */
+	return sprintf(buf, "%u\n", !!(reg_val & BIT(shift)));
+}
+
+static ssize_t supply_avg_en_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	int supply = this_attr->address;
+	u32 shift = REG32_SHIFT(supply);
+	unsigned long val;
+	u32 offset;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	/* Ensure the input value is either 0 or 1 */
+	val = !!val;
+
+	offset = SYSMON_SUPPLY_EN_AVG_OFFSET + REG32_OFFSET(supply);
+	sysmon_update_reg(sysmon, offset, BIT(shift), (val << shift));
+
+	return len;
+}
+
+static ssize_t tempsat_avg_en_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	int tempsat = this_attr->address;
+	u32 shift = REG32_SHIFT(tempsat);
+	unsigned long val;
+	u32 offset;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	/* Ensure the input value is either 0 or 1 */
+	val = !!val;
+
+	offset = SYSMON_TEMP_SAT_EN_AVG_OFFSET + REG32_OFFSET(tempsat);
+	sysmon_update_reg(sysmon, offset, BIT(shift), (val << shift));
+
+	return len;
+}
+
+static const struct iio_info iio_dev_info = {
+	.read_avail = sysmon_read_avail,
+	.read_raw = sysmon_read_raw,
+	.write_raw = sysmon_write_raw,
+	.read_event_config = sysmon_read_event_config,
+	.write_event_config = sysmon_write_event_config,
+	.read_event_value = sysmon_read_event_value,
+	.write_event_value = sysmon_write_event_value,
+};
+
+/* sysmon instance for in kernel exported functions */
+static struct sysmon *g_sysmon;
+
+void sysmon_set_iio_dev_info(struct iio_dev *indio_dev)
+{
+	indio_dev->info = &iio_dev_info;
+}
+EXPORT_SYMBOL(sysmon_set_iio_dev_info);
+/**
+ * sysmon_register_temp_ops - register temperature based event handler for a
+ *				given region.
+ * @cb: callback function pointer.
+ * @data: private data to be passed to the callback.
+ * @region_id: id of the region for which the callback is to be set.
+ * @return: 0 for success and negative number in case of failure.
+ */
+int sysmon_register_temp_ops(void (*cb)(void *data, struct regional_node *node),
+			     void *data, enum sysmon_region region_id)
+{
+	struct sysmon *sysmon = g_sysmon;
+	struct region_info *region;
+	int ret = 0, found = 0;
+
+	if (!cb || !sysmon)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&sysmon->mutex);
+	if (ret) {
+		dev_err(sysmon->dev, "Failed to acquire a lock. Process was interrupted by fatal signals");
+		return ret;
+	}
+
+	if (list_empty(&sysmon->region_list)) {
+		dev_err(sysmon->dev, "Failed to set a callback. HW node info missing in the device tree/ Not supported for this device");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	list_for_each_entry(region, &sysmon->region_list, list) {
+		if (region->id == region_id) {
+			found = 1;
+			if (region->cb) {
+				dev_err(sysmon->dev, "Error callback already set. Unregister the existing callback to set a new one.");
+				ret = -EINVAL;
+				goto exit;
+			}
+			region->cb = cb;
+			region->data = data;
+			break;
+		}
+	}
+
+	if (!found) {
+		dev_err(sysmon->dev, "Error invalid region. Please select the correct region");
+		ret = -EINVAL;
+	}
+
+exit:
+	mutex_unlock(&sysmon->mutex);
+	return ret;
+}
+EXPORT_SYMBOL(sysmon_register_temp_ops);
+
+/**
+ * sysmon_unregister_temp_ops - Unregister the callback for temperature
+ *				notification.
+ * @region_id: id of the region for which the callback is to be set.
+ * @return: 0 for success and negative number in case of failure.
+ */
+int sysmon_unregister_temp_ops(enum sysmon_region region_id)
+{
+	struct sysmon *sysmon = g_sysmon;
+	struct region_info *region;
+	int ret = 0, found = 0;
+
+	if (!sysmon)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&sysmon->mutex);
+	if (ret) {
+		dev_err(sysmon->dev, "Failed to acquire a lock. Process was interrupted by fatal signals");
+		return ret;
+	}
+
+	if (list_empty(&sysmon->region_list)) {
+		dev_err(sysmon->dev, "Failed to set a callback. HW node info missing in the device tree/ Not supported for this device");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	list_for_each_entry(region, &sysmon->region_list, list) {
+		if (region->id == region_id) {
+			found = 1;
+			region->cb = NULL;
+			region->data = NULL;
+			break;
+		}
+	}
+
+	if (!found) {
+		dev_err(sysmon->dev, "Error no such region. Please select the correct region");
+		ret = -EINVAL;
+	}
+
+exit:
+	mutex_unlock(&sysmon->mutex);
+	return ret;
+}
+EXPORT_SYMBOL(sysmon_unregister_temp_ops);
+
+/**
+ * sysmon_nodes_by_region - returns the nodes list for a particular region.
+ * @region_id: id for the region for which nodes are requested.
+ * @return: Pointer to the linked list or NULL if region is not present.
+ */
+struct list_head *sysmon_nodes_by_region(enum sysmon_region region_id)
+{
+	struct sysmon *sysmon = g_sysmon;
+	struct region_info *region;
+
+	if (!sysmon)
+		return NULL;
+
+	list_for_each_entry(region, &sysmon->region_list, list) {
+		if (region->id == region_id)
+			return &region->node_list;
+	}
+
+	dev_err(sysmon->dev, "Error invalid region. Please select the correct region");
+
+	return NULL;
+}
+EXPORT_SYMBOL(sysmon_nodes_by_region);
+
+/**
+ * sysmon_get_node_value - returns value of the sensor at a node.
+ * @sat_id: id of the node.
+ * @return: -EINVAL if not initialized or returns raw value of the sensor.
+ */
+int sysmon_get_node_value(int sat_id)
+{
+	struct sysmon *sysmon = g_sysmon;
+	u32 raw;
+
+	if (!sysmon)
+		return -EINVAL;
+
+	sysmon_read_reg(sysmon, SYSMON_NODE_OFFSET, &raw);
+
+	return raw;
+}
+EXPORT_SYMBOL(sysmon_get_node_value);
+
+static void sysmon_push_event(struct iio_dev *indio_dev, u32 address)
+{
+	u32 i;
+	const struct iio_chan_spec *chan;
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		if (indio_dev->channels[i].address == address) {
+			chan = &indio_dev->channels[i];
+			iio_push_event(indio_dev,
+				       IIO_UNMOD_EVENT_CODE(chan->type,
+							    chan->channel,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_EITHER),
+				       iio_get_time_ns(indio_dev));
+		}
+	}
+}
+
+int sysmon_create_avg_en_sysfs_entries(struct iio_dev *indio_dev)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	int max_attrs_num, ret, i;
+	u8 supply_index;
+
+	/* Allocate memory for temp. sat attribute list dynamically */
+	sysmon->temp_avg_en_attrs =
+		devm_kzalloc(&indio_dev->dev,
+			     SYSMON_TEMP_SAT_COUNT *
+			     sizeof(*sysmon->temp_avg_en_attrs), GFP_KERNEL);
+	if (!sysmon->temp_avg_en_attrs)
+		return -ENOMEM;
+
+	/* Allocate memory for supply attribute list dynamically */
+	sysmon->supply_avg_en_attrs =
+		devm_kzalloc(&indio_dev->dev,
+			     sysmon->num_supply_chan *
+			     sizeof(*sysmon->supply_avg_en_attrs), GFP_KERNEL);
+	if (!sysmon->supply_avg_en_attrs)
+		return -ENOMEM;
+
+	/*
+	 * Maximum attribute number is max temp. satellite number plus
+	 * enabled supply channel number.
+	 */
+	max_attrs_num = SYSMON_TEMP_SAT_COUNT + sysmon->num_supply_chan;
+
+	sysmon->avg_attrs = devm_kzalloc(&indio_dev->dev,
+					 (max_attrs_num + 1) *
+					 sizeof(*sysmon->avg_attrs), GFP_KERNEL);
+	if (!sysmon->avg_attrs)
+		return -ENOMEM;
+
+	for (i = 0; i < SYSMON_TEMP_SAT_COUNT; i++) {
+		/*
+		 * Temp. satellites are indexed from 1 to 64 on the register
+		 * mapping, so the attr. sysfs entry will have appropriate
+		 * postfix index number, plus one, accordingly. We are adding
+		 * loop index number to attributes address because enable bit
+		 * fields starts from 0.
+		 */
+		sysmon->temp_avg_en_attrs[i].dev_attr.attr.name =
+			devm_kasprintf(&indio_dev->dev, GFP_KERNEL,
+				       "averaging_en_tempsat%d", (i + 1));
+		sysmon->temp_avg_en_attrs[i].dev_attr.attr.mode = 0644;
+		sysmon->temp_avg_en_attrs[i].dev_attr.show = tempsat_avg_en_show;
+		sysmon->temp_avg_en_attrs[i].dev_attr.store = tempsat_avg_en_store;
+		sysmon->temp_avg_en_attrs[i].address = i;
+
+		/* Add all temp. sat averaging attrs to array of avg attributes */
+		sysmon->avg_attrs[i] =
+			&sysmon->temp_avg_en_attrs[i].dev_attr.attr;
+	}
+
+	for (i = 0; i < sysmon->num_supply_chan; i++) {
+		/*
+		 * Even each Sysmon device has max. 160 supply/voltage
+		 * channels, they are enabled by dt discretely. There is no
+		 * point of create attributes for all supply channels. We only
+		 * create which is enabled by design and reflected in dt as
+		 * supply channels. Supply index values are address of the
+		 * IIO channel.
+		 */
+		supply_index = indio_dev->channels[i].address;
+		sysmon->supply_avg_en_attrs[i].dev_attr.attr.name =
+			devm_kasprintf(&indio_dev->dev, GFP_KERNEL,
+				       "averaging_en_supply%d", supply_index);
+		sysmon->supply_avg_en_attrs[i].dev_attr.attr.mode = 0644;
+		sysmon->supply_avg_en_attrs[i].dev_attr.show = supply_avg_en_show;
+		sysmon->supply_avg_en_attrs[i].dev_attr.store = supply_avg_en_store;
+		sysmon->supply_avg_en_attrs[i].address = supply_index;
+
+		sysmon->avg_attrs[SYSMON_TEMP_SAT_COUNT + i] =
+			&sysmon->supply_avg_en_attrs[i].dev_attr.attr;
+	}
+
+	/* Null-terminate the attribute array */
+	sysmon->avg_attrs[max_attrs_num + 1] = NULL;
+
+	/*
+	 * Assign all dynamically created attributes to averaging
+	 * attributes group with "averaging" name. It will create
+	 * a subfolder for this group under the IIO device folder.
+	 */
+	sysmon->avg_attr_group.name = "averaging";
+	sysmon->avg_attr_group.attrs = sysmon->avg_attrs;
+
+	/* Create the sysfs group for the attributes */
+	ret = sysfs_create_group(&indio_dev->dev.kobj,
+				 &sysmon->avg_attr_group);
+	if (ret) {
+		dev_err(&indio_dev->dev,
+			"Failed to create averaging attribute group\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sysmon_create_avg_en_sysfs_entries);
+
+static void sysmon_region_event_handler(struct sysmon *sysmon)
+{
+	struct region_info *region;
+	struct regional_node *node, *eventnode;
+	u32 regval, event = 0;
+	u16 thresh_up, val;
+
+	sysmon_read_reg(sysmon, SYSMON_TEMP_TH_UP, &regval);
+	thresh_up = (u16)regval;
+
+	list_for_each_entry(region, &sysmon->region_list, list) {
+		list_for_each_entry(node, &region->node_list,
+				    regional_node_list) {
+			val = sysmon_get_node_value(node->sat_id);
+
+			/* Find the highest value */
+			if (compare(val, thresh_up)) {
+				eventnode = node;
+				eventnode->temp = val;
+				thresh_up = val;
+				event = 1;
+			}
+		}
+		if (event && region->cb)
+			region->cb(region->data, eventnode);
+	}
+}
+
+static void sysmon_handle_event(struct iio_dev *indio_dev, u32 event)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned long alarm_flag_reg;
+	u32 address, bit, reg_val;
+	u32 alarm_flag_offset = SYSMON_ALARM_FLAG + (event * 4);
+	u32 alarm_reg_offset = SYSMON_ALARM_REG + (event * 4);
+
+	switch (event) {
+	case SYSMON_BIT_TEMP:
+		address = TEMP_EVENT;
+		sysmon_push_event(indio_dev, address);
+		sysmon_write_reg(sysmon, SYSMON_IDR, BIT(SYSMON_BIT_TEMP));
+		sysmon->masked_temp |= BIT(SYSMON_BIT_TEMP);
+		sysmon_region_event_handler(sysmon);
+		break;
+
+	case SYSMON_BIT_OT:
+		address = OT_EVENT;
+		sysmon_push_event(indio_dev, address);
+		sysmon_write_reg(sysmon, SYSMON_IDR, BIT(SYSMON_BIT_OT));
+		sysmon->masked_temp |= BIT(SYSMON_BIT_OT);
+		sysmon_region_event_handler(sysmon);
+		break;
+
+	case SYSMON_BIT_ALARM4:
+	case SYSMON_BIT_ALARM3:
+	case SYSMON_BIT_ALARM2:
+	case SYSMON_BIT_ALARM1:
+	case SYSMON_BIT_ALARM0:
+		/* Read enabled alarms */
+		sysmon_read_reg(sysmon, alarm_flag_offset, &reg_val);
+		alarm_flag_reg = (unsigned long)reg_val;
+
+		for_each_set_bit(bit, &alarm_flag_reg, 32) {
+			address = bit + (32 * event);
+			sysmon_push_event(indio_dev, address);
+			/* disable alarm */
+			sysmon_update_reg(sysmon, alarm_reg_offset, BIT(bit),
+					  0);
+		}
+		/* clear alarms */
+		sysmon_write_reg(sysmon, alarm_flag_offset, alarm_flag_reg);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static void sysmon_handle_events(struct iio_dev *indio_dev,
+				 unsigned long events)
+{
+	unsigned int bit;
+
+	for_each_set_bit(bit, &events, SYSMON_NO_OF_EVENTS)
+		sysmon_handle_event(indio_dev, bit);
+}
+
+static void sysmon_unmask_temp(struct sysmon *sysmon, unsigned int isr)
+{
+	unsigned int unmask, status;
+
+	status = isr & SYSMON_TEMP_MASK;
+
+	/* clear bits that are not active any more */
+	unmask = (sysmon->masked_temp ^ status) & sysmon->masked_temp;
+	sysmon->masked_temp &= status;
+
+	/* clear status of disabled alarm */
+	unmask &= ~sysmon->temp_mask;
+
+	sysmon_write_reg(sysmon, SYSMON_IER, unmask);
+}
+
+/*
+ * The Versal threshold interrupts are level sensitive. Since we can't make the
+ * threshold condition go way from within the interrupt handler, this means as
+ * soon as a threshold condition is present we would enter the interrupt handler
+ * again and again. To work around this we mask all active thresholds interrupts
+ * in the interrupt handler and start a timer. In this timer we poll the
+ * interrupt status and only if the interrupt is inactive we unmask it again.
+ */
+static void sysmon_unmask_worker(struct work_struct *work)
+{
+	struct sysmon *sysmon = container_of(work, struct sysmon,
+					     sysmon_unmask_work.work);
+	unsigned int isr;
+
+	spin_lock_irq(&sysmon->lock);
+
+	/* Read the current interrupt status */
+	sysmon_read_reg(sysmon, SYSMON_ISR, &isr);
+
+	/* Clear interrupts */
+	sysmon_write_reg(sysmon, SYSMON_ISR, isr);
+
+	sysmon_unmask_temp(sysmon, isr);
+
+	spin_unlock_irq(&sysmon->lock);
+
+	/* if still pending some alarm re-trigger the timer */
+	if (sysmon->masked_temp)
+		schedule_delayed_work(&sysmon->sysmon_unmask_work,
+				      msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
+	else
+		/*
+		 * Reset the temp_max_max and temp_min_min values to reset the
+		 * previously reached high/low values during an alarm.
+		 * This will enable the user to see the high/low values attained
+		 * during an event
+		 */
+		sysmon_write_reg(sysmon, SYSMON_STATUS_RESET, 1);
+}
+
+static irqreturn_t sysmon_iio_irq(int irq, void *data)
+{
+	u32 isr, imr;
+	struct iio_dev *indio_dev = data;
+	struct sysmon *sysmon = iio_priv(indio_dev);
+
+	spin_lock(&sysmon->lock);
+
+	sysmon_read_reg(sysmon, SYSMON_ISR, &isr);
+	sysmon_read_reg(sysmon, SYSMON_IMR, &imr);
+
+	/* only process alarm that are not masked */
+	isr &= ~imr;
+
+	/* clear interrupt */
+	sysmon_write_reg(sysmon, SYSMON_ISR, isr);
+
+	if (isr) {
+		sysmon_handle_events(indio_dev, isr);
+
+		schedule_delayed_work(&sysmon->sysmon_unmask_work,
+				      msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
+	}
+
+	spin_unlock(&sysmon->lock);
+
+	return IRQ_HANDLED;
+}
+
+static void sysmon_events_worker(struct work_struct *work)
+{
+	u32 isr, imr;
+	struct sysmon *sysmon = container_of(work, struct sysmon,
+					     sysmon_events_work.work);
+
+	spin_lock(&sysmon->lock);
+
+	sysmon_read_reg(sysmon, SYSMON_ISR, &isr);
+	sysmon_read_reg(sysmon, SYSMON_IMR, &imr);
+
+	/* only process alarm that are not masked */
+	isr &= ~imr;
+
+	/* clear interrupt */
+	sysmon_write_reg(sysmon, SYSMON_ISR, isr);
+
+	if (isr) {
+		sysmon_handle_events(sysmon->indio_dev, isr);
+		schedule_delayed_work(&sysmon->sysmon_unmask_work,
+				      msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
+	}
+	spin_unlock(&sysmon->lock);
+
+	schedule_delayed_work(&sysmon->sysmon_events_work,
+			      msecs_to_jiffies(SYSMON_EVENT_WORK_DELAY_MS));
+}
+
+static int get_hw_node_properties(struct device *dev,
+				  struct list_head *region_list)
+{
+	struct region_info *region = NULL;
+	struct regional_node *nodes;
+	struct device_node *np = dev->of_node;
+	int size;
+	u32 id, satid, x, y, i, offset, prev = 0;
+
+	/* get hw-node-info */
+	if (!of_get_property(np, "hw-node", &size))
+		return 0;
+
+	if (size % 16) {
+		dev_info(dev, "HW-Node properties not correct");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < (size / 16); i++) {
+		offset = i * 4;
+		of_property_read_u32_index(np, "hw-node", offset, &id);
+		of_property_read_u32_index(np, "hw-node", offset + 1, &satid);
+		of_property_read_u32_index(np, "hw-node", offset + 2, &x);
+		of_property_read_u32_index(np, "hw-node", offset + 3, &y);
+
+		if (list_empty(region_list) || prev != id) {
+			region = devm_kzalloc(dev, sizeof(*region),
+					      GFP_KERNEL);
+			if (!region)
+				return -ENOMEM;
+
+			region->id = (enum sysmon_region)id;
+			INIT_LIST_HEAD(&region->node_list);
+			list_add(&region->list, region_list);
+		}
+
+		prev = id;
+		nodes = devm_kzalloc(dev, sizeof(*nodes), GFP_KERNEL);
+		if (!nodes)
+			return -ENOMEM;
+		nodes->sat_id = satid;
+		nodes->x = x;
+		nodes->y = y;
+		list_add(&nodes->regional_node_list, &region->node_list);
+	}
+
+	return 0;
+}
+
+int sysmon_parse_dt(struct iio_dev *indio_dev, struct device *dev)
+{
+	struct sysmon *sysmon;
+	struct iio_chan_spec *sysmon_channels;
+	struct device_node *child_node = NULL, *np = dev->of_node;
+	int ret, i = 0;
+	u32 num_supply_chan = 0;
+	u32 reg = 0, num_temp_chan = 0;
+	const char *name;
+	u32 chan_size = sizeof(struct iio_chan_spec);
+	u32 temp_chan_size;
+
+	sysmon = iio_priv(indio_dev);
+	ret = of_property_read_u32(np, "xlnx,numchannels", &num_supply_chan);
+	if (ret < 0)
+		return ret;
+
+	sysmon->num_supply_chan = num_supply_chan;
+
+	INIT_LIST_HEAD(&sysmon->region_list);
+
+	if (sysmon->irq > 0)
+		get_hw_node_properties(dev, &sysmon->region_list);
+
+	/* Initialize buffer for channel specification */
+	if (sysmon->master_slr) {
+		temp_chan_size = (sizeof(temp_channels) + sizeof(temp_events));
+		num_temp_chan = ARRAY_SIZE(temp_channels);
+	} else if (sysmon->hbm_slr) {
+		temp_chan_size = (sizeof(temp_hbm_channels));
+		num_temp_chan = ARRAY_SIZE(temp_hbm_channels);
+	} else {
+		temp_chan_size = sizeof(temp_events);
+		num_temp_chan = 0;
+	}
+
+	sysmon_channels = devm_kzalloc(dev, (chan_size * num_supply_chan) +
+					    temp_chan_size,
+					    GFP_KERNEL);
+	if (!sysmon_channels)
+		return -ENOMEM;
+
+	for_each_child_of_node(np, child_node) {
+		ret = of_property_read_u32(child_node, "reg", &reg);
+		if (ret < 0) {
+			of_node_put(child_node);
+			return ret;
+		}
+
+		ret = of_property_read_string(child_node, "xlnx,name", &name);
+		if (ret < 0) {
+			of_node_put(child_node);
+			return ret;
+		}
+
+		sysmon_channels[i].type = IIO_VOLTAGE;
+		sysmon_channels[i].indexed = 1;
+		sysmon_channels[i].address = reg;
+		sysmon_channels[i].channel = reg;
+		sysmon_channels[i].info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED);
+		sysmon_channels[i].info_mask_shared_by_type =
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+		sysmon_channels[i].info_mask_shared_by_type_available =
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+
+		sysmon_channels[i].event_spec = sysmon_supply_events;
+		sysmon_channels[i].num_event_specs = ARRAY_SIZE(sysmon_supply_events);
+
+		sysmon_channels[i].scan_index = i;
+		sysmon_channels[i].scan_type.realbits = 19;
+		sysmon_channels[i].scan_type.storagebits = 32;
+
+		sysmon_channels[i].scan_type.endianness = IIO_CPU;
+		sysmon_channels[i].extend_name = name;
+
+		if (of_property_read_bool(child_node, "xlnx,bipolar"))
+			sysmon_channels[i].scan_type.sign = 's';
+		else
+			sysmon_channels[i].scan_type.sign = 'u';
+
+		i++;
+	}
+
+	/* Append static temperature channels to the channel list */
+	indio_dev->num_channels = num_supply_chan;
+
+	if (sysmon->master_slr) {
+		memcpy(sysmon_channels + num_supply_chan, temp_channels,
+		       sizeof(temp_channels));
+		indio_dev->num_channels += ARRAY_SIZE(temp_channels);
+	}
+
+	if (sysmon->hbm_slr) {
+		memcpy(sysmon_channels + num_supply_chan, temp_hbm_channels,
+		       sizeof(temp_hbm_channels));
+		indio_dev->num_channels += num_temp_chan;
+	} else {
+		memcpy(sysmon_channels + num_supply_chan + num_temp_chan,
+		       temp_events, sizeof(temp_events));
+		indio_dev->num_channels += ARRAY_SIZE(temp_events);
+	}
+
+	indio_dev->channels = sysmon_channels;
+
+	return 0;
+}
+EXPORT_SYMBOL(sysmon_parse_dt);
+
+int sysmon_init_interrupt(struct sysmon *sysmon)
+{
+	u32 imr;
+	int ret;
+
+	INIT_DELAYED_WORK(&sysmon->sysmon_unmask_work,
+			  sysmon_unmask_worker);
+
+	sysmon_read_reg(sysmon, SYSMON_IMR, &imr);
+	sysmon->temp_mask = imr & SYSMON_TEMP_MASK;
+
+	if (sysmon->irq > 0) {
+		g_sysmon = sysmon;
+		ret = devm_request_irq(sysmon->dev, sysmon->irq, &sysmon_iio_irq,
+				       0, "sysmon-irq", sysmon->indio_dev);
+		if (ret < 0)
+			return ret;
+	} else {
+		INIT_DELAYED_WORK(&sysmon->sysmon_events_work,
+				  sysmon_events_worker);
+		schedule_delayed_work(&sysmon->sysmon_events_work,
+				      msecs_to_jiffies(SYSMON_EVENT_WORK_DELAY_MS));
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(sysmon_init_interrupt);
diff --git a/drivers/iio/adc/versal-sysmon.c b/drivers/iio/adc/versal-sysmon.c
new file mode 100644
index 000000000000..79be5111b56c
--- /dev/null
+++ b/drivers/iio/adc/versal-sysmon.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD SYSMON for Versal
+ *
+ * Copyright (C) 2019 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
+ *
+ * Description:
+ * This driver is developed for SYSMON on Versal. The driver supports INDIO Mode
+ * and supports voltage and temperature monitoring via IIO sysfs interface and
+ * in kernel event monitoring for some modules.
+ */
+
+#include <linux/bits.h>
+#include <linux/moduleparam.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include "versal-sysmon.h"
+
+static LIST_HEAD(sysmon_list_head);
+
+static struct iio_map sysmon_therm_static_maps[] = {
+	IIO_MAP("temp", "versal-thermal", "sysmon-temp-channel"),
+	{}
+};
+
+static inline int sysmon_direct_read_reg(struct sysmon *sysmon, u32 offset, u32 *data)
+{
+	*data = readl(sysmon->base + offset);
+
+	return 0;
+}
+
+static inline void sysmon_direct_write_reg(struct sysmon *sysmon, u32 offset, u32 data)
+{
+	writel(data, sysmon->base + offset);
+}
+
+static inline void sysmon_direct_update_reg(struct sysmon *sysmon, u32 offset,
+					    u32 mask, u32 data)
+{
+	u32 val;
+
+	sysmon_direct_read_reg(sysmon, offset, &val);
+	sysmon_direct_write_reg(sysmon, offset, (val & ~mask) | (mask & data));
+}
+
+static struct sysmon_ops direct_access = {
+	.read_reg = sysmon_direct_read_reg,
+	.write_reg = sysmon_direct_write_reg,
+	.update_reg = sysmon_direct_update_reg,
+};
+
+/**
+ * sysmon_find_extreme_temp() - Finds extreme temperature
+ * value read from each device.
+ * @sysmon: Pointer to the sysmon instance
+ * @offset: Register offset address of temperature channels
+ *
+ * The function takes offset address of temperature channels
+ * returns extreme value (highest/lowest) of that channel
+ *
+ * @return: - The highest/lowest temperature found from
+ * current or historic min/max temperature of all devices.
+ */
+static int sysmon_find_extreme_temp(struct sysmon *sysmon, int offset)
+{
+	u32 extreme_val = SYSMON_LOWER_SATURATION_SIGNED;
+	bool is_min_channel = false, skip_hbm = true;
+	u32 regval;
+
+	if (offset == SYSMON_TEMP_MIN || offset == SYSMON_TEMP_MIN_MIN) {
+		is_min_channel = true;
+		extreme_val = SYSMON_UPPER_SATURATION_SIGNED;
+	} else if (offset == SYSMON_TEMP_HBM) {
+		skip_hbm = false;
+	}
+
+	list_for_each_entry(sysmon, &sysmon_list_head, list) {
+		if (skip_hbm && sysmon->hbm_slr)
+			/* Skip if HBM SLR and need non HBM reading */
+			continue;
+
+		if (!skip_hbm && !sysmon->hbm_slr)
+			/* Skip if not HBM SLR and need a HBM reading */
+			continue;
+
+		sysmon_read_reg(sysmon, offset, &regval);
+
+		if (sysmon->hbm_slr)
+			return regval;
+
+		if (!is_min_channel) {
+			/* Find the highest value */
+			if (compare(regval, extreme_val))
+				extreme_val = regval;
+		} else {
+			/* Find the lowest value */
+			if (compare(extreme_val, regval))
+				extreme_val = regval;
+		}
+	}
+
+	return extreme_val;
+}
+
+static int sysmon_probe(struct platform_device *pdev)
+{
+	struct sysmon *sysmon, *temp_sysmon;
+	struct iio_dev *indio_dev;
+	struct resource *mem;
+	bool exist = false;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*sysmon));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	sysmon = iio_priv(indio_dev);
+
+	sysmon->dev = &pdev->dev;
+	sysmon->indio_dev = indio_dev;
+
+	mutex_init(&sysmon->mutex);
+	spin_lock_init(&sysmon->lock);
+
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->dev.of_node = pdev->dev.of_node;
+	indio_dev->name = "xlnx,versal-sysmon";
+	sysmon_set_iio_dev_info(indio_dev);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	sysmon->base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
+	if (IS_ERR(sysmon->base))
+		return PTR_ERR(sysmon->base);
+
+	sysmon->ops = &direct_access;
+
+	INIT_LIST_HEAD(&sysmon->list);
+
+	mutex_lock(&sysmon->mutex);
+
+	if (list_empty(&sysmon_list_head)) {
+		sysmon->master_slr = true;
+	} else {
+		list_for_each_entry(temp_sysmon, &sysmon_list_head, list) {
+			if (temp_sysmon->master_slr)
+				exist = true;
+		}
+		sysmon->master_slr = !exist;
+	}
+
+	mutex_unlock(&sysmon->mutex);
+
+	sysmon->hbm_slr = of_property_read_bool(pdev->dev.of_node, "xlnx,hbm");
+	if (!sysmon->hbm_slr) {
+		sysmon_write_reg(sysmon, SYSMON_NPI_LOCK, NPI_UNLOCK);
+		sysmon_write_reg(sysmon, SYSMON_IDR, 0xffffffff);
+		sysmon_write_reg(sysmon, SYSMON_ISR, 0xffffffff);
+		sysmon->irq = platform_get_irq_optional(pdev, 0);
+	}
+
+	ret = sysmon_parse_dt(indio_dev, &pdev->dev);
+	if (ret)
+		return ret;
+
+	if (!sysmon->hbm_slr) {
+		ret = sysmon_init_interrupt(sysmon);
+			if (ret)
+				return ret;
+	}
+
+	/*
+	 * Sysmon dev info is cleared initially.
+	 * temperature satellites and supply channels
+	 * oversampling values will be 0. No need to
+	 * assign them again.
+	 */
+	sysmon->oversampling_avail = sysmon_oversampling_avail;
+	sysmon->oversampling_num = ARRAY_SIZE(sysmon_oversampling_avail);
+
+	sysmon->temp_read = &sysmon_find_extreme_temp;
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	if (sysmon->master_slr) {
+		ret = devm_iio_map_array_register(&pdev->dev, indio_dev,
+						  sysmon_therm_static_maps);
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret, "IIO map register failed\n");
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto error_exit;
+
+	/* Create the sysfs entries for the averaging enable bits */
+	ret = sysmon_create_avg_en_sysfs_entries(indio_dev);
+	if (ret < 0)
+		goto error_exit;
+
+	mutex_lock(&sysmon->mutex);
+	list_add(&sysmon->list, &sysmon_list_head);
+	mutex_unlock(&sysmon->mutex);
+
+	return 0;
+
+error_exit:
+	if (sysmon->irq < 0)
+		cancel_delayed_work_sync(&sysmon->sysmon_events_work);
+
+	cancel_delayed_work_sync(&sysmon->sysmon_unmask_work);
+	return ret;
+}
+
+static void sysmon_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct sysmon *sysmon = iio_priv(indio_dev);
+
+	/* cancel SSIT based events */
+	if (sysmon->irq < 0)
+		cancel_delayed_work_sync(&sysmon->sysmon_events_work);
+
+	cancel_delayed_work_sync(&sysmon->sysmon_unmask_work);
+
+	mutex_lock(&sysmon->mutex);
+	list_del(&sysmon->list);
+	mutex_unlock(&sysmon->mutex);
+
+	sysfs_remove_group(&indio_dev->dev.kobj, &sysmon->avg_attr_group);
+	/* Unregister the device */
+	iio_device_unregister(indio_dev);
+}
+
+static int sysmon_resume(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct sysmon *sysmon = iio_priv(indio_dev);
+
+	sysmon_write_reg(sysmon, SYSMON_NPI_LOCK, NPI_UNLOCK);
+
+	return 0;
+}
+
+static const struct of_device_id sysmon_of_match_table[] = {
+	{ .compatible = "xlnx,versal-sysmon" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sysmon_of_match_table);
+
+static struct platform_driver sysmon_driver = {
+	.probe = sysmon_probe,
+	.remove = sysmon_remove,
+	.resume = sysmon_resume,
+	.driver = {
+		.name = "sysmon",
+		.of_match_table = sysmon_of_match_table,
+	},
+};
+module_platform_driver(sysmon_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Xilinx Versal SysMon Driver");
+MODULE_AUTHOR("Advanced Micro Devices, Inc");
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
new file mode 100644
index 000000000000..ba47b6d32f4d
--- /dev/null
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -0,0 +1,275 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD SYSMON for Versal
+ *
+ * Copyright (C) 2019 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
+ *
+ * Description:
+ * This driver is developed for SYSMON on Versal. The driver supports INDIO Mode
+ * and supports voltage and temperature monitoring via IIO sysfs interface.
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/driver.h>
+#include <linux/iio/events.h>
+#include <linux/iio/machine.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/adc/versal-sysmon-events.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/of_address.h>
+
+/* Channel IDs for Temp Channels */
+/* TEMP_MAX gives the current temperature for Production
+ * silicon.
+ * TEMP_MAX gives the current maximum temperature for ES1
+ * silicon.
+ */
+#define TEMP_MAX	160
+
+/* TEMP_MIN is not applicable for Production silicon.
+ * TEMP_MIN gives the current minimum temperature for ES1 silicon.
+ */
+#define TEMP_MIN	161
+
+#define TEMP_MAX_MAX	162
+#define TEMP_MIN_MIN	163
+#define TEMP_EVENT	164
+#define OT_EVENT	165
+#define TEMP_HBM	166
+
+/* Register Unlock Code */
+#define NPI_UNLOCK	0xF9E8D7C6
+
+/* Register Offsets */
+#define SYSMON_NPI_LOCK		0x000C
+#define SYSMON_ISR		0x0044
+#define SYSMON_CONFIG		0x0100
+#define SYSMON_TEMP_MASK	0x300
+#define SYSMON_IMR		0x0048
+#define SYSMON_IER		0x004C
+#define SYSMON_IDR		0x0050
+#define SYSMON_ALARM_FLAG	0x1018
+#define SYSMON_TEMP_MAX		0x1030
+#define SYSMON_TEMP_MIN		0x1034
+#define SYSMON_SUPPLY_BASE	0x1040
+#define SYSMON_ALARM_REG	0x1940
+#define SYSMON_TEMP_TH_LOW	0x1970
+#define SYSMON_TEMP_TH_UP	0x1974
+#define SYSMON_OT_TH_LOW	0x1978
+#define SYSMON_OT_TH_UP		0x197C
+#define SYSMON_SUPPLY_TH_LOW	0x1980
+#define SYSMON_SUPPLY_TH_UP	0x1C80
+#define SYSMON_TEMP_MAX_MAX	0x1F90
+#define SYSMON_TEMP_MIN_MIN	0x1F8C
+#define SYSMON_TEMP_HBM	0x0000
+#define SYSMON_TEMP_EV_CFG	0x1F84
+#define SYSMON_NODE_OFFSET	0x1FAC
+#define SYSMON_STATUS_RESET	0x1F94
+#define SYSMON_SUPPLY_EN_AVG_OFFSET	0x1958
+#define SYSMON_TEMP_SAT_EN_AVG_OFFSET	0x24B4
+
+/* Average Sampling Rate macros */
+#define SYSMON_AVERAGE_FULL_SAMPLE_RATE	0 /* Full sample rate */
+#define SYSMON_AVERAGE_2_SAMPLE_RATE	1 /* Full sample rate/2 */
+#define SYSMON_AVERAGE_4_SAMPLE_RATE	2 /* Full sample rate/4 */
+#define SYSMON_AVERAGE_8_SAMPLE_RATE	4 /* Full sample rate/8 */
+#define SYSMON_AVERAGE_16_SAMPLE_RATE	8 /* Full sample rate/16 */
+
+#define SYSMON_TEMP_SAT_IDX_FIRST	1
+#define SYSMON_TEMP_SAT_IDX_MAX		64
+#define SYSMON_TEMP_SAT_COUNT		64
+#define SYSMON_SUPPLY_IDX_MAX		159
+
+#define SYSMON_SUPPLY_CONFIG_MASK	GENMASK(17, 14)
+#define SYSMON_SUPPLY_CONFIG_SHIFT	14
+#define SYSMON_TEMP_SAT_CONFIG_MASK	GENMASK(27, 24)
+#define SYSMON_TEMP_SAT_CONFIG_SHIFT	24
+
+#define SYSMON_NO_OF_EVENTS	32
+
+/* Supply Voltage Conversion macros */
+#define SYSMON_MANTISSA_MASK		0xFFFF
+#define SYSMON_FMT_MASK			0x10000
+#define SYSMON_FMT_SHIFT		16
+#define SYSMON_MODE_MASK		0x60000
+#define SYSMON_MODE_SHIFT		17
+#define SYSMON_MANTISSA_SIGN_SHIFT	15
+#define SYSMON_UPPER_SATURATION_SIGNED	32767
+#define SYSMON_LOWER_SATURATION_SIGNED	-32768
+#define SYSMON_UPPER_SATURATION		65535
+#define SYSMON_LOWER_SATURATION		0
+
+#define SYSMON_MILLI_SCALE		1000
+
+#define SYSMON_CHAN_TEMP_EVENT(_address, _ext, _events) { \
+	.type = IIO_TEMP, \
+	.indexed = 1, \
+	.address = _address, \
+	.channel = _address, \
+	.event_spec = _events, \
+	.num_event_specs = ARRAY_SIZE(_events), \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = 15, \
+		.storagebits = 16, \
+		.endianness = IIO_CPU, \
+	}, \
+	.extend_name = _ext, \
+	}
+
+#define SYSMON_CHAN_TEMP(_address, _ext) { \
+	.type = IIO_TEMP, \
+	.indexed = 1, \
+	.address = _address, \
+	.channel = _address, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		BIT(IIO_CHAN_INFO_PROCESSED), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.info_mask_shared_by_type_available = \
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = 15, \
+		.storagebits = 16, \
+		.endianness = IIO_CPU, \
+	}, \
+	.extend_name = _ext, \
+	.datasheet_name = _ext,\
+}
+
+#define SYSMON_CHAN_TEMP_HBM(_address, _ext) { \
+	.type = IIO_TEMP, \
+	.indexed = 1, \
+	.address = _address, \
+	.channel = _address, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			BIT(IIO_CHAN_INFO_PROCESSED), \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = 15, \
+		.storagebits = 16, \
+		.endianness = IIO_CPU, \
+	}, \
+	.extend_name = _ext, \
+	.datasheet_name = _ext, \
+}
+
+#define twoscomp(val) ((((val) ^ 0xFFFF) + 1) & 0x0000FFFF)
+#define REG32_OFFSET(address) (4 * ((address) / 32))
+#define REG32_SHIFT(address) ((address) % 32)
+
+#define compare(val, thresh) (((val) & 0x8000) || ((thresh) & 0x8000) ? \
+			      ((val) < (thresh)) : ((val) > (thresh)))  \
+
+enum sysmon_alarm_bit {
+	SYSMON_BIT_ALARM0 = 0,
+	SYSMON_BIT_ALARM1 = 1,
+	SYSMON_BIT_ALARM2 = 2,
+	SYSMON_BIT_ALARM3 = 3,
+	SYSMON_BIT_ALARM4 = 4,
+	SYSMON_BIT_ALARM5 = 5,
+	SYSMON_BIT_ALARM6 = 6,
+	SYSMON_BIT_ALARM7 = 7,
+	SYSMON_BIT_OT = 8,
+	SYSMON_BIT_TEMP = 9,
+};
+
+static const unsigned int sysmon_oversampling_avail[5] = {
+	SYSMON_AVERAGE_FULL_SAMPLE_RATE,
+	SYSMON_AVERAGE_2_SAMPLE_RATE,
+	SYSMON_AVERAGE_4_SAMPLE_RATE,
+	SYSMON_AVERAGE_8_SAMPLE_RATE,
+	SYSMON_AVERAGE_16_SAMPLE_RATE,
+};
+
+/**
+ * struct sysmon - Driver data for Sysmon
+ * @base: physical base address of device
+ * @dev: pointer to device struct
+ * @indio_dev: pointer to the iio device
+ * @client: pointer to the i2c client
+ * @mutex: to handle multiple user interaction
+ * @lock: to help manage interrupt registers correctly
+ * @irq: interrupt number of the sysmon
+ * @region_list: list of the regions of sysmon
+ * @list: list of sysmon instances
+ * @masked_temp: currently masked due to alarm
+ * @temp_mask: temperature based interrupt configuration
+ * @sysmon_unmask_work: re-enables event once the event condition disappears
+ * @sysmon_events_work: poll for events on SSIT slices
+ * @ops: read write operations for sysmon registers
+ * @pm_info: plm address of sysmon
+ * @master_slr: to keep master sysmon info
+ * @hbm_slr: flag if HBM slr is present
+ * @temp_oversampling: current oversampling ratio for temperature satellites
+ * @supply_oversampling: current oversampling ratio for supply nodes
+ * @oversampling_avail: list of available overampling ratios
+ * @oversampling_num: total number of available oversampling ratios
+ * @num_supply_chan: number of supply channels that are enabled
+ * @supply_avg_en_attrs: dynamic array of supply averaging enable attributes
+ * @temp_avg_en_attrs: dynamic array of temp. sat. averaging enable attributes
+ * @avg_attrs: dynamic array of pointers to averaging attributes
+ * @avg_attr_group: attribute group for averaging
+ * @temp_read: function pointer for the special temperature read
+ *
+ * This structure contains necessary state for Sysmon driver to operate
+ */
+struct sysmon {
+	void __iomem *base;
+	struct device *dev;
+	struct iio_dev *indio_dev;
+	struct i2c_client *client;
+	/* kernel doc above */
+	struct mutex mutex;
+	/* kernel doc above */
+	spinlock_t lock;
+	int irq;
+	struct list_head region_list;
+	struct list_head list;
+	unsigned int masked_temp;
+	unsigned int temp_mask;
+	struct delayed_work sysmon_unmask_work;
+	struct delayed_work sysmon_events_work;
+	struct sysmon_ops *ops;
+	u32 pm_info;
+	bool master_slr;
+	bool hbm_slr;
+	unsigned int temp_oversampling;
+	unsigned int supply_oversampling;
+	const unsigned int *oversampling_avail;
+	unsigned int oversampling_num;
+	unsigned int num_supply_chan;
+	struct iio_dev_attr *supply_avg_en_attrs;
+	struct iio_dev_attr *temp_avg_en_attrs;
+	struct attribute **avg_attrs;
+	struct attribute_group avg_attr_group;
+	int (*temp_read)(struct sysmon *sysmon, int offset);
+};
+
+struct sysmon_ops {
+	int (*read_reg)(struct sysmon *sysmon, u32 offset, u32 *data);
+	void (*write_reg)(struct sysmon *sysmon, u32 offset, u32 data);
+	void (*update_reg)(struct sysmon *sysmon, u32 offset,
+			   u32 mask, u32 data);
+};
+
+int sysmon_register_temp_ops(void (*cb)(void *data, struct regional_node *node),
+			     void *data, enum sysmon_region region_id);
+int sysmon_unregister_temp_ops(enum sysmon_region region_id);
+struct list_head *sysmon_nodes_by_region(enum sysmon_region region_id);
+int sysmon_get_node_value(int sat_id);
+int sysmon_parse_dt(struct iio_dev *indio_dev, struct device *dev);
+int sysmon_init_interrupt(struct sysmon *sysmon);
+int sysmon_read_reg(struct sysmon *sysmon, u32 offset, u32 *data);
+void sysmon_write_reg(struct sysmon *sysmon, u32 offset, u32 data);
+void sysmon_set_iio_dev_info(struct iio_dev *indio_dev);
+int sysmon_create_avg_en_sysfs_entries(struct iio_dev *indio_dev);
diff --git a/include/linux/iio/adc/versal-sysmon-events.h b/include/linux/iio/adc/versal-sysmon-events.h
new file mode 100644
index 000000000000..d0a8b3e959c4
--- /dev/null
+++ b/include/linux/iio/adc/versal-sysmon-events.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx SYSMON hardware info
+ *
+ * Copyright (C) 2019 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
+ *
+ */
+#ifndef _VERSAL_SYSMON_EVENTS_H_
+#define _VERSAL_SYSMON_EVENTS_H_
+
+#include <linux/types.h>
+#include <linux/iio/types.h>
+
+/* Sysmon region ids */
+enum sysmon_region {
+	SYSMON_AIE = 0,
+	SYSMON_PMC = 1,
+	SYSMON_XPIO = 2,
+	SYSMON_VNOC = 3,
+	SYSMON_CC = 4,
+};
+
+/**
+ * struct regional_node - regional node properties
+ * @sat_id: node_id
+ * @x: x co-ordinate of the node
+ * @y: y co-ordinate of the node
+ * @temp: raw sensor value
+ * @regional_node_list: list of nodes in the region
+ */
+struct regional_node {
+	int sat_id;
+	int x;
+	int y;
+	u16 temp;
+	struct list_head regional_node_list;
+};
+
+/**
+ * struct region_info - information about a regions sensors
+ * @id: region id
+ * @cb: callback to be called when there is a region specific event
+ * @data: pointer to the callback data
+ * @node_list: head to the regional_nodes list
+ * @list: list of regions
+ */
+struct region_info {
+	enum sysmon_region id;
+	void (*cb)(void *data, struct regional_node *node);
+	void *data;
+	struct list_head node_list;
+	struct list_head list;
+};
+
+#endif
-- 
2.43.0


