Return-Path: <linux-iio+bounces-3064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED54862B62
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 17:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580F3B20BC9
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7A5175A7;
	Sun, 25 Feb 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="kfbJaBwi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09214168DD
	for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876876; cv=fail; b=ZjZrGmyx1QjhG84ypVgzonfTSIi9oyJmEwRs7Hw8CAY3tIgsRDaDKrq2gkeFsVDIXkccTNxUrWth0fUKXd1XmH63zb0FO8TVbpDIuwnX+LLSWMT+0aYeo48KAzLXnejQaCaCsKFhoAgP6SYE2tel+c4qdbwWwrPfd7EMiXOMMUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876876; c=relaxed/simple;
	bh=dk9+YV+9XAe5leDx5AFCAOQysZagOG2MCwHpBmNYxMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pYkxpeZ+JWJZno3zvx6mSmydddLTkqEarODJ6f/wwIpbYkn6DdtR/5CZP0AjB3HyawviUbak+Iz7l9TfOG0P9DHve87Fz3yu3sL8/hhuMLP/31Ct0UW2IwfzuCUgYz94ABtdqBzqNO8GOH99DP/ylhSL3rJHFa2u8FxipZlPor8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=kfbJaBwi; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41PFo2ch018247;
	Sun, 25 Feb 2024 16:00:58 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2169.outbound.protection.outlook.com [104.47.23.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wf9tjrf3v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Feb 2024 16:00:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf9cfEBVJpeCglWpEsr+ehctH8dHFG9OjXvOpvYCT2UrWE/kovNZGp1PisXoaatStGpiBz9RwpJYDtwYIJzbkaU/V9Ws/nhViqmNhTzC+uOEHyGCt3YNSbJ1yDSYlXH2woLOKYygnTkGCMyKryiUWX7xMC9QrGumAA5hZMNMnxONRo9nCMtJiF4H7L2pPFnvFRzAX0/MnJyYHW9ogmTc1hUIEcI1DLUAMuDSdv5L7EdcISEYKHhiHs06TfoZfPP00CPdD3Wnn//lzQhDF9lGyz8OyxaOId/pxcVEvzaSqYCd1hhoprrxiN27m/BzzMKuGRD0VAks7ukOppI7Pkl+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCNVN1XRGRiTNWcrvswYp0UGUrKEINVjMMaHnlVg9G8=;
 b=ZR7yRSdXbQNd51bzwLKHW87pHfi7oSraFyp85oKuPCwTQUZrdCH40bUjdmQEb0tSB9nbnJ/ZBzKz/WEdBnchcCfsnbZ85NIIjrdymGx02e4XnRq9WnIlditRo3hVnZCgvBOOv4na6FYdarkhxdescgIy7Ud8Cfv7v0B7I1375tOWEim1kBFpUClFgcfFjY50WAdp9ToR6LqhVhziUqRUIeUFtRMhN9gWHKwda77TvTlgkhGtMU2QPKTHSoPKG22q56CPLNjfNhdkny/NmupaGBbP0pdsPLCe5/S0spExzRA4poDYUn3gc7JFlhMN8+vL0fihiQxFeNgELWdp6/8+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCNVN1XRGRiTNWcrvswYp0UGUrKEINVjMMaHnlVg9G8=;
 b=kfbJaBwizogTIcFpPXIDPwXXZ4XbKX0lz8eOT8azxyl/47rDy7PrVq1mpAXWf609QbZvSH1OcfdozVvujUL228BN2Ps8zYNFXYkwhl4n5LR9ngsc6pYurGplhAf/7KqIxfvXlsf7Vy2SOgmvaiUmyruDnFxg4gRqupohr7cTCexm7DWnOpUTAvQ5pkGNVqvhR0dpcpU+66Jl3BO/kVBpPFzMzz8LvcIPhxgAzJSgiPlLrwHp2hRd1+x6i+CIEGr0d3+fZi4rgkWE1GZ5WtuaPzP+yZG4fWG471bNO547rZTUdNClt3/6eHyM45DCKufG5vC2qj96YMj7SZXVzfGemw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYTP286MB3462.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Sun, 25 Feb
 2024 16:00:52 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f%4]) with mapi id 15.20.7316.018; Sun, 25 Feb 2024
 16:00:52 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 2/4] iio: imu: inv_mpu6050: add WoM event inside accel channels
Date: Sun, 25 Feb 2024 16:00:25 +0000
Message-Id: <20240225160027.200092-3-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240225160027.200092-1-inv.git-commit@tdk.com>
References: <20240225160027.200092-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::16) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYTP286MB3462:EE_
X-MS-Office365-Filtering-Correlation-Id: bf540368-3ae1-4a76-8840-08dc361af0e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CTRNF9IT5lf5Mt/4YSF8yTX08Oi4TmtNb+4mE/aJiJKjb7zfyTi+I64TOEr/6oal50GsEKCld6w4FjhacGPvH/uNnouUIYa66hvaphB/DEWx69QTEz64212KPgLx3vDXknaKJ0we+RkkbtrMRGoAvj1ZWrcogACzD3cBqbUSzx7JE/cNQdeIcky+eiV4ZSPyykXzWqYfq+/bc2s6B+Fp12z86Wtgf6GQ32KhMfHJBW1zeMPOe2bDQSRNPuTju55VJmvwrwUgqtjQOWBcB3bgvwlPZG/KnvGkt+zGFSmEc91jenWKCRD4dh6xyXlhYnc3cnfUdVOxM+08TkryXv/CUItNARHCsUOVPRjOMKkUB5A3AZ1DwU0zaF9Ll1WVaPOvs7OJspVroaQG8BiILDTZ2eQ4enFZwi9aAtSttWj5dG1xuOaLufeHlFEGCL2hgUDCFW9/ocl6jW7ALCctwHuB36QTOBBaswEp76NzEOnOjrNt4WGVCPvNZ2ucHT8w/gkPGN3Ov+f7CUOB9Dd6yTWx71++xHusdp1HzO8H/Vk1KCWAE0Hekbau8ExUOg+jgN6aotZ34X7OtyoBImY38Osy7p2IpWzsX1a9uYnGlLrtETIMqrVI2tzK0nSOEy29b7HEjtuAcZiV2LuJrLPll4Sd3Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?043ZxxXDb6nD57CBlMflb1zDMAAV2XCPF6lUcHNOFlBYeqqI+biVVbLghcic?=
 =?us-ascii?Q?bREOUsSU0I/O8Kn9KbWJcjvIzZxF9m8fn1mG8w7OCoepKxMd5w3h1umni0yp?=
 =?us-ascii?Q?+8CEI490Nea1OK3c/pprZn67vd+1DaHG4gP195wueQ/L7M0ArEjvwOif5VOU?=
 =?us-ascii?Q?oEAJo+H1US9OII+MTdJ69Aq96GfXIMqrSNuhNJSJbfpR9G7uQNAdxZ5dsH4m?=
 =?us-ascii?Q?OdZFj+3R0nsFVbXja9gFWtmvOtOuiZjfwNi4PZwNyt6630HubglE746p/sRc?=
 =?us-ascii?Q?rT0Gp8/KLOJPNiOP/660wc9cDnaiQwcetI9q7KiwxEAQAEP1QLnwN5tv5gzd?=
 =?us-ascii?Q?+3tK5g3vodMxlRGFPzwsvDsVPh8d9Vw/AnLPGQ4xgIUGjb2b/fxFPdlbEqvU?=
 =?us-ascii?Q?VXiinSpqs3Wn1FwuoXwqIw1ZQJlr47+nldXwzwGYkPbWwlKFq3wK8D9ujHwW?=
 =?us-ascii?Q?7Ef31b2Jub0pE159BSj4laQG7sAI9ezC+Nan4vf/ZNo/rxTLLH5RUx5wN2vE?=
 =?us-ascii?Q?illwrUD3K4wAEa6NRIecpZu2cBhecmPcHfBXVlLP0Gbb/rIPEhlVqmO57mle?=
 =?us-ascii?Q?aHm/UpJimlkB2lhHN924vY6WhV8F2vv3He1ePk3lxSWnaxsO+G2IJdxdM4l0?=
 =?us-ascii?Q?F0aVDTrPpuR+6IEvo+9MT38/huhJSRPzaMN/wRBZQeyde5RvQ3BuwKQmO7hM?=
 =?us-ascii?Q?SvcyDcRLEx6VE6op+nWSRu7Uh+QwrnQHs2s6fBs+5yU/tQtxgW6CDTU12ruL?=
 =?us-ascii?Q?iU1OZUFmWEdFS5qaprfMqIjxHN7lvv4tzR0MeiYXN1SBq3LRjEmlQjFdjYO1?=
 =?us-ascii?Q?RCC1v9cti9E24ciQIV+tEmhOnX/iy7K7IK08CQKLL3aqY4yVgpC4ipcI0fBb?=
 =?us-ascii?Q?frYNVaThNyCIBi+v2mYXJ8bQJf18J20eG0G5ifmChFX4XJgTFVflpkj0hPCd?=
 =?us-ascii?Q?g7LzSoyrsDbULUwBeJeWuz547SWn0O5ATvSRfnfAh+PB9kojMIOd3X3UEwoW?=
 =?us-ascii?Q?aoZ+UzpVS4T9tv2nxs1mjurFr8CjP0F/XEOkw3whLwahjtaQxcihkQ62+UXk?=
 =?us-ascii?Q?rAOovl+ErDdvhy73rQTiv2rKjstaR5/z1jNh2BbF5ZGZdiMtjK3H8MRxwrEn?=
 =?us-ascii?Q?JRcN8pPHYtgXZ+jflr8RDZbmf0kD1iO736kAjpQGvaNq83stwE0F8iR2kBBF?=
 =?us-ascii?Q?3CMqK0b5Xa1Drbpy6XV1ZGMNwIA6AlZOanLPyUAYerUGT9CEILXynYVpW1yt?=
 =?us-ascii?Q?434XAQ4EVXmj/4eIY2TLqA41rG3nAVLHjqo2RBBJYizYBrW+YW1+1LmDoNSN?=
 =?us-ascii?Q?T9fPqackyXM/pOUVGatvcMjjgheQU0EDROw90yV56Gx6ZOz2K+Q+hq1oQItf?=
 =?us-ascii?Q?tqi1gLeY8XSbSzPJzL7w0Q3XWGvBfvZrCv0fzTKpjV0cSJhW7brD8v/o7+vK?=
 =?us-ascii?Q?cjMf1bA5h20r/qrtmaRNkhKOOnw1U5TcWw9X8kZ30+5zJueTy5I33bdbfZeN?=
 =?us-ascii?Q?3S6VDta5bo/j16ZVFk3oL6Ekw5i1eeEBZQgA9c0BxJa7v3azjaJ7fPC0acwJ?=
 =?us-ascii?Q?cY1r8mSe7MthXq5YlCjO96AbWe9Spy+GwhIjwNQP?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf540368-3ae1-4a76-8840-08dc361af0e3
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 16:00:51.9057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaQ3P2aG1gGZEFHliawCvK50bU3nGVrKBC5d3S2DIOeEJxcb+JQiUf3neWFwg/B1C8UyENtqhTjziMtHKHD1NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3462
X-Proofpoint-GUID: -6bCFtZen11USaL7E2UqxQ4WjrIXepFp
X-Proofpoint-ORIG-GUID: -6bCFtZen11USaL7E2UqxQ4WjrIXepFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_18,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402250127

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add WoM (mag_adaptive rising) event in accel channels for all
chips >= MPU-6500. This requires to create new MPU-6500 channels
as default and MPU-6050 channels for older chips.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 132 ++++++++++++++-------
 1 file changed, 89 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index fca7fc1ba4e2..d2544c758815 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1303,23 +1303,34 @@ static const struct iio_chan_spec_ext_info inv_ext_info[] = {
 	{ }
 };
 
-#define INV_MPU6050_CHAN(_type, _channel2, _index)                    \
-	{                                                             \
-		.type = _type,                                        \
-		.modified = 1,                                        \
-		.channel2 = _channel2,                                \
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	      \
-				      BIT(IIO_CHAN_INFO_CALIBBIAS),   \
-		.scan_index = _index,                                 \
-		.scan_type = {                                        \
-				.sign = 's',                          \
-				.realbits = 16,                       \
-				.storagebits = 16,                    \
-				.shift = 0,                           \
-				.endianness = IIO_BE,                 \
-			     },                                       \
-		.ext_info = inv_ext_info,                             \
+static const struct iio_event_spec inv_accel_events[] = {
+	{
+		.type = IIO_EV_TYPE_MAG_ADAPTIVE,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+				       BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
+#define INV_MPU6050_CHAN(_type, _channel2, _index, _events, _events_nb) \
+	{                                                               \
+		.type = _type,                                          \
+		.modified = 1,                                          \
+		.channel2 = _channel2,                                  \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	        \
+				      BIT(IIO_CHAN_INFO_CALIBBIAS),     \
+		.event_spec = _events,                                  \
+		.num_event_specs = _events_nb,                          \
+		.scan_index = _index,                                   \
+		.scan_type = {                                          \
+				.sign = 's',                            \
+				.realbits = 16,                         \
+				.storagebits = 16,                      \
+				.shift = 0,                             \
+				.endianness = IIO_BE,                   \
+			     },                                         \
+		.ext_info = inv_ext_info,                               \
 	}
 
 #define INV_MPU6050_TEMP_CHAN(_index)				\
@@ -1338,18 +1349,35 @@ static const struct iio_chan_spec_ext_info inv_ext_info[] = {
 		},						\
 	}
 
-static const struct iio_chan_spec inv_mpu_channels[] = {
+static const struct iio_chan_spec inv_mpu6050_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),
+
+	INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),
+
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X, NULL, 0),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y, NULL, 0),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z, NULL, 0),
+
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU6050_SCAN_ACCL_X, NULL, 0),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU6050_SCAN_ACCL_Y, NULL, 0),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z, NULL, 0),
+};
+
+static const struct iio_chan_spec inv_mpu6500_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),
 
 	INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),
 
-	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
-	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
-	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X, NULL, 0),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y, NULL, 0),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z, NULL, 0),
 
-	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU6050_SCAN_ACCL_X),
-	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU6050_SCAN_ACCL_Y),
-	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU6050_SCAN_ACCL_X,
+			 inv_accel_events, ARRAY_SIZE(inv_accel_events)),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU6050_SCAN_ACCL_Y,
+			 inv_accel_events, ARRAY_SIZE(inv_accel_events)),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z,
+			 inv_accel_events, ARRAY_SIZE(inv_accel_events)),
 };
 
 #define INV_MPU6050_SCAN_MASK_3AXIS_ACCEL	\
@@ -1401,13 +1429,13 @@ static const struct iio_chan_spec inv_mpu9150_channels[] = {
 
 	INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),
 
-	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
-	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
-	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X, NULL, 0),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y, NULL, 0),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z, NULL, 0),
 
-	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU6050_SCAN_ACCL_X),
-	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU6050_SCAN_ACCL_Y),
-	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU6050_SCAN_ACCL_X, NULL, 0),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU6050_SCAN_ACCL_Y, NULL, 0),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z, NULL, 0),
 
 	/* Magnetometer resolution is 13 bits */
 	INV_MPU9X50_MAGN_CHAN(IIO_MOD_X, 13, INV_MPU9X50_SCAN_MAGN_X),
@@ -1420,13 +1448,16 @@ static const struct iio_chan_spec inv_mpu9250_channels[] = {
 
 	INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),
 
-	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
-	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
-	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X, NULL, 0),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y, NULL, 0),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z, NULL, 0),
 
-	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU6050_SCAN_ACCL_X),
-	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU6050_SCAN_ACCL_Y),
-	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU6050_SCAN_ACCL_X,
+			 inv_accel_events, ARRAY_SIZE(inv_accel_events)),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU6050_SCAN_ACCL_Y,
+			 inv_accel_events, ARRAY_SIZE(inv_accel_events)),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z,
+			 inv_accel_events, ARRAY_SIZE(inv_accel_events)),
 
 	/* Magnetometer resolution is 16 bits */
 	INV_MPU9X50_MAGN_CHAN(IIO_MOD_X, 16, INV_MPU9X50_SCAN_MAGN_X),
@@ -1831,6 +1862,12 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		return result;
 
 	switch (chip_type) {
+	case INV_MPU6000:
+	case INV_MPU6050:
+		indio_dev->channels = inv_mpu6050_channels;
+		indio_dev->num_channels = ARRAY_SIZE(inv_mpu6050_channels);
+		indio_dev->available_scan_masks = inv_mpu_scan_masks;
+		break;
 	case INV_MPU9150:
 		indio_dev->channels = inv_mpu9150_channels;
 		indio_dev->num_channels = ARRAY_SIZE(inv_mpu9150_channels);
@@ -1844,13 +1881,13 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		break;
 	case INV_ICM20600:
 	case INV_ICM20602:
-		indio_dev->channels = inv_mpu_channels;
-		indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
+		indio_dev->channels = inv_mpu6500_channels;
+		indio_dev->num_channels = ARRAY_SIZE(inv_mpu6500_channels);
 		indio_dev->available_scan_masks = inv_icm20602_scan_masks;
 		break;
 	default:
-		indio_dev->channels = inv_mpu_channels;
-		indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
+		indio_dev->channels = inv_mpu6500_channels;
+		indio_dev->num_channels = ARRAY_SIZE(inv_mpu6500_channels);
 		indio_dev->available_scan_masks = inv_mpu_scan_masks;
 		break;
 	}
@@ -1859,9 +1896,18 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	 * auxiliary device in use. Otherwise Going back to 6-axis only.
 	 */
 	if (st->magn_disabled) {
-		indio_dev->channels = inv_mpu_channels;
-		indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
-		indio_dev->available_scan_masks = inv_mpu_scan_masks;
+		switch (chip_type) {
+		case INV_MPU9150:
+			indio_dev->channels = inv_mpu6050_channels;
+			indio_dev->num_channels = ARRAY_SIZE(inv_mpu6050_channels);
+			indio_dev->available_scan_masks = inv_mpu_scan_masks;
+			break;
+		default:
+			indio_dev->channels = inv_mpu6500_channels;
+			indio_dev->num_channels = ARRAY_SIZE(inv_mpu6500_channels);
+			indio_dev->available_scan_masks = inv_mpu_scan_masks;
+			break;
+		}
 	}
 
 	indio_dev->info = &mpu_info;
-- 
2.34.1


