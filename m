Return-Path: <linux-iio+bounces-10667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD29A14DF
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 23:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328101C20EBA
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 21:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCB91D3639;
	Wed, 16 Oct 2024 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="MAW1Nh6g"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF95F1D31B6;
	Wed, 16 Oct 2024 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114518; cv=fail; b=bxHadbt4/d0eYOD90Sy3LLz5mFRQE7r1BZhXhFHKy1K6ZiuVktlYX40PEaDgKMTDegFalD1+kaMz4fkxRQMY9fK0/LaT+wnLrrUab64hO/JjcOalaDd2UTfUcLjNw6joeHBKntlsFLVDwlISmx8QTY1LZW9rsFXLV48WoSWdIhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114518; c=relaxed/simple;
	bh=3MRONMDght4uWF1kFebkJi+eF4kjIv9qK1ZY3JvrjfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CH4bKUrEyOuI3nZ7Fa3ChJ1CdwU85lJo0FH0jsUI1rYoZL23JaMgFLcpwN04nSeqcDSELgoFc9rilR+7fpyUn4AXQzYBcRBIevlgAl9SW+g/temDzMFPSiAvrTKxr5SnlmdHSHBjedlnJRZYZ2scUdmtkZXXOgwxWE+H2t7Zeoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=MAW1Nh6g; arc=fail smtp.client-ip=40.107.22.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oziV9Tttg2TXYmZj/iPzxtLZpf3+YWF4s5Z4WlX3RLQLbxqkwXmJ6vZdAE3tdnJ0kAxW/3x2UP6p1KIICzvFyuKSb2nGBdorXFra0ylgyt/awJrUzBozhFxF/DQCFh0zkprw8aeFwOcm/YT76cf2+rPTeMLU0wEgUQAqBdykLfSpDc3E/DndjxuvWeCBKTJdM0bcgFLHvCpCqYnIjPsoKeYo6zjbG6AnJOf6xi5dE5SYd0CYSPim7jWx9lzdGo2JcPKvMPMW0COpbQWdHxnv7TM6kQS+BU/CMJqeE6frmPg3/vChL+bNpw+frPSsaER5SSm7ZXPfktMzeBK+aq2T0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4M9lQNABecbNZVwqOgmLiXP3FGaUsmE4t9y5akbHguM=;
 b=m+RjOG1U1R4R+5XaKnP8fNdRuE2UBWs9sUiRk3qCLxqLORmulV3HLAekUtbtJXAWzcEExfTuLDT9h5B3rvAet5lzWnwrXYIVNrFLuu5kXIP7+LfqMRCIiTyMSVaes/RpcAXuT3J2DT0+26iuBaTy8zbmrZq8lwvVydy3AjfcOZQ7jhDrKOW9KFRBZ0NbXUwrTvYpxXLo+UuIfFjxDXa6D3YQdCTjT43S3s+bqHBuzPW14Z0GepDzRv6YsAH9nQqhIK6Yh8Tmto9A8VwtBUudgdpHZ4V7wcTgmt0AaOps9/PKkhhfngvUM77SlxQiFUuguQIFeLhKFZUTejtVJz3ftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4M9lQNABecbNZVwqOgmLiXP3FGaUsmE4t9y5akbHguM=;
 b=MAW1Nh6gAT+g7BBNTAcGsoHpxhvvmRV2USlar6Eir/wbm6iBewuGT8e9asoXwL4YOhjdKubpDMyl3YW4tdh487w5QikpPpz9Bf5c28OmSseeqhZhkx/QJrp6r95ieLAwo4cq4rk8tSgZPZLt3FJOa+GQ8qcqEev3QdSql4lpgUI=
Received: from DUZPR01CA0217.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::11) by DB9PR02MB9707.eurprd02.prod.outlook.com
 (2603:10a6:10:45b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 21:35:08 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:4b4:cafe::a8) by DUZPR01CA0217.outlook.office365.com
 (2603:10a6:10:4b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Wed, 16 Oct 2024 21:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 21:35:08 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 23:35:06 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 23:35:06 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 16 Oct 2024 23:35:06 +0200
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 5FDFC13E;
	Wed, 16 Oct 2024 23:35:06 +0200 (CEST)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 73BA418E1ECB; Wed, 16 Oct 2024 23:35:06 +0200 (CEST)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH v4 2/2] iio: light: Add support for TI OPT4060 color sensor
Date: Wed, 16 Oct 2024 23:34:09 +0200
Message-ID: <20241016213409.3823162-3-perdaniel.olsson@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241016213409.3823162-1-perdaniel.olsson@axis.com>
References: <20241016213409.3823162-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|DB9PR02MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: 70535fa1-133a-443d-203c-08dcee2a6819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NzEQ2X7TbP/MSj6v/+pqNiynmHWqx8UlnI7Y5eJ9S67Yy5FYM0XFGyguM7Nx?=
 =?us-ascii?Q?GireozUWecvutB7ApF5m8b6lJpMwCudE6jK5+zH47Y0x9IBRzM/2fnz6N7ub?=
 =?us-ascii?Q?BgrlIHDGKBwBDdyLpVzbuWmmF1KZKkbPvwPOM25D1K/Q4V+tobAxzPgvbZqY?=
 =?us-ascii?Q?A9EpGmubqcHDF9hHPhOMEtNjZshZ4yNJlgTrTYu2lLl5FgTZDi/A+X91+BCG?=
 =?us-ascii?Q?OhOb6o19gvxhpsiheKAHl8Scp3DuQbwN+GAkwYtdplOFPRRQO1Z+eL1+jRSZ?=
 =?us-ascii?Q?cgrCH6hXLNCYBO7sl/DxJvjYrijXrY+THczezzG/mKwYmGXlXgtIjNOJBpqu?=
 =?us-ascii?Q?1QQhG5Pt25cAMfo2wAVSESMH4jHpbGTvdxwEVktTajDORRUKUXdaa9cH6V9G?=
 =?us-ascii?Q?CN6uN4K6462dQY7yvKktDXykjUsvJ/8pkjfugit1qCitDmRzu4QZytYB+clf?=
 =?us-ascii?Q?LNDKnKLiatwsiJimXt4ANQK4fLrdDQAlEfl27ZC+3hxmp+dGzmyH9jV4h1RI?=
 =?us-ascii?Q?537gBjzNF87GMT1DOJUvsLYo3EhlXnyjt/DAN+UZWLBS3Dk3pOlm5IRbUfbv?=
 =?us-ascii?Q?kLD9OIctj5jXPqowzk7IH6W/FmYTnuAKsLtVM0ncIQccVzV5DRKyPu/bGRVL?=
 =?us-ascii?Q?pMb7t9ut5yEWS6oH1Wj+Q4lATNoEXkrgKsLzeYD/pLVoBDcRjHlJHmCu5CUg?=
 =?us-ascii?Q?jhHyM+dRVsbrB/y5zkOJV2+eBeenoDgs9dLInihDhTv8CmBruNaLGpsGnNLV?=
 =?us-ascii?Q?vWgh5XzVKcksKgQscZbRlMJbsnoz1zArvnlRVl+kZfA2RbvXRIFnde3+XYS9?=
 =?us-ascii?Q?QQOdgRvF8UqDjXRNZ+hzWuX44WFLFgZveibriWgyDtL0AU1sG7X1rZfpdgpm?=
 =?us-ascii?Q?mD0kJw/Y+R+29l+bfvE/LsY/FStR4YKB6jKq2erVII1kY9h2ZG3mbKJ6Full?=
 =?us-ascii?Q?lQC4UoKurDSjifhwgV9bQlzupdHUqcgkdU9pYIxGE0P6U+cN05aNZq7a33jl?=
 =?us-ascii?Q?EKs613I6rtqjuWSkICdckerrE256Ke4kIs6+bxfQpw1ChLHYMsc5Yki1nHHw?=
 =?us-ascii?Q?5/8v2L4z9P+U4yptpOLHrTgwNO2XxDu0rXVSBQQIs6dHOR0W3+UmfNAviDt8?=
 =?us-ascii?Q?dZim/1rBC75c0E82TpMEKx1Oq7BPsGnqjPiN8T/XPJrEh51GGeIf62vdBXpF?=
 =?us-ascii?Q?5ToCAEg5jgfdUJnC4nXSnjm9BSG7Wdn7r8wfNkMtnDJt8GB0w+AgcmNvqeYx?=
 =?us-ascii?Q?I2aw5+dW8jY2/MLPZDOSr3Xc4bIzhMoPPn4IwWOQjUCZEASe8cK4C0ZVMZRs?=
 =?us-ascii?Q?nIhmiFpP1vRK1qijBL80ffRDT5dfY4vC1fe8gTeictrckgkbeRZecQ/YUtfC?=
 =?us-ascii?Q?cjqW2LfTfWtat+HCAnslpc6q5/QMXLb6uTFGTMqUhydeetB75w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 21:35:08.1188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70535fa1-133a-443d-203c-08dcee2a6819
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9707

Add support for Texas Instruments OPT4060 RGBW Color sensor.

Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
---
 drivers/iio/light/Kconfig   |   13 +
 drivers/iio/light/Makefile  |    1 +
 drivers/iio/light/opt4060.c | 1259 +++++++++++++++++++++++++++++++++++
 3 files changed, 1273 insertions(+)
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
index 000000000000..2c3761ec423a
--- /dev/null
+++ b/drivers/iio/light/opt4060.c
@@ -0,0 +1,1259 @@
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
+	s64 ts __aligned(8);
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
+	/*
+	 * Calculates a 4-bit CRC from a 20-bit mantissa, 4-bit exponent and a 4-bit counter.
+	 * crc[0] = XOR(mantissa[19:0], exp[3:0], count[3:0])
+	 * crc[1] = XOR(mantissa[1,3,5,7,9,11,13,15,17,19], exp[1,3], count[1,3])
+	 * crc[2] = XOR(mantissa[3,7,11,15,19], exp[3], count[3])
+	 * crc[3] = XOR(mantissa[3,11,19])
+	 */
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
+	u32 result, mantissa_raw;
+	u16 msb, lsb;
+	u8 exp, count, crc, calc_crc;
+
+	ret = regmap_bulk_read(chip->regmap, address, &result, 2);
+	if (ret) {
+		dev_err(chip->dev, "Reading channel data failed\n");
+	} else {
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
+	/*
+	 * The conversion time should be 500us startup time plus the integration time
+	 * times the number of channels. An exact timeout isn't critical, it's better
+	 * not to get incorrect errors in the log. Setting the timeout to double the
+	 * theoretical time plus and extra 100ms margin.
+	 */
+	unsigned int timeout_us = (500 + OPT4060_NUM_CHANS *
+				  opt4060_int_time_reg[chip->int_time][0]) * 2 + 100000;
+
+	if (chip->irq) {
+		reinit_completion(&chip->completion);
+		ret = opt4060_trigger_one_shot(chip);
+		if (ret)
+			return ret;
+		if (wait_for_completion_timeout(&chip->completion,
+						usecs_to_jiffies(timeout_us)) == 0)
+			dev_err(chip->dev, "Completion timed out.\n");
+	} else {
+		unsigned int ready;
+
+		ret = opt4060_trigger_one_shot(chip);
+		if (ret)
+			return ret;
+
+		ret = regmap_read_poll_timeout(chip->regmap, OPT4060_RES_CTRL,
+					       ready, (ready & OPT4060_RES_CTRL_CONV_READY),
+					       1000, timeout_us);
+		if (ret)
+			dev_err(chip->dev, "Conversion ready did not finish within timeout.\n");
+	}
+
+	ret = opt4060_read_raw_value(chip, chan->address, &adc_raw);
+	if (ret) {
+		dev_err(chip->dev, "Reading raw channel data failed\n");
+		return ret;
+	}
+	if (processed) {
+		/*
+		 * The processed value are multiplied by factors that correspond to optical
+		 * parameters in the sensor. The processed values gives more correct comparison
+		 * between channels.
+		 */
+		u32 lux_raw, rem;
+		u32 mul = opt4060_channel_factors[chan->scan_index].mul;
+		u32 div = opt4060_channel_factors[chan->scan_index].div;
+
+		lux_raw = adc_raw * mul;
+		*val = div_u64_rem(lux_raw, div, &rem);
+		*val2 = rem * div_u64(div, 10);
+		return IIO_VAL_INT_PLUS_NANO;
+	}
+	*val = adc_raw;
+	return IIO_VAL_INT;
+}
+
+static int opt4060_set_int_time(struct opt4060_chip *chip)
+{
+	unsigned int regval;
+	int ret;
+
+	regval = FIELD_PREP(OPT4060_CTRL_CONV_TIME_MASK, chip->int_time);
+	ret = regmap_update_bits(chip->regmap, OPT4060_CTRL,
+				 OPT4060_CTRL_CONV_TIME_MASK, regval);
+	if (ret)
+		dev_err(chip->dev, "Failed to set integration time.\n");
+
+	return ret;
+}
+
+static int opt4060_power_down(struct opt4060_chip *chip)
+{
+	int ret;
+
+	ret = regmap_clear_bits(chip->regmap, OPT4060_CTRL, OPT4060_CTRL_OPER_MODE_MASK);
+	if (ret)
+		dev_err(chip->dev, "Failed to power down\n");
+
+	return ret;
+}
+
+static void opt4060_chip_off_action(void *chip)
+{
+	opt4060_power_down(chip);
+}
+
+#define OPT4060_CHAN(color)							\
+{										\
+	.type = IIO_INTENSITY,							\
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
+#define OPT4060_CHAN_NO_IRQ(color)						\
+{										\
+	.type = IIO_INTENSITY,							\
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
+static const struct iio_chan_spec opt4060_channels_no_irq[] = {
+	OPT4060_CHAN_NO_IRQ(RED),
+	OPT4060_CHAN_NO_IRQ(GREEN),
+	OPT4060_CHAN_NO_IRQ(BLUE),
+	OPT4060_CHAN_NO_IRQ(CLEAR),
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
+		return opt4060_set_int_time(chip);
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
+	u32 th_val, th_exp, bits;
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
+static int opt4060_event_set_state(struct opt4060_chip *chip, bool state)
+{
+	int ret = 0;
+
+	if (state)
+		ret = opt4060_set_continous_mode(chip, true);
+	else if (!chip->data_trigger_active && chip->irq)
+		ret = opt4060_set_continous_mode(chip, false);
+
+	if (ret)
+		dev_err(chip->dev, "Failed to set event state.\n");
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
+	} else if (!opt4060_event_active(chip) && chip->irq) {
+		ret = opt4060_set_continous_mode(chip, false);
+	}
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
+	*ch_sel = FIELD_GET(OPT4060_INT_CTRL_THRESH_SEL, regval);
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
+	if (chan->type != IIO_INTENSITY)
+		return -EINVAL;
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		u32 th_lo, th_hi;
+
+		if (opt4060_get_thresholds(chip, &th_lo, &th_hi))
+			return -EFAULT;
+		if (dir == IIO_EV_DIR_FALLING) {
+			*val = th_lo;
+			ret = IIO_VAL_INT;
+		} else if (dir == IIO_EV_DIR_RISING) {
+			*val = th_hi;
+			ret = IIO_VAL_INT;
+		}
+		return ret;
+	case IIO_EV_INFO_PERIOD:
+		return opt4060_read_ev_period(chip, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int opt4060_write_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int val, int val2)
+{
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+
+	if (chan->type != IIO_INTENSITY)
+		return -EINVAL;
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		u32 th_lo, th_hi;
+
+		if (opt4060_get_thresholds(chip, &th_lo, &th_hi))
+			return -EFAULT;
+		if (dir == IIO_EV_DIR_FALLING)
+			th_lo = val;
+		else if (dir == IIO_EV_DIR_RISING)
+			th_hi = val;
+		if (opt4060_set_thresholds(chip, th_lo, th_hi))
+			return -EFAULT;
+		return 0;
+	case IIO_EV_INFO_PERIOD:
+		return opt4060_write_ev_period(chip, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int opt4060_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	int ch_sel, ch_idx = chan->scan_index;
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+
+	if (chan->type != IIO_INTENSITY)
+		return -EINVAL;
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	if (opt4060_get_channel_sel(chip, &ch_sel))
+		return -EFAULT;
+
+	if (((dir == IIO_EV_DIR_FALLING) && chip->thresh_event_lo_active) ||
+	    ((dir == IIO_EV_DIR_RISING) && chip->thresh_event_hi_active))
+		return (ch_sel == ch_idx);
+
+	return FALSE;
+}
+
+static int opt4060_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir, int state)
+{
+	int ch_sel, ch_idx = chan->scan_index;
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+
+	if (chan->type != IIO_INTENSITY)
+		return -EINVAL;
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	if (opt4060_get_channel_sel(chip, &ch_sel))
+		return -EFAULT;
+
+	if (state) {
+		/* Only one channel can be active at the same time */
+		if ((chip->thresh_event_lo_active ||
+			chip->thresh_event_hi_active) && (ch_idx != ch_sel))
+			return -EBUSY;
+		if (dir == IIO_EV_DIR_FALLING)
+			chip->thresh_event_lo_active = TRUE;
+		else if (dir == IIO_EV_DIR_RISING)
+			chip->thresh_event_hi_active = TRUE;
+		if (opt4060_set_channel_sel(chip, ch_idx))
+			return -EFAULT;
+	} else {
+		if (ch_idx == ch_sel) {
+			if (dir == IIO_EV_DIR_FALLING)
+				chip->thresh_event_lo_active = FALSE;
+			else if (dir == IIO_EV_DIR_RISING)
+				chip->thresh_event_hi_active = FALSE;
+		}
+	}
+
+	if (opt4060_event_set_state(chip, chip->thresh_event_hi_active |
+					chip->thresh_event_lo_active))
+		return -EFAULT;
+	return 0;
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
+	u16 reg;
+	int ret;
+
+	chip->int_time = OPT4060_DEFAULT_CONVERSION_TIME;
+
+	/* Set initial MIN/MAX thresholds */
+	ret = opt4060_set_thresholds(chip, 0, UINT_MAX);
+	if (ret)
+		return ret;
+
+	/*
+	 * Setting auto-range, latched window for thresholds, one-shot conversion
+	 * and quick wake-up mode as default.
+	 */
+	reg = FIELD_PREP(OPT4060_CTRL_RANGE_MASK,
+			 OPT4060_CTRL_LIGHT_SCALE_AUTO);
+	reg |= FIELD_PREP(OPT4060_CTRL_CONV_TIME_MASK, chip->int_time);
+	reg |= FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
+				OPT4060_CTRL_OPER_MODE_ONE_SHOT);
+	reg |= OPT4060_CTRL_QWAKE_MASK | OPT4060_CTRL_LATCH_MASK;
+
+	ret = regmap_write(chip->regmap, OPT4060_CTRL, reg);
+	if (ret)
+		dev_err(chip->dev, "Failed to set configuration\n");
+
+	return ret;
+}
+
+static bool opt4060_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return (reg >= OPT4060_RED_MSB && reg <= OPT4060_CLEAR_LSB) ||
+	       (reg == OPT4060_RES_CTRL);
+}
+
+static bool opt4060_writable_reg(struct device *dev, unsigned int reg)
+{
+	return reg >= OPT4060_THRESHOLD_LOW || reg >= OPT4060_INT_CTRL;
+}
+
+static bool opt4060_readonly_reg(struct device *dev, unsigned int reg)
+{
+	return reg == OPT4060_DEVICE_ID;
+}
+
+static bool opt4060_readable_reg(struct device *dev, unsigned int reg)
+{
+	/* Volatile, writable and read-only registers are readable. */
+	return opt4060_volatile_reg(dev, reg) || opt4060_writable_reg(dev, reg) ||
+	       opt4060_readonly_reg(dev, reg);
+}
+
+static const struct regmap_config opt4060_regmap_config = {
+	.name = "opt4060",
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
+	int ret, chan = 0, i = 0;
+
+	memset(&raw, 0, sizeof(raw));
+
+	iio_for_each_active_channel(idev, chan) {
+		ret = opt4060_read_raw_value(chip,
+					     idev->channels[chan].address,
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
+	int ret, dummy;
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
+		int chan = 0;
+
+		ret = opt4060_get_channel_sel(chip, &chan);
+		if (ret) {
+			dev_err(chip->dev, "Failed to read threshold channel.\n");
+			return IRQ_NONE;
+		}
+
+		/* Check if the interrupt is from the lower threshold */
+		if (int_res & OPT4060_RES_CTRL_FLAG_L) {
+			code = IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
+						    chan,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING);
+			iio_push_event(idev, code, iio_get_time_ns(idev));
+		}
+		/* Check if the interrupt is from the upper threshold */
+		if (int_res & OPT4060_RES_CTRL_FLAG_H) {
+			code = IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
+						    chan,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING);
+			iio_push_event(idev, code, iio_get_time_ns(idev));
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
+				     "iio_triggered_buffer_setup_ext FAIL\n");
+
+	data_trigger = devm_iio_trigger_alloc(chip->dev, "%s-data-ready-dev%d",
+					      idev->name, iio_device_id(idev));
+	if (!data_trigger)
+		return -ENOMEM;
+
+	/* The data trigger allows for sample capture on each new conversion ready interrupt. */
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
+
+	/*
+	 * The threshold trigger allows for sample capture on threshold interrupts.
+	 * Just using events does not enable a way to get the samples that actually
+	 * triggered the threshold interrupt.
+	 */
+	chip->threshold_trig = threshold_trigger;
+	threshold_trigger->ops = &opt4060_trigger_ops;
+	iio_trigger_set_drvdata(threshold_trigger, idev);
+	ret = devm_iio_trigger_register(chip->dev, threshold_trigger);
+	if (ret)
+		return dev_err_probe(chip->dev, ret,
+				     "Threshold trigger registration failed\n");
+
+	name = devm_kasprintf(chip->dev, GFP_KERNEL, "%s-opt4060",
+			      dev_name(chip->dev));
+	if (!name)
+		return dev_err_probe(chip->dev, -ENOMEM, "Failed to alloc chip name\n");
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
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable vdd supply\n");
+
+	chip->regmap = devm_regmap_init_i2c(client, &opt4060_regmap_config);
+	if (IS_ERR(chip->regmap))
+		return dev_err_probe(dev, PTR_ERR(chip->regmap),
+				     "regmap initialization failed\n");
+
+	ret = devm_add_action_or_reset(dev, opt4060_chip_off_action, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to setup power off action\n");
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
+		dev_info(dev, "Device ID: %#04x unknown\n", dev_id);
+
+	if (chip->irq) {
+		indio_dev->channels = opt4060_channels;
+		indio_dev->num_channels = ARRAY_SIZE(opt4060_channels);
+	} else {
+		indio_dev->channels = opt4060_channels_no_irq;
+		indio_dev->num_channels = ARRAY_SIZE(opt4060_channels_no_irq);
+	}
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = dev->driver->name;
+
+	ret = opt4060_load_defaults(chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to set sensor defaults\n");
+
+	if (chip->irq) {
+		ret = opt4060_setup_triggers(chip, indio_dev);
+		if (ret)
+			return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id opt4060_id[] = {
+	{ "opt4060", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, opt4060_id);
+
+static const struct of_device_id opt4060_of_match[] = {
+	{ .compatible = "ti,opt4060" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, opt4060_of_match);
+
+static struct i2c_driver opt4060_driver = {
+	.driver = {
+		.name = "opt4060",
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


