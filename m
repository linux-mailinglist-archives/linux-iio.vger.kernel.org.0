Return-Path: <linux-iio+bounces-20680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 606B0ADA037
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 00:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9113B3B7070
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 22:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131B220C026;
	Sat, 14 Jun 2025 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Fl+aQ8pg"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012025.outbound.protection.outlook.com [52.101.71.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365FE20C004;
	Sat, 14 Jun 2025 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749939256; cv=fail; b=uatBab6TjDnEwM+MCG7NFMOGPLn/DejukM0lGSrl69DzUzPq6A48D5VxxfcyadAtj8Vmr7a+F/qQSTU/sXBIF4yeVh3i/iYCWLWwerk+v+zF1z/STciuaKDLLnHDg2KrFIPxOfscGTEFCLXJ0EBNpHqFygZeUKZi4iN43AeLaDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749939256; c=relaxed/simple;
	bh=P5kQO+utbhBf0Mf7K1y6qAG5hI1zm2W3y1Y7HqjPjB8=;
	h=From:To:CC:Subject:In-Reply-To:Message-ID:Date:MIME-Version:
	 Content-Type; b=Edi/lQ5qawkq70NQi/XS49h5Erwyw44dTyPyqoUXz4jQhU3xmZir1pZxPf6JTu5sbLkH2/7lQb7HBYY9Je11S4KjMfDIZfMOOSoKt5Prh1o50VbcZmR4n09PbHHf/HUqZ1maXxRFid4SYCM6A4Ma0EcUPhsMSISwSWE0gknb1k8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Fl+aQ8pg; arc=fail smtp.client-ip=52.101.71.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaizWKVcGwPEZsvwaWEU6btBxDxxCJFXQZE6djqPvB6qVdVjWho3B0IxSMYHP2xoldrBFfP3rKaxFZ4Okwd75LWpKPUWfqRJIPVRXN10s8gH6nLH67pUxFLiWccRywKEqihWI4LtZuXbDcHBExnSDO+0uDEGrk9vJ0LfFwOsPKjZZG8BaFmi5jD7mUc08zyV/O1hAUdpzFU6EHMRjhUNHumC+0AFJPhu5w/3/vTh3gpVN3GXduRXSgEHeXmILbgM8BH8nNhbQfrsibRfrWeV+82yq84muOU3ZFgfa9xqLAFHyEyzMCcygaOyuKK+Llvyaj2TNGWDFIBlD+cC2IxJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gv5MSOl/2M1l5AAAMPQHjn8l+P8cpZg2Jo3V18/YuM0=;
 b=q6LMvcJg6wWHA4nlA3kfF7Rb0VsIvG9brDjq2bhDZmVbwOO1nscmFpgN+vmaQpqZJZvyQ1sK2IFgNdbBCTdu9oNBcTNQxOBeJLoLYop4J3qhJULAB7u7H48Mv4fuQssgvu4FoaPgsUhiFrje37FtZaxNPSpKraVc2xmDnPxWI+Z+nL7ZqoKn9MW7eTQdo5Vis8g1FbeNC7YTmDerhOKiaojS/ZH6+kTd+Yhw3un/6f/rJD3TYMB5Iahqh5VmXyjTo3ORi8rCK6HXqQamGIFw/k76wF4cqj+3/8aZ8BkfPYmmhW9nfI5nGwg8yRM6tV8n9k/9i84AuCCI6OrK7jtREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gv5MSOl/2M1l5AAAMPQHjn8l+P8cpZg2Jo3V18/YuM0=;
 b=Fl+aQ8pgFNGu3v023ewlgvzp75dTwaAvOk/DX3kZuT6P8jVYLWZk/AdODJFAC467+KywaKfyjbIWyaFJ8a7z5b6ea5sfJXGoCXFl3eVsr36yIJNTGI3IIVPRnOhy3lVLo4Ytn/MrhydzOm0A02/wpBcLdBd/YMXHaWyUjpeULWs=
Received: from DUZPR01CA0346.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::29) by PAXPR02MB7996.eurprd02.prod.outlook.com
 (2603:10a6:102:2ba::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Sat, 14 Jun
 2025 22:14:07 +0000
Received: from DU6PEPF0000B620.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::2e) by DUZPR01CA0346.outlook.office365.com
 (2603:10a6:10:4b8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.27 via Frontend Transport; Sat,
 14 Jun 2025 22:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B620.mail.protection.outlook.com (10.167.8.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 22:14:06 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Sun, 15 Jun
 2025 00:14:06 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH v2 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <cover.1749938844.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <5d12fcd6faae86f7280e753f887ea60513b22ea9.1749938844.git.waqar.hameed@axis.com>
Date: Sun, 15 Jun 2025 00:14:05 +0200
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B620:EE_|PAXPR02MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1761ee-b2bd-4fa2-0e16-08ddab90c7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6fojvbMrnWyKjae6uCIOIyxP1hbHTDV8qa5oCkDM3rxMjYAmVmZc5GNNY7xT?=
 =?us-ascii?Q?zbfqroui1Lj003siIAbaz41LrFoe9qsJuWcib/PRWjkoC51EK7gMUIA3u+c5?=
 =?us-ascii?Q?5J9sHLgq0orcRuEzigWwF4mpHbFfY1B0i5aReAeb8JZ5CBJ9itY2O3Z2y4wu?=
 =?us-ascii?Q?2np/4bn4OlNVMqlBWIqb1sR9X5flUr4+WCOBxyDl0JCYZgwpUVw1OuONWN/i?=
 =?us-ascii?Q?A8qoXEXOH+qw2HbQZ/TWpxc/RvsChFm68kBkcIYic8kCNA6D+64+VWlKCu8p?=
 =?us-ascii?Q?pIrVdLYZYdfjU0JRUKLE33qlax1K51f6gYNgntEt5Jryag5gR8DRPSesnJko?=
 =?us-ascii?Q?KsqJOTLr0wUPksXnFOXUWnz2vbhp2mtVazAe14I8pgNFVPnSljIidTMuYScF?=
 =?us-ascii?Q?UoNbgBD37pQe8xYCbG3/xs/IgqyYqeCZNjVI+hktKfX/hATnC/JbKliMmqKv?=
 =?us-ascii?Q?IS/zpZv0U1UiGKFtB/BPA1QiVcrDZaGX5c0/f+597Nat0yVvaTd0gJmw+QGQ?=
 =?us-ascii?Q?uetjRPJtBSTY5eKVqCxVKvXLtg21cL0uB7SZ5Iti1Fc5IaQT8tQPrnsbrO4h?=
 =?us-ascii?Q?kgU0eLbCSWIZoWwRC+dnuHXpI6fzQX8BMB1Dy/XAsZd/KiT8L1S9FxrjaFQG?=
 =?us-ascii?Q?uWjTH3SEx5v+G0QMum59JIiqEAn4W9sUSvnkcfBLkg8gk/oYtslbO4Hs5i+X?=
 =?us-ascii?Q?q0zZPUZ3QHh8BqFQBkJOgkX5wbqoDElMwfXVM/gXcVZXIanpoVDsxLtotc6S?=
 =?us-ascii?Q?tmJEJYL5on5kxV+SPoju6kJeD8/8T98fUCR2Mn7Lfd3bF8y596hmFbKCiO6S?=
 =?us-ascii?Q?r60bSJgUzEVMH5wQZOtZ5tTm3halkbRxYZ6IyNx4hRcrPv8ALZVDN1K5cK4G?=
 =?us-ascii?Q?B4rUHWbgrHqUUH3nVBROj4VHs9yBBcH0M0kMobhOPkwWj94XGl1UFKNvjGhu?=
 =?us-ascii?Q?czXoefvQRAptwuAsk4L+8GlHab/sXh7gqrlNSDQCEuK3RmfMokjKIWNCBA6M?=
 =?us-ascii?Q?CM5cNpeuLFhKjbiuaLbgtAJDoVZ7mXC6hm8C/WONotQIgI4DguUwxz+iB/W3?=
 =?us-ascii?Q?QVKrfYRlc4Xc2/MPdVYhsQQsPOqiY3uDGiF/jcCurGzIowMznfUo5rbPMocp?=
 =?us-ascii?Q?A9rWUma2F4gjqEDaZ2d4tIfz21nIX9ViFoDTsYWvR9jR+r+b9e75t0j+WPGs?=
 =?us-ascii?Q?+5Y0CSQ5Gf9XK//sGCefcbInOwRCZN/kaCCR591am6sWDsMzds3GyGXX7GdY?=
 =?us-ascii?Q?bQ5NSjhVvn7hEhDBg/c2da/EtmuUx2HOMQRtkWnzZ4hMafaTvAAPUFp+5/OQ?=
 =?us-ascii?Q?R/sxeNXZHqyld2UhqxgU8jzM2McBfjpWRYvdvAaESk/71Ks5jkoARaaOB6dj?=
 =?us-ascii?Q?9AxbEPb3QjqQnpD2clObxb2M2kghBx43rb27QB3AXWi/8X1pWpH6XhTUyYpl?=
 =?us-ascii?Q?QdB3embMpTBvShq4SqnlJM0shS4IpqIz1ElkmRXD7xnBlKRVIRbkO1dMO/vq?=
 =?us-ascii?Q?ooP7YPe2bwj/pSGFd5DDg0Pqs3i6meHB3lKG?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 22:14:06.8930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1761ee-b2bd-4fa2-0e16-08ddab90c7a3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7996

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
 drivers/iio/proximity/d3323aa.c | 808 ++++++++++++++++++++++++++++++++
 3 files changed, 818 insertions(+)
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
index 000000000000..71bccca75abd
--- /dev/null
+++ b/drivers/iio/proximity/d3323aa.c
@@ -0,0 +1,808 @@
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
+	atomic_t irq_reset_count;
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
+		if (!val && atomic_inc_return(&data->irq_reset_count) ==
+				    D3323AA_IRQ_RESET_COUNT)
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
+	msleep(30 + 5);
+
+	/*
+	 * After setting VDD to high, the device signals with
+	 * D3323AA_IRQ_RESET_COUNT falling edges on Vout/CLK that it is now
+	 * ready for configuration. Datasheet says that this should happen
+	 * within D3323AA_RESET_TIMEOUT ms. Count these two edges within that
+	 * timeout.
+	 */
+	atomic_set(&data->irq_reset_count, 0);
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
+	usleep_range(2000, 5000);
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
+	usleep_range(10, 20);
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
+		return -ERANGE;
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
+		return -ERANGE;
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
+		return -ERANGE;
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
+		return -ERANGE;
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
+
+	init_completion(&data->reset_completion);
+
+	ret = devm_mutex_init(data->dev, &data->statevar_lock);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Could not initialize mutex\n");
+
+	data->regulator_vdd = devm_regulator_get_exclusive(data->dev, "vdd");
+	if (IS_ERR(data->regulator_vdd))
+		return dev_err_probe(data->dev, PTR_ERR(data->regulator_vdd),
+				     "Could not get regulator\n");
+
+	ret = devm_add_action_or_reset(data->dev, d3323aa_disable_regulator,
+				       data);
+	if (ret)
+		return dev_err_probe(
+			data->dev, ret,
+			"Could not add disable regulator action\n");
+
+	data->gpiod_clkin_detectout =
+		devm_gpiod_get(data->dev, "vout-clk", GPIOD_OUT_LOW);
+	if (IS_ERR(data->gpiod_clkin_detectout))
+		return dev_err_probe(data->dev,
+				     PTR_ERR(data->gpiod_clkin_detectout),
+				     "Could not get GPIO vout-clk\n");
+
+	data->gpiod_data = devm_gpiod_get(data->dev, "data", GPIOD_OUT_LOW);
+	if (IS_ERR(data->gpiod_data))
+		return dev_err_probe(data->dev, PTR_ERR(data->gpiod_data),
+				     "Could not get GPIO data\n");
+
+	ret = gpiod_to_irq(data->gpiod_clkin_detectout);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret, "Could not get IRQ\n");
+
+	/*
+	 * Device signals with a rising or falling detection signal when the
+	 * proximity data is above or below the threshold, respectively.
+	 */
+	ret = devm_request_irq(data->dev, ret, d3323aa_irq_handler,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			       dev_name(data->dev), indio_dev);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
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
+	ret = devm_iio_device_register(data->dev, indio_dev);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
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


