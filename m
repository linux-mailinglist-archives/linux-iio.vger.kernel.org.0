Return-Path: <linux-iio+bounces-19965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A61AC512A
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CAB16A29E
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA52719E7F9;
	Tue, 27 May 2025 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="TTLInaNQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A97279910;
	Tue, 27 May 2025 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357156; cv=fail; b=bloXGyvNMTkRV5wcBZhALmEbrufDLyBZzY9kAVr3vZANe8f7CfJUza5ib3aNw6J8nzMhkQsSLekYcPVp8AqiKzlVa3tMereuSB5agtqjulbmg3grjB3tM11najUF24XwWjT8yxgbI/vnED00dCjhIUOUBlogUfAa25JK0zJeL7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357156; c=relaxed/simple;
	bh=0aPvqjQunqlXBRCN3KPkqe2qEqy7wDldQOUgpNZG2Qk=;
	h=From:To:CC:Subject:In-Reply-To:Message-ID:Date:MIME-Version:
	 Content-Type; b=ccoM4nrE4FNfmxB4woRbbqezALoFmNOcKQ/HIh1TnjtPT1USZ0SiAhclqcxjZTK2yUdw5vDbsFSSR8imWDUof/aNvArUEnZyblY8rgG8tep0oz2LQ8oeuLb24wd82MxP15m+8U1/80gxSa4qy31OvsdswNBfsTrxrElm/q+V7jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=TTLInaNQ; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLqixQtkcxDvXYPlRIYX7Z5U/hblIZcJB3etYeA3Uc09l8Ahe56uN+UO4aJ9mhb4c8xJTXSZKVD79yO7MtepwgQs1nL6TC/CJIUznnonY3J0HKXCM9EpAVXrL4km9hZsTmUmHyg8e10snyANnLGHU9kiU96naBv4JNHNcj/KBMiFMqc3BvzuO3pjW+RiArNaE/bR0rAC0pDHVyrUFoSri6keQDuqc55EGMr6Oci2bvmNu5J/mmCimFT+18imufEAtGHaDFTD2143qx/QMCVbQAhwI9My+uZIu1YhwkNqWZTNWZwTvsfQG8G7YFEtq4e7Pt/9l8T3cff8D3RCuqTfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ65HvJCva9kd0Ydx+Gm71eAxRtjhJtvbgHdr9yAmbs=;
 b=YCzHeypVfiINd89H2pBbFZ0+RoJVbJ5gCFQz75pMdlKW/gT0ZJuZpP8/RhKYEX45uDAbMaOloWEH4HIrRbY/utyNEUsXuqAab3PZLdYH9ZewOJm588ScJOEoP6C8SmLdKxkr0LOhXYmUxQtYlDs0wbjvzX21jKha7ORD7Yaf6y+8jKqwxf66P76ArZ5XVJeeKyDHejkesW5cDircn7Yp55MrkpC6QPGXnWzgejw811ZQImaurMjQ0iXl9asxJ+0NOLXvLZp8kPdNkT/OoVcF04RpeG8wTbsCy5CdPs/e6QDpG6dVZvWrdkYGHp/lI9aAfIUui3KPB/cbuVtyr3/6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ65HvJCva9kd0Ydx+Gm71eAxRtjhJtvbgHdr9yAmbs=;
 b=TTLInaNQEzOERYFnGjLyBJpI7CQD/9AU7PiYPlu8W6dcCSm4AWmYmZLASYGBY902siLg6myjnpoOaomYw4ELSI6zTU2gOlemKxN5EqapeeEW3qYqLA94kLhao8k11ZovxgW4pAprL3Qj08T4fDuqv21rAsr4Izptu/5dDPAhLBo=
Received: from CWLP265CA0323.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:57::23)
 by DU2PR02MB7776.eurprd02.prod.outlook.com (2603:10a6:10:2e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 27 May
 2025 14:45:46 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:401:57:cafe::16) by CWLP265CA0323.outlook.office365.com
 (2603:10a6:401:57::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.25 via Frontend Transport; Tue,
 27 May 2025 14:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 14:45:45 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 16:45:41 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Haibo Chen <haibo.chen@nxp.com>, Michael Hennerich
	<Michael.Hennerich@analog.com>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>
Subject: [PATCH 1/4] iio: Remove single use of macro definition for driver
 name
In-Reply-To: <cover.1748356671.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <4840779a167e027b8be77c82f7a4f27210ef084a.1748356671.git.waqar.hameed@axis.com>
Date: Tue, 27 May 2025 16:45:41 +0200
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6A:EE_|DU2PR02MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 10317a23-a751-413d-a6f4-08dd9d2d29b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZfK0j/AyCNLliCnMxvC549aJ+bjAqf6+CaX70ySNKNqxCzXCN/k1cIEpbfqg?=
 =?us-ascii?Q?TsPNojvFmlcTTsLnnTXU/R8iDnjArxOSqGCeSZqABQLtxOKb8so4/zUVOeTa?=
 =?us-ascii?Q?qQN3gAe9a1ZTE+O9dBMsU7N91vmJnewdpwSFKs8komsjbvimxZtc9tbTL4w5?=
 =?us-ascii?Q?yBvNpX9Re4V3E4osaR2Bn9ATviLRNHSqtZIzt56rJtyJbystfghbAqwXcfvE?=
 =?us-ascii?Q?dehQ3OJJ/+GfwrIfiPHMuIoZWrQwHBLM3C1jpnbeJaMVJBg+WKsFZhwjDKvZ?=
 =?us-ascii?Q?yBdTdA8L4Qq3ESmjWPN0ThqDW4kioYNbS8v4e0pV6KQnzbhlF7dBhVeQlUDj?=
 =?us-ascii?Q?iTbVXPfbZMxtjesneURgx69Xly4vws9AxMEsakS311UV/HPAV915DXGhv54O?=
 =?us-ascii?Q?Ie+WyjSXH5Ht5Yc/cL7onzlLDS7gzrzhGv2+6Rml2Fj/7gTQgYj9JASKnKn1?=
 =?us-ascii?Q?U1LnUU2DbDVFgbzeAlnqVvpOvgWsFa/u+JgPwXagzlUd68oENvK5m6RZTuKK?=
 =?us-ascii?Q?V9GPUyg9YyPZKNWkxdC5+UG8OStqRPnPsq1i0cfvTwwNkKforvty+n/HbdlT?=
 =?us-ascii?Q?tHBnrlm8pdKFyL6n5mQoFFueqzrxomZdTgnMCGnjNTClngy+WC2Gm0gNTonH?=
 =?us-ascii?Q?GSZjEwnYHCcoVNgwSszMBoR+vTLnhkFZ4oBWWTmjIFcMM53s0TzFqvCl/Q2Y?=
 =?us-ascii?Q?m+P8ui6d4zyNkmGIJK8FezaF2d9l/2Voy5y7WSjvTRmKtBT+7vEEaL/pDeXU?=
 =?us-ascii?Q?Ei36ErgP/Zr8sjlzSXWvUr8KPzosjVH8INUhyoa4rOupkBX+qMoWKQRmxcb3?=
 =?us-ascii?Q?plK6R4Q+Ox2wXtS14HZJIr+Tsv8QU2osPPaH5NG0cr0WBRkPmp058+Ngiml9?=
 =?us-ascii?Q?a52NH2hoE8TOQAcuyLlhK0F4kXVoEZt1KDrhVcbQht9SR9pvOn2zSimGrX9M?=
 =?us-ascii?Q?AoPK++u/70VniUklGd1a0gugf/C6Zxcdof5fYjEF5KMbD8JDXT2WQGgAV9Ic?=
 =?us-ascii?Q?UdX7rekHcati5SP6zjTWrTlvKwMQ2fdC/zCSuDG5FucZ83fB2RGZOu/wHJsT?=
 =?us-ascii?Q?tVZUC0DqFa3NK/nun7WNjNgSmGH2nk4gXQOT4YDQB4cSr1NyvG9VZOtOx96B?=
 =?us-ascii?Q?Q9l7KTnf0R5JHsYFnzTLyYvKpp5GatfWmrOK625BzwWw7CgJjM3lcdghA0Dm?=
 =?us-ascii?Q?jyxrWAv2deU6t+DCKeCNSKR7S3KZ9+xOtSC3Q8+xIhUx51EEYeyfbA7x8rqx?=
 =?us-ascii?Q?KePA3WKh4Lz2hv95wtKBTUfTR28+YwyyeJz0LYFa9gd5bJ+uk3nfHo7PBXw+?=
 =?us-ascii?Q?JP/uVN+6IAYTCsDZaFENfEEQ59n5CbuYMqKjoDpA0cYgfc4YwtwXR2ZjuNUH?=
 =?us-ascii?Q?YiZyEHGu8tb14x7PkZqBZKgZKi2JDJG46ICzrmVwBqJ7hwumFQr/SIlyer6G?=
 =?us-ascii?Q?7l9Duz2A17Zj6n7Ep2xefmkZh8Yx8bR2E+WXvN/cdrQkC6KXtlEqhW8LdKWo?=
 =?us-ascii?Q?OoVZNeY0sC4ikeMXTqyosZuRJmCH8LmiBml+?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 14:45:45.5177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10317a23-a751-413d-a6f4-08dd9d2d29b9
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB7776

There is really no reason for having the driver name as a macro
definition if it is only used once (often as `.name` in `struct
device_driver`). It is also more readable this way. Remove these macro
definitions and instead use the string literal directly.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/iio/accel/kxcjk-1013.c  | 3 +--
 drivers/iio/accel/mma9551.c     | 3 +--
 drivers/iio/accel/mma9553.c     | 3 +--
 drivers/iio/accel/sca3300.c     | 4 +---
 drivers/iio/adc/hi8435.c        | 4 +---
 drivers/iio/adc/max9611.c       | 4 +---
 drivers/iio/adc/vf610_adc.c     | 5 +----
 drivers/iio/dac/max517.c        | 4 +---
 drivers/iio/dac/mcp4725.c       | 4 +---
 drivers/iio/humidity/dht11.c    | 4 +---
 drivers/iio/imu/kmx61.c         | 3 +--
 drivers/iio/light/ltr501.c      | 4 +---
 drivers/iio/resolver/ad2s1200.c | 3 +--
 13 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index f2496cad8ec2..4480dee96fc5 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -26,7 +26,6 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/accel/kxcjk_1013.h>
 
-#define KXCJK1013_DRV_NAME "kxcjk1013"
 #define KXCJK1013_IRQ_NAME "kxcjk1013_event"
 
 #define KXTF9_REG_HP_XOUT_L		0x00
@@ -1727,7 +1726,7 @@ MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
 
 static struct i2c_driver kxcjk1013_driver = {
 	.driver = {
-		.name	= KXCJK1013_DRV_NAME,
+		.name	= "kxcjk1013",
 		.acpi_match_table = kx_acpi_match,
 		.of_match_table = kxcjk1013_of_match,
 		.pm	= pm_ptr(&kxcjk1013_pm_ops),
diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 1b96687da01a..d00b238331e9 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -17,7 +17,6 @@
 #include <linux/pm_runtime.h>
 #include "mma9551_core.h"
 
-#define MMA9551_DRV_NAME		"mma9551"
 #define MMA9551_IRQ_NAME		"mma9551_event"
 #define MMA9551_GPIO_COUNT		4
 
@@ -592,7 +591,7 @@ MODULE_DEVICE_TABLE(i2c, mma9551_id);
 
 static struct i2c_driver mma9551_driver = {
 	.driver = {
-		   .name = MMA9551_DRV_NAME,
+		   .name = "mma9551",
 		   .acpi_match_table = mma9551_acpi_match,
 		   .pm = pm_ptr(&mma9551_pm_ops),
 	},
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 00e224efc8ed..02a3085a3fe1 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -15,7 +15,6 @@
 #include <linux/pm_runtime.h>
 #include "mma9551_core.h"
 
-#define MMA9553_DRV_NAME			"mma9553"
 #define MMA9553_IRQ_NAME			"mma9553_event"
 
 /* Pedometer configuration registers (R/W) */
@@ -1230,7 +1229,7 @@ MODULE_DEVICE_TABLE(i2c, mma9553_id);
 
 static struct i2c_driver mma9553_driver = {
 	.driver = {
-		   .name = MMA9553_DRV_NAME,
+		   .name = "mma9553",
 		   .acpi_match_table = mma9553_acpi_match,
 		   .pm = pm_ptr(&mma9553_pm_ops),
 	},
diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index ca0ce83e42b2..25cb88d64531 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -20,8 +20,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#define SCA3300_ALIAS "sca3300"
-
 #define SCA3300_CRC8_POLYNOMIAL 0x1d
 
 /* Device mode register */
@@ -687,7 +685,7 @@ MODULE_DEVICE_TABLE(spi, sca3300_ids);
 
 static struct spi_driver sca3300_driver = {
 	.driver   = {
-		.name		= SCA3300_ALIAS,
+		.name		= "sca3300",
 		.of_match_table = sca3300_dt_ids,
 	},
 	.probe	  = sca3300_probe,
diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 689e34f06987..1de3c921c7b7 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -19,8 +19,6 @@
 #include <linux/spi/spi.h>
 #include <linux/gpio/consumer.h>
 
-#define DRV_NAME "hi8435"
-
 /* Register offsets for HI-8435 */
 #define HI8435_CTRL_REG		0x02
 #define HI8435_PSEN_REG		0x04
@@ -536,7 +534,7 @@ MODULE_DEVICE_TABLE(spi, hi8435_id);
 
 static struct spi_driver hi8435_driver = {
 	.driver	= {
-		.name		= DRV_NAME,
+		.name		= "hi8435",
 		.of_match_table	= hi8435_dt_ids,
 	},
 	.probe		= hi8435_probe,
diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 14fe42fc4b7d..826566d7a85e 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -25,8 +25,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 
-#define DRIVER_NAME			"max9611"
-
 /* max9611 register addresses */
 #define MAX9611_REG_CSA_DATA		0x00
 #define MAX9611_REG_RS_DATA		0x02
@@ -553,7 +551,7 @@ static int max9611_probe(struct i2c_client *client)
 
 static struct i2c_driver max9611_driver = {
 	.driver = {
-		   .name = DRIVER_NAME,
+		   .name = "max9611",
 		   .of_match_table = max9611_of_table,
 	},
 	.probe = max9611_probe,
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 513365d42aa5..4a325f3c626f 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -27,9 +27,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-/* This will be the driver name the kernel reports */
-#define DRIVER_NAME "vf610-adc"
-
 /* Vybrid/IMX ADC registers */
 #define VF610_REG_ADC_HC0		0x00
 #define VF610_REG_ADC_HC1		0x04
@@ -962,7 +959,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend,
 static struct platform_driver vf610_adc_driver = {
 	.probe          = vf610_adc_probe,
 	.driver         = {
-		.name   = DRIVER_NAME,
+		.name   = "vf610-adc",
 		.of_match_table = vf610_adc_match,
 		.pm     = pm_sleep_ptr(&vf610_adc_pm_ops),
 	},
diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 84336736a47b..d334c67821ad 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -15,8 +15,6 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/dac/max517.h>
 
-#define MAX517_DRV_NAME	"max517"
-
 /* Commands */
 #define COMMAND_CHANNEL0	0x00
 #define COMMAND_CHANNEL1	0x01 /* for MAX518 and MAX519 */
@@ -200,7 +198,7 @@ MODULE_DEVICE_TABLE(i2c, max517_id);
 
 static struct i2c_driver max517_driver = {
 	.driver = {
-		.name	= MAX517_DRV_NAME,
+		.name	= "max517",
 		.pm	= pm_sleep_ptr(&max517_pm_ops),
 	},
 	.probe		= max517_probe,
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 1337fb02ccf5..8b9656a111e1 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -24,8 +24,6 @@
 
 #include <linux/iio/dac/mcp4725.h>
 
-#define MCP4725_DRV_NAME "mcp4725"
-
 #define MCP472X_REF_VDD			0x00
 #define MCP472X_REF_VREF_UNBUFFERED	0x02
 #define MCP472X_REF_VREF_BUFFERED	0x03
@@ -546,7 +544,7 @@ MODULE_DEVICE_TABLE(of, mcp4725_of_match);
 
 static struct i2c_driver mcp4725_driver = {
 	.driver = {
-		.name	= MCP4725_DRV_NAME,
+		.name	= "mcp4725",
 		.of_match_table = mcp4725_of_match,
 		.pm	= pm_sleep_ptr(&mcp4725_pm_ops),
 	},
diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 48c59d09eea7..73d2033954e7 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -27,8 +27,6 @@
 
 #include <linux/iio/iio.h>
 
-#define DRIVER_NAME	"dht11"
-
 #define DHT11_DATA_VALID_TIME	2000000000  /* 2s in ns */
 
 #define DHT11_EDGES_PREAMBLE 2
@@ -331,7 +329,7 @@ static int dht11_probe(struct platform_device *pdev)
 
 static struct platform_driver dht11_driver = {
 	.driver = {
-		.name	= DRIVER_NAME,
+		.name	= "dht11",
 		.of_match_table = dht11_dt_ids,
 	},
 	.probe  = dht11_probe,
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index e19c5d3137c6..05343655e58a 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -22,7 +22,6 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
-#define KMX61_DRV_NAME "kmx61"
 #define KMX61_IRQ_NAME "kmx61_event"
 
 #define KMX61_REG_WHO_AM_I	0x00
@@ -1494,7 +1493,7 @@ MODULE_DEVICE_TABLE(i2c, kmx61_id);
 
 static struct i2c_driver kmx61_driver = {
 	.driver = {
-		.name = KMX61_DRV_NAME,
+		.name = "kmx61",
 		.pm = pm_ptr(&kmx61_pm_ops),
 	},
 	.probe		= kmx61_probe,
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 669da0840eba..34ab4702277a 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -24,8 +24,6 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#define LTR501_DRV_NAME "ltr501"
-
 #define LTR501_ALS_CONTR 0x80 /* ALS operation mode, SW reset */
 #define LTR501_PS_CONTR 0x81 /* PS operation mode */
 #define LTR501_PS_MEAS_RATE 0x84 /* measurement rate*/
@@ -1624,7 +1622,7 @@ MODULE_DEVICE_TABLE(of, ltr501_of_match);
 
 static struct i2c_driver ltr501_driver = {
 	.driver = {
-		.name   = LTR501_DRV_NAME,
+		.name   = "ltr501",
 		.of_match_table = ltr501_of_match,
 		.pm	= pm_sleep_ptr(&ltr501_pm_ops),
 		.acpi_match_table = ltr_acpi_match,
diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
index 9d95241bdf8f..99c4333321d0 100644
--- a/drivers/iio/resolver/ad2s1200.c
+++ b/drivers/iio/resolver/ad2s1200.c
@@ -21,7 +21,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#define DRV_NAME "ad2s1200"
 
 /* input clock on serial interface */
 #define AD2S1200_HZ	8192000
@@ -192,7 +191,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1200_id);
 
 static struct spi_driver ad2s1200_driver = {
 	.driver = {
-		.name = DRV_NAME,
+		.name = "ad2s1200",
 		.of_match_table = ad2s1200_of_match,
 	},
 	.probe = ad2s1200_probe,
-- 
2.39.5


