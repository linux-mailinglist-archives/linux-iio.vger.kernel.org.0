Return-Path: <linux-iio+bounces-12423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104C99D401E
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 17:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE95E281299
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC2E155725;
	Wed, 20 Nov 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ZAovLTt2"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC08D153828;
	Wed, 20 Nov 2024 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120384; cv=fail; b=g72+ggduObRBK4hrSR0zR6v+km1tEoX4EOpwIYRSEDe8hz5ayM++CrpV+LZnMWlsU6/eRpPYjVtQSHSkVzLaRVyJPjp4qs+xcv2CI8AHduSlTpydT3Y1e76aboKd0Yx4vtfAXjcRAqKGu5gsTlyDPkgUs2HsdNgJCNTn2p/nFb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120384; c=relaxed/simple;
	bh=MfauhE/C5Xbvk2M4pNK5OzZPg63bTBudfizVjui/0bs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnVbwFbOtw8YKWcfaMKIij7IWSDEMVfG2Yxx1Wzy+bJ897zTS1exBAP/SjPYaFBC4tvWwCUeqUnxbZEg+gUI5ZfDHB5xkmHbqXTkeg0y+on9kemztBVSxS7uNMIvrrffElg3bRKaytwSAnlcyR4HKL1WIiIt6miUyBk9W0rvWJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ZAovLTt2; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Br+lEj0SJEgCGdGDlRbk4hxjEikA1QiCKx9jmgKWIL5+eQghmuglbeExQojvo8/EWjpAdSVFeHRz+WlqiTWZpx6Cn0gxviWhnc+ozUc83KBkhfCYi6zZQJ/esk+v5FxD3s1eunNK2J0wQIU/k9uu0d3UXMa5hT1lAFq7yOScCr/MyktlRlDyXUbBOSBV50lVMNIUpukC/EIOhOljR7wFHUPy7vWhApbMuuJ5jLUXa2i77LVfAawBJS29M6CUET6VMLSm2bjLQ/nLZXuh3Jonbl+NXorxVt5GlPEmlkwEyPujZdRlXtMKZFL2IxpEFzLarPEhzJnL9F/u/M1vNOfGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZeh8Iw1tkMaNdyh4H3OurKQETN8TRaeVg8evMblOsQ=;
 b=SydlguxbYxXqvJGgxhAvqDS14VxO47xp5bxHNBN2dEfoRl7BB6Lb+VmKONTw4TFmLcCgwaZVy28u3lbAJkvsETVw0TLNo/tNUoDcd3y9Xwmj6f2gwABHxeUk83cDF7ej6rieYvw3mB0uumtKh6B7XrJSFLf3Ko6ADUDRambX05vHeexrJOx29Zvy3WT7cYaqtB4UmdUxVdBq+yoVnFPEvHZOZEzf5v7TjitNNmuo3RsBx3UC3gwUy2C+6SlNN+5OGKQ0qOj5gFnuDONhi0MRkHPtHcRWdVnV4/yKrKuEuymRFyJvnY56gZV4tVsJ8cn3OQFZ0m72oIkVKMlkTqQ53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZeh8Iw1tkMaNdyh4H3OurKQETN8TRaeVg8evMblOsQ=;
 b=ZAovLTt2lewaKX/CMd7E62GvwuXKuq4WhGjdZYgJEim6ARpxAllNkRdniDw61d5EFW0H1N/lNUV1QS92dKB95lI85w8NlwkOAyULnDZnwodeDCOWdinbUP/fHIbfbfF39b3e78/oWmnWxOck3FsyfLkBqNXJ31oxt7+f8YdfEYg=
Received: from AM0PR05CA0083.eurprd05.prod.outlook.com (2603:10a6:208:136::23)
 by GV1PR02MB8657.eurprd02.prod.outlook.com (2603:10a6:150:93::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 16:32:57 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:208:136:cafe::53) by AM0PR05CA0083.outlook.office365.com
 (2603:10a6:208:136::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Wed, 20 Nov 2024 16:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 16:32:56 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 17:32:54 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 20 Nov 2024 17:32:54 +0100
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 2E1323BB;
	Wed, 20 Nov 2024 17:32:54 +0100 (CET)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id 2C31C18E1ECB; Wed, 20 Nov 2024 17:32:54 +0100 (CET)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: [PATCH v6 2/2] iio: light: Add support for TI OPT4060 color sensor
Date: Wed, 20 Nov 2024 17:32:47 +0100
Message-ID: <20241120163247.2791600-3-perdaniel.olsson@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241120163247.2791600-1-perdaniel.olsson@axis.com>
References: <20241120163247.2791600-1-perdaniel.olsson@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|GV1PR02MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd4d840-091e-4b7e-d236-08dd0980fd5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kbq8RK6Yza0e8ImiHPOz5I8rK86qE3YB7JQY3vfc2ohSiJs1uPRaRtcO2GJh?=
 =?us-ascii?Q?VSH+4qSeUd2e2WZZe1yHHyFOF9hU8UQL50lDdsIJzRLtS8BggL//q/dZpGPH?=
 =?us-ascii?Q?lSPkLuVkN3dO4wwshZeqYHDZW1uGPyFNIuNBoGhhrSeMqhorer8UKCMK9Ecq?=
 =?us-ascii?Q?T5W9NiDCnsH3vNRgX2UsjfuZrQ1hYcJTi+LBywlCnhC+L5mte/F11X8+cFPD?=
 =?us-ascii?Q?dTmSlYAi1OKPlkOt8u2MfQzk9eh95JPzKhbAe6mwg2BqPIs8mkQHFmzM4xmT?=
 =?us-ascii?Q?l6mc2m2p80D0ExAUnMJWP0h2j6p6cB+2DL9F2oQMKtasKqfBSSWcaJSkcYa5?=
 =?us-ascii?Q?09GHvLUJ5OZpyGdd3uAF6c8dG0/I4sBZHlG2UWADmDR9PdEybrgP1lZtea87?=
 =?us-ascii?Q?QDIlQStmAc8V+cxeeZ9hbiEDlr37CBhzFcIOQ6I/a+Qrj5mqpBOWUICeFrJM?=
 =?us-ascii?Q?sqPBh7iJUdWcV3I/Wy83+ZyDTlUtfFf8/rSgffAz9vpIDG9FeuG/gyZUIZUL?=
 =?us-ascii?Q?tG65PVhNUw+IFZ4WZBqB1WsbfeDrvajtMkFDINBuyscCuWMF7X4LjJby5c7B?=
 =?us-ascii?Q?fm+iwt0Gjv/sA3hI/ImDJo6V38FQ6RUNNiZsdZHuz7jUTR4u0Ay36Z5qFws+?=
 =?us-ascii?Q?CM8ZGnlm64obXbrUsfZROCSRA2aMGk8bGqLxMMiHnXfk2nPsAULrFoPvceqR?=
 =?us-ascii?Q?NMV2Z5vmxgZDTCH1ns2bgrc+JgCOtD3HgNkKQK0tQ2Q+oIu/YGnvU8wNM9a/?=
 =?us-ascii?Q?/2qnyOZq9qhuUmLkaWPYMgy4kQzXkTkplJbYOO2XZTsbV2upXQZMRQZayURX?=
 =?us-ascii?Q?a+3uTUpm3LZIqkX2sYxRUp+9sxlN+wq5hOch1/+mJsP2Gzkilk4PIT/vJyiZ?=
 =?us-ascii?Q?gzRUWt6gOCrRBXQ9SvDxZ2eEK+WEjE2wOBjvfZUj8afYsDqRIBOh7kUHtXg9?=
 =?us-ascii?Q?HSxzFyo9Pc+k+GSBD4lRLSYQgjdwleA2STj2JMynVpDPq1gcAJ5TqdMjGkQr?=
 =?us-ascii?Q?nwAsURQMlOQgDMbCt70w8bRZlnDvm7zpGhR3qcqzbMxbEEqgfwCK4WRUJpAt?=
 =?us-ascii?Q?eaeuEWYKpxKPzBvgF/tsxuHNfa5MikmOmLiuGh5hyqI5MSSZ5f74iT8PIKD1?=
 =?us-ascii?Q?Ybgw8mKKei59kB72zuu5o7bKi8bQKAl2lrFezfjKgyMxkn7e51I4BKmXn+Hj?=
 =?us-ascii?Q?9oeRX19YtnWz/g16AEvrjVlc473jrWRcHb5hZJm0EAwsKcDu3eXyjH0MzneC?=
 =?us-ascii?Q?hQfz/jWUBrC3dbxIiN+uG5nE+6cPVHCfbEFSTxrT5vnDBLELC0C4R3JOHw0Z?=
 =?us-ascii?Q?z7dVUIuwyeg3TI96ZP7y4iHQB75G4u+6LLna7GZ1uF10ccNu6O5cWXU8n4yt?=
 =?us-ascii?Q?SctcEZA=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 16:32:56.7192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd4d840-091e-4b7e-d236-08dd0980fd5c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8657

Add support for Texas Instruments OPT4060 RGBW Color sensor.

Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
---
 Documentation/ABI/testing/sysfs-bus-iio |    4 +
 Documentation/iio/index.rst             |    1 +
 Documentation/iio/opt4060.rst           |   52 +
 drivers/iio/light/Kconfig               |   13 +
 drivers/iio/light/Makefile              |    1 +
 drivers/iio/light/opt4060.c             | 1295 +++++++++++++++++++++++
 6 files changed, 1366 insertions(+)
 create mode 100644 Documentation/iio/opt4060.rst
 create mode 100644 drivers/iio/light/opt4060.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 9641dd2a1e4b..491c43fe45a0 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1633,6 +1633,10 @@ What:		/sys/.../iio:deviceX/in_intensityY_uv_raw
 What:		/sys/.../iio:deviceX/in_intensityY_uva_raw
 What:		/sys/.../iio:deviceX/in_intensityY_uvb_raw
 What:		/sys/.../iio:deviceX/in_intensityY_duv_raw
+What:		/sys/.../iio:deviceX/in_intensity_red_raw
+What:		/sys/.../iio:deviceX/in_intensity_green_raw
+What:		/sys/.../iio:deviceX/in_intensity_blue_raw
+What:		/sys/.../iio:deviceX/in_intensity_clear_raw
 KernelVersion:	3.4
 Contact:	linux-iio@vger.kernel.org
 Description:
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 074dbbf7ba0a..5710f5b9e958 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -29,3 +29,4 @@ Industrial I/O Kernel Drivers
    adxl380
    bno055
    ep93xx_adc
+   opt4060
diff --git a/Documentation/iio/opt4060.rst b/Documentation/iio/opt4060.rst
new file mode 100644
index 000000000000..d81bac4cc23f
--- /dev/null
+++ b/Documentation/iio/opt4060.rst
@@ -0,0 +1,52 @@
+==============================
+OPT4060 driver
+==============================
+
+1. Overview
+=============================
+
+This driver supports the Texas Instrument RGBW high resolution color sensor over
+I2C.
+https://www.ti.com/lit/gpn/opt4060
+
+The driver supports:
+- Raw values for red, green, blue and clear.
+- Illuminance values.
+- Scaled color values for red, green and blue.
+- IIO events for thresholds.
+- IIO triggered buffer using both its own data ready trigger and triggers from
+other drivers.
+
+2. Illuminance calculation
+=============================
+
+Illuminance is calculated using the wide spectrum green channel.
+
+lux = GREEN_RAW x 2.15e-3
+
+The value is accessed from:
+/sys/bus/iio/devices/iio:deviceX/in_illuminance_input
+
+See section 8.4.5.2 in the data sheet for additional details.
+
+3. Scaled color values
+=============================
+
+The driver exposes scaled color values that indicate the ratio between the three
+different colors independent of the light intensity. This is calculated in the
+following way:
+
+R = RED_RAW x 2.4
+G = GREEN_RAW x 1.0
+B = BLUE_RAW x 1.3
+
+R_SCALED = R / (R + G + B)
+G_SCALED = G / (R + G + B)
+B_SCALED = B / (R + G + B)
+
+The values are accessed from:
+/sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
+/sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
+/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
+
+See section 8.4.5.2 in the data sheet for additional details.
\ No newline at end of file
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 29ffa8491927..96cd26d95af9 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -491,6 +491,19 @@ config OPT4001
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
index f14a37442712..0ea5e6348878 100644
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
index 000000000000..4a0456c63c07
--- /dev/null
+++ b/drivers/iio/light/opt4060.c
@@ -0,0 +1,1295 @@
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
+ * @OPT4060_ILLUM:	Calculated illuminance channel.
+ * @OPT4060_NUM_CHANS:	Number of channel types.
+ */
+enum opt4060_chan_type {
+	OPT4060_RED,
+	OPT4060_GREEN,
+	OPT4060_BLUE,
+	OPT4060_CLEAR,
+	OPT4060_ILLUM,
+	OPT4060_NUM_CHANS
+};
+
+struct opt4060_chip {
+	struct regmap *regmap;
+	struct device *dev;
+	struct iio_trigger *trig;
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
+	unsigned int ctrl_reg;
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
+	/* If the device is already in continuous mode, one-shot is not needed. */
+	if (FIELD_GET(OPT4060_CTRL_OPER_MODE_MASK, ctrl_reg) ==
+	    OPT4060_CTRL_OPER_MODE_CONTINUOUS)
+		return 0;
+
+	ctrl_reg &= ~OPT4060_CTRL_OPER_MODE_MASK;
+	ctrl_reg |= FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
+				OPT4060_CTRL_OPER_MODE_ONE_SHOT);
+
+	/* Trigger a new conversion by writing to CRTL register. */
+	ret = regmap_write(chip->regmap, OPT4060_CTRL, ctrl_reg);
+	if (ret)
+		dev_err(chip->dev, "Failed to set ctrl register\n");
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
+	u16 result[2];
+	u32 mantissa_raw;
+	u16 msb, lsb;
+	u8 exp, count, crc, calc_crc;
+
+	ret = regmap_bulk_read(chip->regmap, address, result, 2);
+	if (ret) {
+		dev_err(chip->dev, "Reading channel data failed\n");
+		return ret;
+	}
+	exp = FIELD_GET(OPT4060_EXPONENT_MASK, result[0]);
+	msb = FIELD_GET(OPT4060_MSB_MASK, result[0]);
+	count = FIELD_GET(OPT4060_COUNTER_MASK, result[1]);
+	crc = FIELD_GET(OPT4060_CRC_MASK, result[1]);
+	lsb = FIELD_GET(OPT4060_LSB_MASK, result[1]);
+	mantissa_raw = (msb << 8) + lsb;
+	calc_crc = opt4060_calculate_crc(exp, mantissa_raw, count);
+	if (calc_crc != crc)
+		return -EIO;
+	*raw = mantissa_raw << exp;
+	return 0;
+}
+
+static int opt4060_trigger_new_samples(struct iio_dev *indio_dev)
+{
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+	int ret;
+
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
+						usecs_to_jiffies(timeout_us)) == 0) {
+			dev_err(chip->dev, "Completion timed out.\n");
+			return -ETIME;
+		}
+		/*
+		 * The opt4060_trigger_one_shot() function will enable irq on
+		 * every conversion. If the buffer isn't enabled, irq should
+		 * only be enabled for thresholds.
+		 */
+		if (!iio_buffer_enabled(indio_dev)) {
+			ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_THRESHOLD);
+			if (ret)
+				return ret;
+		}
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
+	return ret;
+}
+
+static int opt4060_read_chan_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan, int *val)
+{
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+	u32 adc_raw;
+	int ret;
+
+	ret = opt4060_trigger_new_samples(indio_dev);
+	if (ret) {
+		dev_err(chip->dev, "Failed to trigger new samples.\n");
+		return ret;
+	}
+
+	ret = opt4060_read_raw_value(chip, chan->address, &adc_raw);
+	if (ret) {
+		dev_err(chip->dev, "Reading raw channel data failed.\n");
+		return ret;
+	}
+	*val = adc_raw;
+	return IIO_VAL_INT;
+}
+
+/*
+ * Function for calculating color components independent of light intensity. The
+ * raw values are multiplied by individual factors that correspond to the
+ * sensitivity of the different color filters. The returned value is normalized.
+ */
+static int opt4060_read_chan_scale(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan,
+				   int *val, int *val2)
+{
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+	static const u32 color_factors[] = { 24, 10, 13 };
+	u32 adc_raw[3], sum = 0, rem;
+	int ret;
+
+	ret = opt4060_trigger_new_samples(indio_dev);
+	if (ret) {
+		dev_err(chip->dev, "Failed to trigger new samples.\n");
+		return ret;
+	}
+
+	for (int color = OPT4060_RED; color <= OPT4060_BLUE; color++) {
+		ret = opt4060_read_raw_value(chip, indio_dev->channels[color].address,
+					     &(adc_raw[color]));
+		if (ret) {
+			dev_err(chip->dev, "Reading raw channel data failed\n");
+			return ret;
+		}
+		adc_raw[color] *= color_factors[color];
+		sum += adc_raw[color];
+	}
+	*val = div_u64_rem((u64)adc_raw[chan->scan_index], sum, &rem);
+	*val2 = DIV_U64_ROUND_CLOSEST((u64)(rem * MICRO), sum);
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int opt4060_calc_illuminance(struct opt4060_chip *chip, int *val)
+{
+	u32 lux_raw;
+	int ret;
+
+	/* The green wide spectral channel is used for illuminance. */
+	ret = opt4060_read_raw_value(chip, OPT4060_GREEN_MSB, &lux_raw);
+	if (ret) {
+		dev_err(chip->dev, "Reading raw channel data failed\n");
+		return ret;
+	}
+
+	/* Illuminance is calculated by ADC_RAW * 2.15e-3. */
+	*val = DIV_U64_ROUND_CLOSEST((u64)(lux_raw * 215), 1000);
+	return ret;
+}
+
+static int opt4060_read_illuminance(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    int *val)
+{
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+	int ret;
+
+	ret = opt4060_trigger_new_samples(indio_dev);
+	if (ret) {
+		dev_err(chip->dev, "Failed to trigger new samples.\n");
+		return ret;
+	}
+	ret = opt4060_calc_illuminance(chip, val);
+	if (ret) {
+		dev_err(chip->dev, "Failed to calculate illuminance.\n");
+		return ret;
+	}
+
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
+#define _OPT4060_COLOR_CHANNEL(_color, _mask, _ev_spec, _num_ev_spec)		\
+{										\
+	.type = IIO_INTENSITY,							\
+	.modified = 1,								\
+	.channel2 = IIO_MOD_LIGHT_##_color,					\
+	.info_mask_separate = _mask,						\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),			\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),	\
+	.address = OPT4060_##_color##_MSB,					\
+	.scan_index = OPT4060_##_color,						\
+	.scan_type = {								\
+		.sign = 'u',							\
+		.realbits = 32,							\
+		.storagebits = 32,						\
+		.endianness = IIO_CPU,						\
+	},									\
+	.event_spec = _ev_spec,							\
+	.num_event_specs = _num_ev_spec,					\
+}
+
+#define OPT4060_COLOR_CHANNEL(_color, _mask)					\
+	_OPT4060_COLOR_CHANNEL(_color, _mask, opt4060_event_spec,		\
+			       ARRAY_SIZE(opt4060_event_spec))			\
+
+#define OPT4060_COLOR_CHANNEL_NO_EVENTS(_color, _mask)				\
+	_OPT4060_COLOR_CHANNEL(_color, _mask, NULL, 0)				\
+
+#define OPT4060_LIGHT_CHANNEL(_channel)						\
+{										\
+	.type = IIO_LIGHT,							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),			\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),			\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),	\
+	.scan_index = OPT4060_##_channel,					\
+	.scan_type = {								\
+		.sign = 'u',							\
+		.realbits = 32,							\
+		.storagebits = 32,						\
+		.endianness = IIO_CPU,						\
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
+	OPT4060_COLOR_CHANNEL(RED, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)),
+	OPT4060_COLOR_CHANNEL(GREEN, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)),
+	OPT4060_COLOR_CHANNEL(BLUE, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)),
+	OPT4060_COLOR_CHANNEL(CLEAR, BIT(IIO_CHAN_INFO_RAW)),
+	OPT4060_LIGHT_CHANNEL(ILLUM),
+	IIO_CHAN_SOFT_TIMESTAMP(OPT4060_NUM_CHANS),
+};
+
+static const struct iio_chan_spec opt4060_channels_no_events[] = {
+	OPT4060_COLOR_CHANNEL_NO_EVENTS(RED, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)),
+	OPT4060_COLOR_CHANNEL_NO_EVENTS(GREEN, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)),
+	OPT4060_COLOR_CHANNEL_NO_EVENTS(BLUE, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)),
+	OPT4060_COLOR_CHANNEL_NO_EVENTS(CLEAR, BIT(IIO_CHAN_INFO_RAW)),
+	OPT4060_LIGHT_CHANNEL(ILLUM),
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
+		return opt4060_read_chan_raw(indio_dev, chan, val);
+	case IIO_CHAN_INFO_SCALE:
+		return opt4060_read_chan_scale(indio_dev, chan, val, val2);
+	case IIO_CHAN_INFO_PROCESSED:
+		return opt4060_read_illuminance(indio_dev, chan, val);
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
+static int opt4060_event_set_state(struct iio_dev *indio_dev, bool state)
+{
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (state)
+		ret = opt4060_set_continous_mode(chip, true);
+	else if (!iio_buffer_enabled(indio_dev) && chip->irq)
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
+	if (state) {
+		ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_ALL_CH);
+		if (ret)
+			return ret;
+		return opt4060_set_continous_mode(chip, true);
+	}
+	if (!opt4060_event_active(chip) && chip->irq) {
+		ret = opt4060_set_continous_mode(chip, false);
+		if (ret)
+			return ret;
+	}
+	return opt4060_set_int_state(chip, OPT4060_INT_CTRL_THRESHOLD);
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
+		break;
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
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+	u32 th_lo, th_hi;
+	int ret;
+
+	if (chan->type != IIO_INTENSITY)
+		return -EINVAL;
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = opt4060_get_thresholds(chip, &th_lo, &th_hi);
+		if (ret)
+			return ret;
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
+	u32 th_lo, th_hi;
+	int ret;
+
+	if (chan->type != IIO_INTENSITY)
+		return -EINVAL;
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = opt4060_get_thresholds(chip, &th_lo, &th_hi);
+		if (ret)
+			return ret;
+		if (dir == IIO_EV_DIR_FALLING)
+			th_lo = val;
+		else if (dir == IIO_EV_DIR_RISING)
+			th_hi = val;
+		return opt4060_set_thresholds(chip, th_lo, th_hi);
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
+	int ret;
+
+	if (chan->type != IIO_INTENSITY)
+		return -EINVAL;
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	ret = opt4060_get_channel_sel(chip, &ch_sel);
+	if (ret)
+		return ret;
+
+	if (((dir == IIO_EV_DIR_FALLING) && chip->thresh_event_lo_active) ||
+	    ((dir == IIO_EV_DIR_RISING) && chip->thresh_event_hi_active))
+		return ch_sel == ch_idx;
+
+	return ret;
+}
+
+static int opt4060_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir, int state)
+{
+	int ch_sel, ch_idx = chan->scan_index;
+	struct opt4060_chip *chip = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_INTENSITY)
+		return -EINVAL;
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	ret = opt4060_get_channel_sel(chip, &ch_sel);
+	if (ret)
+		return ret;
+
+	if (state) {
+		/* Only one channel can be active at the same time */
+		if ((chip->thresh_event_lo_active ||
+			chip->thresh_event_hi_active) && (ch_idx != ch_sel))
+			return -EBUSY;
+		if (dir == IIO_EV_DIR_FALLING)
+			chip->thresh_event_lo_active = true;
+		else if (dir == IIO_EV_DIR_RISING)
+			chip->thresh_event_hi_active = true;
+		ret = opt4060_set_channel_sel(chip, ch_idx);
+		if (ret)
+			return ret;
+	} else {
+		if (ch_idx == ch_sel) {
+			if (dir == IIO_EV_DIR_FALLING)
+				chip->thresh_event_lo_active = false;
+			else if (dir == IIO_EV_DIR_RISING)
+				chip->thresh_event_hi_active = false;
+		}
+	}
+
+	return opt4060_event_set_state(indio_dev, chip->thresh_event_hi_active |
+				       chip->thresh_event_lo_active);
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
+	return reg <= OPT4060_CLEAR_LSB || reg == OPT4060_RES_CTRL;
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
+	.set_trigger_state = opt4060_trigger_set_state,
+};
+
+static irqreturn_t opt4060_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *idev = pf->indio_dev;
+	struct opt4060_chip *chip = iio_priv(idev);
+	struct  {
+		u32 chan[OPT4060_NUM_CHANS];
+		aligned_s64 ts;
+	} raw;
+	int i = 0;
+	int chan, ret;
+
+	/* If the trigger is coming for a different driver, a new sample is needed.*/
+	if (iio_trigger_validate_own_device(idev->trig, idev))
+		opt4060_trigger_new_samples(idev);
+
+	memset(&raw, 0, sizeof(raw));
+
+	iio_for_each_active_channel(idev, chan) {
+		if (chan == OPT4060_ILLUM)
+			ret = opt4060_calc_illuminance(chip, &raw.chan[i++]);
+		else
+			ret = opt4060_read_raw_value(chip,
+						     idev->channels[chan].address,
+						     &raw.chan[i++]);
+		if (ret) {
+			dev_err(chip->dev, "Reading channel data failed\n");
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
+			code = IIO_MOD_EVENT_CODE(IIO_INTENSITY,
+						  chan,
+						  idev->channels[chan].channel2,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_FALLING);
+			iio_push_event(idev, code, iio_get_time_ns(idev));
+		}
+		/* Check if the interrupt is from the upper threshold */
+		if (int_res & OPT4060_RES_CTRL_FLAG_H) {
+			code = IIO_MOD_EVENT_CODE(IIO_INTENSITY,
+						  chan,
+						  idev->channels[chan].channel2,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_RISING);
+			iio_push_event(idev, code, iio_get_time_ns(idev));
+		}
+	}
+
+	/* Handle conversion ready */
+	if (int_res & OPT4060_RES_CTRL_CONV_READY) {
+		/* Signal completion for potentially waiting reads */
+		complete(&chip->completion);
+
+		/* Handle data ready triggers */
+		if (iio_buffer_enabled(idev))
+			iio_trigger_poll_nested(chip->trig);
+	}
+	return IRQ_HANDLED;
+}
+
+static int opt4060_setup_buffer(struct opt4060_chip *chip, struct iio_dev *idev)
+{
+	int ret;
+
+	ret = devm_iio_triggered_buffer_setup(chip->dev, idev,
+					      &iio_pollfunc_store_time,
+					      opt4060_trigger_handler, NULL);
+	if (ret)
+		return dev_err_probe(chip->dev, ret,
+				     "Buffer setup failed.\n");
+	return ret;
+}
+
+static int opt4060_setup_trigger(struct opt4060_chip *chip, struct iio_dev *idev)
+{
+	struct iio_trigger *data_trigger;
+	char *name;
+	int ret;
+
+	data_trigger = devm_iio_trigger_alloc(chip->dev, "%s-data-ready-dev%d",
+					      idev->name, iio_device_id(idev));
+	if (!data_trigger)
+		return -ENOMEM;
+
+	/* The data trigger allows for sample capture on each new conversion ready interrupt. */
+	chip->trig = data_trigger;
+	data_trigger->ops = &opt4060_trigger_ops;
+	iio_trigger_set_drvdata(data_trigger, idev);
+	ret = devm_iio_trigger_register(chip->dev, data_trigger);
+	if (ret)
+		return dev_err_probe(chip->dev, ret,
+				     "Data ready trigger registration failed\n");
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
+	init_completion(&chip->completion);
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
+	unsigned int regval, dev_id;
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
+	chip->dev = dev;
+	chip->irq = client->irq;
+
+	indio_dev->info = &opt4060_info;
+
+	ret = regmap_reinit_cache(chip->regmap, &opt4060_regmap_config);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to reinit regmap cache\n");
+
+	ret = regmap_read(chip->regmap, OPT4060_DEVICE_ID, &regval);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+			"Failed to read the device ID register\n");
+
+	dev_id = FIELD_GET(OPT4060_DEVICE_ID_MASK, regval);
+	if (dev_id != OPT4060_DEVICE_ID_VAL)
+		dev_info(dev, "Device ID: %#04x unknown\n", dev_id);
+
+	if (chip->irq) {
+		indio_dev->channels = opt4060_channels;
+		indio_dev->num_channels = ARRAY_SIZE(opt4060_channels);
+	} else {
+		indio_dev->channels = opt4060_channels_no_events;
+		indio_dev->num_channels = ARRAY_SIZE(opt4060_channels_no_events);
+	}
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = "opt4060";
+
+	ret = opt4060_load_defaults(chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to set sensor defaults\n");
+
+	ret = devm_add_action_or_reset(dev, opt4060_chip_off_action, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to setup power off action\n");
+
+	ret = opt4060_setup_buffer(chip, indio_dev);
+	if (ret)
+		return ret;
+
+	if (chip->irq) {
+		ret = opt4060_setup_trigger(chip, indio_dev);
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
+MODULE_AUTHOR("Per-Daniel Olsson <perdaniel.olsson@axis.com>");
+MODULE_DESCRIPTION("Texas Instruments OPT4060 RGBW color sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5


