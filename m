Return-Path: <linux-iio+bounces-10183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBA5991881
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0601F22930
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236EF15820C;
	Sat,  5 Oct 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="MJFzfWly"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F7F153598;
	Sat,  5 Oct 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147105; cv=fail; b=R7av2Ewnx5I7zI5srfE87j1ju8tVSQ/7O14Frexjh6AIaeldvrdJUNJYDg2prCa2OaURqtAb5K3VPUGw0gcxR6Elgv7uDtc5qUXNtBRdE93+h4GFVm4db3waTtgi7m11Sg2VqPZGglqLw25kb4QzmiTqve8QDIliaiTehW2DOUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147105; c=relaxed/simple;
	bh=cZ9VQePDvGyEeyxYqayaKqpxcMRl9lMIWJJ70nhAuoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBR4NCEf0pKqnxoF3Abvxw4YoDi2dTLN6R2GbWndpdriMq2MZ3UMfz2q0NPGSyQS4/0xvgp/GxQcQHeHupbXI7o+njoIl1lnRdQRw/EgOwZpkTle3eI3lPiWSTcEEI/G44aXc/r8qT2O5NDeLDaSmd16CgHmUiHcxD/gdUJOrGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=MJFzfWly; arc=fail smtp.client-ip=52.101.70.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUJz4WkTL7urp72W1ksECAI7tTIExpWH+YdjIlXfdpJCFDsNJn8kPuvH9GejKfngOl0ygxQco3VlGFIU3tLNlCg7EekY2HapStXxlFa0+RiB2G41DAISPHHuwmFhEIiLwZsAe11E1B+obmQWJ0lgyAnHTes5CEikp3NlI/x5K7YEhWqWfaj0wTpXU6I5QxRQPawQmRmksrPPJG63sJXp7u+LsTzC/pq+lyaiidf1SfQcgSGkTYFd5NfOYO1ee/YPL+4PSmCBczy9aqQGqlwMHG9GNsYhOkNztfcYuj/Q70ichvEv1G3pvNHXGJmwZe1KbVpqRfFGfxGGwOpHg69Frw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlmcBpEXWTWClK8xj39X6+KhzNumod6aJI8EkZZlNSc=;
 b=mnTD7+yPb1KbXkWr4H3Eas8FkX3o3Ej2ouiP7bkOwcojAR08rgsmWh/pAePfv4wcKe+jCXRA0vDv00v2dlJUk7jQi/FAeb0axBrZ7qxYO2YFtyYvi8sAlI9CrEtQGu/XnBpbpvyi/e4J4aAzDn4cV5GhYa9V/Zg8GD1deLBBZUU6ogfW+eQhWkylwyrmh62lfwpWL3SdyHmU+0/vLOXFjqlPX9PBomQ9TrRp7DXutWXfAkgCJ6pSHEIyErCt/QMDAvF+rehFEns+8UwUciDbQFDG6TWosH2DBJVB9Z+HCIDuahSWWjWktCaKMQMSLaC2Q+fmSR6+nUw+GscfjLA1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlmcBpEXWTWClK8xj39X6+KhzNumod6aJI8EkZZlNSc=;
 b=MJFzfWlybZD7BqOXNHdvPvGPileu3QYrbkvqZCL291sJTSqeIqoO6StojbpCeUQ8wX6QApnxgnR7VWkFyOAn4+nbZ7EHxdUR38x1ga1dt+PIV8joDI0uINIpDLuusD7pSyX7WVe0if7tS5JPm/jW5mWZelSiLBPcNaJvl5iwTF8=
Received: from DB9PR05CA0001.eurprd05.prod.outlook.com (2603:10a6:10:1da::6)
 by GV1PR02MB11035.eurprd02.prod.outlook.com (2603:10a6:150:204::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 16:51:35 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::15) by DB9PR05CA0001.outlook.office365.com
 (2603:10a6:10:1da::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Sat, 5 Oct 2024 16:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Sat, 5 Oct 2024 16:51:34 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 5 Oct
 2024 18:51:27 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 5 Oct
 2024 18:51:27 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 5 Oct 2024 18:51:27 +0200
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 188E4123;
	Sat,  5 Oct 2024 18:51:27 +0200 (CEST)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 168EE18E1EC0; Sat,  5 Oct 2024 18:51:27 +0200 (CEST)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH v2 2/2] iio: light: Add support for TI OPT4060 color sensor
Date: Sat, 5 Oct 2024 18:51:19 +0200
Message-ID: <20241005165119.3549472-3-perdaniel.olsson@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241005165119.3549472-1-perdaniel.olsson@axis.com>
References: <20241005165119.3549472-1-perdaniel.olsson@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|GV1PR02MB11035:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a448f1-0618-41e9-3418-08dce55df857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SxccbLfmPAaSkbCbyvEX1JQCQTr8/16cVIWLd8KtBKn6g6A7krCdV/WteHEe?=
 =?us-ascii?Q?5b7hSP9WT2q5VtdKkbYQOE0D2X+u3IX30MMJUA326DVNwIT72LuYRNDPdwMZ?=
 =?us-ascii?Q?GNtyGd/l/nNDxjl2kjz7+vvhf4C0qCc2a10aJ2BDUUCNoQnbypqh0rwse/l0?=
 =?us-ascii?Q?cfFimbu+GLUvI4T0SLoESvmmooJjtw/QpVFE9Q2HJU3+trG9iOxBA2VdeTM5?=
 =?us-ascii?Q?KH7evB6Y7NX8SsW57/ANiPWs7jv0NnzBUMaZh0KVBQcV677Osx3LHZKLn3ZC?=
 =?us-ascii?Q?5gNFfqNZpyFRn+YOmxwqFnkvNVPVnSrNlBULscAkpUd4abK3qLpnXOrbRWSw?=
 =?us-ascii?Q?2jnFyBCltLnRRfmU/24R1BTXBjrsQlCTrpZVs2ioty+Lz+HNnjlMc8qYCvdL?=
 =?us-ascii?Q?BG6EztgY31ufGxKa64I1tUSDVw0bsr24RD5FalXRiGIJAWkVAKzZWjxY1uVS?=
 =?us-ascii?Q?UBTY4AKqcbPf8OnOcb9yOUDadldZ5/PweMDPZYT5KMQXleoGMlZn0wlhOIEm?=
 =?us-ascii?Q?8yL4N6vlHt8EAGxjjB7GOJiM0Axa44mGa3xjfYuS/cBy86jotFMZ4rOzGXef?=
 =?us-ascii?Q?ppTVKaqnO6ILY8bViJKjqTVaTKVRPAUSalTdpwpC1hE2omC6T9tLq7L9mnFI?=
 =?us-ascii?Q?7Wq0rzIpMoVVjcfapv3lyvd8E1XB14yqCkdAuSV70B6DtYOuJmNLzfy+cQZj?=
 =?us-ascii?Q?zVNFW6tO6m6c1zqSrZN7udir4KWH1uACsLONTbQ3qvx3Q/V4HQr/z7+dhEor?=
 =?us-ascii?Q?DpqW/S8XG9Ae39/ylERYkJTCpbLs2TvLA84pXG+eDXRLmEwBv0ixjDMoJAEh?=
 =?us-ascii?Q?0Lz3sWOFT9JOPKxPfOVNph2ljALD3gvwUNY+xE3iBYoFsyvMmpxMPvZ+GVFj?=
 =?us-ascii?Q?zSNeVDoZLv7LAL/qQnqWiDTtusrmMlUk9G4eDG1q9WYLSnterbshL7WiQCxZ?=
 =?us-ascii?Q?4booKk36k8NxT5P/BdVcczDPir504msfbFcE2K9fbsmpxGRfIe3VoC2MjtrI?=
 =?us-ascii?Q?czZXx9J0kTp4iItD6AwIJO4wtxai9VKs1e8KGEaqXMN2FfkcSIP4DeizYMSU?=
 =?us-ascii?Q?ZAAOkh81thZOVGRxcpEa5SA5nJTUE3xWPSVaj3KkUeo3NZgskXQuJ1LUkpSr?=
 =?us-ascii?Q?9ffM5+0Zly7nnI1Vr251OQGSY9INs7726NPcB3TdxAuVBnSu1R3YNxkTtvgE?=
 =?us-ascii?Q?j7Vohp36r0UT/CImwmhPXj/V2ScokxRFTTNSQTDp+3494eZpBxXPtETLnYi1?=
 =?us-ascii?Q?hm9J8Aesi5XPRp5dpOCkUZnwXmZ5RirRl8uijnzcjXqORAe3oRlwGMRdP7e9?=
 =?us-ascii?Q?Cdj/6tvZ6hbu/0yWPjUA7YDgxHoWbDkpQ0H0HphtWAp0N/0nXyNxPSnxyN44?=
 =?us-ascii?Q?Q+GOXKMnA0B7Vty/TB+wDxjRHzg8?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 16:51:34.0326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a448f1-0618-41e9-3418-08dce55df857
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB11035

Add support for Texas Instruments OPT4060 RGBW Color sensor.

Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
---
 drivers/iio/light/Kconfig   |   13 +
 drivers/iio/light/Makefile  |    1 +
 drivers/iio/light/opt4060.c | 1216 +++++++++++++++++++++++++++++++++++
 3 files changed, 1230 insertions(+)
 create mode 100644 drivers/iio/light/opt4060.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 515ff46b5b82..0e2059512157 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -490,6 +490,19 @@ config OPT4001
 	  If built as a dynamically linked module, it will be called
 	  opt4001.
 
+config OPT4060
+	tristate "Texas Instruments OPT4060 RGBW Color Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  If you say Y or M here, you get support for Texas Instruments
+	  OPT4060 RGBW Color Sensor.
+
+	  If built as a dynamically linked module, it will be called
+	  opt4060.
+
 config PA12203001
 	tristate "TXC PA12203001 light and proximity sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 321010fc0b93..55902b21ec0c 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_MAX44009)		+= max44009.o
 obj-$(CONFIG_NOA1305)		+= noa1305.o
 obj-$(CONFIG_OPT3001)		+= opt3001.o
 obj-$(CONFIG_OPT4001)		+= opt4001.o
+obj-$(CONFIG_OPT4060)		+= opt4060.o
 obj-$(CONFIG_PA12203001)	+= pa12203001.o
 obj-$(CONFIG_ROHM_BU27008)	+= rohm-bu27008.o
 obj-$(CONFIG_ROHM_BU27034)	+= rohm-bu27034.o
diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
new file mode 100644
index 000000000000..a917b59cd500
--- /dev/null
+++ b/drivers/iio/light/opt4060.c
@@ -0,0 +1,1216 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Axis Communications AB
+ *
+ * Datasheet: https://www.ti.com/lit/gpn/opt4060
+ *
+ * Device driver for the Texas Instruments OPT4060 RGBW Color Sensor.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/math64.h>
+#include <linux/units.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define OPT_4060_DRV_NAME	"opt4060"
+
+/* OPT4060 register set */
+#define OPT4060_RED_MSB				0x00
+#define OPT4060_RED_LSB				0x01
+#define OPT4060_GREEN_MSB			0x02
+#define OPT4060_GREEN_LSB			0x03
+#define OPT4060_BLUE_MSB			0x04
+#define OPT4060_BLUE_LSB			0x05
+#define OPT4060_CLEAR_MSB			0x06
+#define OPT4060_CLEAR_LSB			0x07
+#define OPT4060_THRESHOLD_LOW			0x08
+#define OPT4060_THRESHOLD_HIGH			0x09
+#define OPT4060_CTRL				0x0a
+#define OPT4060_INT_CTRL			0x0b
+#define OPT4060_RES_CTRL			0x0c
+#define OPT4060_DEVICE_ID			0x11
+
+/* OPT4060 register mask */
+#define OPT4060_EXPONENT_MASK			GENMASK(15, 12)
+#define OPT4060_MSB_MASK			GENMASK(11, 0)
+#define OPT4060_LSB_MASK			GENMASK(15, 8)
+#define OPT4060_COUNTER_MASK			GENMASK(7, 4)
+#define OPT4060_CRC_MASK			GENMASK(3, 0)
+
+/* OPT4060 device id mask */
+#define OPT4060_DEVICE_ID_MASK			GENMASK(11, 0)
+
+/* OPT4060 control register masks */
+#define OPT4060_CTRL_QWAKE_MASK			BIT(15)
+#define OPT4060_CTRL_RANGE_MASK			GENMASK(13, 10)
+#define OPT4060_CTRL_CONV_TIME_MASK		GENMASK(9, 6)
+#define OPT4060_CTRL_OPER_MODE_MASK		GENMASK(5, 4)
+#define OPT4060_CTRL_LATCH_MASK			BIT(3)
+#define OPT4060_CTRL_INT_POL_MASK		BIT(2)
+#define OPT4060_CTRL_FAULT_COUNT_MASK		GENMASK(1, 0)
+
+/* OPT4060 interrupt control register masks */
+#define OPT4060_INT_CTRL_THRESH_SEL		GENMASK(6, 5)
+#define OPT4060_INT_CTRL_OUTPUT			BIT(4)
+#define OPT4060_INT_CTRL_INT_CFG		GENMASK(3, 2)
+#define OPT4060_INT_CTRL_THRESHOLD		0x0
+#define OPT4060_INT_CTRL_NEXT_CH		0x1
+#define OPT4060_INT_CTRL_ALL_CH			0x3
+
+/* OPT4060 result control register masks */
+#define OPT4060_RES_CTRL_OVERLOAD		BIT(3)
+#define OPT4060_RES_CTRL_CONV_READY		BIT(2)
+#define OPT4060_RES_CTRL_FLAG_H			BIT(1)
+#define OPT4060_RES_CTRL_FLAG_L			BIT(0)
+
+/* OPT4060 constants */
+#define OPT4060_DEVICE_ID_VAL			0x821
+
+/* OPT4060 operating modes */
+#define OPT4060_CTRL_OPER_MODE_OFF		0x0
+#define OPT4060_CTRL_OPER_MODE_FORCED		0x1
+#define OPT4060_CTRL_OPER_MODE_ONE_SHOT		0x2
+#define OPT4060_CTRL_OPER_MODE_CONTINUOUS	0x3
+
+/* OPT4060 conversion control register definitions */
+#define OPT4060_CTRL_CONVERSION_0_6MS		0x0
+#define OPT4060_CTRL_CONVERSION_1MS		0x1
+#define OPT4060_CTRL_CONVERSION_1_8MS		0x2
+#define OPT4060_CTRL_CONVERSION_3_4MS		0x3
+#define OPT4060_CTRL_CONVERSION_6_5MS		0x4
+#define OPT4060_CTRL_CONVERSION_12_7MS		0x5
+#define OPT4060_CTRL_CONVERSION_25MS		0x6
+#define OPT4060_CTRL_CONVERSION_50MS		0x7
+#define OPT4060_CTRL_CONVERSION_100MS		0x8
+#define OPT4060_CTRL_CONVERSION_200MS		0x9
+#define OPT4060_CTRL_CONVERSION_400MS		0xa
+#define OPT4060_CTRL_CONVERSION_800MS		0xb
+
+/* OPT4060 fault count control register definitions */
+#define OPT4060_CTRL_FAULT_COUNT_1		0x0
+#define OPT4060_CTRL_FAULT_COUNT_2		0x1
+#define OPT4060_CTRL_FAULT_COUNT_4		0x2
+#define OPT4060_CTRL_FAULT_COUNT_8		0x3
+
+/* OPT4060 scale light level range definitions */
+#define OPT4060_CTRL_LIGHT_SCALE_AUTO		12
+
+/* OPT4060 default values */
+#define OPT4060_DEFAULT_CONVERSION_TIME OPT4060_CTRL_CONVERSION_50MS
+
+/*
+ * enum opt4060_chan_type - OPT4060 channel types
+ * @OPT4060_RED:	Red channel.
+ * @OPT4060_GREEN:	Green channel.
+ * @OPT4060_BLUE:	Blue channel.
+ * @OPT4060_CLEAR:	Clear (white) channel.
+ * @OPT4060_NUM_CHANS:	Number of channel types.
+ */
+enum opt4060_chan_type {
+	OPT4060_RED,
+	OPT4060_GREEN,
+	OPT4060_BLUE,
+	OPT4060_CLEAR,
+	OPT4060_NUM_CHANS
+};
+
+struct opt4060_chip {
+	struct regmap *regmap;
+	struct device *dev;
+	struct iio_trigger *data_trig;
+	bool data_trigger_active;
+	struct iio_trigger *threshold_trig;
+	bool threshold_trigger_active;
+	u8 int_time;
+	int irq;
+	struct completion completion;
+	bool thresh_event_lo_active;
+	bool thresh_event_hi_active;
+};
+
+struct opt4060_channel_factor {
+	u32 mul;
+	u32 div;
+};
+
+struct opt4060_buffer {
+	u32 chan[OPT4060_NUM_CHANS];
+	s64 ts;
+};
+
+static const struct opt4060_channel_factor opt4060_channel_factors[] = {
+	{
+		/* RED 2.4 * 2.15e-3 */
+		.mul = 516,
+		.div = 100000,
+	}, {
+		/* GREEN 1.0 * 2.15e-3 */
+		.mul = 215,
+		.div = 100000,
+	}, {
+		/* BLUE 1.3 * 2.15e-3 */
+		.mul = 258,
+		.div = 100000,
+	}, {
+		/* CLEAR 1.0 * 2.15e-3 */
+		.mul = 215,
+		.div = 100000,
+	},
+};
+
+static const int opt4060_int_time_available[][2] = {
+	{ 0,    600 },
+	{ 0,   1000 },
+	{ 0,   1800 },
+	{ 0,   3400 },
+	{ 0,   6500 },
+	{ 0,  12700 },
+	{ 0,  25000 },
+	{ 0,  50000 },
+	{ 0, 100000 },
+	{ 0, 200000 },
+	{ 0, 400000 },
+	{ 0, 800000 },
+};
+
+/*
+ * Conversion time is integration time + time to set register
+ * this is used as integration time.
+ */
+static const int opt4060_int_time_reg[][2] = {
+	{    600,  OPT4060_CTRL_CONVERSION_0_6MS  },
+	{   1000,  OPT4060_CTRL_CONVERSION_1MS    },
+	{   1800,  OPT4060_CTRL_CONVERSION_1_8MS  },
+	{   3400,  OPT4060_CTRL_CONVERSION_3_4MS  },
+	{   6500,  OPT4060_CTRL_CONVERSION_6_5MS  },
+	{  12700,  OPT4060_CTRL_CONVERSION_12_7MS },
+	{  25000,  OPT4060_CTRL_CONVERSION_25MS   },
+	{  50000,  OPT4060_CTRL_CONVERSION_50MS   },
+	{ 100000,  OPT4060_CTRL_CONVERSION_100MS  },
+	{ 200000,  OPT4060_CTRL_CONVERSION_200MS  },
+	{ 400000,  OPT4060_CTRL_CONVERSION_400MS  },
+	{ 800000,  OPT4060_CTRL_CONVERSION_800MS  },
+};
+
+static int opt4060_als_time_to_index(const u32 als_integration_time)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(opt4060_int_time_available); i++) {
+		if (als_integration_time == opt4060_int_time_available[i][1])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static u8 opt4060_calculate_crc(u8 exp, u32 mantissa, u8 count)
+{
+	u8 crc;
+
+	crc = (hweight32(mantissa) + hweight32(exp) + hweight32(count)) % 2;
+	crc |= ((hweight32(mantissa & 0xAAAAA) + hweight32(exp & 0xA)
+		 + hweight32(count & 0xA)) % 2) << 1;
+	crc |= ((hweight32(mantissa & 0x88888) + hweight32(exp & 0x8)
+		 + hweight32(count & 0x8)) % 2) << 2;
+	crc |= (hweight32(mantissa & 0x80808) % 2) << 3;
+
+	return crc;
+}
+
+static int opt4060_set_int_state(struct opt4060_chip *chip, u32 state)
+{
+	int ret;
+	unsigned int regval;
+
+	regval = FIELD_PREP(OPT4060_INT_CTRL_INT_CFG, state);
+	ret = regmap_update_bits(chip->regmap, OPT4060_INT_CTRL,
+				 OPT4060_INT_CTRL_INT_CFG, regval);
+	if (ret)
+		dev_err(chip->dev, "Failed to set interrupt config\n");
+	return ret;
+}
+
+static int opt4060_trigger_one_shot(struct opt4060_chip *chip)
+{
+	int ret;
+	unsigned int ctrl_reg, oper_mode;
+
+	/* Enable interrupt for conversion ready of all channels */
+	ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_ALL_CH);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(chip->regmap, OPT4060_CTRL, &ctrl_reg);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read ctrl register\n");
+		return ret;
+	}
+
+	oper_mode = FIELD_GET(OPT4060_CTRL_OPER_MODE_MASK, ctrl_reg);
+
+	/* If the device is already in continuous mode, one-shot is not needed. */
+	if (oper_mode != OPT4060_CTRL_OPER_MODE_CONTINUOUS) {
+		ctrl_reg &= ~OPT4060_CTRL_OPER_MODE_MASK;
+		ctrl_reg |= FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
+				       OPT4060_CTRL_OPER_MODE_ONE_SHOT);
+
+		/* Trigger a new conversion by writing to CRTL register. */
+		ret = regmap_write(chip->regmap, OPT4060_CTRL, ctrl_reg);
+		if (ret)
+			dev_err(chip->dev, "Failed to set ctrl register\n");
+	}
+	return ret;
+}
+
+static int opt4060_set_continous_mode(struct opt4060_chip *chip,
+				      bool continuous)
+{
+	u16 reg;
+	int ret;
+
+	if (continuous)
+		reg = FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
+				 OPT4060_CTRL_OPER_MODE_CONTINUOUS);
+	else
+		reg = FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
+				 OPT4060_CTRL_OPER_MODE_ONE_SHOT);
+
+	ret = regmap_update_bits(chip->regmap, OPT4060_CTRL,
+				 OPT4060_CTRL_OPER_MODE_MASK, reg);
+	if (ret)
+		dev_err(chip->dev, "Failed to set configuration\n");
+
+	return ret;
+}
+
+static int opt4060_read_raw_value(struct opt4060_chip *chip,
+				  unsigned long address, u32 *raw)
+{
+	int ret;
+	u32 result;
+	u16 msb;
+	u16 lsb;
+	u8 exp;
+	u8 count;
+	u8 crc;
+	u8 calc_crc;
+	u32 mantissa_raw;
+
+	ret = regmap_bulk_read(chip->regmap, address, &result, 2);
+	if (ret)
+		dev_err(chip->dev, "Reading channel data failed\n");
+	else {
+		count = FIELD_GET(OPT4060_COUNTER_MASK, result >> 16);
+		crc = FIELD_GET(OPT4060_CRC_MASK, result >> 16);
+		lsb = FIELD_GET(OPT4060_LSB_MASK, result >> 16);
+		exp = FIELD_GET(OPT4060_EXPONENT_MASK, result);
+		msb = FIELD_GET(OPT4060_MSB_MASK, result);
+		mantissa_raw = (msb << 8) + lsb;
+		calc_crc = opt4060_calculate_crc(exp, mantissa_raw, count);
+		if (calc_crc != crc)
+			return -EIO;
+
+		*raw = mantissa_raw << exp;
+	}
+	return ret;
+}
+
+static int opt4060_read_chan_value(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan,
+				   int *val, int *val2, bool processed)
+{
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+	u32 adc_raw;
+	int ret;
+	/* Set timeout to two times the integration time multiplied by channel count. */
+	unsigned int timeout_us = 2 * OPT4060_NUM_CHANS *
+				  opt4060_int_time_reg[chip->int_time][0];
+
+	if (chip->irq) {
+		reinit_completion(&chip->completion);
+		ret = opt4060_trigger_one_shot(chip);
+		if (ret)
+			return ret;
+		if (wait_for_completion_timeout(&chip->completion,
+						usecs_to_jiffies(timeout_us)) == 0)
+			dev_info(chip->dev, "Completion timed out.\n");
+	}
+
+	ret = opt4060_read_raw_value(chip, chan->address, &adc_raw);
+	if (ret) {
+		dev_err(chip->dev, "Reading raw channel data failed\n");
+		return ret;
+	}
+	if (processed) {
+		u32 lux_raw;
+		u32 rem;
+		u32 mul = opt4060_channel_factors[chan->scan_index].mul;
+		u32 div = opt4060_channel_factors[chan->scan_index].div;
+
+		lux_raw = adc_raw * mul;
+		*val = div_u64_rem(lux_raw, div, &rem);
+		*val2 = rem * div_u64(div, 10);
+		return IIO_VAL_INT_PLUS_NANO;
+	}
+	*val = adc_raw;
+	*val2 = 0;
+	return IIO_VAL_INT;
+}
+
+static int opt4060_set_conf(struct opt4060_chip *chip)
+{
+	u16 reg;
+	int ret;
+
+	reg = FIELD_PREP(OPT4060_CTRL_RANGE_MASK,
+			 OPT4060_CTRL_LIGHT_SCALE_AUTO);
+	reg |= FIELD_PREP(OPT4060_CTRL_CONV_TIME_MASK, chip->int_time);
+	if (chip->irq)
+		reg |= FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
+				  OPT4060_CTRL_OPER_MODE_ONE_SHOT);
+	else
+		reg |= FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
+				  OPT4060_CTRL_OPER_MODE_CONTINUOUS);
+	reg |= OPT4060_CTRL_QWAKE_MASK | OPT4060_CTRL_LATCH_MASK;
+
+	ret = regmap_write(chip->regmap, OPT4060_CTRL, reg);
+	if (ret)
+		dev_err(chip->dev, "Failed to set configuration\n");
+
+	return ret;
+}
+
+static int opt4060_power_down(struct opt4060_chip *chip)
+{
+	int ret;
+	unsigned int reg;
+
+	ret = regmap_read(chip->regmap, OPT4060_CTRL, &reg);
+	if (ret) {
+		dev_err(chip->dev, "Failed to read configuration\n");
+		return ret;
+	}
+
+	/* MODE_OFF is 0x0 so just set bits to 0 */
+	reg &= ~OPT4060_CTRL_OPER_MODE_MASK;
+
+	ret = regmap_write(chip->regmap, OPT4060_CTRL, reg);
+	if (ret)
+		dev_err(chip->dev, "Failed to power down\n");
+
+	return ret;
+}
+
+static void opt4060_chip_off_action(void *data)
+{
+	struct opt4060_chip *chip = data;
+
+	opt4060_power_down(chip);
+}
+
+#define OPT4060_CHAN(color)							\
+{										\
+	.type = IIO_LIGHT,							\
+	.modified = 1,								\
+	.channel2 = IIO_MOD_LIGHT_##color,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |			\
+			      BIT(IIO_CHAN_INFO_RAW),				\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),			\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),	\
+	.address = OPT4060_##color##_MSB,					\
+	.scan_index = OPT4060_##color,						\
+	.scan_type = {								\
+		.sign = 'u',							\
+		.realbits = 32,							\
+		.storagebits = 32,						\
+		.endianness = IIO_LE,						\
+	},									\
+	.event_spec = opt4060_event_spec,					\
+	.num_event_specs = ARRAY_SIZE(opt4060_event_spec),			\
+}
+
+static const struct iio_event_spec opt4060_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
+	},
+};
+
+static const struct iio_chan_spec opt4060_channels[] = {
+	OPT4060_CHAN(RED),
+	OPT4060_CHAN(GREEN),
+	OPT4060_CHAN(BLUE),
+	OPT4060_CHAN(CLEAR),
+	IIO_CHAN_SOFT_TIMESTAMP(OPT4060_NUM_CHANS),
+};
+
+static int opt4060_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return opt4060_read_chan_value(indio_dev, chan, val, val2,
+					       false);
+	case IIO_CHAN_INFO_PROCESSED:
+		return opt4060_read_chan_value(indio_dev, chan, val, val2,
+					       true);
+	case IIO_CHAN_INFO_INT_TIME:
+		*val = 0;
+		*val2 = opt4060_int_time_reg[chip->int_time][0];
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int opt4060_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+	int int_time;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		int_time = opt4060_als_time_to_index(val2);
+		if (int_time < 0)
+			return int_time;
+		chip->int_time = int_time;
+		return opt4060_set_conf(chip);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int opt4060_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static u32 opt4060_calc_th_reg(u32 adc_val)
+{
+	u32 th_val, th_exp;
+	u32 bits;
+	/*
+	 * The threshold registers take 4 bits of exponent and 12 bits of data
+	 * ADC = TH_VAL << (8 + TH_EXP)
+	 */
+	bits = fls(adc_val);
+
+	if (bits > 31)
+		th_exp = 11; /* Maximum exponent */
+	else if (bits > 20)
+		th_exp = bits - 20;
+	else
+		th_exp = 0;
+	th_val = (adc_val >> (8 + th_exp)) & 0xfff;
+
+	return (th_exp << 12) + th_val;
+}
+
+static u32 opt4060_calc_val_from_th_reg(u32 th_reg)
+{
+	/*
+	 * The threshold registers take 4 bits of exponent and 12 bits of data
+	 * ADC = TH_VAL << (8 + TH_EXP)
+	 */
+	u32 th_val, th_exp;
+
+	th_exp = (th_reg >> 12) & 0xf;
+	th_val = th_reg & 0xfff;
+
+	return th_val << (8 + th_exp);
+}
+
+static bool opt4060_event_active(struct opt4060_chip *chip)
+{
+	return chip->thresh_event_lo_active || chip->thresh_event_hi_active;
+}
+
+static int opt4060_read_available(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  const int **vals, int *type, int *length,
+				  long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*length = ARRAY_SIZE(opt4060_int_time_available) * 2;
+		*vals = (const int *)opt4060_int_time_available;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+
+static int opt4060_event_set_state(struct opt4060_chip *chip, bool state)
+{
+	int ret = 0;
+
+	if (state)
+		ret = opt4060_set_continous_mode(chip, true);
+	else if (!chip->data_trigger_active && chip->irq)
+		ret = opt4060_set_continous_mode(chip, false);
+
+	return ret;
+}
+
+static int opt4060_trigger_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (indio_dev->trig) {
+		iio_trigger_put(indio_dev->trig);
+		indio_dev->trig = NULL;
+	}
+
+	if (state) {
+		indio_dev->trig = iio_trigger_get(trig);
+		ret = opt4060_set_continous_mode(chip, true);
+	} else if (!opt4060_event_active(chip) && chip->irq)
+		ret = opt4060_set_continous_mode(chip, false);
+
+	if (trig == chip->data_trig) {
+		chip->data_trigger_active = state;
+		chip->threshold_trigger_active = !state;
+	} else if (trig == chip->threshold_trig) {
+		chip->data_trigger_active = !state;
+		chip->threshold_trigger_active = state;
+	}
+
+	return ret;
+}
+
+static ssize_t opt4060_read_ev_period(struct opt4060_chip *chip, int *val,
+				     int *val2)
+{
+	int ret, pers, fault_count, int_time;
+	u64 uval;
+
+	int_time = opt4060_int_time_reg[chip->int_time][0];
+
+	ret = regmap_read(chip->regmap, OPT4060_CTRL, &fault_count);
+	if (ret < 0)
+		return ret;
+
+	fault_count = fault_count & OPT4060_CTRL_FAULT_COUNT_MASK;
+	switch (fault_count) {
+	case OPT4060_CTRL_FAULT_COUNT_2:
+		pers = 2;
+		break;
+	case OPT4060_CTRL_FAULT_COUNT_4:
+		pers = 4;
+		break;
+	case OPT4060_CTRL_FAULT_COUNT_8:
+		pers = 8;
+		break;
+
+	default:
+		pers = 1;
+	}
+
+	uval = mul_u32_u32(int_time, pers);
+	*val = div_u64_rem(uval, MICRO, val2);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static ssize_t opt4060_write_ev_period(struct opt4060_chip *chip, int val,
+				      int val2)
+{
+	u64 uval, int_time;
+	unsigned int regval, fault_count_val;
+
+	uval = mul_u32_u32(val, MICRO) + val2;
+	int_time = opt4060_int_time_reg[chip->int_time][0];
+
+	/* Check if the period is closest to 1, 2, 4 or 8 times integration time.*/
+	if (uval <= int_time)
+		fault_count_val = OPT4060_CTRL_FAULT_COUNT_1;
+	else if (uval <= int_time * 2)
+		fault_count_val = OPT4060_CTRL_FAULT_COUNT_2;
+	else if (uval <= int_time * 4)
+		fault_count_val = OPT4060_CTRL_FAULT_COUNT_4;
+	else
+		fault_count_val = OPT4060_CTRL_FAULT_COUNT_8;
+
+	regval = FIELD_PREP(OPT4060_CTRL_FAULT_COUNT_MASK, fault_count_val);
+	return regmap_update_bits(chip->regmap, OPT4060_CTRL,
+				 OPT4060_CTRL_FAULT_COUNT_MASK, regval);
+}
+
+static int opt4060_get_channel_sel(struct opt4060_chip *chip, int *ch_sel)
+{
+	int ret;
+	u32 regval;
+
+	ret = regmap_read(chip->regmap, OPT4060_INT_CTRL, &regval);
+	if (ret)
+		dev_err(chip->dev, "Failed to get channel selection.\n");
+	else
+		*ch_sel = FIELD_GET(OPT4060_INT_CTRL_THRESH_SEL, regval);
+	return ret;
+}
+
+static int opt4060_set_channel_sel(struct opt4060_chip *chip, int ch_sel)
+{
+	int ret;
+	u32 regval;
+
+	regval = FIELD_PREP(OPT4060_INT_CTRL_THRESH_SEL, ch_sel);
+	ret = regmap_update_bits(chip->regmap, OPT4060_INT_CTRL,
+				 OPT4060_INT_CTRL_THRESH_SEL, regval);
+	if (ret)
+		dev_err(chip->dev, "Failed to set channel selection.\n");
+	return ret;
+}
+
+static int opt4060_get_thresholds(struct opt4060_chip *chip, u32 *th_lo, u32 *th_hi)
+{
+	int ret;
+	u32 regval;
+
+	ret = regmap_read(chip->regmap, OPT4060_THRESHOLD_LOW, &regval);
+	if (ret) {
+		dev_err(chip->dev, "Failed to read THRESHOLD_LOW.\n");
+		return ret;
+	}
+	*th_lo = opt4060_calc_val_from_th_reg(regval);
+
+	ret = regmap_read(chip->regmap, OPT4060_THRESHOLD_HIGH, &regval);
+	if (ret) {
+		dev_err(chip->dev, "Failed to read THRESHOLD_LOW.\n");
+		return ret;
+	}
+	*th_hi = opt4060_calc_val_from_th_reg(regval);
+
+	return ret;
+}
+
+static int opt4060_set_thresholds(struct opt4060_chip *chip, u32 th_lo, u32 th_hi)
+{
+	int ret;
+
+	ret = regmap_write(chip->regmap, OPT4060_THRESHOLD_LOW, opt4060_calc_th_reg(th_lo));
+	if (ret) {
+		dev_err(chip->dev, "Failed to write THRESHOLD_LOW.\n");
+		return ret;
+	}
+
+	ret = regmap_write(chip->regmap, OPT4060_THRESHOLD_HIGH, opt4060_calc_th_reg(th_hi));
+	if (ret)
+		dev_err(chip->dev, "Failed to write THRESHOLD_HIGH.\n");
+
+	return ret;
+}
+
+static int opt4060_read_event(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      enum iio_event_type type,
+			      enum iio_event_direction dir,
+			      enum iio_event_info info,
+			      int *val, int *val2)
+{
+	int ret = -EINVAL;
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (chan->type == IIO_LIGHT && type == IIO_EV_TYPE_THRESH) {
+			u32 th_lo, th_hi;
+
+			if (opt4060_get_thresholds(chip, &th_lo, &th_hi))
+				return -EFAULT;
+			if (dir == IIO_EV_DIR_FALLING) {
+				*val = th_lo;
+				ret = IIO_VAL_INT;
+			} else if (dir == IIO_EV_DIR_RISING) {
+				*val = th_hi;
+				ret = IIO_VAL_INT;
+			}
+		}
+		break;
+	case IIO_EV_INFO_PERIOD:
+		return opt4060_read_ev_period(chip, val, val2);
+	default:
+		return -EINVAL;
+	}
+	return ret;
+}
+
+static int opt4060_write_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int val, int val2)
+{
+	int ret = -EINVAL;
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (chan->type == IIO_LIGHT && type == IIO_EV_TYPE_THRESH) {
+			u32 th_lo, th_hi;
+
+			if (opt4060_get_thresholds(chip, &th_lo, &th_hi))
+				return -EFAULT;
+			if (dir == IIO_EV_DIR_FALLING)
+				th_lo = val;
+			else if (dir == IIO_EV_DIR_RISING)
+				th_hi = val;
+			if (opt4060_set_thresholds(chip, th_lo, th_hi))
+				return -EFAULT;
+			ret = 0;
+		}
+		break;
+	case IIO_EV_INFO_PERIOD:
+		return opt4060_write_ev_period(chip, val, val2);
+	default:
+		return -EINVAL;
+	}
+	return ret;
+}
+
+static int opt4060_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	int ret = -EINVAL;
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+
+	if (chan->type == IIO_LIGHT && type == IIO_EV_TYPE_THRESH) {
+		int ch_idx = chan->scan_index;
+		int ch_sel;
+
+		if (opt4060_get_channel_sel(chip, &ch_sel))
+			return -EFAULT;
+
+		if (((dir == IIO_EV_DIR_FALLING) && chip->thresh_event_lo_active) ||
+		    ((dir == IIO_EV_DIR_RISING) && chip->thresh_event_hi_active))
+			ret = (ch_sel == ch_idx);
+		else
+			ret = FALSE;
+	}
+	return ret;
+}
+
+static int opt4060_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir, int state)
+{
+	int ret = -EINVAL;
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+
+	if (chan->type == IIO_LIGHT && type == IIO_EV_TYPE_THRESH) {
+		int ch_idx = chan->scan_index;
+		int ch_sel;
+
+		if (opt4060_get_channel_sel(chip, &ch_sel))
+			return -EFAULT;
+
+		if (state) {
+			/* Only one channel can be active at the same time */
+			if ((chip->thresh_event_lo_active ||
+			     chip->thresh_event_hi_active) && (ch_idx != ch_sel))
+				return -EBUSY;
+			if (dir == IIO_EV_DIR_FALLING)
+				chip->thresh_event_lo_active = TRUE;
+			else if (dir == IIO_EV_DIR_RISING)
+				chip->thresh_event_hi_active = TRUE;
+			if (opt4060_set_channel_sel(chip, ch_idx))
+				return -EFAULT;
+			ret = 0;
+		} else {
+			if (ch_idx == ch_sel) {
+				if (dir == IIO_EV_DIR_FALLING)
+					chip->thresh_event_lo_active = FALSE;
+				else if (dir == IIO_EV_DIR_RISING)
+					chip->thresh_event_hi_active = FALSE;
+			}
+			ret = 0;
+		}
+
+		if (opt4060_event_set_state(chip, chip->thresh_event_hi_active |
+					    chip->thresh_event_lo_active))
+			return -EFAULT;
+	}
+	return ret;
+}
+
+static const struct iio_info opt4060_info = {
+	.read_raw = opt4060_read_raw,
+	.write_raw = opt4060_write_raw,
+	.write_raw_get_fmt = opt4060_write_raw_get_fmt,
+	.read_avail = opt4060_read_available,
+	.read_event_value = opt4060_read_event,
+	.write_event_value = opt4060_write_event,
+	.read_event_config = opt4060_read_event_config,
+	.write_event_config = opt4060_write_event_config,
+};
+
+static int opt4060_load_defaults(struct opt4060_chip *chip)
+{
+	int ret;
+
+	chip->int_time = OPT4060_DEFAULT_CONVERSION_TIME;
+
+	/* Set initial MIN/MAX thresholds */
+	ret = opt4060_set_thresholds(chip, 0, UINT_MAX);
+	if (ret)
+		return ret;
+
+	return opt4060_set_conf(chip);
+}
+
+static bool opt4060_volatile_reg(struct device *dev, unsigned int reg)
+{
+	if ((reg >= OPT4060_RED_MSB && reg <= OPT4060_CLEAR_LSB) ||
+	    reg == OPT4060_RES_CTRL)
+		return true;
+	return false;
+}
+
+static bool opt4060_writable_reg(struct device *dev, unsigned int reg)
+{
+	if (reg >= OPT4060_THRESHOLD_LOW || reg >= OPT4060_INT_CTRL)
+		return true;
+	return false;
+}
+
+static bool opt4060_readonly_reg(struct device *dev, unsigned int reg)
+{
+	if (reg == OPT4060_DEVICE_ID)
+		return true;
+	return false;
+}
+
+static bool opt4060_readable_reg(struct device *dev, unsigned int reg)
+{
+	/* Volatile, writable and read-only registers are readable. */
+	if (opt4060_volatile_reg(dev, reg) || opt4060_writable_reg(dev, reg) ||
+	    opt4060_readonly_reg(dev, reg))
+		return TRUE;
+	return false;
+}
+
+static const struct regmap_config opt4060_regmap_config = {
+	.name = OPT_4060_DRV_NAME,
+	.reg_bits = 8,
+	.val_bits = 16,
+	.cache_type = REGCACHE_RBTREE,
+	.max_register = OPT4060_DEVICE_ID,
+	.readable_reg = opt4060_readable_reg,
+	.writeable_reg = opt4060_writable_reg,
+	.volatile_reg = opt4060_volatile_reg,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+
+static const struct iio_trigger_ops opt4060_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+	.set_trigger_state = opt4060_trigger_set_state,
+};
+
+static irqreturn_t opt4060_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *idev = pf->indio_dev;
+	struct opt4060_chip *chip = iio_priv(idev);
+	struct opt4060_buffer raw;
+	int ret, chan;
+	int i = 0;
+
+	memset(&raw, 0, sizeof(raw));
+
+	for_each_set_bit(chan, idev->active_scan_mask, idev->masklength) {
+		ret = opt4060_read_raw_value(chip,
+					     opt4060_channels[chan].address,
+					     &raw.chan[i++]);
+		if (ret) {
+			dev_err(chip->dev, "Reading raw channel data failed\n");
+			goto err_read;
+		}
+	}
+
+	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
+err_read:
+	iio_trigger_notify_done(idev->trig);
+	return IRQ_HANDLED;
+}
+
+static int opt4060_buffer_preenable(struct iio_dev *idev)
+{
+	struct opt4060_chip *chip = iio_priv(idev);
+
+	return opt4060_trigger_one_shot(chip);
+}
+
+static const struct iio_buffer_setup_ops opt4060_buffer_ops = {
+	.preenable = opt4060_buffer_preenable,
+};
+
+static irqreturn_t opt4060_irq_thread(int irq, void *private)
+{
+	struct iio_dev *idev = private;
+	struct opt4060_chip *chip = iio_priv(idev);
+	int ret, chan, dummy;
+	unsigned int int_res;
+
+	ret = regmap_read(chip->regmap, OPT4060_RES_CTRL, &int_res);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read interrupt reasons.\n");
+		return IRQ_NONE;
+	}
+
+	if (!chip->data_trigger_active) {
+		/* Only trigger interrupts on thresholds */
+		ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_THRESHOLD);
+		if (ret) {
+			dev_err(chip->dev, "Failed to set interrupt state\n");
+			return IRQ_NONE;
+		}
+	}
+
+	/* Read OPT4060_CTRL to clear interrupt */
+	ret = regmap_read(chip->regmap, OPT4060_CTRL, &dummy);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to clear interrupt\n");
+		return IRQ_NONE;
+	}
+
+	/* Handle events */
+	if (int_res & (OPT4060_RES_CTRL_FLAG_H | OPT4060_RES_CTRL_FLAG_L)) {
+		u64 code;
+
+		/* Check if the interrupt is from the lower threshold */
+		if (int_res & OPT4060_RES_CTRL_FLAG_L) {
+			code = IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
+							chan,
+							IIO_EV_TYPE_THRESH,
+							IIO_EV_DIR_FALLING);
+			iio_push_event(idev, code,
+					iio_get_time_ns(idev));
+		}
+		/* Check if the interrupt is from the upper threshold */
+		if (int_res & OPT4060_RES_CTRL_FLAG_H) {
+			code = IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
+							chan,
+							IIO_EV_TYPE_THRESH,
+							IIO_EV_DIR_RISING);
+			iio_push_event(idev, code,
+					iio_get_time_ns(idev));
+		}
+		/* Handle threshold triggers */
+		if (chip->threshold_trigger_active && iio_buffer_enabled(idev))
+			iio_trigger_poll_nested(chip->threshold_trig);
+	}
+
+	/* Handle conversion ready */
+	if (int_res & OPT4060_RES_CTRL_CONV_READY) {
+		/* Signal completion for potentially waiting reads */
+		complete(&chip->completion);
+
+		/* Handle data ready triggers */
+		if (chip->data_trigger_active && iio_buffer_enabled(idev))
+			iio_trigger_poll_nested(chip->data_trig);
+	}
+	return IRQ_HANDLED;
+}
+
+static int opt4060_setup_triggers(struct opt4060_chip *chip, struct iio_dev *idev)
+{
+	struct iio_trigger *data_trigger;
+	struct iio_trigger *threshold_trigger;
+	char *name;
+	int ret;
+
+	ret = devm_iio_triggered_buffer_setup(chip->dev, idev,
+					      &iio_pollfunc_store_time,
+					      opt4060_trigger_handler,
+					      &opt4060_buffer_ops);
+	if (ret)
+		return dev_err_probe(chip->dev, ret,
+			     "iio_triggered_buffer_setup_ext FAIL\n");
+
+	data_trigger = devm_iio_trigger_alloc(chip->dev, "%s-data-ready-dev%d",
+				       idev->name, iio_device_id(idev));
+	if (!data_trigger)
+		return -ENOMEM;
+	chip->data_trig = data_trigger;
+	data_trigger->ops = &opt4060_trigger_ops;
+	iio_trigger_set_drvdata(data_trigger, idev);
+	ret = devm_iio_trigger_register(chip->dev, data_trigger);
+	if (ret)
+		return dev_err_probe(chip->dev, ret,
+				     "Data ready trigger registration failed\n");
+
+	threshold_trigger = devm_iio_trigger_alloc(chip->dev, "%s-threshold-dev%d",
+				       idev->name, iio_device_id(idev));
+	if (!threshold_trigger)
+		return -ENOMEM;
+	chip->threshold_trig = threshold_trigger;
+	threshold_trigger->ops = &opt4060_trigger_ops;
+	iio_trigger_set_drvdata(threshold_trigger, idev);
+	ret = devm_iio_trigger_register(chip->dev, threshold_trigger);
+	if (ret)
+		return dev_err_probe(chip->dev, ret,
+				     "Threshold trigger registration failed\n");
+
+
+	name = devm_kasprintf(chip->dev, GFP_KERNEL, "%s-opt4060",
+			      dev_name(chip->dev));
+
+	ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL, opt4060_irq_thread,
+					IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
+					IRQF_ONESHOT, name, idev);
+	if (ret)
+		return dev_err_probe(chip->dev, ret, "Could not request IRQ\n");
+
+	ret = regmap_write_bits(chip->regmap, OPT4060_INT_CTRL,
+				OPT4060_INT_CTRL_OUTPUT,
+				OPT4060_INT_CTRL_OUTPUT);
+	if (ret)
+		return dev_err_probe(chip->dev, ret,
+				     "Failed to set interrupt as output\n");
+
+	return 0;
+}
+
+static int opt4060_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct opt4060_chip *chip;
+	struct iio_dev *indio_dev;
+	int ret;
+	uint dev_id;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	chip = iio_priv(indio_dev);
+
+	/* Request regulator */
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable vdd supply\n");
+
+	chip->regmap = devm_regmap_init_i2c(client, &opt4060_regmap_config);
+	if (IS_ERR(chip->regmap))
+		return dev_err_probe(dev, PTR_ERR(chip->regmap),
+				     "regmap initialization failed\n");
+
+	chip->dev = dev;
+	chip->irq = client->irq;
+	init_completion(&chip->completion);
+
+	indio_dev->info = &opt4060_info;
+
+	ret = regmap_reinit_cache(chip->regmap, &opt4060_regmap_config);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to reinit regmap cache\n");
+
+	ret = regmap_read(chip->regmap, OPT4060_DEVICE_ID, &dev_id);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+			"Failed to read the device ID register\n");
+
+	dev_id = FIELD_GET(OPT4060_DEVICE_ID_MASK, dev_id);
+	if (dev_id != OPT4060_DEVICE_ID_VAL)
+		dev_warn(dev, "Device ID: %#04x unknown\n", dev_id);
+
+	indio_dev->channels = opt4060_channels;
+	indio_dev->num_channels = ARRAY_SIZE(opt4060_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = OPT_4060_DRV_NAME;
+
+	/* Initialize device with default settings */
+	ret = opt4060_load_defaults(chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to set sensor defaults\n");
+
+	/* If irq is enabled, initialize triggers */
+	if (chip->irq) {
+		ret = opt4060_setup_triggers(chip, indio_dev);
+		if (ret)
+			return ret;
+	} else {
+		dev_info(chip->dev, "No IRQ, events and triggers disabled\n");
+	}
+
+	ret = devm_add_action_or_reset(dev, opt4060_chip_off_action, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to setup power off action\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+/*
+ * The compatible string determines which constants to use depending on
+ * opt4060 packaging
+ */
+static const struct i2c_device_id opt4060_id[] = {
+	{ OPT_4060_DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, opt4060_id);
+
+static const struct of_device_id opt4060_of_match[] = {
+	{ .compatible = "ti,opt4060" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, opt4060_of_match);
+
+static struct i2c_driver opt4060_driver = {
+	.driver = {
+		.name = OPT_4060_DRV_NAME,
+		.of_match_table = opt4060_of_match,
+	},
+	.probe = opt4060_probe,
+	.id_table = opt4060_id,
+};
+module_i2c_driver(opt4060_driver);
+
+MODULE_DESCRIPTION("Texas Instruments opt4060 RGBW color sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


