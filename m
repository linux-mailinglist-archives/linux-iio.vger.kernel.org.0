Return-Path: <linux-iio+bounces-3465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA1B8786BF
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 18:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDE5B22826
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 17:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A409524C3;
	Mon, 11 Mar 2024 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="XisjH5Fw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15721482E9
	for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179599; cv=fail; b=OOspg03mhv1+p9Jr5YXx8EQVzXbuTX+RZ/6DxS7nBUW4G9LDEuMdrQZId4yAzAt9DH0o6lu0mTwdLAGqTIDrGZHD1ymkHumtDxw8BRDsl0UHAa2XVvz4lZ0uRlENj5vufkzA/5oCUtIhaee/wU50VIW+7vNJSkhAkb7wiFx4U0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179599; c=relaxed/simple;
	bh=sTSvgx0lEUwGnmLdqht12FFZlXs7HhXWcIjAr5BoWZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=khG4/a4RlYXp2PaMCm4e/MBWl2lIMIY0cMKdJJ8Uva9qAX6uAjxUJrEHGYn4YshBG3gVuRqBDY7A+ctSpQPvDSDIaKHmooh3KgB0ky36hUZXYYTAfzmDgjGsVwLIeEjEDxC/DfR6a5Wu7UvLe1XEm5aZYl+Xej9twZkHq5PnuvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=XisjH5Fw; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B9r7MB020821;
	Mon, 11 Mar 2024 16:06:19 GMT
Received: from os0p286cu010.outbound.protection.outlook.com (mail-japanwestazlp17010003.outbound.protection.outlook.com [40.93.130.3])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wre4xsbjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 16:06:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNyg28CMJLFlgwNXCfYZy1QEzUWn5+A/RnUbBDdmp0QbDHGcuFCS6qhCfr2TGc+Bo4ptKbzvkX7ulvTMRQ/BYxX47fb4AEFxKFTLw68MOpS0B9mBA66pPZcRfTVL/NIHqj4PBl3QPN61ZNdgM4Ev35PgVYBai8WHtYLgo4Wijy9vFlQ34ZI6/3EuiQImg5nVfvSoQgMTD06XoETaRwJI1/zmeAiFAXTroxh7sTob9vDdkWhpsoZAJisMx7yT+DqfnFWMee8YQewlHmDLvSSnkKg4tZdLguxR8hQqlGQ4weTNV6A4bCksaWcrs1fCCd2J5DfY4bV99uMW02bt6Rwa6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qC479+W/FizE/kP9UEdDEwdYfqkvs6R4i72UBgk++jw=;
 b=Pxg4B3GMuR9TJNtpM+btAMDEwWxsquBU0n4Uej8bkooGBTDf/2VWmIdFg7o4M5tfrmYpRH5uF6FZpdnESahFjiMHuoJTzG6A/P5nvnFXqMweI9AVkXzkEf+sPep6i0IlskIT488ec9OnNZB44Lj1Kt9OULyV8YkLkBnrsdBuzAZtupgj3qsL+sJGBY1fnVFCiddqSyOoRVKireyLOjun1qhoMOwV8S0EkDVTh5l0Qi/brsoTgIBwn5I3rtCrTCEMq1TRdG9CiLU7UNtlDEaLxdnIad+5l13hdDAjfAaVHTSuyK/ecGAyY6cf9HvzPS6qJW55/IViQsU8lSxlQBW+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC479+W/FizE/kP9UEdDEwdYfqkvs6R4i72UBgk++jw=;
 b=XisjH5FwMRfMu7GWJwobeLejjTt5q85tAB7BFUVxyidjoBHVDcyKNBvPUib9lj7DCYXW324trHaQDN2AY95FGJENW4PgepSK0dfHi1ME7HKRXs3ap9TEDoTwYnRQdqxY2W/1Dcnq+awIwyb8oUGvOeGC1417GISAqSCEm5Gdw28lCsvR2nctVelIsdNPkX5wHjbekzij6Z5HTJV8YWZA5E+W+rU4s+aklyMXyzMWx/xQC+HPuuWGGNx94FI/hNU+Ju0m/LSDRz4WOv2BsZEkITcJAd1F+xKT+J3SVD4+SCtK5ig4gH+uvbRDrR2fOSgubl2Ngwca6DuZ33UGd1Xy5A==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB1961.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:06:16 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%5]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 16:06:16 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt handler for WoM events
Date: Mon, 11 Mar 2024 16:05:56 +0000
Message-Id: <20240311160557.437337-4-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311160557.437337-1-inv.git-commit@tdk.com>
References: <20240311160557.437337-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0074.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::7) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB1961:EE_
X-MS-Office365-Filtering-Correlation-Id: 281eab46-823f-4015-7361-08dc41e52e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	i/cO1yMZpUXtEtFySfQkCbmBqGdwokrRzT3exrEzGw+nAH6G02rKpOZM6f2Jw/tzO3u7m6040AtKuCkE6xDrxU9DSVDUXaUs6X07yd7I0pcDZQZeEKT7GnIAi1Nee+75Y0AZm7dk5FJO0PNo3IJ3aSNEwxGmonp8s0y5sm54lXk85oU1Yw1L98xFXDIw4lYgvNiFZcdy6bEQ2wC0kKUlriVSrmZVkOhpZqaApMOS8eO1v5qo+uPmSo2xkGXz/LWGiv5Z673Awq4WQd4fTfHrKqPogWX/tgF9GH3MrO74suXSP2UC8aoKxtCggAjtrKQPjWSLGioBkq49s0ZcReBl/SUY05yxZcEI9doLdJg/bcuc3xAT7A6H4m91T29Qu4+MHexYdTri2yU3UT0jhZhTP+JTj/wUU0i7gD6c379gEWuc+ajp6LHXuY6bQGAVCrNAuhOx95OM/ssC0fIZ1FcDnKG6lEgoBF/2TL0AxtHfxPxby1R8+gs/p1vKvu1UlSm1jvugvl2oRBIrADrT65cVsuCNWkO+fUpBTFG4hECa+BRs7RRM7JjHifBXF6+jwNZAer/7V4Az8VDjsWlqKZPv0dWHU9cc6W/v4po9EVlxzC4xmzIZnDQ2Yfgkf/qfpkurn86UMUG4B458fCCW6UvIRbaC4TH1sTZgHDQRW3UzKblba7YXtNpUakmU6cLUgX7grn/Rdu6+0cTvTgCXsMrbTNFoJASsXPIDo4PFnCl4OM4Fo02CpI+Fh9u17qNshewD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(3613699003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PCZXgXzNPmGj4dq5O36mmpO+D7e3zbJ6zOB36H9YDp+WQb7eaW2lu3WmDHL+?=
 =?us-ascii?Q?kBJJxG/+AXl7xjOvpdhEJEcKZp6NrgK9ZrozQIK3yeU/C64wOxTHzhO1znX/?=
 =?us-ascii?Q?/22gGivav6kVUY0/dnZAH5XUvKYlpxgwsBfWFy5jaEdQ+OVoYcgVBhlUVlb5?=
 =?us-ascii?Q?A9wW7MPlxmjU/Hrp1AKGyaGiqkW/4MmX536N/IkDscZOHvy/rZ8c1R83bfxF?=
 =?us-ascii?Q?iMweUCb+lNVs5Hw/gMPqmKOgI4aUW4Rb6UiBa4kDtsSB50Nsh3G/OsFFqCma?=
 =?us-ascii?Q?xs0zCbh3YCwOguDenKKejCr59BaGzXB91MG277rBHEe5obHCdqBLUTH1+52i?=
 =?us-ascii?Q?3oFwn9AFjF92/dJXQZ+fgv3HE1Xym2bgbd0A8ioaEwe+svKHwPfxUeWE4LaD?=
 =?us-ascii?Q?kCBm0Aqzm/1tp3Ch9FLlGgu9o2vjH8OpezA+7A8WKE3SPdm1U0kPSbayKsK+?=
 =?us-ascii?Q?rHrAEQ6fTaaL5CIMHf/fluEiQ2oVodfRWkuUMgqhwZpwrHLlyEDlbCwJavM/?=
 =?us-ascii?Q?b7ArQIzGIgsVhLSRy+XqHmxlK+ZtluuRZc43WoLEd9BWDCet9Jd5PaAwnwP8?=
 =?us-ascii?Q?zvlP/VAzFLQRVADBjBr4TgpBuZj8VB6WMJDUnH3U4UwC6ns2qLXu5NTHQLzX?=
 =?us-ascii?Q?OxNRWtqXIlA33mRpcd3Rq//dUgzdCKYtgMYkOHkd8jBZzSuR/kd/lbj6OD/t?=
 =?us-ascii?Q?8C8sYvGM5vWephpw5SlyAlwpTsOwk3rQ1LZlq1CiBt9kZ2uL6W89gmqo6Crg?=
 =?us-ascii?Q?tEuGuilFnEFnW4Q7Jix3t0cZiaQZTfr140mjR7eIPzZFoz3JSo5ljEeI8Jyx?=
 =?us-ascii?Q?wPBX0D4Xf8O7S4x2eVqgyejWkH7m35+SxNXqfUIsiA4AQTyevwuCGbLmBB4J?=
 =?us-ascii?Q?hb7P/k5kyWilQ+6x6admxsPGgwIECnIUrhw0ZNGx1U7B8U4QQ6lrJTcuzXf1?=
 =?us-ascii?Q?2KxoqSXAYm/Y6D+xCYgBwSnJqaFCzRInQ6tE2XW9QAC4boSuWewzdYH+xo28?=
 =?us-ascii?Q?s4sbUDzrU1L94zsmENCsfXt5o6KUqpWcCXSDzdMaw8+E5NSHVUcX74E1N/Pn?=
 =?us-ascii?Q?ARSrPZrpDocB5j4PuPgD3gKwL4XjT8hwoZa/h9PEmkijui9bmfm4AHwbdU0I?=
 =?us-ascii?Q?b9bZnxE392AuBhtghMlrC4CJ0WMOdXU6jz7ExwNUQlhywy6tSczIGL2H7Qyc?=
 =?us-ascii?Q?ARLANW0riqxRsnxajGTD2PPJPnoeww6ngHQIumm9vV8HteDvCA6RtsHFeVoU?=
 =?us-ascii?Q?Z/20uoSI5Oloc4IkfZmOeuFZIPhyq2rxnBiU71T50jy4pe1I4fNXIXxwKSsb?=
 =?us-ascii?Q?THe8wdtrJ2Svl56YLPzHF3x5jCE4pAx0VKyWcy2QatWCzLOWOJxvboFnROgp?=
 =?us-ascii?Q?pCQBPVQ1LFfCJCxn0Y8AQ3EiQHOzeA7Be/rKjrJq2wq4XL/0REqbi4VLhJaZ?=
 =?us-ascii?Q?WEwuLvnoaUh3QbwM+ggXhqsusf3FpylfCrF+nvNQSYCE4RqkUkxHGa2+QveE?=
 =?us-ascii?Q?x0+6rPmfcz9zCkKt1VbF7fKlzITzfd+jiKajRtEKh4x/qcFPD88+7xEeoGBp?=
 =?us-ascii?Q?sNryaNThz0GhMGjB/rLy6nzQ9OTwWgFeb7hZCTw4?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281eab46-823f-4015-7361-08dc41e52e9b
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:06:16.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXf67PXtOiilULLEA7sjT0vomhB6/gN6IhV4Y4To2/utItiDh9t16L1poW92EIDJHPm6Qt+S9iA8+ZyeGMoEog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1961
X-Proofpoint-GUID: u03V6lfqaQwEcJ9BxBvQ5mWPurcFKvAV
X-Proofpoint-ORIG-GUID: u03V6lfqaQwEcJ9BxBvQ5mWPurcFKvAV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403110122

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add new interrupt handler for generating WoM event from int status register
bits. Launch from interrupt the trigger poll function for data buffer.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 11 ---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 69 +++++++++++++++++--
 3 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index d5b0465d1f74..ca5f7d45a6d4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -185,6 +185,7 @@ struct inv_mpu6050_hw {
  *  @magn_orient:       magnetometer sensor chip orientation if available.
  *  @suspended_sensors:	sensors mask of sensors turned off for suspend
  *  @data:		read buffer used for bulk reads.
+ *  @it_timestamp:	interrupt timestamp.
  */
 struct inv_mpu6050_state {
 	struct mutex lock;
@@ -210,6 +211,7 @@ struct inv_mpu6050_state {
 	unsigned int suspended_sensors;
 	bool level_shifter;
 	u8 *data;
+	s64 it_timestamp;
 };
 
 /*register and associated bit definition*/
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 13da6f523ca2..e282378ee2ca 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -51,21 +51,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u32 fifo_period;
 	s64 timestamp;
 	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
-	int int_status;
 	size_t i, nb;
 
 	mutex_lock(&st->lock);
 
-	/* ack interrupt and check status */
-	result = regmap_read(st->map, st->reg->int_status, &int_status);
-	if (result) {
-		dev_err(regmap_get_device(st->map),
-			"failed to ack interrupt\n");
-		goto flush_fifo;
-	}
-	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))
-		goto end_session;
-
 	if (!(st->chip_config.accl_fifo_enable |
 		st->chip_config.gyro_fifo_enable |
 		st->chip_config.magn_fifo_enable))
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index ec2398a87f45..2514966f6495 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -6,6 +6,7 @@
 #include <linux/pm_runtime.h>
 
 #include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/events.h>
 
 #include "inv_mpu_iio.h"
 
@@ -223,6 +224,65 @@ static const struct iio_trigger_ops inv_mpu_trigger_ops = {
 	.set_trigger_state = &inv_mpu_data_rdy_trigger_set_state,
 };
 
+static irqreturn_t inv_mpu6050_interrupt_timestamp(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+
+	st->it_timestamp = iio_get_time_ns(indio_dev);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	unsigned int int_status, wom_bits;
+	u64 ev_code;
+	int result;
+
+	switch (st->chip_type) {
+	case INV_MPU6050:
+	case INV_MPU6500:
+	case INV_MPU6515:
+	case INV_MPU6880:
+	case INV_MPU6000:
+	case INV_MPU9150:
+	case INV_MPU9250:
+	case INV_MPU9255:
+		wom_bits = INV_MPU6500_BIT_WOM_INT;
+		break;
+	default:
+		wom_bits = INV_ICM20608_BIT_WOM_INT;
+		break;
+	}
+
+	scoped_guard(mutex, &st->lock) {
+		/* ack interrupt and check status */
+		result = regmap_read(st->map, st->reg->int_status, &int_status);
+		if (result) {
+			dev_err(regmap_get_device(st->map), "failed to ack interrupt\n");
+			return IRQ_HANDLED;
+		}
+
+		/* handle WoM event */
+		if (st->chip_config.wom_en && (int_status & wom_bits)) {
+			ev_code = IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
+						     IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING);
+			iio_push_event(indio_dev, ev_code, st->it_timestamp);
+		}
+	}
+
+	/* handle raw data interrupt */
+	if (int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT) {
+		indio_dev->pollfunc->timestamp = st->it_timestamp;
+		iio_trigger_poll_nested(st->trig);
+	}
+
+	return IRQ_HANDLED;
+}
+
 int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
 {
 	int ret;
@@ -235,11 +295,10 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
 	if (!st->trig)
 		return -ENOMEM;
 
-	ret = devm_request_irq(&indio_dev->dev, st->irq,
-			       &iio_trigger_generic_data_rdy_poll,
-			       irq_type,
-			       "inv_mpu",
-			       st->trig);
+	ret = devm_request_threaded_irq(&indio_dev->dev, st->irq,
+					&inv_mpu6050_interrupt_timestamp,
+					&inv_mpu6050_interrupt_handle,
+					irq_type, "inv_mpu", indio_dev);
 	if (ret)
 		return ret;
 
-- 
2.34.1


