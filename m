Return-Path: <linux-iio+bounces-22800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4BBB28D8A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232C0AA040A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB8C23A9B3;
	Sat, 16 Aug 2025 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="B+xE5h8X"
X-Original-To: linux-iio@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013060.outbound.protection.outlook.com [40.107.44.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1F22083;
	Sat, 16 Aug 2025 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755345925; cv=fail; b=Shjh35VJHLITy0epfSQtRmrtRnkt9Jg1MEbWF2AZH0KVHhPkipoPxnGdU1XH6+HFCDpYqtBsGXBJOz2MXdjqEEIFrC0uKKhtwqRKbEq5rD8R3/kBM4eFNgR2yK9Z0QDA5WnJVPIrHRXN+52ccWnB4CV6m5fitAFTf7a88yKEACo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755345925; c=relaxed/simple;
	bh=9gE2kNiKUL8UjIipRx0xBKcG+YLr/JcKitLYF08Vx7A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gcSeDG+NUSA3yKpMQYchN5yhN0Z7U718fmH6Zv3Ecc0oKUU4yDvxC57PtUS0q2rwR3yicrLowaBitzrq2xf5uDoGxKbqrsLt1UJABM6CI3Mfs4QHEAlrUK4odkJ4tjL3wD+4igvTflKokYAFtkkZDw8K0oEVs5YpABxXZaFLNpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=B+xE5h8X; arc=fail smtp.client-ip=40.107.44.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZUv8jqS/FD+cd1QbWNepLPBq9K6DFW/7eZDnCZuEzcCRYdLR596+tXfrRpX47PH/WRkZApaI9Becug+5QZjog5OV9VU74zk686yj0hpBh8A7+LjJ60mWRECdrR4HuLUQDme2NFryavVtos4CT96SoREJgirT7+Bf1fg+gOVQji9cut+5jL+TEgiaXcolUwsxgZdH7bPuCbQyzuNPRYoax4yURB8PCEq8gKD8vChc1q5PhxghW3St3475vqgPoD3tD89QiPyCNcEgb+TGzapr8Lw0y2V83db5pJbKLA6xu1onnMR0Y11wauVEr63Mz0ZYRUFm1qMg7of5tMfrnlNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyAU2ucGBCSxJOjpQbRRiMtIFA7qkdbczuLoJnM94ds=;
 b=g1f2PR0oTdeyQmviULXTOmK5IKq2oXt5/vk8IY5/s3gkJRgZuduM/98Bo+Gvem8TXaJk1zB1tWQ1w2HzpBPq9dEIooGGZcwThtTx42gr/dsmR67HzYuL4djDedAlpDQZAho/PonRtSL8L2pLrfHj94PMkJeAd6W1LhAZ9MA/NM3B2ns3My3PDAloArTN/2ThkYxm1tS12bo2rEI76DI2C6XH+GYdhR2Psck9kFgBUrrZXQWoE3+n0NhseOP/0DXuPYfVF9xZz3QvQ0Wtc9zo3ZRlStrfeJNVQP3LdNWtzvY5i7IUfuKD7Pq9imGQGjW0vkAfbgflpt60EeoPXsoFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyAU2ucGBCSxJOjpQbRRiMtIFA7qkdbczuLoJnM94ds=;
 b=B+xE5h8XZFerNlz1q+BvuQu+SbmJJD1IF2vnV6BxmEGRC7Eqm9+6XfKBvwH7YjiHwLHvU34/s5q0jILIa8doC6ihMkJELwtHgZ3m3IkesaWv1mdlmUKC7TBkWkJ6BBlichh+UHehYyNxqk2pT2JY4ljOeykfYrrdSpNy82+DyBHhMLkw9Y7nPvvzr+lkeo2d7LtYktrA/rwva/TKQ7v7B1bqy9+/NiMQJ8Bgwn5ZTS6hx2T3ri2YIAz5hjxR1H4AJspTzeDWmiTrYZ9MkxAqrIyuSpHZGKJG5m+7PkFjw9pm71NEljROxJojN/foiYC+IMM/GxDOhIhqYOqqZjwIRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEZPR06MB6599.apcprd06.prod.outlook.com (2603:1096:101:17e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Sat, 16 Aug
 2025 12:05:20 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.018; Sat, 16 Aug 2025
 12:05:20 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2] iio: imu: use min() to improve code
Date: Sat, 16 Aug 2025 20:05:09 +0800
Message-Id: <20250816120510.355835-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::6) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEZPR06MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 6335b491-1a90-49fb-885c-08dddcbd2bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6VPUQyUzsIaDNhSi56mpTgMagCL1mY3xqsb/ROo9dh6rr0nBYAnbpiOtiFfk?=
 =?us-ascii?Q?mnCI0Qyg31vhWXXcbBbHd79Qd7JV5k7SAhqGt94Dzq04VgOO8ZEPhhbN9Mjo?=
 =?us-ascii?Q?OkIrS4lmtWXffe9QI1N6PtHtVNZsezEqjVHHoMxkXZ9p1U43ELaqT1lu4hb6?=
 =?us-ascii?Q?gwRkQUTWv8DdNTBvSAmbog07KcHXNqEWJ0q4rCbxPQZFEyunStJ+yuVr3vE1?=
 =?us-ascii?Q?tCR38vxWG79gU96NYEALl1Gkj2zwSxpeDffhBGILpgmaDx539qJ0kUho5kV/?=
 =?us-ascii?Q?miIAjOwDVzUrQX5vaiiEkleYjuHW1x1PHx5JAxgUJo0tZT1s9j39dpCTL+mK?=
 =?us-ascii?Q?V59ML9HnLh9+gJoPF+mxI65mC+L52rLfPjJEX8DyYlvEXtIP/mlIkRM2hrjl?=
 =?us-ascii?Q?FT0Fy4gizsuBfkM95qqEQ7ePIu4D6HkeW9wwQqg6sMt62oTzzEzkqqRZ6wCN?=
 =?us-ascii?Q?xZmlHRCpE5jvUJUdIXUEs3KJuc5fn4ANup2PGia9Wy0i2PRnoyQDjqkOzhto?=
 =?us-ascii?Q?lbkRwUsQkzVKRh5EqvvxltLkKqf1FibvvbCkexfnP7b+RnOwjN2lLcgQqDdR?=
 =?us-ascii?Q?lM7r0K02FReIANAhd86Bbi7pntUg9BGYnwPvTR8d7ofOutwV1SmtN+5kTjlq?=
 =?us-ascii?Q?SjCkc39j9i/qMxTzZM4QgF6mKs1UBCM99gZvhu9AAV2aoyYV12kcy/HICWuD?=
 =?us-ascii?Q?w8QpTShN8EEj5zDuZtHUJlgkQxhOjD2Uw1X6GPN3BksJsjrz5O2mlSiKZYoR?=
 =?us-ascii?Q?xj8F5NMFuh8L23yLGHIqvCoDtss+NcGnoO1X62AEa7mf4Gi7w6gH401yITVC?=
 =?us-ascii?Q?13PlUe83kBlH3ikkhjy+pdcF1ez+VNRZqP7X3NefpBzIWC77xDe/MwIEd7UI?=
 =?us-ascii?Q?ym3iyI5QUh0oCiCm3D4uy/kp9d7vb+Fd/GYAc54oDo2iyCWwLCN1/9yBEOIB?=
 =?us-ascii?Q?4ut09f9yeuUy+zzQkMGnqfgK6SMlEipGTTFQntPSOhsIkDWAGyIudm9ng3Vu?=
 =?us-ascii?Q?I5l8B9MYRbSOp68hVnu7HluPNbDOCyhbF9x2VtjRnaaAoxnR9pjpgCXRAXJb?=
 =?us-ascii?Q?Zx800HJdlWTKplUXsRq3wxR6hpFV9m4XE37QEj0UJbq70PVn/JOA0FocW2sM?=
 =?us-ascii?Q?2DrsnjZJLEReZc+KUTUnLW92ZwdztUGHTAEuJVngfif3pdNgtrogV3b6xeqw?=
 =?us-ascii?Q?kta8ODPtrVx0AaXdxRQ72kzXfap3wP2pR0AvRZ6J3Uyev/b1/1GpxLE2tPH2?=
 =?us-ascii?Q?sQup8u0cGbxzjaeQoPttg/DHWkRG2Fezrv1T6vkT/8jnSGtBlPYS2b4nnJQS?=
 =?us-ascii?Q?g0KqYqDp7XhnQp1kHxavMVMv19HWdvlaLpaPLBdvpJ+Rt3ps4OtB0yEO93hf?=
 =?us-ascii?Q?MLNXXeeOnFCO7DOI6XfPWvgrQd2X/ccpL1pisyQBSQBG0teFI9170UfndtD+?=
 =?us-ascii?Q?C8/DY2JtNomt/UmQKli+OmL2xiUUyaXReWS4mg0p4CJMRxgt8pd9yg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8mI1enieTUSiCZ7ztFJ5mogqUbvJ789o5xCy0NWfyU/l+eGxOhOGKF/oCNjq?=
 =?us-ascii?Q?yGoD1TUkoT4HPSn6FXGgD/5oo6joNsRIMOsXUse578Rpj1/8z6/txbni9BLc?=
 =?us-ascii?Q?zwfO7GaRQbjvrPxnVoF2fAwup4OA4V+HIB7hoyWS7TFb4aEBC2HEntfZOLbI?=
 =?us-ascii?Q?OFmfn0eQtwfdS5vfzNZ+WijqZTTRMbt449ENs+O7Llpcw+FmFW4Q5vr4AFHQ?=
 =?us-ascii?Q?XSAlXZMImc2QikxwD7nilWeAJHtjmxMZGpbeLbrrTwNyT+wEWcCvlHMMLc7p?=
 =?us-ascii?Q?B729cyOBXolGtD5UOkqnnwM/XMF+yB1S51YwG3YNzmBodhLp2vidMzyTYhOL?=
 =?us-ascii?Q?owuVAZlSCfbs1WIz6bLm/C43OOF/4vzyy29r/qdGUz2T7UDzYX5UVwRqrbo+?=
 =?us-ascii?Q?ms86AKv2mrMn/yTiLppVb+jOqjKcR7OauGS0jpYFvvhMUN7QNBp0seRfbU1o?=
 =?us-ascii?Q?ri72yEu1bm2kB50pMjjmbpjh3HkV0scKExqDs6JAr6D63r49SRfd5UTlQ+0l?=
 =?us-ascii?Q?WxCxbO45EmfrwzouPAMKtHIsfUfdrTNO1yfKHrXbfsouvGX3+HcfhwWBPiWT?=
 =?us-ascii?Q?Q6cqNN6DJp1wQ1C7TPVK2ZdGidn5HapZz79I6/RGKjNrf52E/NZbsCU3DLKu?=
 =?us-ascii?Q?0C2DyxpPQLH8AQmiwSrrqRJBmEjFVkZkkLrbsCe+QdFcMFrvXEd+Z3/qwg2G?=
 =?us-ascii?Q?VhymdMah+AjYfJyR1hjJWs++sGUWe3EgiEtX/hYNz662HnSKDzr3onT/Ybi/?=
 =?us-ascii?Q?t1C8RcP4TVj1qSp3w4YX4j35CZL8sF6k9G8hVx2VjNg7piZ05638qd/o7nRN?=
 =?us-ascii?Q?F19KokY8mSnoUB1QlsI9j3wvdJ76eLZdAWLU9GQCG1FGB1QcpbEp61w/+eBQ?=
 =?us-ascii?Q?JTYbBY+HU36bThxrLpLEuILBWlXq58WUAfk0yAkLupZ+RalVa7tsGo16laAa?=
 =?us-ascii?Q?y3HYji4MpI+kgu0qNMPynIe5s8I5nAnZ7DcsTZW7mkmJUr+TpoUVH4J8IA8V?=
 =?us-ascii?Q?JC8J/tWLO7xHQeM/eUoZ8JEzrBpQcwiMNbO/XvX4PaEwvfaWn2gvf4UcGdAm?=
 =?us-ascii?Q?fIUOxIqpmBtYwoWB7MnO2oV5TYFaNZKkXAGdgAZ64aNaRjUC+rNUFsZerllj?=
 =?us-ascii?Q?H7lv8Gf5wn+AQsr/NX1Eaair7O8iGhlKWAX2giBPpznUu86E/IizGTIZUX2F?=
 =?us-ascii?Q?62EE/HmUlf1YJLyNGJ+yLMXL22Tk9X7Pkxb1YOjH9jJ0fzozXJQza/C33CWQ?=
 =?us-ascii?Q?iyE93+FGsXSBU5NfFfkU9Q1hpoJzjePR7S5KlGUMczpPkCY0gb8Un0F5CJXb?=
 =?us-ascii?Q?uFC+B2nBXRLuEce2pvleSVKJ0odibZDCbdk9+4OXXao2AW4HMBTK+lFLnB7v?=
 =?us-ascii?Q?z+ScQgLoik9toFg8VHtWo8Gq94CpoAEcFFje7pPZo4fNAvw8hK1Hq0cHCDyX?=
 =?us-ascii?Q?EnM3J5V+G+P2Yqa/cqw8XlCTbUi02XmvOzrf4evONsjQ+y0/0ISMZgVHk3cS?=
 =?us-ascii?Q?r+EKIwvf+RVusnJ5UzS+wvPJH4CfJNS/6+F6+RLT61XtI/ap0JR3YpWjnyCm?=
 =?us-ascii?Q?PMAsWAPoHtA7oBW7TBDvrSkUx98zJjF7UfdhwOrt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6335b491-1a90-49fb-885c-08dddcbd2bc5
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 12:05:19.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1VITZYmywjMr5KwHgiYusduM2wYVq9l4DqVyO+Ueqf5C2bOuULsfwoxhFy3pc3GrlXOfs99bO+MHuBvg+eU6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6599

Use min() to reduce code in inv_icm42600_buffer_update_fifo_period()
and inv_icm42600_buffer_update_watermark(), and improve readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v2: Remove the redundant variable and comment as suggested by David.
---
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 7c4ed981db04..ca744aaee542 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -100,7 +101,7 @@ ssize_t inv_icm42600_fifo_decode_packet(const void *packet, const void **accel,
 
 void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state *st)
 {
-	u32 period_gyro, period_accel, period;
+	u32 period_gyro, period_accel;
 
 	if (st->fifo.en & INV_ICM42600_SENSOR_GYRO)
 		period_gyro = inv_icm42600_odr_to_period(st->conf.gyro.odr);
@@ -112,12 +113,7 @@ void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state *st)
 	else
 		period_accel = U32_MAX;
 
-	if (period_gyro <= period_accel)
-		period = period_gyro;
-	else
-		period = period_accel;
-
-	st->fifo.period = period;
+	st->fifo.period = min(period_gyro, period_accel);
 }
 
 int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st,
@@ -204,7 +200,7 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 {
 	size_t packet_size, wm_size;
 	unsigned int wm_gyro, wm_accel, watermark;
-	u32 period_gyro, period_accel, period;
+	u32 period_gyro, period_accel;
 	u32 latency_gyro, latency_accel, latency;
 	bool restore;
 	__le16 raw_wm;
@@ -237,13 +233,8 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 			latency = latency_gyro - (latency_accel % latency_gyro);
 		else
 			latency = latency_accel - (latency_gyro % latency_accel);
-		/* use the shortest period */
-		if (period_gyro <= period_accel)
-			period = period_gyro;
-		else
-			period = period_accel;
 		/* all this works because periods are multiple of each others */
-		watermark = latency / period;
+		watermark = latency / min(period_gyro, period_accel);
 		if (watermark < 1)
 			watermark = 1;
 		/* update effective watermark */
-- 
2.34.1


