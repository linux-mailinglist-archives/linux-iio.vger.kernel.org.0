Return-Path: <linux-iio+bounces-22749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEA3B27A87
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 10:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324A41BC6D69
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2AA242D97;
	Fri, 15 Aug 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UuM2Q0Kt"
X-Original-To: linux-iio@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012064.outbound.protection.outlook.com [40.107.75.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A8221571;
	Fri, 15 Aug 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245225; cv=fail; b=CU1oNvbt552N90eBGzeMVcb9m6vv3/9oXAGHcpxZQJgvZ5aXgbBJR4sYcQWtcwEJUgLozY2AHTJze+BsLts03j5nEXTuPr01vp3RoydPi58+pjZH3QX3C+V/LwbUUSG3L35kJlRwD90E8O9VMLJ2/MhqycdtAQ18y5mNZf/FgUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245225; c=relaxed/simple;
	bh=Ilgy8vlME4R1NHlMkJpHMpwsI9i3mB1FnZMV0dleLHA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kgkFbuv7A7GnIOGxyFQfw3P1HogqLxvlRi6+FPseIg+e+4I9xbmTS0i+qaJ3F1JIa10oQNvgd+MCo5loqml6ewoANpcTBqLg4lPGgDqEkNwuQ08miaBiZsTUFXDK0Y9nQb6Q7fRd5xsWANX1hl40BDFprLDFATbwBN9fdNNm2W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UuM2Q0Kt; arc=fail smtp.client-ip=40.107.75.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rriwAdvSCeEj2Ukh6ajNR0F+1DEFPuiF5kpsEScv0w8bWgLINnwERKqCYqSWNsfxoUmKqfyxG5i97YdyJwh89x4T/AszstsSSfROA/96E4re4OPRg7lF2356ha9MM99S2jRzqtDueF0ByR2fTIGv8w/10J2q+yy3wafOrzwftkjSwrMkCnhJNys4/fcytY8sB4cmjA8fU/4w2+/t3qHQ1mlAm8RNkC1r6XBFqy+ou0ysuBuWe2plSSGnyQnPETs4do5ev9+mPXmFynKvIkKAqSMNw9cBYXbKFqZXOtHVhIZzJPzTxqjYnQtDu2eRBUfK7xZvpx8Qpj85sENgBwhgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E+YYyJ9Lp0qC9UUeyoWwJ59mAj7LoyeqoxhVYkS/AU=;
 b=C5DvXwHVeg1Z4112nfzaAvjUPBXkt8YY/x/6GBZ9W55KOL8A8WJ/eUXNpw4dc19E4nM4Bfx3MN4n25+jcurMn5LADhQSikWaOl66NoCBrlMLIBuBGBKS2RA0TTlMh641pk4d099+IZeMailHy1SBgE+KbUiMqixx1MU9QDAHtkUUDiyvb60WCPGEJu+p+Q4dA7Mjpft68XuW7MDX9o8OpsDkPlbKxmt4GDUcOC/GhCSqNCS3jsLvctYMIc72r7poV3iNnDYhbcMBpqwGsg8K1bpX5cLFvHvOD9H56DAb68itE0AfxroJrptaDgWyc8JsbTSZC2XJ4jVa0+qK6EAfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E+YYyJ9Lp0qC9UUeyoWwJ59mAj7LoyeqoxhVYkS/AU=;
 b=UuM2Q0Kt1YfCoBZ0PM3eODVdai9NJO2qR0RzbBWp5/2jOltFOFPBJufu08rKYemEvu0G9X6MAyNoEzduyyQw4Ni9WKBfldnr8fEf5ATyBHj0nXT/sRyj/r7IeFMh2AOOj3lG8dOe5JvLSjGBdRLU9UYpxTZNtDfGX3toxajaQEynigCIyrah5GXQU3GrAPpECvsVPedJ57Q9XSS8VBZikXEwRuWL4A4k9tPvEdCH8O42Qujbu2p327gvcX8nc1hzQRSpre2SHbglKQoMEvZZMSg7oHYB2P8m8RPnNdg6FnH8bC4gjU/cisNnBbJa+LugSc2YEtzoBF4ey7QvRiIMQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYSPR06MB6766.apcprd06.prod.outlook.com (2603:1096:400:473::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Fri, 15 Aug 2025 08:07:00 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 08:07:00 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] iio: imu: use min() to improve code
Date: Fri, 15 Aug 2025 16:06:49 +0800
Message-Id: <20250815080649.582775-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:3:18::24) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYSPR06MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4c532e-7e5c-431d-42e8-08dddbd2b57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rsDMM6pLlyRo2s72owuiuezWAVKDevoAh8col8KmsnPff2EmFO/1KhvDuGd/?=
 =?us-ascii?Q?yO4l7O296bzej4+q7zzOFXh2c3Q0hiS+4z3+Inh6kRhGPPQ5lxBTD5NcMN1t?=
 =?us-ascii?Q?8ws28nMv4Ju9D8F1Oz2I5EoZzKh4Mrci1fnKDErcSCJLsCTuGWxmPQa0kN3H?=
 =?us-ascii?Q?ghfoaVeOAbV7AB94fMfqbPQYsDJPpB6tcWmyek0jCtRr9cRKQAPwI5c/R1Y0?=
 =?us-ascii?Q?BKJ2xGFYmPKAzYK6yPmwVp8LIv+o65LMT98MxfeAfvJl3MhYfP59kFEq3ivf?=
 =?us-ascii?Q?J6cPjrgrQeitCHUCISw9ntZps4Tcz08e+tY3Con5PRf2A5XO6RjNUcfrUqSA?=
 =?us-ascii?Q?swHqmA48j8B31gOrIusWdk2ZtZm4VRwTNXihVdqRmMD/+Iy61XvLPQY+WzwG?=
 =?us-ascii?Q?Niu70h5mdP1CaHxN7YiuMV4ksnDzwPL7qptWjIqxr9j7FeTRyfNXAACgWR/A?=
 =?us-ascii?Q?VwedtPyezXiK9kK8MKrbdpjokSB3POhLzQjKujvtdFm0AVjmuq1gQ5RKmjlY?=
 =?us-ascii?Q?JJvdie4lr9NAXbJQatNQYSAj6BHm/t816NekFwfPKEXER5+eU1xp4jhs52Vn?=
 =?us-ascii?Q?S+YHpBSGzTp50nlOZTPxwlzbKh59qVFK2Sa/Dog19M7z1esAQh/d/CQtn7/g?=
 =?us-ascii?Q?FVgdWl7/3VkdhwTPRxrNeqKx9WZZ8HKQ9afabuMnaWhPoGW+YJMxBAA4kvT0?=
 =?us-ascii?Q?+xZEmvY5UbWQOtla50HOL8GvrFR6KXTsa5xk0TvDWpb2p1Owd+6nlASZ14zx?=
 =?us-ascii?Q?bpceUHxzq86N7Jwy9y4xaWq3SvSFeHIasFN8ZiPWDp9K1VcmVYb9U6vUGHuq?=
 =?us-ascii?Q?Mdn/ttxLHDORSoH4iEq0p/tXwZ7b2m847YK7lsbKhPWp7UVVLsqYcz670kO9?=
 =?us-ascii?Q?p2E5I0++xGqbF1C84YAPF/f5QRWorasRHAgktAPbHaj8ggK3/+DWaVOes91W?=
 =?us-ascii?Q?sW9Fz/kqaQQ2VBQdmuptDEcaq9wSMQdEuKZD+veVO/W7DG+qDCQyqFIkH4nv?=
 =?us-ascii?Q?IKGumY9GRoi/VlOAo8XoR4jhRVghSpLNrEQyzt2uW7mHW8YFJmajikr/HMC3?=
 =?us-ascii?Q?mSbo508NeS2WrYiD7mN8HM29B5lcvl1UzBIcnXYNtho7EmP3ZA8GffMc8xIO?=
 =?us-ascii?Q?ogy+JlquWUo0zpEyuJR+FTcc0nOySKuM4bX3/nLVya4O/2RtpiwAwmuRZ/It?=
 =?us-ascii?Q?FvLrM0//LduIVnYN01T3PtxerA06QPMHGwLqZKg2eA8EV3xSXqOjCqx6dxBM?=
 =?us-ascii?Q?U9JRLyViHUacnLgNIq2q3PL6Jokls9xZFv6rg8fv1IV4gnp7MqZMn4bV1Nfx?=
 =?us-ascii?Q?u3xEEMASIhP7a2eFZmkN+8Xj75G7EKviraauo7Tkt34eecuCOQbUkq7wR80D?=
 =?us-ascii?Q?V+5H9hsr1rMs8rH97dD8+Km+4JqLtLb2ZyntYOJ12qxUEc1tLV5WugnUvmxA?=
 =?us-ascii?Q?Oih8Rhou5DpGJCbclX9CBBZ85Qy9JyBGECRH2gCwbUvuxg50D55l3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LJXXy6jCbVBPXXuFnNm/88Oq7BxYonvKTc5+BzO0LJWayRxDQW3Wwv2Ngodr?=
 =?us-ascii?Q?0DOjq+OYgK0BO+jWw2wnTsK0quhjyZkc0dFbK5KRm6dHBF55qUVdxt7tCzQX?=
 =?us-ascii?Q?0ZK+o8bVqDFayB4ICvf94UWvC/ZsbpHFl0oneh48PDrWI2wVRdBCeZ4n73tL?=
 =?us-ascii?Q?oQZdLoqcNLKMnlcLLRwZMXRGqI/QvOEbSrwH527hKoIjfNnq+b5JvzhesR8g?=
 =?us-ascii?Q?x79QkD9l2fG1POgFxA9htz43MI92jiBfGRMqLbAer97d8oHY4G21YcszrdP/?=
 =?us-ascii?Q?01IjSMOdQD2UuO5eQwnPHNIo0f3T34FJdqmK2WMt1fyr8bJTYYtEXfPjhq/5?=
 =?us-ascii?Q?oo0hcZneEOCpLPmgcICqLhOykYLcWy429WoBUSs9sFMuIpXWk9KUd69TdlQ/?=
 =?us-ascii?Q?2nI7Bp+Vn0Jd/TCU7a1Ey6kTJAfo/ohAXz4fctO8SkbEW4/k2dW1Enbubw9w?=
 =?us-ascii?Q?EaSHwYRDH81kLMFpOXgw4ItQ3kgeEJpe6Ry9uXid3DWs99gMRc88Cr3mf8Sm?=
 =?us-ascii?Q?SodGh4DWEzLI/Pa6L7kEDrS0PhLeCVX8LodrF4qt5fYwG2BlxoUp1ybnnf+w?=
 =?us-ascii?Q?EZxdtDEPEJ/lEv2ZtTdq23OBHnzbNyf+m7jFi5AVMUoA83UWhEcqAffD28sz?=
 =?us-ascii?Q?AM/T3PSg4WvWHIEjGi2SYlTQKIXqrn6I1BvwJ1+RcAOEI8PtM6Teh+URRSEY?=
 =?us-ascii?Q?wS82SVDSv5sDm1cA9ypt0WnfvxOs0hByz3bWR+4WSAPWfCFYa0VXro0soYCr?=
 =?us-ascii?Q?4AF5MG2hD1gLOmSqSue87/M+wPaGV+p13ztSCOBa01x87zLSQwbqipy9F2DY?=
 =?us-ascii?Q?VxmBfxu1M3LGwq9TwmWMqL+gi1WfDQLHLKmpOtn0BTB/Q4xlQfvTMkfhsC5n?=
 =?us-ascii?Q?TtXprW8v4zZejwrpTGaMALWk0Gpx0bAC+5oPWMzxti72TxelMoOhZH3lzjW2?=
 =?us-ascii?Q?enPWtGfQa0JpQSefkHu7JNcT6rJP4FFTk5DftgPMLj9p2ooIo/7ijZZBKh2H?=
 =?us-ascii?Q?3tOgDzYVe8P/BNZh3FbziQjR7kzbLK0ADpC9pP2ozXLIjUdi+fJ7I8jejKVS?=
 =?us-ascii?Q?F/EWcgh3T54rNMGD9An93bSatao3qaTEqLfmJCtv4OjkqsHdsYpuv+HriHRp?=
 =?us-ascii?Q?SGNW8oyfR+PRHwL9JDFVQJ8XcyxNAueN+k9BVZov8zC2vPyerLjl9XHdmsgl?=
 =?us-ascii?Q?uVgOZB9nFLaMrrsq4sJzzbgtQaRf06me4pv8eerKrCW2QoPFPyqqFVu8PJQ9?=
 =?us-ascii?Q?5KD/4XF365ivCVWcoF07dls1SLHEJbjqSJtT08w9mmm6oj2CFkTikf1yjhs7?=
 =?us-ascii?Q?h1YpyMPOfpSQ6dfXZqTQHcp+P2divcJeoKBml2whogL/MPiUKVyteuEMOAvh?=
 =?us-ascii?Q?jb+3pxE8YCChAzgrJY7Gyump1QRno5JSmhSLJemIJbPW9E1ijpE1Qo0Tg+KX?=
 =?us-ascii?Q?VX2x2vfl2L2Z6VL/hUqrpilIxT6cU07i7+LOpj/fu5QXlEMmcIC6Y9ruDuNX?=
 =?us-ascii?Q?/+5RzDIW8VUsbQOo2PNi59nJSgkwkrj4lOUrBux/1g+T/N68nKn++KwEj1YW?=
 =?us-ascii?Q?EeWB0j0z2dcCv+imHwYGERkRvKgWFaXu6GB4ZS01?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4c532e-7e5c-431d-42e8-08dddbd2b57f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:07:00.1864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AlMAV7iH9DZT2zxU+y0J5FL6XybCxshq8Ce+5bn4Au33b8xAqYLiE13+HlivqPHgwPZqbCSkTmmbW6QK5YhwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6766

Use min() to reduce code in inv_icm42600_buffer_update_fifo_period()
and inv_icm42600_buffer_update_watermark(), and improve readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 7c4ed981db04..91d166de1231 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -9,6 +9,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
+#include <linux/minmax.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/common/inv_sensors_timestamp.h>
@@ -112,10 +113,7 @@ void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state *st)
 	else
 		period_accel = U32_MAX;
 
-	if (period_gyro <= period_accel)
-		period = period_gyro;
-	else
-		period = period_accel;
+	period = min(period_gyro, period_accel);
 
 	st->fifo.period = period;
 }
@@ -238,10 +236,7 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 		else
 			latency = latency_accel - (latency_gyro % latency_accel);
 		/* use the shortest period */
-		if (period_gyro <= period_accel)
-			period = period_gyro;
-		else
-			period = period_accel;
+		period = min(period_gyro, period_accel);
 		/* all this works because periods are multiple of each others */
 		watermark = latency / period;
 		if (watermark < 1)
-- 
2.34.1


