Return-Path: <linux-iio+bounces-19389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 899C3AB17E6
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 17:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1BC507893
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 15:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9772356A9;
	Fri,  9 May 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="BFQeS3sO"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2043.outbound.protection.outlook.com [40.107.103.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F4234973;
	Fri,  9 May 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746802992; cv=fail; b=bU6ZvmrJwVKZbHIE/L07WW6k3vi96/CemydI6BG+JUvduM1USlLSiBEP1RIsRJozr9WC25laM20yn8mXU9wd9UnXzCt/QUCEZjuGUKFHs9mnrei4jxhypYTIZcCQcx34o6xYkW7kSikXgUs0znjdpwSVRJJIEvnGLZP46wGLUmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746802992; c=relaxed/simple;
	bh=ZQicLhuC1OYKF2eF6HMr7bESA9ShTPXoXwBba9aLP8I=;
	h=From:To:CC:Subject:In-Reply-To:Message-ID:Date:MIME-Version:
	 Content-Type; b=ETCWWCZvV97oXYxFGK5qTYaYz/KtMRkLnnDHzyIy/oSQkSPasAnVX5CNGriAAykngMuwL117QaTKOodtKBN5Ge19V6CIDPUBQQV7CUkO+ezq/PDpkj78PhOOTerpjFMxA8q8yKxAZnya1iGV2s5i+6xHZSOpobOkzSAWTdWUrHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=BFQeS3sO; arc=fail smtp.client-ip=40.107.103.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edf8Rk3lVbYoJCAAKrPnyGBHGtMG1ARS3NudQVydX8yoZ2Ddc5lFVC0Gc1wToE0QIO/pzom+zNxqvgpizXXWh+IQLQGYQ6DRynqjqzRlrrv0tg+FbF4p1FSQl9H/Hu44Nuc5cIyRBCYl610RN0bIIZmAeCB0FlnTr/pzUyg0PKyh0Ps9aUoOoCFCBRmDht9dKtCrMNqwzHYyPQfkdJ+SBK5Lbzc7puCK3NdQqEVtKafuRMS6pY7o1QaawohNu5gcdli+Hr1ziwQE5+QiktIrmBuWkZmL8b581sylXvOodjSlyEKr07JuWtRWKUzQ11b25Doa9H0IOPSyV5PPUTypZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grJkg6qedWKKrnb9BmGSOEzjgNh9Jfom6Dc8cXR1sGM=;
 b=qDzBW14hRx6JNpzTQe6yTQFyTRMjL3iDTv8GpCS1fkDMMH0O0d3yYToMLwKfSPgdChPS2irfkRcn4VasJTuFyJynDVx5xbnvE3M4lQou7UoAd9QioQoDFkeOUC9WjF5J7AaoVHuVmJ/7mUXN+2Nw9b4id4hj6uKHBalLLvArN6fDMgbBtewWsV56ulkNdCzqIadOCaZsaGVw2WFtkwxrbpnQzJSHwMXICDy9LcXWbiL+IZ04X7gCFtEL7LHSH9QBuV7+lOZKjePpZZbu79AqQbEpZU2xffEsyGVne+LwD5XB5RmkxasqDHuli/UMTLQ8cPjH2iUO6xyGCr4AeAvQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grJkg6qedWKKrnb9BmGSOEzjgNh9Jfom6Dc8cXR1sGM=;
 b=BFQeS3sOuaYYaBIw7tzfwRM9JI8dV7bz7Nvv/RK0aqGmT5a9+S8TJLRGbiOqf7S6S1LZEjE2Nv2hALUYKahzXo9z/T1OlCdIlEqfzU9lYxPrGEq/BdOuFFr0kB/b2o/kEz8JDi2ozjXJL9UuqD77KORgi4UsTKmVEsQhpgCc1kg=
Received: from DU7P195CA0005.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::24)
 by GV2PR02MB9422.eurprd02.prod.outlook.com (2603:10a6:150:e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Fri, 9 May
 2025 15:03:06 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::6) by DU7P195CA0005.outlook.office365.com
 (2603:10a6:10:54d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Fri,
 9 May 2025 15:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:03:05 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 9 May
 2025 17:03:03 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <cover.1746802541.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <c5184074d85b68ca35ccb29ab94d774203b93535.1746802541.git.waqar.hameed@axis.com>
Date: Fri, 9 May 2025 17:03:03 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|GV2PR02MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1f31f1-f39e-4fea-0626-08dd8f0a9a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wrCxcymbem05t70DmZ32Njl8l7F5H35zQYuIYxKbyPuH5i00pk4P6f85k1jg?=
 =?us-ascii?Q?FJmN7cQkSTlmMViAzv0XYCbdFWEqPy5kaRUCWHqrF4C9gcluSAGwm9ZjfPs0?=
 =?us-ascii?Q?DsAr3Q4pexw3wKJi6VvPnUVXdvXs3TcERSkylLBBF2+lsamqUw0EztrKQtYd?=
 =?us-ascii?Q?iPcstP5NtqEnfCI1vo5SRRZmqQgLpdoW+gleVC3d0hWhZir14xeFDtkg06Dz?=
 =?us-ascii?Q?qhcAm1fc3JOY8QPyDi82TEQhMoQrUjuQNrj0d9CgxYYvMTNX6JPJPY+n9f75?=
 =?us-ascii?Q?aER0zRI1UorEdxGmA/UUUPKpspM9TpZsYlpc4XiFazJviDoD3wA/5rUFfDS0?=
 =?us-ascii?Q?MAYzNv+TnclFwL4XHl9vHmCvuvn3+DEe1JVwSUsHRck5kd4XDuzt3CtFYhPT?=
 =?us-ascii?Q?LizU58dWR6OfyXdFS8x2/xmi9ppDBKT5t9Jq+DiG/TUgI6kifXVE1rg8jKZy?=
 =?us-ascii?Q?8wxhwdBVCJ8NOHN/vkKxV3nYQmPSwkxLLO3OaUCOG0Z8FDMiRJX/gM05ODRB?=
 =?us-ascii?Q?CItnlxyMvLjskgZrOqRKyi171uciUXHqRGY4M/iK/xqV6TlwpuN8g7FGf0eO?=
 =?us-ascii?Q?3PnCFfkHvK5IKIub1qZiqaQKqlXcUQMSQaKXGQC/LLEGCNSQbEzY1F1K/n+P?=
 =?us-ascii?Q?vDsuRXepDsrJ28S0zdDRtwTggdMiYQtTcOMFUGMQReCdTDxWmv4uTprXwxQq?=
 =?us-ascii?Q?OzhgqzpzIU99w0dO1U8gOd9qEt+vrnFkfHnw7UEy+dtnJCKjcCIA1faSm/dM?=
 =?us-ascii?Q?fWOB0GLFuoNVukHelBNlKgHL9x4aBjXH9CcSSWjcwgv8s3lZ5XziobcAEqyB?=
 =?us-ascii?Q?W7kNGSnWqyyJUKVYPt5l935AXJbm3I+TrLcg1WxpOnOAMXFQ9Aq37theSLIM?=
 =?us-ascii?Q?CO8Ik7IFSWM+N7vTf/vo+AwqLZgLm6FUxRKDZmlGx7EPYBM118Lw1rqOxga5?=
 =?us-ascii?Q?T4eIDE90X++bUtqtrwHlOj8IMRJfLLN1TXrk41dQdXas+aYC0FofDQuBOX8R?=
 =?us-ascii?Q?YH9XuWPUG4P0dxFd1BrgwjkJojQGeC1iKNUHiXBlYerJjxaA7k4u8mgKnHd1?=
 =?us-ascii?Q?11jiJ80+pYrwNvbb+qBZGyiqxFV/lJ61FvpaH45ITw6UqzQudeu4DV/0Vrt3?=
 =?us-ascii?Q?EwwfMTRKJ2li2NwsrkD5l1nmTkfNBK/CRK/4PeBNKfYZYA0HYtzzUoizxaOi?=
 =?us-ascii?Q?olj5MdTjQ7g9d/kGp143OXkMyw2v7t95AYBZY4K6FPbTSYQeKP3yGrEuaj+F?=
 =?us-ascii?Q?GBW7B1czhit5fjl+fsiyVUYUfNqBFzKdvCVMqRr+N0xrTrEVeXl36siZfgsX?=
 =?us-ascii?Q?NDOnY293vyNJzQ8YJB/S0TVphnLVzm8Jvi0/6KMCCvVp2D+xkYr6P3DTIAZG?=
 =?us-ascii?Q?hjQOtMZxm3NwWLXkhrCqCPhe2HhhNRzxYrOFyHMqib0ZwNANASJ+R113dnFX?=
 =?us-ascii?Q?+32dmLwO0LSJagRUQgKm6+Z2Wz/e+naHpOhp8oJjcLr57ARXJtPWTOQsKfyK?=
 =?us-ascii?Q?TpaK38CiiS70sLoIMTw8OY4GFYxdau2Ka0LN?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:03:05.9240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1f31f1-f39e-4fea-0626-08dd8f0a9a6d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9422

Nicera D3-323-AA is a PIR sensor for human detection. It has support for
raw data measurements and detection notification. The communication
protocol is custom made and therefore needs to be GPIO bit banged.

The device has two main settings that can be configured: a threshold
value for detection and a band-pass filter. The configurable parameters
for the band-pass filter are the high-pass and low-pass cutoff
frequencies and its peak gain. Map these settings to the corresponding
parameters in the `iio` framework.

The low-pass and high-pass cutoff frequencies are pairwise for the
different available filter types. Because of this, only allow to set the
low-pass cutoff frequency from `sysfs` and use that to configure the
corresponding high-pass cutoff frequency. This is sufficient to
unambiguously choose a filter type.

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
 drivers/iio/proximity/d3323aa.c | 868 ++++++++++++++++++++++++++++++++
 3 files changed, 878 insertions(+)
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
index 000000000000..fa08b52636ba
--- /dev/null
+++ b/drivers/iio/proximity/d3323aa.c
@@ -0,0 +1,868 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Nicera D3-323-AA PIR sensor.
+ *
+ * Copyright (C) 2025 Axis Communications AB
+ */
+
+#include <linux/atomic.h>
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
+#include <linux/types.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+
+#define D3323AA_DRV_NAME "d3323aa"
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
+#define D3323AA_FILTER_GAIN_DEFAULT_VAL 2
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
+ * corresponds to 4 / 10 = 0.4 Hz).
+ */
+static const int d3323aa_hp_filter_freq[][2] = {
+	{ 4, 10 },
+	{ 3, 10 },
+	{ 3, 10 },
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
+static const int d3323aa_filter_gain[] = {
+	1,
+	2,
+	3,
+};
+
+/*
+ * Register bitmap values for the filter gain. The index in this array is the
+ * corresponding index in d3323aa_filter_gain for the gain value.
+ */
+static const u8 d3323aa_filter_gain_regval[] = {
+	1,
+	3,
+	0,
+};
+
+struct d3323aa_data {
+	struct completion reset_completion;
+	/*
+	 *  Since the setup process always requires a complete write of the
+	 *  _whole_ register bitmap, we need to synchronize it with a lock.
+	 */
+	struct mutex regmap_lock;
+	atomic_t irq_reset_count;
+	unsigned int irq;
+
+	struct device *dev;
+
+	/* Supply voltage. */
+	struct gpio_desc *gpiod_vdd;
+	/* Input clock or output detection signal (Vout). */
+	struct gpio_desc *gpiod_clk_vout;
+	/* Input (setting) or output data. */
+	struct gpio_desc *gpiod_data;
+
+	DECLARE_BITMAP(regmap, D3323AA_REG_NR_BITS);
+
+	/*
+	 * Indicator for operational mode (configuring or detecting), i.e.
+	 * d3323aa_irq_detection() registered or not.
+	 */
+	bool detecting;
+};
+
+static int d3323aa_read_settings(struct iio_dev *indio_dev,
+				 unsigned long *regmap)
+{
+	struct d3323aa_data *data = iio_priv(indio_dev);
+	size_t i;
+	int ret;
+
+	/* Bit bang the clock and data pins. */
+	ret = gpiod_direction_output(data->gpiod_clk_vout, 0);
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
+		gpiod_set_value(data->gpiod_clk_vout, 1);
+		udelay(500);
+
+		/* The data seems to change when clock signal is high. */
+		if (gpiod_get_value(data->gpiod_data))
+			set_bit(i, regmap);
+
+		gpiod_set_value(data->gpiod_clk_vout, 0);
+		udelay(500);
+	}
+
+	/* The first bit (F37) is just dummy data. Discard it. */
+	clear_bit(0, regmap);
+
+	/* Datasheet says to wait 30 ms after reading the settings. */
+	msleep(30);
+
+	return 0;
+}
+
+static int d3323aa_write_settings(struct iio_dev *indio_dev,
+				  const unsigned long *regmap)
+{
+	DECLARE_BITMAP(end_pattern, D3323AA_SETTING_END_PATTERN_NR_BITS);
+	struct d3323aa_data *data = iio_priv(indio_dev);
+	size_t i;
+	int ret;
+
+	/* Bit bang the clock and data pins. */
+	ret = gpiod_direction_output(data->gpiod_clk_vout, 0);
+	if (ret)
+		return ret;
+
+	ret = gpiod_direction_output(data->gpiod_data, 0);
+	if (ret)
+		return ret;
+
+	dev_dbg(data->dev, "Writing settings...\n");
+
+	/* First bit (F37) is not used when writing the register map. */
+	for (i = 1; i < D3323AA_REG_NR_BITS; ++i) {
+		gpiod_set_value(data->gpiod_data, test_bit(i, regmap));
+
+		/* Clock frequency needs to be 1 kHz. */
+		gpiod_set_value(data->gpiod_clk_vout, 1);
+		udelay(500);
+		gpiod_set_value(data->gpiod_clk_vout, 0);
+		udelay(500);
+	}
+
+	/* Compulsory end pattern. */
+	bitmap_write(end_pattern, D3323AA_SETTING_END_PATTERN, 0,
+		     D3323AA_SETTING_END_PATTERN_NR_BITS);
+	for (i = 0; i < D3323AA_SETTING_END_PATTERN_NR_BITS; ++i) {
+		gpiod_set_value(data->gpiod_data, test_bit(i, end_pattern));
+
+		gpiod_set_value(data->gpiod_clk_vout, 1);
+		udelay(500);
+		gpiod_set_value(data->gpiod_clk_vout, 0);
+		udelay(500);
+	}
+
+	/* Datasheet says to wait 30 ms after writing the settings. */
+	msleep(30);
+
+	return 0;
+}
+
+static irqreturn_t d3323aa_irq_detection(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct d3323aa_data *data = iio_priv(indio_dev);
+	enum iio_event_direction dir;
+	int val;
+
+	val = gpiod_get_value(data->gpiod_clk_vout);
+	if (val < 0) {
+		dev_err_ratelimited(data->dev,
+				    "Could not read from GPIO clk-vout (%d)\n",
+				    val);
+		return IRQ_HANDLED;
+	}
+
+	dir = val ? IIO_EV_DIR_RISING : IIO_EV_DIR_FALLING;
+	iio_push_event(indio_dev,
+		       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+					    IIO_EV_TYPE_THRESH, dir),
+		       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t d3323aa_irq_reset(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct d3323aa_data *data = iio_priv(indio_dev);
+	int count = atomic_inc_return(&data->irq_reset_count);
+
+	if (count == D3323AA_IRQ_RESET_COUNT)
+		complete(&data->reset_completion);
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
+	/*
+	 * Datasheet says VDD needs to be low at least for 30 ms. Let's add a
+	 * couple more to allow VDD to completely discharge as well.
+	 */
+	gpiod_set_value(data->gpiod_vdd, 0);
+	msleep(30 + 5);
+
+	/*
+	 * After setting VDD to high, the device signals with
+	 * D3323AA_IRQ_RESET_COUNT falling edges on CLK/Vout that it is now
+	 * ready for configuration. Datasheet says that this should happen
+	 * within D3323AA_RESET_TIMEOUT ms. Count these two edges within that
+	 * timeout.
+	 */
+	atomic_set(&data->irq_reset_count, 0);
+	reinit_completion(&data->reset_completion);
+
+	ret = gpiod_direction_input(data->gpiod_clk_vout);
+	if (ret)
+		return ret;
+
+	dev_dbg(data->dev, "Resetting...\n");
+
+	gpiod_set_value(data->gpiod_vdd, 1);
+
+	/*
+	 * Datasheet doesn't mention this but measurements have shown that
+	 * CLK/Vout signal slowly ramps up during the first 1.5 ms after reset.
+	 * This means that the digital signal will have bogus values during this
+	 * period. Let's wait for this ramp-up before counting the "real"
+	 * falling edges.
+	 */
+	usleep_range(2000, 5000);
+
+	if (data->detecting) {
+		/*
+		 * Device had previously been set up and was in operational
+		 * mode. Thus, free that detection IRQ handler before requesting
+		 * the reset IRQ handler.
+		 */
+		free_irq(data->irq, indio_dev);
+		data->detecting = false;
+	}
+
+	ret = request_irq(data->irq, d3323aa_irq_reset, IRQF_TRIGGER_FALLING,
+			  dev_name(data->dev), indio_dev);
+	if (ret)
+		return ret;
+
+	time = wait_for_completion_killable_timeout(
+		&data->reset_completion,
+		msecs_to_jiffies(D3323AA_RESET_TIMEOUT));
+	free_irq(data->irq, indio_dev);
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
+static int d3323aa_setup(struct iio_dev *indio_dev, const unsigned long *regmap)
+{
+	DECLARE_BITMAP(read_regmap, D3323AA_REG_NR_BITS);
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
+	usleep_range(10, 20);
+	start_time = jiffies;
+
+	ret = d3323aa_write_settings(indio_dev, regmap);
+	if (ret) {
+		dev_err(data->dev, "Could not write settings (%d)\n", ret);
+		return ret;
+	}
+
+	ret = d3323aa_read_settings(indio_dev, read_regmap);
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
+	if (!bitmap_equal(regmap, read_regmap, D3323AA_REG_NR_BITS)) {
+		dev_err(data->dev, "Settings data mismatch\n");
+		return -EIO;
+	}
+
+	/* Now in operational mode. */
+	ret = gpiod_direction_input(data->gpiod_clk_vout);
+	if (ret) {
+		dev_err(data->dev,
+			"Could not set GPIO clk-vout as input (%d)\n", ret);
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
+	ret = request_irq(data->irq, d3323aa_irq_detection,
+			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			  dev_name(data->dev), indio_dev);
+	if (ret) {
+		dev_err(data->dev, "Could not request IRQ for detection (%d)\n",
+			ret);
+		return ret;
+	}
+
+	bitmap_copy(data->regmap, regmap, D3323AA_REG_NR_BITS);
+	data->detecting = true;
+
+	dev_dbg(data->dev, "Setup done\n");
+
+	return 0;
+}
+
+static int d3323aa_get_hp_filter_freq(unsigned long *regmap, int *val,
+				      int *val2)
+{
+	size_t idx;
+	u8 regval;
+
+	regval = bitmap_read(regmap, D3323AA_REG_BIT_FILSEL0,
+			     D3323AA_FILTER_TYPE_NR_BITS);
+	for (idx = 0; idx < ARRAY_SIZE(d3323aa_lp_filter_regval); ++idx) {
+		if (d3323aa_lp_filter_regval[idx] == regval)
+			break;
+	}
+
+	if (idx == ARRAY_SIZE(d3323aa_lp_filter_regval))
+		return -EINVAL;
+
+	*val = d3323aa_hp_filter_freq[idx][0];
+	*val2 = d3323aa_hp_filter_freq[idx][1];
+
+	return 0;
+}
+
+static int d3323aa_get_lp_filter_freq(unsigned long *regmap, int *val,
+				      int *val2)
+{
+	size_t idx;
+	u8 regval;
+
+	regval = bitmap_read(regmap, D3323AA_REG_BIT_FILSEL0,
+			     D3323AA_FILTER_TYPE_NR_BITS);
+	for (idx = 0; idx < ARRAY_SIZE(d3323aa_lp_filter_regval); ++idx) {
+		if (d3323aa_lp_filter_regval[idx] == regval)
+			break;
+	}
+
+	if (idx == ARRAY_SIZE(d3323aa_lp_filter_regval))
+		return -EINVAL;
+
+	*val = d3323aa_lp_filter_freq[idx][0];
+	*val2 = d3323aa_lp_filter_freq[idx][1];
+
+	return 0;
+}
+
+static int d3323aa_set_lp_filter_freq(unsigned long *regmap, const int val,
+				      int val2)
+{
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
+		if (val == integer && val2 == fract)
+			break;
+	}
+
+	if (idx == ARRAY_SIZE(d3323aa_lp_filter_freq))
+		return -ERANGE;
+
+	bitmap_write(regmap, d3323aa_lp_filter_regval[idx],
+		     D3323AA_REG_BIT_FILSEL0, D3323AA_FILTER_TYPE_NR_BITS);
+
+	return 0;
+}
+
+static int d3323aa_get_filter_gain(unsigned long *regmap, int *val)
+{
+	size_t idx;
+	u8 regval;
+
+	regval = bitmap_read(regmap, D3323AA_REG_BIT_FSTEP0,
+			     D3323AA_FILTER_GAIN_REG_NR_BITS);
+	for (idx = 0; idx < ARRAY_SIZE(d3323aa_filter_gain_regval); ++idx) {
+		if (d3323aa_filter_gain_regval[idx] == regval)
+			break;
+	}
+
+	if (idx == ARRAY_SIZE(d3323aa_filter_gain_regval))
+		return -EINVAL;
+
+	*val = d3323aa_filter_gain[idx];
+
+	return 0;
+}
+
+static int d3323aa_set_filter_gain(unsigned long *regmap, const int val)
+{
+	size_t idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(d3323aa_filter_gain); ++idx) {
+		if (d3323aa_filter_gain[idx] == val)
+			break;
+	}
+
+	if (idx == ARRAY_SIZE(d3323aa_filter_gain))
+		return -ERANGE;
+
+	bitmap_write(regmap, d3323aa_filter_gain_regval[idx],
+		     D3323AA_REG_BIT_FSTEP0, D3323AA_FILTER_GAIN_REG_NR_BITS);
+
+	return 0;
+}
+
+static void d3323aa_get_threshold(unsigned long *regmap, int *val)
+{
+	*val = bitmap_read(regmap, D3323AA_REG_BIT_DETLVLABS0,
+			   D3323AA_THRESH_REG_NR_BITS);
+}
+
+static int d3323aa_set_threshold(unsigned long *regmap, const int val)
+{
+	if (val > ((1 << D3323AA_THRESH_REG_NR_BITS) - 1))
+		return -ERANGE;
+
+	bitmap_write(regmap, val, D3323AA_REG_BIT_DETLVLABS0,
+		     D3323AA_THRESH_REG_NR_BITS);
+
+	return 0;
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
+	int ret;
+
+	guard(mutex)(&data->regmap_lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		ret = d3323aa_get_hp_filter_freq(data->regmap, val, val2);
+		if (ret)
+			return ret;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret = d3323aa_get_lp_filter_freq(data->regmap, val, val2);
+		if (ret)
+			return ret;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		ret = d3323aa_get_filter_gain(data->regmap, val);
+		if (ret)
+			return ret;
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
+	DECLARE_BITMAP(regmap, D3323AA_REG_NR_BITS);
+	int ret;
+
+	guard(mutex)(&data->regmap_lock);
+
+	bitmap_copy(regmap, data->regmap, D3323AA_REG_NR_BITS);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		/*
+		 * We only allow to set the low-pass cutoff frequency, since
+		 * that is the only way to unambigously choose the type of
+		 * band-pass filter. For example, both filter type B and C have
+		 * 0.3 Hz as high-pass cutoff frequency (see
+		 * d3323aa_hp_filter_freq).
+		 */
+		return -EINVAL;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret = d3323aa_set_lp_filter_freq(regmap, val, val2);
+		if (ret)
+			return ret;
+		break;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		ret = d3323aa_set_filter_gain(regmap, val);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return d3323aa_setup(indio_dev, regmap);
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
+	guard(mutex)(&data->regmap_lock);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		d3323aa_get_threshold(data->regmap, val);
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
+	DECLARE_BITMAP(regmap, D3323AA_REG_NR_BITS);
+	int ret;
+
+	guard(mutex)(&data->regmap_lock);
+
+	bitmap_copy(regmap, data->regmap, D3323AA_REG_NR_BITS);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = d3323aa_set_threshold(regmap, val);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return d3323aa_setup(indio_dev, regmap);
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
+static int d3323aa_probe(struct platform_device *pdev)
+{
+	DECLARE_BITMAP(default_regmap, D3323AA_REG_NR_BITS);
+	struct d3323aa_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
+	if (!indio_dev)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "Could not allocate iio device\n");
+
+	data = iio_priv(indio_dev);
+	data->dev = &pdev->dev;
+	platform_set_drvdata(pdev, indio_dev);
+
+	init_completion(&data->reset_completion);
+
+	ret = devm_mutex_init(data->dev, &data->regmap_lock);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Could not initialize mutex (%d)\n", ret);
+
+	/* Request GPIOs. */
+	data->gpiod_vdd = devm_gpiod_get(data->dev, "vdd", GPIOD_OUT_LOW);
+	if (IS_ERR(data->gpiod_vdd))
+		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_vdd),
+				     "Could not get GPIO vdd (%ld)\n",
+				     PTR_ERR(data->gpiod_vdd));
+
+	data->gpiod_clk_vout =
+		devm_gpiod_get(data->dev, "clk-vout", GPIOD_OUT_LOW);
+	if (IS_ERR(data->gpiod_clk_vout))
+		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_clk_vout),
+				     "Could not get GPIO clk-vout (%ld)\n",
+				     PTR_ERR(data->gpiod_clk_vout));
+
+	data->gpiod_data = devm_gpiod_get(data->dev, "data", GPIOD_OUT_LOW);
+	if (IS_ERR(data->gpiod_data))
+		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_data),
+				     "Could not get GPIO data (%ld)\n",
+				     PTR_ERR(data->gpiod_data));
+
+	ret = gpiod_to_irq(data->gpiod_clk_vout);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret, "Could not get IRQ (%d)\n",
+				     ret);
+
+	data->irq = ret;
+
+	/* Do one setup with the default values. */
+	bitmap_zero(default_regmap, D3323AA_REG_NR_BITS);
+	d3323aa_set_threshold(default_regmap, D3323AA_THRESH_DEFAULT_VAL);
+	d3323aa_set_filter_gain(default_regmap,
+				D3323AA_FILTER_GAIN_DEFAULT_VAL);
+	ret = d3323aa_setup(indio_dev, default_regmap);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &d3323aa_info;
+	indio_dev->name = D3323AA_DRV_NAME;
+	indio_dev->channels = d3323aa_channels;
+	indio_dev->num_channels = ARRAY_SIZE(d3323aa_channels);
+
+	ret = devm_iio_device_register(data->dev, indio_dev);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Could not register iio device (%d)\n",
+				     ret);
+
+	return 0;
+}
+
+static void d3323aa_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct d3323aa_data *data = iio_priv(indio_dev);
+
+	if (data->detecting)
+		free_irq(data->irq, indio_dev);
+}
+
+static const struct of_device_id d3323aa_of_match[] = {
+	{
+		.compatible = "nicera,d3323aa",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, d3323aa_of_match);
+
+static struct platform_driver d3323aa_driver = {
+	.probe = d3323aa_probe,
+	.remove = d3323aa_remove,
+	.driver = {
+		.name = D3323AA_DRV_NAME,
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


