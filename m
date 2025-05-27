Return-Path: <linux-iio+bounces-19968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E74AC5131
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 16:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6B916D0DA
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 14:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C385727A45A;
	Tue, 27 May 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="deY47OEP"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013019.outbound.protection.outlook.com [40.107.162.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DD17FAC2;
	Tue, 27 May 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357158; cv=fail; b=WS0bQf4iFf+Sd81lfrQwcfcgfA+XwVyN3FbbIjq+ryn1+662FoNk505CWRJa0n9RaOvry0QZswNalVhpSRqw4LKAOh8yhDMKmtyUvh6+7Hr28oW+SvKSs3O35xBhr4MBeOv6fjKveeSx+vYvltgI4cHi+/i7QAXCBLpL8KXNl9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357158; c=relaxed/simple;
	bh=B+fhRoHpKF+loeLAQrFOV7giWvQhZqNRXvuGqlgpRXA=;
	h=From:To:CC:Subject:In-Reply-To:Message-ID:Date:MIME-Version:
	 Content-Type; b=VthUn0EXRO07kUT+peQFw+OwjaOlM/BR+VQ0qCtTg4zgxuP2AjgnmalQFrFFOfYIg8mzK+XU+T5vG4zPj0C2BbtBAsXKSIJDvUnA5r95BIgZ/ipUqpZJccqFlM4q4FKqkp7X4N6nS7clZhj1zKrMpk1AdARo7tpu/Ai2SxM1k50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=deY47OEP; arc=fail smtp.client-ip=40.107.162.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaoQ19q1btGLwbEUOjMRr08yeoQ3bncm0jTzEwrfucc3Ubbxow1Zq7RpqSyVztUG8qd1do2+p9gm25OxzkyNoPt1EJlZ7QamaRN9nXnb5l1gXT6xjSw5U7kEKkNNR7aXmLtEErsEeslMRrT5NRVpAABpcGv1CuGadpK3U+4zcl28TDAaTWCyy5yVfayJXqi8GIy9jFc4mrDDl8WDP6DoQDs0wTgSS6w5TVQey3fxfVrSpKZ1YR5QbOWJBIqEuqeDfbYoBg5mH/CB/FUNKetJ01/NVM9xNnT0M2N7WaNZqC2IfdIxj2SEPUxe5i/INbcjJQPih5HNFNWLSjbdk68IDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inZ/AofN5A4KpABXJod+KsrL5M8Rd1YRSdxkehrgvco=;
 b=ENBCrSTKqtDFLqugckjrsewgKRHaC2hcZtat16Ispren6t2C88Aezzaistg5GMelhr1MU1OMVPDVAU4LMwa2K59/s5ke4wsF5OLXjryGWjnUUYTBx9YUjxNM6sw5BR8i6vHschcU8tl3WT5Lmk7oUsmPEXCaJxLeGw1EuSHVwG21GL7yvXx5hmfkc6vbwUs97pW1HoKEl2N0MrStw5xa+eLjivS9bJiSk+a1mb6SItZb1yuxigDD9GI6qRVZvs9iYD73ju5MLypzCg3lGpW/oJZ2eYF72teYSRjlgf0U/t5Dxts8SxVKReSsv3qU85ekIkHh+CrWjgliR3RkHxVPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inZ/AofN5A4KpABXJod+KsrL5M8Rd1YRSdxkehrgvco=;
 b=deY47OEPzjNdQg64VtkEO1kuyquN5jE8PezA97Dc9rzQM13FwFvKLpXnmPIToGEDkkctJF3t3sSuC14VJ0tdigUWPQeaGDUWt9tr+H1bTWZNBm6r/f9bsU5KTH4mTuL9qixjGTL7zCPo21b8fgDSAlD3e53BLIzd0Qq1wPTgI/Q=
Received: from CWLP265CA0319.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:57::19)
 by GV2PR02MB8508.eurprd02.prod.outlook.com (2603:10a6:150:7e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Tue, 27 May
 2025 14:45:50 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:401:57:cafe::ab) by CWLP265CA0319.outlook.office365.com
 (2603:10a6:401:57::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Tue,
 27 May 2025 14:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 14:45:50 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 16:45:42 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Mikael Gonella-Bolduc
	<m.gonella.bolduc@gmail.com>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] iio: Remove single use of macro definition for regmap
 name
In-Reply-To: <cover.1748356671.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <3a8572de8316c7d2746c2ccea8c478f594221319.1748356671.git.waqar.hameed@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6A:EE_|GV2PR02MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 335a8276-3d1e-4fb2-b3aa-08dd9d2d2c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YSTOwjBX+qmAasDVH6+3gGtnU5vnZ3obrJ0QFATG0xhKLW5cVpobHJEc0Umm?=
 =?us-ascii?Q?YEdH51UuF0kwZ7APaM6TyBDfMXDGdDTPksE8dceZtnjRoLzj0bLU7yxK54C+?=
 =?us-ascii?Q?oNZO4ZeN1hnzN4S9hmv4jo5YqT1Kvm/P6FoEZP+e6CL1VmUQqL9GlclkuMLJ?=
 =?us-ascii?Q?KKrjkxqykd9eTbVh+KWsvWBtedUBBNmf4RCqwViwRx01PRafBvXtyv6K15MI?=
 =?us-ascii?Q?bPnLmPtqod8UU2V6UzfpRAgPhiN1KvzGcvHokXrkqXL+wNtmOyxwYt6d3xit?=
 =?us-ascii?Q?xgGWE1NR/Jeq0FO/t7pmXax+Nj9cGA7AnlA0khMh1X7rgVQm/6AsBjpUDROh?=
 =?us-ascii?Q?Zf+FLnU9CrURKBdPxZvZ96jNtLbnDqCn7Lw63byZ2qZJH7w/bt87Yatq35Vc?=
 =?us-ascii?Q?6m1PUM/XYlJJ0IN4byya1yssPkWZmfcne90pEc0NfiLokqzSyqaxdSI4XPDF?=
 =?us-ascii?Q?Kqu9wCcPjr2pIrf4uubybCbycjIwlZXoXcFXKmoMW0/ZhGbCDemWeG1hEt5R?=
 =?us-ascii?Q?bE+RO5R8ajdGcpUGE0uBswI6Vehvxl5at5yUU0/hon4iujC7iiptj061JSkD?=
 =?us-ascii?Q?OIEd1sMmHpdIEYI7vDEe1WfBNubIyRz3jyUz+gE2xP9TWmdbQyGyXfYafuqV?=
 =?us-ascii?Q?zHsPqED9N8MBHT/bLO/VwMTKNY/oaYaBIjbX+fNsfCp6aPKAZPDJd91JadkA?=
 =?us-ascii?Q?mKbwtwclB+7BxjfC5uE9pSYXK79KO2+qzYHgKHEtbgaZmVHanYZj7VkMFU3B?=
 =?us-ascii?Q?YW20enswa5H+dcmILCD28txZyHL8WKnglLBLyn+V9XtA2g3eA0A5WIIo/1oV?=
 =?us-ascii?Q?5TWPgv0SsVR70by2CUxLUVNp12DZvsVyTlKpM3sx+iHku6qkp1lyADapgVRA?=
 =?us-ascii?Q?cnOmsIZNZ+3Yy83HX4TjdwO4D2OLBngjnZDDwery4aT4uFCsPFvY35bq2FD5?=
 =?us-ascii?Q?dG1mMxnHXdQEGHN5b246MosZuDrx1w5to8iwseHKj85RNvzhMqNkAaqvE8bP?=
 =?us-ascii?Q?yqoVjADEKzfqJL0eXTI2paXWCEXUPbXhHE32HfgfjfRcKreNeWa759LC8uqx?=
 =?us-ascii?Q?M6TM9tO8iDouY6k3uE3ODWwkEpBNMKW8E3TMVjOXFdZbh5uKpAgeOjsRmaxa?=
 =?us-ascii?Q?0vUWWUWlhYcHfmsOa1I2zvhuGRrLZHeqkcO3/V5jJiauagzC3pi00V/+1pb8?=
 =?us-ascii?Q?hOYgz0pmSEY0+Zi40V4X6UVDTKF+O6RvAgCBEERi63msL2eblHsv9X4mpZvr?=
 =?us-ascii?Q?z9mNaul+nRbcTywM64ViJGOnhWS1XAIlMg99xjLuvvQHAwvmYtk8Ebalk96Q?=
 =?us-ascii?Q?6aRIlZ+yPSVqM5fmkA/plxSPElUGw7NIX3SjZyXRPrPzpxd7G0NBXIYttjQg?=
 =?us-ascii?Q?24xgXKRkUg7llv4521ubUaxUotPp1RzLnbGNYvC95+OdmaU3yQyvys4019PW?=
 =?us-ascii?Q?7ikQD0E0z9sHkGpAkHAqSh+hF39Jiw2CHURq/xUwvc778PmiSxDjhaxLmRF/?=
 =?us-ascii?Q?not+BWZ7mT195vA3wEafmHiTQNHNsBFx4RDv?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 14:45:50.0334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 335a8276-3d1e-4fb2-b3aa-08dd9d2d2c6a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8508

There is really no reason for having the `regmap` name as a macro
definition if it is only used once directly in `struct regmap_config`.
It is also more readable this way. Remove these macro definitions and
instead use the string literal directly.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/iio/accel/mxc4005.c         | 3 +--
 drivers/iio/accel/mxc6255.c         | 3 +--
 drivers/iio/chemical/atlas-sensor.c | 3 +--
 drivers/iio/health/max30100.c       | 3 +--
 drivers/iio/health/max30102.c       | 3 +--
 drivers/iio/light/adux1020.c        | 3 +--
 drivers/iio/light/apds9160.c        | 4 +---
 drivers/iio/light/apds9960.c        | 3 +--
 drivers/iio/light/jsa1212.c         | 3 +--
 drivers/iio/light/ltr501.c          | 4 +---
 drivers/iio/light/rpr0521.c         | 3 +--
 drivers/iio/light/stk3310.c         | 3 +--
 drivers/iio/light/vcnl4035.c        | 3 +--
 drivers/iio/magnetometer/mmc35240.c | 3 +--
 14 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index aa9ec5950121..9b6da6f3d410 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -19,7 +19,6 @@
 #include <linux/iio/trigger_consumer.h>
 
 #define MXC4005_DRV_NAME		"mxc4005"
-#define MXC4005_REGMAP_NAME		"mxc4005_regmap"
 
 #define MXC4005_REG_XOUT_UPPER		0x03
 #define MXC4005_REG_XOUT_LOWER		0x04
@@ -137,7 +136,7 @@ static bool mxc4005_is_writeable_reg(struct device *dev, unsigned int reg)
 }
 
 static const struct regmap_config mxc4005_regmap_config = {
-	.name = MXC4005_REGMAP_NAME,
+	.name = "mxc4005_regmap",
 
 	.reg_bits = 8,
 	.val_bits = 8,
diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
index a8abda7b2a63..fc3ed84d1933 100644
--- a/drivers/iio/accel/mxc6255.c
+++ b/drivers/iio/accel/mxc6255.c
@@ -17,7 +17,6 @@
 #include <linux/iio/sysfs.h>
 
 #define MXC6255_DRV_NAME		"mxc6255"
-#define MXC6255_REGMAP_NAME		"mxc6255_regmap"
 
 #define MXC6255_REG_XOUT		0x00
 #define MXC6255_REG_YOUT		0x01
@@ -105,7 +104,7 @@ static bool mxc6255_is_readable_reg(struct device *dev, unsigned int reg)
 }
 
 static const struct regmap_config mxc6255_regmap_config = {
-	.name = MXC6255_REGMAP_NAME,
+	.name = "mxc6255_regmap",
 
 	.reg_bits = 8,
 	.val_bits = 8,
diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index baf93e5e3ca7..83cdbd57311d 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -24,7 +24,6 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/pm_runtime.h>
 
-#define ATLAS_REGMAP_NAME	"atlas_regmap"
 #define ATLAS_DRV_NAME		"atlas"
 
 #define ATLAS_REG_DEV_TYPE		0x00
@@ -96,7 +95,7 @@ struct atlas_data {
 };
 
 static const struct regmap_config atlas_regmap_config = {
-	.name = ATLAS_REGMAP_NAME,
+	.name = "atlas_regmap",
 	.reg_bits = 8,
 	.val_bits = 8,
 };
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index e08d143a707c..66e82ff475a0 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -22,7 +22,6 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/kfifo_buf.h>
 
-#define MAX30100_REGMAP_NAME	"max30100_regmap"
 #define MAX30100_DRV_NAME	"max30100"
 
 #define MAX30100_REG_INT_STATUS			0x00
@@ -94,7 +93,7 @@ static bool max30100_is_volatile_reg(struct device *dev, unsigned int reg)
 }
 
 static const struct regmap_config max30100_regmap_config = {
-	.name = MAX30100_REGMAP_NAME,
+	.name = "max30100_regmap",
 
 	.reg_bits = 8,
 	.val_bits = 8,
diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 1d074eb6a8c5..8016c9617b69 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -25,7 +25,6 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/kfifo_buf.h>
 
-#define MAX30102_REGMAP_NAME	"max30102_regmap"
 #define MAX30102_DRV_NAME	"max30102"
 #define MAX30102_PART_NUMBER	0x15
 
@@ -112,7 +111,7 @@ struct max30102_data {
 };
 
 static const struct regmap_config max30102_regmap_config = {
-	.name = MAX30102_REGMAP_NAME,
+	.name = "max30102_regmap",
 
 	.reg_bits = 8,
 	.val_bits = 8,
diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index 9240983a6cc4..a011159c8970 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -23,7 +23,6 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 
-#define ADUX1020_REGMAP_NAME		"adux1020_regmap"
 #define ADUX1020_DRV_NAME		"adux1020"
 
 /* System registers */
@@ -114,7 +113,7 @@ static const struct adux1020_mode_data adux1020_modes[] = {
 };
 
 static const struct regmap_config adux1020_regmap_config = {
-	.name = ADUX1020_REGMAP_NAME,
+	.name = "adux1020_regmap",
 	.reg_bits = 8,
 	.val_bits = 16,
 	.max_register = 0x6F,
diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
index d3f415930ec9..9b8af11b7b67 100644
--- a/drivers/iio/light/apds9160.c
+++ b/drivers/iio/light/apds9160.c
@@ -25,8 +25,6 @@
 
 #include <linux/unaligned.h>
 
-#define APDS9160_REGMAP_NAME "apds9160_regmap"
-
 /* Main control register */
 #define APDS9160_REG_CTRL 0x00
 #define APDS9160_CTRL_SWRESET BIT(4) /* 1: Activate reset */
@@ -161,7 +159,7 @@ static const struct regmap_access_table apds9160_volatile_table = {
 };
 
 static const struct regmap_config apds9160_regmap_config = {
-	.name = APDS9160_REGMAP_NAME,
+	.name = "apds9160_regmap",
 	.reg_bits = 8,
 	.val_bits = 8,
 	.use_single_read = true,
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index d30441d33703..7ae437f76266 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -25,7 +25,6 @@
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/sysfs.h>
 
-#define APDS9960_REGMAP_NAME	"apds9960_regmap"
 #define APDS9960_DRV_NAME	"apds9960"
 
 #define APDS9960_REG_RAM_START	0x00
@@ -221,7 +220,7 @@ static const struct regmap_access_table apds9960_writeable_table = {
 };
 
 static const struct regmap_config apds9960_regmap_config = {
-	.name = APDS9960_REGMAP_NAME,
+	.name = "apds9960_regmap",
 	.reg_bits = 8,
 	.val_bits = 8,
 	.use_single_read = true,
diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
index e7ba934c8e69..f7d2f2c626a1 100644
--- a/drivers/iio/light/jsa1212.c
+++ b/drivers/iio/light/jsa1212.c
@@ -106,7 +106,6 @@
 #define JSA1212_PXS_DELAY_MS	100
 
 #define JSA1212_DRIVER_NAME	"jsa1212"
-#define JSA1212_REGMAP_NAME	"jsa1212_regmap"
 
 enum jsa1212_op_mode {
 	JSA1212_OPMODE_ALS_EN,
@@ -300,7 +299,7 @@ static bool jsa1212_is_volatile_reg(struct device *dev, unsigned int reg)
 }
 
 static const struct regmap_config jsa1212_regmap_config = {
-	.name =  JSA1212_REGMAP_NAME,
+	.name = "jsa1212_regmap",
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = JSA1212_MAX_REG,
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 34ab4702277a..0cc3ca1b0d63 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -63,8 +63,6 @@
 #define LTR501_ALS_DEF_PERIOD 500000
 #define LTR501_PS_DEF_PERIOD 100000
 
-#define LTR501_REGMAP_NAME "ltr501_regmap"
-
 #define LTR501_LUX_CONV(vis_coeff, vis_data, ir_coeff, ir_data) \
 			((vis_coeff * vis_data) - (ir_coeff * ir_data))
 
@@ -1400,7 +1398,7 @@ static bool ltr501_is_volatile_reg(struct device *dev, unsigned int reg)
 }
 
 static const struct regmap_config ltr501_regmap_config = {
-	.name =  LTR501_REGMAP_NAME,
+	.name = "ltr501_regmap",
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = LTR501_MAX_REG,
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 1f5aa88a66cd..5ccb1434ebb8 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -68,7 +68,6 @@
 #define RPR0521_DEFAULT_MEAS_TIME	0x06 /* ALS - 100ms, PXS - 100ms */
 
 #define RPR0521_DRV_NAME		"RPR0521"
-#define RPR0521_REGMAP_NAME		"rpr0521_regmap"
 
 #define RPR0521_SLEEP_DELAY_MS	2000
 
@@ -904,7 +903,7 @@ static bool rpr0521_is_volatile_reg(struct device *dev, unsigned int reg)
 }
 
 static const struct regmap_config rpr0521_regmap_config = {
-	.name		= RPR0521_REGMAP_NAME,
+	.name		= "rpr0521_regmap",
 
 	.reg_bits	= 8,
 	.val_bits	= 8,
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 1d5947723045..72bc151982a6 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -46,7 +46,6 @@
 #define STK3310_PS_MAX_VAL			0xFFFF
 
 #define STK3310_DRIVER_NAME			"stk3310"
-#define STK3310_REGMAP_NAME			"stk3310_regmap"
 
 #define STK3310_SCALE_AVAILABLE			"6.4 1.6 0.4 0.1"
 
@@ -526,7 +525,7 @@ static bool stk3310_is_volatile_reg(struct device *dev, unsigned int reg)
 }
 
 static const struct regmap_config stk3310_regmap_config = {
-	.name = STK3310_REGMAP_NAME,
+	.name = "stk3310_regmap",
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = STK3310_MAX_REG,
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 6ba2b1a5a4b8..b15761ce707c 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -23,7 +23,6 @@
 #include <linux/iio/triggered_buffer.h>
 
 #define VCNL4035_DRV_NAME	"vcnl4035"
-#define VCNL4035_REGMAP_NAME	"vcnl4035_regmap"
 
 /* Device registers */
 #define VCNL4035_ALS_CONF	0x00
@@ -492,7 +491,7 @@ static bool vcnl4035_is_volatile_reg(struct device *dev, unsigned int reg)
 }
 
 static const struct regmap_config vcnl4035_regmap_config = {
-	.name		= VCNL4035_REGMAP_NAME,
+	.name		= "vcnl4035_regmap",
 	.reg_bits	= 8,
 	.val_bits	= 16,
 	.max_register	= VCNL4035_DEV_ID,
diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index dd480a4a5f98..64609fd93b99 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -21,7 +21,6 @@
 #include <linux/iio/sysfs.h>
 
 #define MMC35240_DRV_NAME "mmc35240"
-#define MMC35240_REGMAP_NAME "mmc35240_regmap"
 
 #define MMC35240_REG_XOUT_L	0x00
 #define MMC35240_REG_XOUT_H	0x01
@@ -463,7 +462,7 @@ static const struct reg_default mmc35240_reg_defaults[] = {
 };
 
 static const struct regmap_config mmc35240_regmap_config = {
-	.name = MMC35240_REGMAP_NAME,
+	.name = "mmc35240_regmap",
 
 	.reg_bits = 8,
 	.val_bits = 8,
-- 
2.39.5


