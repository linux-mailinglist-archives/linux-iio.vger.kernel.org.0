Return-Path: <linux-iio+bounces-19967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95916AC512D
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 16:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E94267AD8D9
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 14:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE98D27A131;
	Tue, 27 May 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="oCOn6rB9"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CAF279918;
	Tue, 27 May 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357157; cv=fail; b=l3e38v/bNCsd2ZbW/bY2UE1HI9qFoYz7i5Zcw57sbJGMNChrgtXjV8Y/ErlWdkRrXZG1U1F4Gu3FKEJFY3VMmw8xIVoZESSvd/NHAh0EpYiGRs0GVe3gIpCrA3NFw4QIgzXImlu0Ek+pb2sY+ppOs+u2J2+3epzoUtMPkdO8PqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357157; c=relaxed/simple;
	bh=qpgfgqJcbDbUebLOPLkX8AvcGqj4OZjDU5MZhioX6o4=;
	h=From:To:CC:Subject:In-Reply-To:Message-ID:Date:MIME-Version:
	 Content-Type; b=Pz+zsxKD2Quwh2gKEdjKp/yy8m2uwID+eRX9ZPSG/UGsdJLZtHohbEqWAAivNc+hJQYGbN74JbRbUaspLQCP/hkY+X3RXt57PQoGVwVsb3cqus7AkuFLIGbSXoitbpZ616gdv4lbcc+Ovo4RdHvO6koXWHKoa0Js4LN0s5co4Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=oCOn6rB9; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P79C4c7tF5wTWyjyELwoPXqDGu7QRP5dlTF1JCdALnpA3V38lgv3vuRat9xzZAIPhhKva0eQVNA6hMu0q9fZrfdV/Obj/2TYT46DbazTdSljTvIMVNiIGqgEiiMSCf4ec9f9C2N1Bxn3zXvJAo7cdTnqrF81kyx2YRXWNBityjMawDe2dHaBJr0wMoA5r0rwxkr5oezYhk79oIOW82J26fkTCO08y4LxjGySaFuD/jFHmRYLJHVzgHWYnWAERPp17a1xmo2QaA39qrlEO9330x2fLCXL5MrMVytweHBVj2wGAmAs5zW49MRbwEbce+oWP2gj9xI5IleSTG65VWKlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyb39vPVY8ijzhlWNvwdC407SCy8oFP6s63Q7soielg=;
 b=M87AZZW7apQwfro0pGleoTw+VttvdIhjjAtvMEBF44HF4maTBGDH1GN3RHkad55S9PEY+XstE3fgYMgf1ov8SR14fK4iJBKOC9b/w9/lHtqzF7IUFASbHyFZSCGbZc1kn/rTzg6vwf/5KBSZOAtLwE4K0rNHe+yGYesyXCxY2+Zo78UkJVuj0QsOJ/Gkb/DKBhtLBFJmwnhJdfVHY2JKZNatdsWaQ/7Q9pUMuaPRN96GHMbW9x4IQY2jBpefUE1V0eSjMZ6ChTEMka9bU50nII28BbUuEQHCg71LDbxYLdV5xD+dP1dSDyVwgvNTXRYPzReXj++7Lq1YPqZv+NW8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyb39vPVY8ijzhlWNvwdC407SCy8oFP6s63Q7soielg=;
 b=oCOn6rB9TEc1dtebYcy8NGXYiEo4SfZV5DD8VveSr71kAx4W80WVGkKyA58euegmvuzhMb6X8Vn+gQZX8yZjQtz7dbKDEr/211P5baLwoiHCUai9FTgQE7umOYo2+6rU2UQQFNhZD4ayWjeKxFIxmrSS8u1/ONgLer0EhLHXD2I=
Received: from CWLP265CA0314.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:57::14)
 by AM9PR02MB6658.eurprd02.prod.outlook.com (2603:10a6:20b:2cf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 27 May
 2025 14:45:49 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:401:57:cafe::59) by CWLP265CA0314.outlook.office365.com
 (2603:10a6:401:57::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 27 May 2025 14:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 14:45:48 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 16:45:42 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] iio: Remove single use of macro definition for IRQ name
In-Reply-To: <cover.1748356671.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <3dc06cb2a83d292c50d9758643aad37ca5c6d95c.1748356671.git.waqar.hameed@axis.com>
Date: Tue, 27 May 2025 16:45:42 +0200
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6A:EE_|AM9PR02MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ca74b6-b851-43c3-faaf-08dd9d2d2b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N3jwaB0jagbQVtAhFprOI61QHuYAK/Dc/LBwQP/IgYMZ4EHY9cXeX/IiUaw6?=
 =?us-ascii?Q?gPD4VM2+Ea+aHr1tDYWUi5WLk13syq/VACjTdnAesAG9zHx2QElWLBYBrJvs?=
 =?us-ascii?Q?ROdPa63y9nC7wcTxGh8hyJA/g5jlle1U0/jmbR6FyiLorC9jXBlUsbCmyTwi?=
 =?us-ascii?Q?WPiOHuCVjH4+V0nQltUrp+7AcOOzlGDO9PU5uuXWFBH8OaTfW4IAdW2ITw+3?=
 =?us-ascii?Q?gd9Y5Hn+hLfvPoUZeaVRk6u4TGpbiznpQk4C2kpXT5s7dPEFBPLOaCeSze8e?=
 =?us-ascii?Q?+CwMjQec+jTe7UuUiXafvqowA6+E0X3Yd1X1j1pfgv4oi2nBqyAzi2Jp421u?=
 =?us-ascii?Q?UmWOZUh8xrFZIDzxOpm1GMbgge/BaV+bx8eeT8Nw31YfWw3f4STo862jc2M6?=
 =?us-ascii?Q?zFGxVo/aCVh4rUlZXPmZieg5ye+z0UeGjDuYWxmrcQjbWEp2xEZIX8OCp6DJ?=
 =?us-ascii?Q?TWB3dkdLA9LKiCPCGHhSetGvogfk/pI1n0wkB1fUCtlY8pL7WhMrjAur+wuS?=
 =?us-ascii?Q?AYRdFSD53pcIyX+ttStTtSz02x2cwXRvkGQFETH1hHAU/9mbKiXN1dG/zGn/?=
 =?us-ascii?Q?LzFEqFn7ks5/kVxy/MgEPN/rP4nmDEYy7lTDtHzxODaXoB0rkbs4x7TFaaMD?=
 =?us-ascii?Q?HyTZNdlbxRezBSmNXc3SIe6S3gKwukSysWzdhysXpUWgO2UWcAMb4PKDP7u5?=
 =?us-ascii?Q?IATc4auT0s8Q2fkvrtBc/EohQ3iB64nFcvIc1I5tHXNMr7OotfHWxT15J9wg?=
 =?us-ascii?Q?8AJqO1tXUPKEB0I/9tMcHEgShwT6g+7WBNs5ztmO3801XYh8OLZipDYUoJj3?=
 =?us-ascii?Q?xuo0YaOuiA6qL73rVHVSNthI5+tOt8UtLS4xB3vjhUn+nEEvjUteNr++1Yz8?=
 =?us-ascii?Q?WbhF7Lh0V4IEX1G6IgVIKrRdocLThtzQeaaF43s/w4mBl1zkbjpK4se7Oo29?=
 =?us-ascii?Q?Tnglxyr3ffTVvgT/5X2v52y95T3ZvMjpqsRiBy0ScLu83aOfE6gbt19xCK+Y?=
 =?us-ascii?Q?+yDwEdGfygGJDtzbssV+xe44iod2SWu09qXLn8Ih5fHwGiOuFjkt5S/xTA0F?=
 =?us-ascii?Q?IZxKRnUB7IV5l67BHn2TEjZqaFuIQCrEXfj+GGqs68IFmtAimaAdX9vFn3Q7?=
 =?us-ascii?Q?Qft8817oBbCN0d7Vg1/UI4UOTocI00fgMy1DRLAi3nWWkg0lOBWPC5fuxjwL?=
 =?us-ascii?Q?3v6Ui9po8RHzCWeFzUQguWFcHIdoyaeE0/27QXKbiWcfoC9afXRMfIOd6M/S?=
 =?us-ascii?Q?FqJEAKP9uapG7ei9MN93NXMAfCZXKyrWmwQ3jPQaR/ad0J9cwznQvh8M4bqz?=
 =?us-ascii?Q?QShsICCuwpAkVC8dlpf4BhOQ5n9QP46KQ/DnN59S2NQ891YQGJFcS2lwFuUD?=
 =?us-ascii?Q?kspNvSsLjnsbfv4WDhIYsgnA1fNX9trVndbx1939gaWYftj9Fgxu0aBv6nFa?=
 =?us-ascii?Q?/H8y4mCCQMCKFVdgn7glaU/MfuLVvqPocSp7lQX1v88mBGZCBTW/ecbr0NkU?=
 =?us-ascii?Q?pxP9UYVGGNRxq5bJ+jIin5NL65vkhfGEv1uR?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 14:45:48.0490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ca74b6-b851-43c3-faaf-08dd9d2d2b3b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6658

There is really no reason for having the IRQ name as a macro definition
if it is only used once (often in functions requesting the IRQ). It
is also more readable this way. Remove these macro definitions and
instead use the string literal directly.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/iio/accel/bmc150-accel-core.c  | 3 +--
 drivers/iio/accel/kxcjk-1013.c         | 4 +---
 drivers/iio/accel/mma9551.c            | 3 +--
 drivers/iio/accel/mma9553.c            | 4 +---
 drivers/iio/accel/mxc4005.c            | 3 +--
 drivers/iio/accel/stk8312.c            | 3 +--
 drivers/iio/accel/stk8ba50.c           | 3 +--
 drivers/iio/gyro/bmg160_core.c         | 4 +---
 drivers/iio/imu/kmx61.c                | 4 +---
 drivers/iio/light/apds9300.c           | 3 +--
 drivers/iio/light/rpr0521.c            | 3 +--
 drivers/iio/light/stk3310.c            | 3 +--
 drivers/iio/light/vcnl4035.c           | 3 +--
 drivers/iio/magnetometer/bmc150_magn.c | 3 +--
 drivers/iio/proximity/sx9500.c         | 3 +--
 15 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 744a034bb8b5..546839d386a9 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -26,7 +26,6 @@
 #include "bmc150-accel.h"
 
 #define BMC150_ACCEL_DRV_NAME			"bmc150_accel"
-#define BMC150_ACCEL_IRQ_NAME			"bmc150_accel_event"
 
 #define BMC150_ACCEL_REG_CHIP_ID		0x00
 
@@ -1706,7 +1705,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 						bmc150_accel_irq_handler,
 						bmc150_accel_irq_thread_handler,
 						IRQF_TRIGGER_RISING,
-						BMC150_ACCEL_IRQ_NAME,
+						"bmc150_accel_event",
 						indio_dev);
 		if (ret)
 			goto err_buffer_cleanup;
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 4480dee96fc5..b4b9aaee2b68 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -26,8 +26,6 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/accel/kxcjk_1013.h>
 
-#define KXCJK1013_IRQ_NAME "kxcjk1013_event"
-
 #define KXTF9_REG_HP_XOUT_L		0x00
 #define KXTF9_REG_HP_XOUT_H		0x01
 #define KXTF9_REG_HP_YOUT_L		0x02
@@ -1516,7 +1514,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
 						kxcjk1013_data_rdy_trig_poll,
 						kxcjk1013_event_handler,
 						IRQF_TRIGGER_RISING,
-						KXCJK1013_IRQ_NAME,
+						"kxcjk1013_event",
 						indio_dev);
 		if (ret)
 			goto err_poweroff;
diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index d00b238331e9..2099b3ac41f9 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -17,7 +17,6 @@
 #include <linux/pm_runtime.h>
 #include "mma9551_core.h"
 
-#define MMA9551_IRQ_NAME		"mma9551_event"
 #define MMA9551_GPIO_COUNT		4
 
 /* Tilt application (inclination in IIO terms). */
@@ -421,7 +420,7 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
 		ret = devm_request_threaded_irq(dev, data->irqs[i],
 				NULL, mma9551_event_handler,
 				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-				MMA9551_IRQ_NAME, indio_dev);
+				"mma9551_event", indio_dev);
 		if (ret < 0) {
 			dev_err(dev, "request irq %d failed\n", data->irqs[i]);
 			return ret;
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 02a3085a3fe1..2389dd427af1 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -15,8 +15,6 @@
 #include <linux/pm_runtime.h>
 #include "mma9551_core.h"
 
-#define MMA9553_IRQ_NAME			"mma9553_event"
-
 /* Pedometer configuration registers (R/W) */
 #define MMA9553_REG_CONF_SLEEPMIN		0x00
 #define MMA9553_REG_CONF_SLEEPMAX		0x02
@@ -1101,7 +1099,7 @@ static int mma9553_probe(struct i2c_client *client)
 						mma9553_irq_handler,
 						mma9553_event_handler,
 						IRQF_TRIGGER_RISING,
-						MMA9553_IRQ_NAME, indio_dev);
+						"mma9553_event", indio_dev);
 		if (ret < 0) {
 			dev_err(&client->dev, "request irq %d failed\n",
 				client->irq);
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index cb5c4e354fc0..aa9ec5950121 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -19,7 +19,6 @@
 #include <linux/iio/trigger_consumer.h>
 
 #define MXC4005_DRV_NAME		"mxc4005"
-#define MXC4005_IRQ_NAME		"mxc4005_event"
 #define MXC4005_REGMAP_NAME		"mxc4005_regmap"
 
 #define MXC4005_REG_XOUT_UPPER		0x03
@@ -493,7 +492,7 @@ static int mxc4005_probe(struct i2c_client *client)
 						NULL,
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
-						MXC4005_IRQ_NAME,
+						"mxc4005_event",
 						data->dready_trig);
 		if (ret) {
 			dev_err(&client->dev,
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 471c154c3631..1df423b919f0 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -46,7 +46,6 @@
 #define STK8312_ALL_CHANNEL_SIZE	3
 
 #define STK8312_DRIVER_NAME		"stk8312"
-#define STK8312_IRQ_NAME		"stk8312_event"
 
 /*
  * The accelerometer has two measurement ranges:
@@ -543,7 +542,7 @@ static int stk8312_probe(struct i2c_client *client)
 						NULL,
 						IRQF_TRIGGER_RISING |
 						IRQF_ONESHOT,
-						STK8312_IRQ_NAME,
+						"stk8312_event",
 						indio_dev);
 		if (ret < 0) {
 			dev_err(&client->dev, "request irq %d failed\n",
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index cab592a68622..04db1584510e 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -42,7 +42,6 @@
 #define STK8BA50_ALL_CHANNEL_SIZE		6
 
 #define STK8BA50_DRIVER_NAME			"stk8ba50"
-#define STK8BA50_IRQ_NAME			"stk8ba50_event"
 
 #define STK8BA50_SCALE_AVAIL			"0.0384 0.0767 0.1534 0.3069"
 
@@ -436,7 +435,7 @@ static int stk8ba50_probe(struct i2c_client *client)
 						NULL,
 						IRQF_TRIGGER_RISING |
 						IRQF_ONESHOT,
-						STK8BA50_IRQ_NAME,
+						"stk8ba50_event",
 						indio_dev);
 		if (ret < 0) {
 			dev_err(&client->dev, "request irq %d failed\n",
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index deb3c6459dde..781d3e96645f 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -21,8 +21,6 @@
 #include <linux/regulator/consumer.h>
 #include "bmg160.h"
 
-#define BMG160_IRQ_NAME		"bmg160_event"
-
 #define BMG160_REG_CHIP_ID		0x00
 #define BMG160_CHIP_ID_VAL		0x0F
 
@@ -1099,7 +1097,7 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 						bmg160_data_rdy_trig_poll,
 						bmg160_event_handler,
 						IRQF_TRIGGER_RISING,
-						BMG160_IRQ_NAME,
+						"bmg160_event",
 						indio_dev);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 05343655e58a..3bb6bad3e89f 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -22,8 +22,6 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
-#define KMX61_IRQ_NAME "kmx61_event"
-
 #define KMX61_REG_WHO_AM_I	0x00
 #define KMX61_REG_INS1		0x01
 #define KMX61_REG_INS2		0x02
@@ -1311,7 +1309,7 @@ static int kmx61_probe(struct i2c_client *client)
 						kmx61_data_rdy_trig_poll,
 						kmx61_event_handler,
 						IRQF_TRIGGER_RISING,
-						KMX61_IRQ_NAME,
+						"kmx61_event",
 						data);
 		if (ret)
 			goto err_chip_uninit;
diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index 938d76f7e312..05ba21675063 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -17,7 +17,6 @@
 #include <linux/iio/events.h>
 
 #define APDS9300_DRV_NAME "apds9300"
-#define APDS9300_IRQ_NAME "apds9300_event"
 
 /* Command register bits */
 #define APDS9300_CMD	BIT(7) /* Select command register. Must write as 1 */
@@ -432,7 +431,7 @@ static int apds9300_probe(struct i2c_client *client)
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 				NULL, apds9300_interrupt_handler,
 				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				APDS9300_IRQ_NAME, indio_dev);
+				"apds9300_event", indio_dev);
 		if (ret) {
 			dev_err(&client->dev, "irq request error %d\n", -ret);
 			goto err;
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 2ba917c5c138..1f5aa88a66cd 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -68,7 +68,6 @@
 #define RPR0521_DEFAULT_MEAS_TIME	0x06 /* ALS - 100ms, PXS - 100ms */
 
 #define RPR0521_DRV_NAME		"RPR0521"
-#define RPR0521_IRQ_NAME		"rpr0521_event"
 #define RPR0521_REGMAP_NAME		"rpr0521_regmap"
 
 #define RPR0521_SLEEP_DELAY_MS	2000
@@ -982,7 +981,7 @@ static int rpr0521_probe(struct i2c_client *client)
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 			rpr0521_drdy_irq_handler, rpr0521_drdy_irq_thread,
 			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-			RPR0521_IRQ_NAME, indio_dev);
+			"rpr0521_event", indio_dev);
 		if (ret < 0) {
 			dev_err(&client->dev, "request irq %d for trigger0 failed\n",
 				client->irq);
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index b81cc44db43c..1d5947723045 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -47,7 +47,6 @@
 
 #define STK3310_DRIVER_NAME			"stk3310"
 #define STK3310_REGMAP_NAME			"stk3310_regmap"
-#define STK3310_EVENT				"stk3310_event"
 
 #define STK3310_SCALE_AVAILABLE			"6.4 1.6 0.4 0.1"
 
@@ -643,7 +642,7 @@ static int stk3310_probe(struct i2c_client *client)
 						stk3310_irq_event_handler,
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
-						STK3310_EVENT, indio_dev);
+						"stk3310_event", indio_dev);
 		if (ret < 0) {
 			dev_err(&client->dev, "request irq %d failed\n",
 				client->irq);
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 67c94be02018..6ba2b1a5a4b8 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -23,7 +23,6 @@
 #include <linux/iio/triggered_buffer.h>
 
 #define VCNL4035_DRV_NAME	"vcnl4035"
-#define VCNL4035_IRQ_NAME	"vcnl4035_event"
 #define VCNL4035_REGMAP_NAME	"vcnl4035_regmap"
 
 /* Device registers */
@@ -535,7 +534,7 @@ static int vcnl4035_probe_trigger(struct iio_dev *indio_dev)
 	ret = devm_request_threaded_irq(&data->client->dev, data->client->irq,
 			NULL, vcnl4035_drdy_irq_thread,
 			IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-			VCNL4035_IRQ_NAME, indio_dev);
+			"vcnl4035_event", indio_dev);
 	if (ret < 0)
 		dev_err(&data->client->dev, "request irq %d for trigger0 failed\n",
 				data->client->irq);
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 88bb673e40d8..b757ed55e99e 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -29,7 +29,6 @@
 #include "bmc150_magn.h"
 
 #define BMC150_MAGN_DRV_NAME			"bmc150_magn"
-#define BMC150_MAGN_IRQ_NAME			"bmc150_magn_event"
 
 #define BMC150_MAGN_REG_CHIP_ID			0x40
 #define BMC150_MAGN_CHIP_ID_VAL			0x32
@@ -918,7 +917,7 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 					   iio_trigger_generic_data_rdy_poll,
 					   NULL,
 					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					   BMC150_MAGN_IRQ_NAME,
+					   "bmc150_magn_event",
 					   data->dready_trig);
 		if (ret < 0) {
 			dev_err(dev, "request irq %d failed\n", irq);
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index c4e94d0fb163..40e0edeedeb4 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -27,7 +27,6 @@
 #include <linux/iio/trigger_consumer.h>
 
 #define SX9500_DRIVER_NAME		"sx9500"
-#define SX9500_IRQ_NAME			"sx9500_event"
 
 /* Register definitions. */
 #define SX9500_REG_IRQ_SRC		0x00
@@ -939,7 +938,7 @@ static int sx9500_probe(struct i2c_client *client)
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 				sx9500_irq_handler, sx9500_irq_thread_handler,
 				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				SX9500_IRQ_NAME, indio_dev);
+				"sx9500_event", indio_dev);
 		if (ret < 0)
 			return ret;
 
-- 
2.39.5


