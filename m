Return-Path: <linux-iio+bounces-15063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC38A2A0D0
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 07:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B6418831CD
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 06:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C771FF5FC;
	Thu,  6 Feb 2025 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="BD8g5mdK"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F2A190685;
	Thu,  6 Feb 2025 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738822592; cv=fail; b=igdJHNETGnVdHsY3WCOrMLMZJ2B2zqfOyRDwH4sZ29evqc1V5UwmLKX5vkt93Z4h1RQQdyY9fvruA5rUPmrYryMqZAvqkqeM/ixN+0RITOe8DKyyUrdHkE43z0PmdTyH6NKEZuLU9+m+GH4H8Y6JRrLv5C6eLvskIwWPdwUiM0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738822592; c=relaxed/simple;
	bh=oxKF5rExgfNfrxgeLQePoyKKi1Aq5U6+mukGyD0UuUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMFI3kB5iitDKUFVmFYN9tjp5NwoozWk73b+aXDxKzvY7qvHFMzcZUqaNHzamiOLArvOSnVMg1fJkSVZ0JOvcyQ+d3WRxh7azJtF8ewZTST82Vp3JdAE/gCXcVSpfGd5knScr5KwMhDB2zLdkM1c0y2r3mbmCbyLJm0oPdtYbSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=BD8g5mdK; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhQLMmdDIOBH0HyKHiwcuF63kixGkKtEPJtil11ewWhRpHJcP+OsexUenhnIPFb5tKm1eQ9G+ZCEtvXmAsn/sHMqvK7klAdQpNYXDJed9CDSr+7MnL8TFUnRneJHXUJjxVpHfIYpBNe9qViODX9R+VlpZEfEoFXTJPIFJ0OZ/ju+2+PaWI19mimY4wOCWokHkteJxgIKeWcfUoy3l/xRu0KFnFY6nhbv4UJxoZcqbno+ToslL+pTaozT84Rhnjj/pXsj+0DihW9xglj/aW6tAg7uk0v07WyIDRxKtRNZCBtxLiTdiLoNYsjjTvmZhCLBFNyAdxgEXWxvt3BO2KDwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMyklRcySIntw3jeqybkgUeWqn1UUuDiBPunucr4QZQ=;
 b=BcLUIrgn8cxK7KVDsVIif3KM7GhYqjYBjPen5dEUg5YmWnCnfGKMNrltJEY3/oFtagCsjnUMjWghAkvR/BDJkOTpT2xLTHh48K/t0b0plCvtds0xtRf25pl8a8mbryBNOXwc3GyoGhP7hLo/2ycJMVcaiebRlepjfpzmNLS4+NI5t/wyMziQvA0F+x/DgdKQujk+MT/PoHCrtCx5FGMfpvywYpZ3N1LNF9dySkn0sFkQ3GPGI8FQMRkbpCzf/K2r0haZu5cr/3fHnQQyglkQ578TZppmXWMIYQe+tpgd1M+/CgpZ1+PvT51SEN7qxMg+TmPn+1qGAV/k3n8siDuE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMyklRcySIntw3jeqybkgUeWqn1UUuDiBPunucr4QZQ=;
 b=BD8g5mdK+6+O/v3GRJSmgPOlkAEpef0mp0PeW2VkroSSh864S2wnNneGk7CgSjwECkGCL4QnXwXpSexpm9WM2EzJ3/WOxissFq16Eh8m5iQvu86WrW/KFCAhZdPhprIUWYuMUDW3cu8lDgaXNOqZKe8YCySpFv9Ui05TqLyDnFM=
Received: from AS9PR06CA0381.eurprd06.prod.outlook.com (2603:10a6:20b:460::28)
 by AS8PR02MB8319.eurprd02.prod.outlook.com (2603:10a6:20b:524::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 06:16:22 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:460:cafe::2c) by AS9PR06CA0381.outlook.office365.com
 (2603:10a6:20b:460::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Thu,
 6 Feb 2025 06:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 06:16:22 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 6 Feb
 2025 07:16:21 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 6 Feb
 2025 07:16:21 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 6 Feb 2025 07:16:21 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id AF36B462;
	Thu,  6 Feb 2025 07:16:18 +0100 (CET)
From: Hermes Zhang <Hermes.Zhang@axis.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <lars@metafoo.de>,
	<krzk+dt@kernel.org>
CC: <kernel@axis.com>, Hermes Zhang <Hermes.Zhang@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH 3/3] iio: chemical: add support for Sensirion SEN5x/SEN6x
Date: Thu, 6 Feb 2025 14:15:17 +0800
Message-ID: <20250206061521.2546108-4-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
References: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B7:EE_|AS8PR02MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: fc426ee2-ad44-4ba9-8e0e-08dd4675c773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jP2U/YJKdPaXJ80vxWvPtyagX+kPpXFRa4dGSMNQjvyUN4sNCjbAKjQFxGjO?=
 =?us-ascii?Q?nDrWKlzq0oudPM+XWU6asX5Cwn1IR1Cjw4s5S9EuMHVakQQIMCxXH09W626r?=
 =?us-ascii?Q?Wv6SNfsShJfT6Ut2MJ6uYXBUlv/D4sryC5JbiJDzskXSRqmfqTfQbfeOv1ge?=
 =?us-ascii?Q?hnYzM1UKSRHL9MPazhngYXEU4yLBk3aJEvWGLsnklc9Ob7niZ9FMOnzmLdmZ?=
 =?us-ascii?Q?H5EoElw3nyzBdL1eQvzAnEpo4i+gKOpiThRtZM7uRm1F02Ezbspe7gwJFLTt?=
 =?us-ascii?Q?Ccn7vA93hqyJ9+Im7wv29T7pcarAhW5ir6CE07+sMTV020ugDJy/82PAGBNe?=
 =?us-ascii?Q?13DM2qcVdXyIpLx3CUh0jcN2jw/M2WWT2A2YSwZRQwgXNXvI3g6PGqZvc/UL?=
 =?us-ascii?Q?TZsC5Hi48ezGIsND3xoHwtjlRgBFBUbMEs80flnQKoi288+2cIpj/MFR7cfl?=
 =?us-ascii?Q?E/RZWhnD5+KhQvWRdzACCvWxmiXRauOdlWiXTs9fDtbeo66F7XCg8+bpbaeQ?=
 =?us-ascii?Q?LSgq2RG3yhJHES2mNYB88aPEPWYRvDlRZ7p4yS29FKsVp1xvJhQp4qZcFDCO?=
 =?us-ascii?Q?wZYMu4ivLX+RmhLTXAMcBcjMnFJpsg67tYQfGA0X/AgXjvBQjOoT/8A8mulH?=
 =?us-ascii?Q?sQQUvDXhKlt5FsBFeE6URKtfdVQsiyRfQ3f2yCMS8a3B9CBjGHHgDv9XEao6?=
 =?us-ascii?Q?z4FB0rMi5Xbt5v3DCvh+JofkVAEGDc/6IfgwR8lxY5ESvWDtY1WjXq4UYmR1?=
 =?us-ascii?Q?FnKfd2Td1+eHeTNk4Jz2v4Di/ugRl0xYdqhmGJO2VWTUCWPiQ/YNvL66hG8n?=
 =?us-ascii?Q?Q55LgyJe6Ykb8vVBY2Az3T44veWnE22QP9wU+xhUx3FAnjXPfmiIodIC532n?=
 =?us-ascii?Q?uNrPnnnX+4mpc/uyf+rAzzTG+cUtA5q2GuXpYPALiAVp7+n3tFYvq7H9k0Gu?=
 =?us-ascii?Q?ktbNLTku+a8kTdKvdwYDqJEIxpDubGTITJUUuoOw75QMyFQExtnQmHX+T420?=
 =?us-ascii?Q?2M3n03p39TDKOMfhgN9t58bJ1dAeQDIVin9aqrjiXsLnwWBqdKAr9lEUC0jY?=
 =?us-ascii?Q?OBYl+b/EJ669qZzT8izOmxw4tR+ZfrfwYEwju758/lz2O4GUlryj21opXuC0?=
 =?us-ascii?Q?MoFmYKe74Qk0M+3Cf6VgjGEnvhkWmoPARZh6uBMmAHLTyYnsxWNV8g09jVsk?=
 =?us-ascii?Q?9h4Y1KwppFgRLXmQMKkF/22puW54fRX2nSeZsW4SRAOq82ZplJeMmopiz82E?=
 =?us-ascii?Q?xuWNUDewZxTKk0yHiXXzNzUmTuFyatV1J+TCvTST59Hdn2QJ6UZ6OV/GAdfx?=
 =?us-ascii?Q?O5XNVutSdFl7K/J/OGxDbPmzfm4QYs+e4jO3pmUhpx8lzn4EU2S3FhbjMpZz?=
 =?us-ascii?Q?dm5IaIT7jLdRsYvcx8vXKzJJTbT87/qAGLQRlnbtS0ZatCIKUnKR1FWWY+o7?=
 =?us-ascii?Q?0R+C4UeIiOgzHXgsl2Fi+tP5TVW1paOhY17KxKcXeE4uw65WdvqS8tIDhCnL?=
 =?us-ascii?Q?kpmnbkMvwF9ISxc=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 06:16:22.7366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc426ee2-ad44-4ba9-8e0e-08dd4675c773
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8319

Add support for the Senseair SEN5x/SEN6x environment sensor through the
IIO subsystem, include SEN50, SEN54, SEN55, SEN60, SEN65 and SEN66.
Different sensor channels will be supported in different models:

SEN50: PM1, PM2.5, PM4, PM10
SEN54: PM1, PM2.5, PM4, PM10, Humidity, Temperature, VOC
SEN55: PM1, PM2.5, PM4, PM10, Humidity, Temperature, VOC, NOx

SEN60: PM1, PM2.5, PM4, PM10
SEN65: PM1, PM2.5, PM4, PM10, Humidity, Temperature, VOC, NOx
SEN66: PM1, PM2.5, PM4, PM10, Humidity, Temperature, VOC, NOx, CO2

The driver support to read sensor data from raw data or iio buffer with
software trigger configured.

Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
---
 drivers/iio/chemical/Kconfig      |  27 ++
 drivers/iio/chemical/Makefile     |   3 +
 drivers/iio/chemical/sen5x.c      |  76 +++++
 drivers/iio/chemical/sen6x.c      |  76 +++++
 drivers/iio/chemical/sen_common.c | 464 ++++++++++++++++++++++++++++++
 drivers/iio/chemical/sen_common.h |  29 ++
 6 files changed, 675 insertions(+)
 create mode 100644 drivers/iio/chemical/sen5x.c
 create mode 100644 drivers/iio/chemical/sen6x.c
 create mode 100644 drivers/iio/chemical/sen_common.c
 create mode 100644 drivers/iio/chemical/sen_common.h

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 330fe0af946f..8a21ac74d12b 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -166,6 +166,33 @@ config SCD4X
 	  To compile this driver as a module, choose M here: the module will
 	  be called scd4x.
 
+config SENSIRION_SEN_COMMON
+	tristate
+	depends on I2C
+	select CRC8
+	help
+	  Common Sensirion environmental sensor code
+
+config SENSIRION_SEN5X
+	tristate "Sensirion SEN5x environmental sensor"
+	select SENSIRION_SEN_COMMON
+	help
+	  Say Y here to build support for the Sensirion SEN5x environmental
+	  sensor driver.
+
+	  To compile this driver as module, choose M here: the module will
+	  be called sen5x.
+
+config SENSIRION_SEN6X
+	tristate "Sensirion SEN6x environmental sensor"
+	select SENSIRION_SEN_COMMON
+	help
+	  Say Y here to build support for the Sensirion SEN6x environmental
+	  sensor driver.
+
+	  To compile this driver as module, choose M here: the module will
+	  be called sen6x.
+
 config SENSIRION_SGP30
 	tristate "Sensirion SGPxx gas sensors"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 4866db06bdc9..988c929383d4 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -21,6 +21,9 @@ obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
 obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
 obj-$(CONFIG_SCD4X) += scd4x.o
 obj-$(CONFIG_SENSEAIR_SUNRISE_CO2) += sunrise_co2.o
+obj-$(CONFIG_SENSIRION_SEN_COMMON)	+= sen_common.o
+obj-$(CONFIG_SENSIRION_SEN5X)	+= sen5x.o
+obj-$(CONFIG_SENSIRION_SEN6X)	+= sen6x.o
 obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
 obj-$(CONFIG_SENSIRION_SGP40)	+= sgp40.o
 obj-$(CONFIG_SPS30) += sps30.o
diff --git a/drivers/iio/chemical/sen5x.c b/drivers/iio/chemical/sen5x.c
new file mode 100644
index 000000000000..ddd1cbf18d0c
--- /dev/null
+++ b/drivers/iio/chemical/sen5x.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "sen_common.h"
+
+#define SEN50_NUM_CHANNELS 4 /* PM1,PM2.5,PM4,PM10 */
+#define SEN54_NUM_CHANNELS 7 /* PM1,PM2.5,PM4,PM10,RHT,TEMP,VOC */
+#define SEN55_NUM_CHANNELS 8 /* PM1,PM2.5,PM4,PM10,RHT,TEMP,VOC,NOx */
+
+#define SEN5X_RESET_DELAY 100
+
+#define SEN5X_READ_MEASURED 0x03C4
+
+enum {
+	SEN50,
+	SEN54,
+	SEN55,
+};
+
+static const struct sen_chip_info sen5x_chips[] = {
+	[SEN50] = {
+		.reset_delay = SEN5X_RESET_DELAY,
+		.num_iio_channels = SEN50_NUM_CHANNELS,
+		.read_measured_cmd = SEN5X_READ_MEASURED,
+		.read_measured_rx_size = 24,
+		.temperature_compensation_required = false,
+	},
+	[SEN54] = {
+		.reset_delay = SEN5X_RESET_DELAY,
+		.num_iio_channels = SEN54_NUM_CHANNELS,
+		.read_measured_cmd = SEN5X_READ_MEASURED,
+		.read_measured_rx_size = 24,
+		.temperature_compensation_required = true,
+	},
+	[SEN55] = {
+		.reset_delay = SEN5X_RESET_DELAY,
+		.num_iio_channels = SEN55_NUM_CHANNELS,
+		.read_measured_cmd = SEN5X_READ_MEASURED,
+		.read_measured_rx_size = 24,
+		.temperature_compensation_required = true,
+	},
+};
+
+static int sen5x_probe(struct i2c_client *client)
+{
+	return sen_common_probe(client);
+}
+
+static const struct i2c_device_id sen5x_id[] = {
+						 { "sen50", },
+						 { "sen54", },
+						 { "sen55", },
+						 {} };
+
+MODULE_DEVICE_TABLE(i2c, sen5x_id);
+
+static const struct of_device_id sen5x_dt_ids[] = {
+	{ .compatible = "sensirion,sen50", .data = &sen5x_chips[SEN50] },
+	{ .compatible = "sensirion,sen54", .data = &sen5x_chips[SEN54] },
+	{ .compatible = "sensirion,sen55", .data = &sen5x_chips[SEN55] },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, sen5x_dt_ids);
+
+static struct i2c_driver sen5x_driver = {
+	.driver = {
+		.name = "sen5x",
+		.of_match_table = sen5x_dt_ids,
+	},
+	.probe = sen5x_probe,
+	.id_table = sen5x_id,
+};
+module_i2c_driver(sen5x_driver);
+
+MODULE_DESCRIPTION("Sensirion SEN5x environmental sensor");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/chemical/sen6x.c b/drivers/iio/chemical/sen6x.c
new file mode 100644
index 000000000000..ba99242f30ef
--- /dev/null
+++ b/drivers/iio/chemical/sen6x.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "sen_common.h"
+
+#define SEN60_NUM_CHANNELS 4 /* PM1,PM2.5,PM4,PM10 */
+#define SEN65_NUM_CHANNELS 8 /* PM1,PM2.5,PM4,PM10,RHT,TEMP,VOC,NOx */
+#define SEN66_NUM_CHANNELS 9 /* PM1,PM2.5,PM4,PM10,RHT,TEMP,VOC,NOx,CO2 */
+
+#define SEN6X_RESET_DELAY 1200
+
+#define SEN6X_READ_MEASURED 0x0300
+
+enum {
+	SEN60,
+	SEN65,
+	SEN66,
+};
+
+static const struct sen_chip_info sen6x_chips[] = {
+	[SEN60] = {
+		.reset_delay = SEN6X_RESET_DELAY,
+		.num_iio_channels = SEN60_NUM_CHANNELS,
+		.read_measured_cmd = SEN6X_READ_MEASURED,
+		.read_measured_rx_size = 27,
+		.temperature_compensation_required = false,
+	},
+	[SEN65] = {
+		.reset_delay = SEN6X_RESET_DELAY,
+		.num_iio_channels = SEN65_NUM_CHANNELS,
+		.read_measured_cmd = SEN6X_READ_MEASURED,
+		.read_measured_rx_size = 27,
+		.temperature_compensation_required = false,
+	},
+	[SEN66] = {
+		.reset_delay = SEN6X_RESET_DELAY,
+		.num_iio_channels = SEN66_NUM_CHANNELS,
+		.read_measured_cmd = SEN6X_READ_MEASURED,
+		.read_measured_rx_size = 27,
+		.temperature_compensation_required = false,
+	},
+};
+
+static int sen6x_probe(struct i2c_client *client)
+{
+	return sen_common_probe(client);
+}
+
+static const struct i2c_device_id sen6x_id[] = {
+						 { "sen60", },
+						 { "sen65", },
+						 { "sen66", },
+						 {} };
+
+MODULE_DEVICE_TABLE(i2c, sen6x_id);
+
+static const struct of_device_id sen6x_dt_ids[] = {
+	{ .compatible = "sensirion,sen60", .data = &sen6x_chips[SEN60] },
+	{ .compatible = "sensirion,sen65", .data = &sen6x_chips[SEN65] },
+	{ .compatible = "sensirion,sen66", .data = &sen6x_chips[SEN66] },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, sen6x_dt_ids);
+
+static struct i2c_driver sen6x_driver = {
+	.driver = {
+		.name = "sen6x",
+		.of_match_table = sen6x_dt_ids,
+	},
+	.probe = sen6x_probe,
+	.id_table = sen6x_id,
+};
+module_i2c_driver(sen6x_driver);
+
+MODULE_DESCRIPTION("Sensirion SEN6x environmental sensor");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/chemical/sen_common.c b/drivers/iio/chemical/sen_common.c
new file mode 100644
index 000000000000..5fad439c87d9
--- /dev/null
+++ b/drivers/iio/chemical/sen_common.c
@@ -0,0 +1,464 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/crc8.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include "sen_common.h"
+
+DECLARE_CRC8_TABLE(sen_common_crc8_table);
+
+enum {
+	PM1,
+	PM2P5,
+	PM4,
+	PM10,
+	RHT,
+	TEMP,
+	VOC,
+	NOX,
+	CO2,
+};
+
+#define SENXX_CRC8_POLYNOMIAL 0x31
+#define SENXX_CRC8_INIT 0xff
+
+/* Command */
+#define SENXX_START_MEASUREMENT 0x0021
+#define SENXX_STOP_MEASUREMENT 0x0104
+#define SENXX_READ_DATA_READY 0x0202
+#define SENXX_PRODUCT_NAME 0xD014
+#define SENXX_DEVICE_STATUS 0xD206
+#define SENXX_RESET 0xD304
+#define SEN5X_TEMPERATURE 0x60B2
+
+#define SENXX_CMD_HEAD_LEN 2
+
+#define SENXX_PRODUCT_NAME_RSP_LEN 48
+#define SENXX_DEVICE_STATUS_RSP_LEN 6
+
+#define SEN5X_TEMPERATURE_REQ_LEN 9
+
+/* For sen5x(03C4) is 24 and sen6x(0300) is 27 */
+#define SENXX_MAX_MEASURED_RSP_LEN 27
+
+#define PACK_CMD_HEAD(value, buffer)               \
+	do {                                       \
+		(buffer)[0] = ((value) >> 8) & 0xFF; \
+		(buffer)[1] = (value) & 0xFF;        \
+	} while (0)
+
+/* Convert a 16-bit value to big-endian, store in a 3-bytes buffer with calculated CRC */
+#define PACK_TO_BUFFER_WITH_CRC(value, buffer)                       \
+	do {                                                         \
+		u16 __be_value = cpu_to_be16(value);                 \
+		(buffer)[0] = (__be_value >> 8) & 0xFF;              \
+		(buffer)[1] = __be_value & 0xFF;                     \
+		(buffer)[2] = crc8(sen_common_crc8_table, buffer, 2, \
+				   CRC8_INIT_VALUE);                 \
+	} while (0)
+
+static int sen_common_i2c_recv_reply(struct i2c_client *client,
+				     unsigned char *buf, unsigned int size)
+{
+	struct device *dev = &client->dev;
+	unsigned char *tmp = buf;
+	int ret;
+	int i;
+
+	ret = i2c_master_recv(client, buf, size);
+	if (ret < 0)
+		return ret;
+	if (ret != size) {
+		dev_warn(dev, "i2c_master_recv ret: %d size: %u\n", ret, size);
+		return -EIO;
+	}
+
+	/* All the Read and Write Commands transmit the data in 2-byte packets,
+	 * followed by an 8-bit checksum
+	 */
+	for (i = 0; i < size / 3; i++) {
+		unsigned char crc;
+
+		crc = crc8(sen_common_crc8_table, buf + i * 3, 2,
+			   CRC8_INIT_VALUE);
+		if (crc != buf[i * 3 + 2]) {
+			dev_err(dev, "data integrity check failed\n");
+			return -EIO;
+		}
+
+		*tmp++ = buf[i * 3];
+		*tmp++ = buf[i * 3 + 1];
+	}
+
+	return tmp - buf;
+}
+
+static int sen_common_simple_command(struct i2c_client *client,
+				     unsigned int cmd, unsigned int time)
+{
+	unsigned char txbuf[SENXX_CMD_HEAD_LEN];
+	int ret;
+
+	PACK_CMD_HEAD(cmd, &txbuf[0]);
+
+	ret = i2c_master_send(client, txbuf, 2);
+	if (ret < 0)
+		return ret;
+
+	msleep(time);
+
+	return 0;
+}
+
+static int sen_common_product_name(struct i2c_client *client, char *name,
+				   size_t len)
+{
+	unsigned char txbuf[SENXX_CMD_HEAD_LEN];
+	unsigned char rxbuf[SENXX_PRODUCT_NAME_RSP_LEN];
+	int ret;
+
+	PACK_CMD_HEAD(SENXX_PRODUCT_NAME, &txbuf[0]);
+
+	ret = i2c_master_send(client, txbuf, 2);
+	if (ret < 0)
+		return ret;
+
+	msleep(20);
+
+	ret = sen_common_i2c_recv_reply(client, rxbuf, sizeof(rxbuf));
+	if (ret < 0)
+		return ret;
+
+	rxbuf[ret] = '\0';
+
+	strscpy(name, rxbuf, len);
+
+	return 0;
+}
+
+static int sen_common_status(struct i2c_client *client, int *status)
+{
+	unsigned char txbuf[SENXX_CMD_HEAD_LEN];
+	unsigned char rxbuf[SENXX_DEVICE_STATUS_RSP_LEN];
+	int ret;
+
+	PACK_CMD_HEAD(SENXX_DEVICE_STATUS, &txbuf[0]);
+
+	ret = i2c_master_send(client, txbuf, 2);
+	if (ret < 0)
+		return ret;
+
+	msleep(20);
+
+	ret = sen_common_i2c_recv_reply(client, rxbuf, sizeof(rxbuf));
+	if (ret < 0)
+		return ret;
+
+	*status = (rxbuf[0] << 24) + (rxbuf[1] << 16) + (rxbuf[2] << 8) +
+		  rxbuf[3];
+
+	return 0;
+}
+
+static int sen5x_set_temperature_compensation(struct i2c_client *client,
+					      s16 offset, s16 slope, u16 time)
+{
+	unsigned char txbuf[SENXX_CMD_HEAD_LEN + SEN5X_TEMPERATURE_REQ_LEN];
+	int ret;
+
+	PACK_CMD_HEAD(SEN5X_TEMPERATURE, &txbuf[0]);
+
+	PACK_TO_BUFFER_WITH_CRC(offset, &txbuf[2]);
+	PACK_TO_BUFFER_WITH_CRC(slope, &txbuf[5]);
+	PACK_TO_BUFFER_WITH_CRC(time, &txbuf[8]);
+
+	ret = i2c_master_send(client, txbuf, sizeof(txbuf));
+	if (ret < 0)
+		return ret;
+
+	msleep(20);
+
+	return 0;
+}
+
+static int sen_common_fetch_measured(struct sen_common_state *state)
+{
+	struct i2c_client *client = state->client;
+	unsigned char txbuf[SENXX_CMD_HEAD_LEN];
+	unsigned char rxbuf[SENXX_MAX_MEASURED_RSP_LEN];
+	int rx_size = state->chip->read_measured_rx_size;
+	int ret;
+
+	if (rx_size > SENXX_MAX_MEASURED_RSP_LEN)
+		return -EINVAL;
+
+	PACK_CMD_HEAD(state->chip->read_measured_cmd, &txbuf[0]);
+
+	/* sensor can only be polled once a second max per datasheet */
+	if (!time_after(jiffies, state->last_update + HZ))
+		return 0;
+
+	ret = i2c_master_send(client, txbuf, sizeof(txbuf));
+	if (ret < 0)
+		return ret;
+
+	msleep(20);
+
+	ret = sen_common_i2c_recv_reply(client, rxbuf, rx_size);
+	if (ret < 0)
+		return ret;
+
+	memcpy(&state->data, rxbuf, ret);
+
+	state->last_update = jiffies;
+
+	return 0;
+}
+
+static ssize_t status_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sen_common_state *state = iio_priv(indio_dev);
+	int status;
+	int ret;
+
+	ret = sen_common_status(state->client, &status);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%x\n", status);
+}
+
+static IIO_DEVICE_ATTR_RO(status, 0);
+
+static struct attribute *sen_common_attrs[] = {
+	&iio_dev_attr_status.dev_attr.attr, NULL
+};
+
+static const struct attribute_group sen_common_attr_group = {
+	.attrs = sen_common_attrs,
+};
+
+#define SEN_CHAN_SCAN_TYPE(_sign)     \
+	.scan_type = {                \
+		.sign = _sign,        \
+		.realbits = 16,       \
+		.storagebits = 16,    \
+		.endianness = IIO_BE, \
+	}
+
+#define SEN_MASSCONC_CHAN(_index, _mod, _sign)                           \
+	{                                                                \
+		.type = IIO_MASSCONCENTRATION, .modified = 1,            \
+		.channel2 = IIO_MOD_##_mod,                              \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),            \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),    \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.address = _mod, .scan_index = _index,                   \
+		SEN_CHAN_SCAN_TYPE(_sign),                               \
+	}
+
+#define SEN_CONC_CHAN(_index, _mod, _sign)                               \
+	{                                                                \
+		.type = IIO_CONCENTRATION, .modified = 1,                \
+		.channel2 = IIO_MOD_##_mod,                              \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |           \
+				      BIT(IIO_CHAN_INFO_SCALE),          \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.address = _mod, .scan_index = _index,                   \
+		SEN_CHAN_SCAN_TYPE(_sign),                               \
+	}
+
+static const struct iio_chan_spec sen_common_channels[] = {
+	SEN_MASSCONC_CHAN(0, PM1, 'u'),
+	SEN_MASSCONC_CHAN(1, PM2P5, 'u'),
+	SEN_MASSCONC_CHAN(2, PM4, 'u'),
+	SEN_MASSCONC_CHAN(3, PM10, 'u'),
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.address = RHT,
+		.scan_index = 4,
+		SEN_CHAN_SCAN_TYPE('s'),
+	},
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.address = TEMP,
+		.scan_index = 5,
+		SEN_CHAN_SCAN_TYPE('s'),
+	},
+	SEN_CONC_CHAN(6, VOC, 's'),
+	SEN_CONC_CHAN(7, NOX, 's'),
+	SEN_CONC_CHAN(8, CO2, 'u'),
+};
+
+static int sen_common_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan, int *val,
+			       int *val2, long mask)
+{
+	struct sen_common_state *state = iio_priv(indio_dev);
+	int ret = IIO_VAL_INT;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&state->lock);
+		ret = sen_common_fetch_measured(state);
+		if (ret < 0) {
+			mutex_unlock(&state->lock);
+			return ret;
+		}
+
+		*val = be16_to_cpu(state->data[chan->address]);
+
+		mutex_unlock(&state->lock);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_MASSCONCENTRATION:
+			*val = 0;
+			*val2 = 100000;
+
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_HUMIDITYRELATIVE:
+			*val = 0;
+			*val2 = 10000;
+
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			*val = 0;
+			*val2 = 5000;
+
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_CONCENTRATION:
+			switch (chan->channel2) {
+			case IIO_MOD_NOX:
+			case IIO_MOD_VOC:
+				*val = 0;
+				*val2 = 100000;
+
+				return IIO_VAL_INT_PLUS_MICRO;
+			case IIO_MOD_CO2:
+				*val = 1;
+				*val2 = 0;
+
+				return IIO_VAL_INT_PLUS_MICRO;
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = 1;
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info sen_common_info = {
+	.attrs = &sen_common_attr_group,
+	.read_raw = sen_common_read_raw,
+};
+
+static irqreturn_t sen_common_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct sen_common_state *state = iio_priv(indio_dev);
+
+	mutex_lock(&state->lock);
+
+	if (sen_common_fetch_measured(state) < 0)
+		goto out;
+
+	iio_push_to_buffers(indio_dev, &state->data);
+
+out:
+	mutex_unlock(&state->lock);
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+int sen_common_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	const struct sen_chip_info *chip;
+	const char *name = client->name;
+	struct sen_common_state *state;
+	struct iio_dev *indio_dev;
+	char senxx[8];
+	int ret = 0;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct sen_common_state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	chip = i2c_get_match_data(client);
+
+	state = iio_priv(indio_dev);
+	state->client = client;
+	state->dev = dev;
+	mutex_init(&state->lock);
+	state->chip = chip;
+
+	crc8_populate_msb(sen_common_crc8_table, SENXX_CRC8_POLYNOMIAL);
+
+	ret = sen_common_simple_command(client, SENXX_RESET, chip->reset_delay);
+	if (ret < 0)
+		return ret;
+
+	ret = sen_common_product_name(client, senxx, sizeof(senxx));
+	if (ret < 0)
+		return ret;
+
+	if (strncasecmp(senxx, name, sizeof(senxx)) != 0)
+		dev_warn(dev, "chip mismatch: %s != %s\n", senxx, name);
+
+	/* Set default temperature compensation parameters */
+	if (chip->temperature_compensation_required) {
+		ret = sen5x_set_temperature_compensation(client, 0, 0, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = sen_common_simple_command(client, SENXX_START_MEASUREMENT, 50);
+	if (ret < 0)
+		return ret;
+
+	indio_dev->name = name;
+	indio_dev->info = &sen_common_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = sen_common_channels;
+	indio_dev->num_channels = chip->num_iio_channels;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      sen_common_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		dev_err(dev, "failed to register iio device\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sen_common_probe);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Sensirion SEN5x/SEN6x common functionality");
diff --git a/drivers/iio/chemical/sen_common.h b/drivers/iio/chemical/sen_common.h
new file mode 100644
index 000000000000..aa40053c53ae
--- /dev/null
+++ b/drivers/iio/chemical/sen_common.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef IIO_SEN_COMMON_H
+#define IIO_SEN_COMMON_H
+
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+
+struct sen_chip_info {
+	int reset_delay;
+	int num_iio_channels;
+	unsigned int read_measured_cmd;
+	unsigned int read_measured_rx_size;
+	bool temperature_compensation_required;
+};
+
+struct sen_common_state {
+	struct device *dev;
+	struct i2c_client *client;
+	struct mutex lock;
+	/* PM1, PM2.5, PM4, PM10, RHT, TEMP, VOC, NOX, CO2 */
+	__be16 data[9];
+	const struct sen_chip_info *chip;
+	unsigned long last_update;
+};
+
+int sen_common_probe(struct i2c_client *client);
+
+#endif
-- 
2.45.2


