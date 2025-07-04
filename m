Return-Path: <linux-iio+bounces-21361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF49AF97C8
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 18:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE4F1CA6C2E
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F43328007;
	Fri,  4 Jul 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="KU16RCT6"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013030.outbound.protection.outlook.com [40.107.162.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C5C327FFD;
	Fri,  4 Jul 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645690; cv=fail; b=OSOlK2xP33tSOpUoLXdDJMSHmg1b1qr16ni15m/J5JzKVg6rx7xURNx10VhFqXa1YNR+muTF9z9Ac5v2J14mUr4pNqcfL7ZKLH7UD49Oi5x6uyIwg9kBgyj/YZN78Hk7uib0nJ4Ny47lfpHhR41fG1J3VK7ATdlok7iycPnWpi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645690; c=relaxed/simple;
	bh=sVtCoBItwkJV1I+sqXLt5XIG3RK1Kn5k8hFvHjIu4KM=;
	h=From:To:CC:Subject:In-Reply-To:Message-ID:Date:MIME-Version:
	 Content-Type; b=Vg6f1iziRSJBfKDSnhz3TUpzBS/+jcMkGDpP6a+VdkRGbytO8oBO1Hc4pZXkB2SEdb6CWOO9vyfdnxY6bS94C9K7Hy9XBZ8GlO7/OVxMZWAaHuuSumF2FA8Hk7JgApBQfAnmiyz9lgH9VVldkyb/56FdLRH/FIBKdhIUXk2K9js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=KU16RCT6; arc=fail smtp.client-ip=40.107.162.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9BnuShPMZ+lsGiSGWTcJYkehRGqC5DDISOTUyuA6luBuEu3lpGt2GavN0CeFDyRv8l1jXb3C0bPpHC1gyArGRj9dIuz9P4rnNlqB6CS7QgoHkKx3taUVmIkhfFC2Ly+7YRCJaBgXff9+VsX83llYa50yuJc/nEPr7PiABOtjtmTN7YJY2GfZTChv6n+2Ud8VP/JorHv8PbEnYJH8Ha//XkZiICSVdHuselANzZSR6c7ymekuqTlRaQhpkVrEraosZxv5Cz1G5Zckv5ZF07Ty25Z0PLhPmxpyLL5bGwqHQ5kiqkMLvBZ6uIquUAbEPJBH+H1ZGWkPEQTsZrn730S8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOKdy9FU1lLVwFgLbRaAq96e2jvL13Wn2nkhpOyCEzE=;
 b=jonV+VRU2gWfMmB0RtQT0IKd2P6BpShg1DcGjVU+1ZftTi/VakIJo3FWaS8fmDGf9AfGsvWoIDA53/TquPlfs89+ntlM7DbQQMos46NtBiIGEsdsMSW6t9Jsoilxd/Hsyjw6btM5HNmXLmxgtozyhKHlckBSmCBgPlIi4KyhKE43tt3jVpUZR3C2UpCUBVjdPP1ZUYvBUuel+iZmKri0qMw7Vd+s4JYZZrNE0DrAN3xhnuJUplMLivND6SyOMkv1tO7HPTbxXT/fjCCvyBgWF7SpC+469QafUS7jiqoBUMHhZ+nMjsQOxiRxIAdJbeBfDOl1xNgSVDNRcst5az+WgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOKdy9FU1lLVwFgLbRaAq96e2jvL13Wn2nkhpOyCEzE=;
 b=KU16RCT6QGD75L2o3QGlemLNVgmS/WqUjif58DSY4lrqski6Za0JR7U6EvZDONNvmk+/lhePefY7w0QyRx81dGr0HUtNFrhntdnFzj7SLShcjLB7HEXB3tdR3ADFmXxsoKG27sRzWZCq1uGugTvg9J3FgfR7zWVGBYR0GGeeO+Q=
Received: from AM0PR01CA0155.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::24) by DU4PR02MB11124.eurprd02.prod.outlook.com
 (2603:10a6:10:58e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 16:14:41 +0000
Received: from AMS0EPF000001AD.eurprd05.prod.outlook.com
 (2603:10a6:208:aa:cafe::5c) by AM0PR01CA0155.outlook.office365.com
 (2603:10a6:208:aa::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 16:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AD.mail.protection.outlook.com (10.167.16.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 16:14:41 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 4 Jul
 2025 18:14:38 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>
CC: <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH v3 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <cover.1751636734.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <29f84da1431f4a3f17fdeef27297a4ab14455404.1751636734.git.waqar.hameed@axis.com>
Date: Fri, 4 Jul 2025 18:14:38 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AD:EE_|DU4PR02MB11124:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a9d306-07ff-465d-4ae8-08ddbb15e1a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KlLUhAz5/g9HVkr80XunQ2ZT8uBsc8Pl4xu7DWq2gThM11yutI93Qfc7Pliq?=
 =?us-ascii?Q?XB+6tCy0d1bjxrK+Veon77R2dksdKwxHjXCCQbFn/ljfeImZzo/xPtn5PVXj?=
 =?us-ascii?Q?6rcMXHd/7EC4xUfP+1PlGxShq02xpBI6huhbR4WXpNjzSc3oV+R3jCDvt61j?=
 =?us-ascii?Q?fnR2g+oZLCb6YsVulBMOHDPXS1x0A2ygW7pcBYeONipbfV3iDRRlmNEeM4zX?=
 =?us-ascii?Q?NLcuIRFjuj+9DUejwJD3ZI/NU03jbqckMIZNNU9UkMqfevf4mBGsQ8zArz3b?=
 =?us-ascii?Q?8T3XsFJI+X9cIs8a4pMwtbEPYhsyST7n+MDrL/mVBC+tZPGe/loAmB12qR6k?=
 =?us-ascii?Q?BURMzn4uu0ZgF7+GEaXNOGJqwXSSrHGi8AK+cHbP4lbRKAavhq/oDud2jy2W?=
 =?us-ascii?Q?0z8PfMA+WYVNWxJChZ6596o2V67N4cP/Gtl+oSZ3AQfqm8CmLBYEPPExR5e9?=
 =?us-ascii?Q?lDJ/Xeo6NUBakE44Y9KowmTMvxZpGbxWIZ+tA5f+SQ7aPBfttsgJeqGCB4DP?=
 =?us-ascii?Q?mQpDTfwv4Xf66H4GffFwpuFvAz6e7uyEMFZXKGdNpXyqqOzRQjouobW1GcEf?=
 =?us-ascii?Q?dBiG5XdNwIhAqq6hVC9bpkBenzkdOBq6LoLXKxoD1sLGBXUhQ7fHkSupQdUn?=
 =?us-ascii?Q?Nvn+CgCoIkNBwXO1UZmcleGuOTB7Hc5sWlxjkdVcJ8/Pz8JiO/1UFSSPfBuk?=
 =?us-ascii?Q?Oo1yVmNRB/99NYAV4PLwU8vntWxtEb+s1T6KGAoyloyn1J7A0jvLSKYwZ50a?=
 =?us-ascii?Q?m3WzGvX52TgY3e/Yyak5ALCyPa9DYY+MP535fS759IAAlgWv35lSGsDC6nma?=
 =?us-ascii?Q?Y58iaeDjbRuaLw6dBUeS3xpkcdmuh1l7ns0OkFj6pH7iLUYVCNVsul3kwpeG?=
 =?us-ascii?Q?zQ9q+Tq5KU1qJqMNBNlwuVG9T6TndYTj5fV2l+0tUUxZyvZuSVyPwN73IUnC?=
 =?us-ascii?Q?S3L7+QPO4PRJoMLDYTJHMFbg0MIHtKPSxJ4goENWtAwQsvBpw2F6yzBGrFFJ?=
 =?us-ascii?Q?zbdSRkF21JOCFwKRLNYaKnD4Kj9qwTi0he7PuCm6pDDtArOmhbt1jWegtKJE?=
 =?us-ascii?Q?MoOVBnmDDSGd/eB+A3MNIEHSnrMNLxy+vaAuJGXyw3ONkEEdIEiVq+jWYv26?=
 =?us-ascii?Q?g9vdePwYCoH0SdB65XJVzf86XbicsSf8jv9Kbj1lLKJf2sFtY8Im71QyfJCk?=
 =?us-ascii?Q?+U/H2NOO0S+tumv4lxBiM31GhczvJl5dky4v2AyfPTrkAORVEE6/mwNWZkdo?=
 =?us-ascii?Q?JyVYE7R21M2L7m0VZyrV20+yfPdvA7iZuqyQYjmARuY/OHXxffIykQmpkE52?=
 =?us-ascii?Q?hmJkYgRqhPQ/ix/zAIxvdoRWhsRICtCNzOwd9PxQF9rwqz3toq1g+Gq7ii0w?=
 =?us-ascii?Q?h1qYkKfQaSxJbHu2wvCOTxyUbKzVuxF8lOA7yaJRULACqGxwjGh1Cmw8BAPx?=
 =?us-ascii?Q?xh4D99vAEsHr8ba2hAFlDUgrvYBYwXNQ+DiEkWriHQurw7Zxi14M0d2rdCYS?=
 =?us-ascii?Q?vscOy1vqAtMknKBbSc9Q0F1DCsn9pb3JEfHh?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 16:14:41.0401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a9d306-07ff-465d-4ae8-08ddbb15e1a4
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR02MB11124

Nicera D3-323-AA is a PIR sensor for human detection. It has support for
raw data measurements and detection notification. The communication
protocol is custom made and therefore needs to be GPIO bit banged.

The device has two main settings that can be configured: a threshold
value for detection and a band-pass filter. The configurable parameters
for the band-pass filter are the high-pass and low-pass cutoff
frequencies and its peak gain. Map these settings to the corresponding
parameters in the `iio` framework.

Raw data measurements can be obtained from the device. However, since we
rely on bit banging, it will be rather cumbersome with buffer support.
The main reason being that the data protocol has strict timing
requirements (it's serial like UART), and it's mainly used during
debugging since in real-world applications only the event notification
is of importance. Therefore, only add support for events (for now).

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/iio/proximity/Kconfig   |   9 +
 drivers/iio/proximity/Makefile  |   1 +
 drivers/iio/proximity/d3323aa.c | 814 ++++++++++++++++++++++++++++++++
 3 files changed, 824 insertions(+)
 create mode 100644 drivers/iio/proximity/d3323aa.c

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index a562a78b7d0d..6070974c2c85 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -32,6 +32,15 @@ config CROS_EC_MKBP_PROXIMITY
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_mkbp_proximity.
 
+config D3323AA
+	tristate "Nicera (Nippon Ceramic Co.) D3-323-AA PIR sensor"
+	depends on GPIOLIB
+	help
+	  Say Y here to build a driver for the Nicera D3-323-AA PIR sensor.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called d3323aa.
+
 config HX9023S
 	tristate "TYHX HX9023S SAR sensor"
 	select IIO_BUFFER
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index c5e76995764a..152034d38c49 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -6,6 +6,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AS3935)		+= as3935.o
 obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) += cros_ec_mkbp_proximity.o
+obj-$(CONFIG_D3323AA)		+= d3323aa.o
 obj-$(CONFIG_HX9023S)		+= hx9023s.o
 obj-$(CONFIG_IRSD200)		+= irsd200.o
 obj-$(CONFIG_ISL29501)		+= isl29501.o
diff --git a/drivers/iio/proximity/d3323aa.c b/drivers/iio/proximity/d3323aa.c
new file mode 100644
index 000000000000..b1bc3204c0c0
--- /dev/null
+++ b/drivers/iio/proximity/d3323aa.c
@@ -0,0 +1,814 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Nicera D3-323-AA PIR sensor.
+ *
+ * Copyright (C) 2025 Axis Communications AB
+ */
+
+#include <linux/bitmap.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+
+/*
+ * Register bitmap.
+ * For some reason the first bit is denoted as F37 in the datasheet, the second
+ * as F38 and so on. Note the gap between F60 and F64.
+ */
+#define D3323AA_REG_BIT_SLAVEA1		0	/* F37. */
+#define D3323AA_REG_BIT_SLAVEA2		1	/* F38. */
+#define D3323AA_REG_BIT_SLAVEA3		2	/* F39. */
+#define D3323AA_REG_BIT_SLAVEA4		3	/* F40. */
+#define D3323AA_REG_BIT_SLAVEA5		4	/* F41. */
+#define D3323AA_REG_BIT_SLAVEA6		5	/* F42. */
+#define D3323AA_REG_BIT_SLAVEA7		6	/* F43. */
+#define D3323AA_REG_BIT_SLAVEA8		7	/* F44. */
+#define D3323AA_REG_BIT_SLAVEA9		8	/* F45. */
+#define D3323AA_REG_BIT_SLAVEA10	9	/* F46. */
+#define D3323AA_REG_BIT_DETLVLABS0	10	/* F47. */
+#define D3323AA_REG_BIT_DETLVLABS1	11	/* F48. */
+#define D3323AA_REG_BIT_DETLVLABS2	12	/* F49. */
+#define D3323AA_REG_BIT_DETLVLABS3	13	/* F50. */
+#define D3323AA_REG_BIT_DETLVLABS4	14	/* F51. */
+#define D3323AA_REG_BIT_DETLVLABS5	15	/* F52. */
+#define D3323AA_REG_BIT_DETLVLABS6	16	/* F53. */
+#define D3323AA_REG_BIT_DETLVLABS7	17	/* F54. */
+#define D3323AA_REG_BIT_DSLP		18	/* F55. */
+#define D3323AA_REG_BIT_FSTEP0		19	/* F56. */
+#define D3323AA_REG_BIT_FSTEP1		20	/* F57. */
+#define D3323AA_REG_BIT_FILSEL0		21	/* F58. */
+#define D3323AA_REG_BIT_FILSEL1		22	/* F59. */
+#define D3323AA_REG_BIT_FILSEL2		23	/* F60. */
+#define D3323AA_REG_BIT_FDSET		24	/* F64. */
+#define D3323AA_REG_BIT_F65		25
+#define D3323AA_REG_BIT_F87		(D3323AA_REG_BIT_F65 + (87 - 65))
+
+#define D3323AA_REG_NR_BITS (D3323AA_REG_BIT_F87 - D3323AA_REG_BIT_SLAVEA1 + 1)
+#define D3323AA_THRESH_REG_NR_BITS                                             \
+	(D3323AA_REG_BIT_DETLVLABS7 - D3323AA_REG_BIT_DETLVLABS0 + 1)
+#define D3323AA_FILTER_TYPE_NR_BITS                                            \
+	(D3323AA_REG_BIT_FILSEL2 - D3323AA_REG_BIT_FILSEL0 + 1)
+#define D3323AA_FILTER_GAIN_REG_NR_BITS                                        \
+	(D3323AA_REG_BIT_FSTEP1 - D3323AA_REG_BIT_FSTEP0 + 1)
+
+#define D3323AA_THRESH_DEFAULT_VAL 56
+#define D3323AA_FILTER_GAIN_DEFAULT_IDX 1
+#define D3323AA_LP_FILTER_FREQ_DEFAULT_IDX 1
+
+/*
+ * The pattern is 0b01101, but store it reversed (0b10110) due to writing from
+ * LSB on the wire (c.f. d3323aa_write_settings()).
+ */
+#define D3323AA_SETTING_END_PATTERN 0x16
+#define D3323AA_SETTING_END_PATTERN_NR_BITS 5
+
+/*
+ * Device should be ready for configuration after this many milliseconds.
+ * Datasheet mentions "approx. 1.2 s". Measurements show around 1.23 s,
+ * therefore add 100 ms of slack.
+ */
+#define D3323AA_RESET_TIMEOUT (1200 + 100)
+
+/*
+ * The configuration of the device (write and read) should be done within this
+ * many milliseconds.
+ */
+#define D3323AA_CONFIG_TIMEOUT 1400
+
+/* Number of IRQs needed for configuration stage after reset. */
+#define D3323AA_IRQ_RESET_COUNT 2
+
+/*
+ * High-pass filter cutoff frequency for the band-pass filter. There is a
+ * corresponding low-pass cutoff frequency for each of the filter types
+ * (denoted A, B, C and D in the datasheet). The index in this array matches
+ * that corresponding value in d3323aa_lp_filter_freq.
+ * Note that this represents a fractional value (e.g. the first value
+ * corresponds to 40 / 100 = 0.4 Hz).
+ */
+static const int d3323aa_hp_filter_freq[][2] = {
+	{ 40, 100 },
+	{ 30, 100 },
+	{ 30, 100 },
+	{ 1, 100 },
+};
+
+/*
+ * Low-pass filter cutoff frequency for the band-pass filter. There is a
+ * corresponding high-pass cutoff frequency for each of the filter types
+ * (denoted A, B, C and D in the datasheet). The index in this array matches
+ * that corresponding value in d3323aa_hp_filter_freq.
+ * Note that this represents a fractional value (e.g. the first value
+ * corresponds to 27 / 10 = 2.7 Hz).
+ */
+static const int d3323aa_lp_filter_freq[][2] = {
+	{ 27, 10 },
+	{ 15, 10 },
+	{ 5, 1 },
+	{ 100, 1 },
+};
+
+/*
+ * Register bitmap values for filter types (denoted A, B, C and D in the
+ * datasheet). The index in this array matches the corresponding value in
+ * d3323aa_lp_filter_freq (which in turn matches d3323aa_hp_filter_freq). For
+ * example, the first value 7 corresponds to 2.7 Hz low-pass and 0.4 Hz
+ * high-pass cutoff frequency.
+ */
+static const int d3323aa_lp_filter_regval[] = {
+	7,
+	0,
+	1,
+	2,
+};
+
+/*
+ * This is denoted as "step" in datasheet and corresponds to the gain at peak
+ * for the band-pass filter. The index in this array is the corresponding index
+ * in d3323aa_filter_gain_regval for the register bitmap value.
+ */
+static const int d3323aa_filter_gain[] = { 1, 2, 3 };
+
+/*
+ * Register bitmap values for the filter gain. The index in this array is the
+ * corresponding index in d3323aa_filter_gain for the gain value.
+ */
+static const u8 d3323aa_filter_gain_regval[] = { 1, 3, 0 };
+
+struct d3323aa_data {
+	struct completion reset_completion;
+	/*
+	 *  Since the setup process always requires a complete write of _all_
+	 *  the state variables, we need to synchronize them with a lock.
+	 */
+	struct mutex statevar_lock;
+
+	struct device *dev;
+
+	/* Supply voltage. */
+	struct regulator *regulator_vdd;
+	/* Input clock or output detection signal (Vout). */
+	struct gpio_desc *gpiod_clkin_detectout;
+	/* Input (setting) or output data. */
+	struct gpio_desc *gpiod_data;
+
+	/*
+	 * We only need the low-pass cutoff frequency to unambiguously choose
+	 * the type of band-pass filter. For example, both filter type B and C
+	 * have 0.3 Hz as high-pass cutoff frequency (see
+	 * d3323aa_hp_filter_freq).
+	 */
+	size_t lp_filter_freq_idx;
+	size_t filter_gain_idx;
+	u8 detect_thresh;
+	u8 irq_reset_count;
+
+	/* Indicator for operational mode (configuring or detecting). */
+	bool detecting;
+};
+
+static int d3323aa_read_settings(struct iio_dev *indio_dev,
+				 unsigned long *regbitmap)
+{
+	struct d3323aa_data *data = iio_priv(indio_dev);
+	size_t i;
+	int ret;
+
+	/* Bit bang the clock and data pins. */
+	ret = gpiod_direction_output(data->gpiod_clkin_detectout, 0);
+	if (ret)
+		return ret;
+
+	ret = gpiod_direction_input(data->gpiod_data);
+	if (ret)
+		return ret;
+
+	dev_dbg(data->dev, "Reading settings...\n");
+
+	for (i = 0; i < D3323AA_REG_NR_BITS; ++i) {
+		/* Clock frequency needs to be 1 kHz. */
+		gpiod_set_value(data->gpiod_clkin_detectout, 1);
+		udelay(500);
+
+		/* The data seems to change when clock signal is high. */
+		if (gpiod_get_value(data->gpiod_data))
+			set_bit(i, regbitmap);
+
+		gpiod_set_value(data->gpiod_clkin_detectout, 0);
+		udelay(500);
+	}
+
+	/* The first bit (F37) is just dummy data. Discard it. */
+	clear_bit(0, regbitmap);
+
+	/* Datasheet says to wait 30 ms after reading the settings. */
+	msleep(30);
+
+	return 0;
+}
+
+static int d3323aa_write_settings(struct iio_dev *indio_dev,
+				  unsigned long *written_regbitmap)
+{
+#define REGBITMAP_LEN \
+	(D3323AA_REG_NR_BITS + D3323AA_SETTING_END_PATTERN_NR_BITS)
+	DECLARE_BITMAP(regbitmap, REGBITMAP_LEN);
+	struct d3323aa_data *data = iio_priv(indio_dev);
+	size_t i;
+	int ret;
+
+	/* Build the register bitmap. */
+	bitmap_zero(regbitmap, REGBITMAP_LEN);
+	bitmap_write(regbitmap, data->detect_thresh, D3323AA_REG_BIT_DETLVLABS0,
+		     D3323AA_REG_BIT_DETLVLABS7 - D3323AA_REG_BIT_DETLVLABS0 +
+			     1);
+	bitmap_write(regbitmap,
+		     d3323aa_filter_gain_regval[data->filter_gain_idx],
+		     D3323AA_REG_BIT_FSTEP0,
+		     D3323AA_REG_BIT_FSTEP1 - D3323AA_REG_BIT_FSTEP0 + 1);
+	bitmap_write(regbitmap,
+		     d3323aa_lp_filter_regval[data->lp_filter_freq_idx],
+		     D3323AA_REG_BIT_FILSEL0,
+		     D3323AA_REG_BIT_FILSEL2 - D3323AA_REG_BIT_FILSEL0 + 1);
+	/* Compulsory end pattern. */
+	bitmap_write(regbitmap, D3323AA_SETTING_END_PATTERN,
+		     D3323AA_REG_NR_BITS, D3323AA_SETTING_END_PATTERN_NR_BITS);
+
+	/* Bit bang the clock and data pins. */
+	ret = gpiod_direction_output(data->gpiod_clkin_detectout, 0);
+	if (ret)
+		return ret;
+
+	ret = gpiod_direction_output(data->gpiod_data, 0);
+	if (ret)
+		return ret;
+
+	dev_dbg(data->dev, "Writing settings...\n");
+
+	/* First bit (F37) is not used when writing the register bitmap. */
+	for (i = 1; i < REGBITMAP_LEN; ++i) {
+		gpiod_set_value(data->gpiod_data, test_bit(i, regbitmap));
+
+		/* Clock frequency needs to be 1 kHz. */
+		gpiod_set_value(data->gpiod_clkin_detectout, 1);
+		udelay(500);
+		gpiod_set_value(data->gpiod_clkin_detectout, 0);
+		udelay(500);
+	}
+
+	/* Datasheet says to wait 30 ms after writing the settings. */
+	msleep(30);
+
+	bitmap_copy(written_regbitmap, regbitmap, D3323AA_REG_NR_BITS);
+
+	return 0;
+}
+
+static irqreturn_t d3323aa_irq_handler(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct d3323aa_data *data = iio_priv(indio_dev);
+	enum iio_event_direction dir;
+	int val;
+
+	val = gpiod_get_value(data->gpiod_clkin_detectout);
+	if (val < 0) {
+		dev_err_ratelimited(data->dev,
+				    "Could not read from GPIO vout-clk (%d)\n",
+				    val);
+		return IRQ_HANDLED;
+	}
+
+	if (!data->detecting) {
+		/* Reset interrupt counting falling edges. */
+		if (!val && ++data->irq_reset_count == D3323AA_IRQ_RESET_COUNT)
+			complete(&data->reset_completion);
+
+		return IRQ_HANDLED;
+	}
+
+	/* Detection interrupt. */
+	dir = val ? IIO_EV_DIR_RISING : IIO_EV_DIR_FALLING;
+	iio_push_event(indio_dev,
+		       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+					    IIO_EV_TYPE_THRESH, dir),
+		       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
+static int d3323aa_reset(struct iio_dev *indio_dev)
+{
+	struct d3323aa_data *data = iio_priv(indio_dev);
+	long time;
+	int ret;
+
+	/* During probe() the regulator may already be disabled. */
+	if (regulator_is_enabled(data->regulator_vdd)) {
+		ret = regulator_disable(data->regulator_vdd);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Datasheet says VDD needs to be low at least for 30 ms. Let's add a
+	 * couple more to allow VDD to completely discharge as well.
+	 */
+	fsleep((30 + 5) * USEC_PER_MSEC);
+
+	/*
+	 * When later enabling VDD, the device will signal with
+	 * D3323AA_IRQ_RESET_COUNT falling edges on Vout/CLK that it is now
+	 * ready for configuration. Datasheet says that this should happen
+	 * within D3323AA_RESET_TIMEOUT ms. Count these two edges within that
+	 * timeout.
+	 */
+	data->irq_reset_count = 0;
+	reinit_completion(&data->reset_completion);
+	data->detecting = false;
+
+	ret = gpiod_direction_input(data->gpiod_clkin_detectout);
+	if (ret)
+		return ret;
+
+	dev_dbg(data->dev, "Resetting...\n");
+
+	ret = regulator_enable(data->regulator_vdd);
+	if (ret)
+		return ret;
+
+	/*
+	 * Wait for VDD to completely charge up. Measurements have shown that
+	 * Vout/CLK signal slowly ramps up during this period. Thus, the digital
+	 * signal will have bogus values. It is therefore necessary to wait
+	 * before we can count the "real" falling edges.
+	 */
+	fsleep(2000);
+
+	time = wait_for_completion_killable_timeout(
+		&data->reset_completion,
+		msecs_to_jiffies(D3323AA_RESET_TIMEOUT));
+	if (time == 0) {
+		return -ETIMEDOUT;
+	} else if (time < 0) {
+		/* Got interrupted. */
+		return time;
+	}
+
+	dev_dbg(data->dev, "Reset completed\n");
+
+	return 0;
+}
+
+static int d3323aa_setup(struct iio_dev *indio_dev, size_t lp_filter_freq_idx,
+			 size_t filter_gain_idx, u8 detect_thresh)
+{
+	DECLARE_BITMAP(write_regbitmap, D3323AA_REG_NR_BITS);
+	DECLARE_BITMAP(read_regbitmap, D3323AA_REG_NR_BITS);
+	struct d3323aa_data *data = iio_priv(indio_dev);
+	unsigned long start_time;
+	int ret;
+
+	ret = d3323aa_reset(indio_dev);
+	if (ret) {
+		if (ret != -ERESTARTSYS)
+			dev_err(data->dev, "Could not reset device (%d)\n",
+				ret);
+
+		return ret;
+	}
+
+	/*
+	 * Datasheet says to wait 10 us before setting the configuration.
+	 * Moreover, the total configuration should be done within
+	 * D3323AA_CONFIG_TIMEOUT ms. Clock it.
+	 */
+	fsleep(10);
+	start_time = jiffies;
+
+	ret = d3323aa_write_settings(indio_dev, write_regbitmap);
+	if (ret) {
+		dev_err(data->dev, "Could not write settings (%d)\n", ret);
+		return ret;
+	}
+
+	ret = d3323aa_read_settings(indio_dev, read_regbitmap);
+	if (ret) {
+		dev_err(data->dev, "Could not read settings (%d)\n", ret);
+		return ret;
+	}
+
+	if (time_is_before_jiffies(start_time +
+				   msecs_to_jiffies(D3323AA_CONFIG_TIMEOUT))) {
+		dev_err(data->dev, "Could not set up configuration in time\n");
+		return -EAGAIN;
+	}
+
+	/* Check if settings were set successfully. */
+	if (!bitmap_equal(write_regbitmap, read_regbitmap,
+			  D3323AA_REG_NR_BITS)) {
+		dev_err(data->dev, "Settings data mismatch\n");
+		return -EIO;
+	}
+
+	/* Now in operational mode. */
+	ret = gpiod_direction_input(data->gpiod_clkin_detectout);
+	if (ret) {
+		dev_err(data->dev,
+			"Could not set GPIO vout-clk as input (%d)\n", ret);
+		return ret;
+	}
+
+	ret = gpiod_direction_input(data->gpiod_data);
+	if (ret) {
+		dev_err(data->dev, "Could not set GPIO data as input (%d)\n",
+			ret);
+		return ret;
+	}
+
+	data->lp_filter_freq_idx = lp_filter_freq_idx;
+	data->filter_gain_idx = filter_gain_idx;
+	data->detect_thresh = detect_thresh;
+	data->detecting = true;
+
+	dev_dbg(data->dev, "Setup done\n");
+
+	return 0;
+}
+
+static int d3323aa_set_lp_filter_freq(struct iio_dev *indio_dev, const int val,
+				      int val2)
+{
+	struct d3323aa_data *data = iio_priv(indio_dev);
+	size_t idx;
+
+	/* Truncate fractional part to one digit. */
+	val2 /= 100000;
+
+	for (idx = 0; idx < ARRAY_SIZE(d3323aa_lp_filter_freq); ++idx) {
+		int integer = d3323aa_lp_filter_freq[idx][0] /
+			      d3323aa_lp_filter_freq[idx][1];
+		int fract = d3323aa_lp_filter_freq[idx][0] %
+			    d3323aa_lp_filter_freq[idx][1];
+
+		if (val == integer && val2 == fract)
+			break;
+	}
+
+	if (idx == ARRAY_SIZE(d3323aa_lp_filter_freq))
+		return -EINVAL;
+
+	return d3323aa_setup(indio_dev, idx, data->filter_gain_idx,
+			     data->detect_thresh);
+}
+
+static int d3323aa_set_hp_filter_freq(struct iio_dev *indio_dev, const int val,
+				      int val2)
+{
+	struct d3323aa_data *data = iio_priv(indio_dev);
+	size_t idx;
+
+	/* Truncate fractional part to two digits. */
+	val2 /= 10000;
+
+	for (idx = 0; idx < ARRAY_SIZE(d3323aa_hp_filter_freq); ++idx) {
+		int integer = d3323aa_hp_filter_freq[idx][0] /
+			      d3323aa_hp_filter_freq[idx][1];
+		int fract = d3323aa_hp_filter_freq[idx][0] %
+			    d3323aa_hp_filter_freq[idx][1];
+
+		if (val == integer && val2 == fract)
+			break;
+	}
+
+	if (idx == ARRAY_SIZE(d3323aa_hp_filter_freq))
+		return -EINVAL;
+
+	if (idx == data->lp_filter_freq_idx) {
+		/* Corresponding filter frequency already set. */
+		return 0;
+	}
+
+	if (idx == 1 && data->lp_filter_freq_idx == 2) {
+		/*
+		 * The low-pass cutoff frequency is the only way to
+		 * unambiguously choose the type of band-pass filter. For
+		 * example, both filter type B (index 1) and C (index 2) have
+		 * 0.3 Hz as high-pass cutoff frequency (see
+		 * d3323aa_hp_filter_freq). Therefore, if one of these are
+		 * requested _and_ the corresponding low-pass filter frequency
+		 * is already set, we can't know which filter type is the wanted
+		 * one. The low-pass filter frequency is the decider (i.e. in
+		 * this case index 2).
+		 */
+		return 0;
+	}
+
+	return d3323aa_setup(indio_dev, idx, data->filter_gain_idx,
+			     data->detect_thresh);
+}
+
+static int d3323aa_set_filter_gain(struct iio_dev *indio_dev, const int val)
+{
+	struct d3323aa_data *data = iio_priv(indio_dev);
+	size_t idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(d3323aa_filter_gain); ++idx) {
+		if (d3323aa_filter_gain[idx] == val)
+			break;
+	}
+
+	if (idx == ARRAY_SIZE(d3323aa_filter_gain))
+		return -EINVAL;
+
+	return d3323aa_setup(indio_dev, data->lp_filter_freq_idx, idx,
+			     data->detect_thresh);
+}
+
+static int d3323aa_set_threshold(struct iio_dev *indio_dev, const int val)
+{
+	struct d3323aa_data *data = iio_priv(indio_dev);
+
+	if (val > ((1 << D3323AA_THRESH_REG_NR_BITS) - 1))
+		return -EINVAL;
+
+	return d3323aa_setup(indio_dev, data->lp_filter_freq_idx,
+			     data->filter_gain_idx, val);
+}
+
+static int d3323aa_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		*vals = (int *)d3323aa_hp_filter_freq;
+		*type = IIO_VAL_FRACTIONAL;
+		*length = 2 * ARRAY_SIZE(d3323aa_hp_filter_freq);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*vals = (int *)d3323aa_lp_filter_freq;
+		*type = IIO_VAL_FRACTIONAL;
+		*length = 2 * ARRAY_SIZE(d3323aa_lp_filter_freq);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		*vals = (int *)d3323aa_filter_gain;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(d3323aa_filter_gain);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int d3323aa_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct d3323aa_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->statevar_lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		*val = d3323aa_hp_filter_freq[data->lp_filter_freq_idx][0];
+		*val2 = d3323aa_hp_filter_freq[data->lp_filter_freq_idx][1];
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*val = d3323aa_lp_filter_freq[data->lp_filter_freq_idx][0];
+		*val2 = d3323aa_lp_filter_freq[data->lp_filter_freq_idx][1];
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		*val = d3323aa_filter_gain[data->filter_gain_idx];
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int d3323aa_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct d3323aa_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->statevar_lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		return d3323aa_set_hp_filter_freq(indio_dev, val, val2);
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return d3323aa_set_lp_filter_freq(indio_dev, val, val2);
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		return d3323aa_set_filter_gain(indio_dev, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int d3323aa_read_event(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      enum iio_event_type type,
+			      enum iio_event_direction dir,
+			      enum iio_event_info info, int *val, int *val2)
+{
+	struct d3323aa_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->statevar_lock);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		*val = data->detect_thresh;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int d3323aa_write_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info, int val, int val2)
+{
+	struct d3323aa_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->statevar_lock);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return d3323aa_set_threshold(indio_dev, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info d3323aa_info = {
+	.read_avail = d3323aa_read_avail,
+	.read_raw = d3323aa_read_raw,
+	.write_raw = d3323aa_write_raw,
+	.read_event_value = d3323aa_read_event,
+	.write_event_value = d3323aa_write_event,
+};
+
+static const struct iio_event_spec d3323aa_event_spec[] = {
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
+};
+
+static const struct iio_chan_spec d3323aa_channels[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY) |
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
+			BIT(IIO_CHAN_INFO_HARDWAREGAIN),
+		.info_mask_separate_available =
+			BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY) |
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
+			BIT(IIO_CHAN_INFO_HARDWAREGAIN),
+		.event_spec = d3323aa_event_spec,
+		.num_event_specs = ARRAY_SIZE(d3323aa_event_spec),
+	},
+};
+
+static void d3323aa_disable_regulator(void *indata)
+{
+	struct d3323aa_data *data = indata;
+	int ret;
+
+	/*
+	 * During probe() the regulator may be disabled. It is enabled during
+	 * device setup (in d3323aa_reset(), where it is also briefly disabled).
+	 * The check is therefore needed in order to have balanced
+	 * regulator_enable/disable() calls.
+	 */
+	if (!regulator_is_enabled(data->regulator_vdd))
+		return;
+
+	ret = regulator_disable(data->regulator_vdd);
+	if (ret)
+		dev_err(data->dev, "Could not disable regulator (%d)\n", ret);
+}
+
+static int d3323aa_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct d3323aa_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Could not allocate iio device\n");
+
+	data = iio_priv(indio_dev);
+	data->dev = dev;
+
+	init_completion(&data->reset_completion);
+
+	ret = devm_mutex_init(dev, &data->statevar_lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "Could not initialize mutex\n");
+
+	data->regulator_vdd = devm_regulator_get_exclusive(dev, "vdd");
+	if (IS_ERR(data->regulator_vdd))
+		return dev_err_probe(dev, PTR_ERR(data->regulator_vdd),
+				     "Could not get regulator\n");
+
+	/*
+	 * The regulator will be enabled during the device setup below (in
+	 * d3323aa_reset()). Note that d3323aa_disable_regulator() also checks
+	 * for the regulator state.
+	 */
+	ret = devm_add_action_or_reset(dev, d3323aa_disable_regulator, data);
+	if (ret)
+		return ret;
+
+	data->gpiod_clkin_detectout =
+		devm_gpiod_get(dev, "vout-clk", GPIOD_OUT_LOW);
+	if (IS_ERR(data->gpiod_clkin_detectout))
+		return dev_err_probe(dev, PTR_ERR(data->gpiod_clkin_detectout),
+				     "Could not get GPIO vout-clk\n");
+
+	data->gpiod_data = devm_gpiod_get(dev, "data", GPIOD_OUT_LOW);
+	if (IS_ERR(data->gpiod_data))
+		return dev_err_probe(dev, PTR_ERR(data->gpiod_data),
+				     "Could not get GPIO data\n");
+
+	ret = gpiod_to_irq(data->gpiod_clkin_detectout);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Could not get IRQ\n");
+
+	/*
+	 * Device signals with a rising or falling detection signal when the
+	 * proximity data is above or below the threshold, respectively.
+	 */
+	ret = devm_request_irq(dev, ret, d3323aa_irq_handler,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			       dev_name(dev), indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Could not request IRQ\n");
+
+	ret = d3323aa_setup(indio_dev, D3323AA_LP_FILTER_FREQ_DEFAULT_IDX,
+			    D3323AA_FILTER_GAIN_DEFAULT_IDX,
+			    D3323AA_THRESH_DEFAULT_VAL);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &d3323aa_info;
+	indio_dev->name = "d3323aa";
+	indio_dev->channels = d3323aa_channels;
+	indio_dev->num_channels = ARRAY_SIZE(d3323aa_channels);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Could not register iio device\n");
+
+	return 0;
+}
+
+static const struct of_device_id d3323aa_of_match[] = {
+	{
+		.compatible = "nicera,d3323aa",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, d3323aa_of_match);
+
+static struct platform_driver d3323aa_driver = {
+	.probe = d3323aa_probe,
+	.driver = {
+		.name = "d3323aa",
+		.of_match_table = d3323aa_of_match,
+	},
+};
+module_platform_driver(d3323aa_driver);
+
+MODULE_AUTHOR("Waqar Hameed <waqar.hameed@axis.com>");
+MODULE_DESCRIPTION("Nicera D3-323-AA PIR sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


