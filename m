Return-Path: <linux-iio+bounces-3458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078BE878498
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 17:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA171C2117F
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B91B4436C;
	Mon, 11 Mar 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="aKdFaTse"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C944C8D
	for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173205; cv=fail; b=mMyKym6fQ9dFxZYXAlHqFgzWH5xFT5lPpCzuWUc+gYkKNeF7wb7r6eCRT3mZ/r8Ihj/aPGAetdds2Wz7nn+tJnZLdYZxeca3a4DT+bReBPjPz1LD+A9lnVB99Y4Ga3HAfi9jn389VLMvED6pPbjHhZVbuFRIUFfSSOMgYF5cNcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173205; c=relaxed/simple;
	bh=9mLo8US8o87b7jnsSKdCF2+Pvs53aaazeP2Xa/M59nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eRWHrKDQO2khKBOLdoqMZBgZA4vxKwrYhqc9eHOss5WBE43weFNyqqMcQofdpAZDfwRBTw77ZYhlLNMTu8aVrwOhO56LtlxvNzhURpYsI1A641vMiyGsnXXNiE4Mj7lqn6OJuGn+06Lh1aKzFiocouEJ2htjaSf5+0UWEqC2XTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=aKdFaTse; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B9oV0k032277;
	Mon, 11 Mar 2024 16:06:17 GMT
Received: from os0p286cu010.outbound.protection.outlook.com (mail-japanwestazlp17010000.outbound.protection.outlook.com [40.93.130.0])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wrh4j19vn-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 16:06:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8L/UOlE0TIn1DE8RbfeKLs+EQtJeSHJbLA456lm+ShR+HvYbnDRzlzneXJ/f2Ht7ssoN4jGptSi3NyNZQsZbatYvSS47Q7FPeo0FG1IKjan4AQB03oUrgLmxnGRNfULZrVjNSn2hv29iDt9uYkaS48p/SwI8Vz4Ks9n4O/BHmfs/OToXs9e9cNVCt4kEF8vjRrDdyPJyULRF+Iu3O7r5K/d1bLOgWlpeeU0fDTcEqNPW8u8qXA9DDHdhvmab6GmiBCqIseWY9qHhAywt1261Jmp8ovTqgDOoEGvxDNZCfsjBbKb2O5cvbe+y+IYXbULtubQOcxBCZkY6/KGqMpiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSJQ5WckAmyspTFv2g3Y8gpyEj82xt9jLcyK7W6GJtw=;
 b=kjTzw+xyC5Hzt0CRGkEJTUuBqqpB2aZ2g/crn6AF7qv5CtancSXuDTP5qnqRQuw5Jw1UxnMXL7TwpG/Kpe3RpqQVuP7zLa4mZ+oAQBS4lAK/I3dQ77aTLp/hydZ/ymuzRA5aQB8pT5XMkwsH0J0/Oa52gfgJ4VpLO4owmNa0SpspgVVv7x1ML9pzm+95RTQsUrCDUYDKoYKnRJfmFIf1NgR7rZhv9QZVNb7McctCvGayrXTtIZYiGOBDnxAovHYZ6HJebHxkMtZ9yt4kxxLjjcqTo582gVi0quFMLYghoVzngUW4+h8abC9wy05d9EXrKjS/ePj/FWNH/ULQmVtZig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSJQ5WckAmyspTFv2g3Y8gpyEj82xt9jLcyK7W6GJtw=;
 b=aKdFaTseGNDON1RBckWDvu1lg4ZlIhnilABmLAKDQjhybF8jLiFBC36eIrRS4woS7labvJIDcCrsZltmjxQrvYQKh0/Slru5/+mEqelopwVvpjWpeBN547HsxqMCoxZXgtuW5mgxUFoElKr3ZnP5vvqSyuyBdwGNYyzfPtiMxY7KWtxUwZ4zyLkR2wkwetlgRTtU2KjYwO84zOMlEllu3wnpj8iEbzD+ubYR7RJlCH3bOOTk4//YvGuk01UlAxBQe20ymtlnAd0WekUEI/JtT+kP4CnpZa91Q+AV5wFhjMv584lnXuWDf5Cs/A5UOdpZ0cL/In1EvH71HPoFkD4urg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB1961.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:06:14 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%5]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 16:06:14 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v3 2/4] iio: imu: inv_mpu6050: add WoM event as accel event
Date: Mon, 11 Mar 2024 16:05:55 +0000
Message-Id: <20240311160557.437337-3-inv.git-commit@tdk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2611c030-d768-4b4a-f9bc-08dc41e52d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/OmIGkZfSLsmL02+sxGoT7RThrjfXT3LaDQ45JjgBWScboSeW+IzcGv4Wad73hdV0M7MLfeC0IvqeThk1yv3ciuaEiNSDV1QYSa6eL2GMnRn62FpIH3P10iNhA+Ic4skQCpMB1RabHw3dfus8Uj7mQX6UjVF7kU+JXctt+YL6WFMmR71lMrT+OIIQ+CrCWECJMBR1kToZtEZJIuRe2hpDrqig6bteAZtiyZ+0fan0Pc6MXDzHQV0LGQGWg+VwBSPXVj7soCt0SFJdWHDLqe/kWniQJ2EzePA/8eBiQY2wTfo6kbIeIIxCISyOcW+0kZxbCfNOl3vviVeImZ5Ara2Gysie0K4K9sGkZyyRZm2Dt+O/C383Z6J07oD/v4WoGk8oN0x7w50lFVdzOqjhzEbtRnIj5nl+a6wzhT2GU0xid7jC9EOVSq7Baim9HvwPNYkAi1XIQU6eBL869QIeEFSdWPW6V7uIFAvWXZL4+rlS/PyBlvy2tIEwRYeDti3UYS6zIMeKzloooVAjEZRv70ZADFr7TOzm5OD19oaIIRP7OfJuCEFEXI+4vE3xCfhyTSnltv//uexXd3G1FBI6AgiKQbmVbhxCbH7aUd4MSWeg3bQZTHOweNlJ6lXETac1BNBvDKvxaUGEtQyj6xlXhApGHn+HvIo9+qxW7sXd5X9ZKuQDpGRvBgle3FJ275iYkob7jX19r9/s+KKP/EDB30YLghz7Oj3HqVbcu0r13ShkueBFPNyWOC321J+RhQ5iS4j
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(3613699003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?W8G+mWQuDK/xWEn+9dFyiRrwIkGRnYXqUOnzZDH5DwXHTGf3g0aM6t465Rkl?=
 =?us-ascii?Q?G6XXDtVpOi6/fPDFSDVimvuPu8HLYHVnhUM4qsv/IEeJehLSxjfTr43QBu8w?=
 =?us-ascii?Q?fpe2ojPQjOBFuPSPyRNcyPdrxbcgmdCSdMl4k31g0wn2KVfYBhI0LsGgDdws?=
 =?us-ascii?Q?pUNtj7kEOgAwzOq2kGeNt+r3fgiIP/lQVzM4bRRrXNaTJMbRUAtGeKxfyyf0?=
 =?us-ascii?Q?27VkdlreP81TivarqOEpB6srStd2/CzPVYbxY10H5KKHfD59BhmiUg/MTm3f?=
 =?us-ascii?Q?dGYN6+qxFxxXV+WC+SrRiE/vlmL2CovBJzCpLTrnynXVIKedxTPc7rrz5pbW?=
 =?us-ascii?Q?sWux0iblJ4iAVq5BYou88UU/dVMjM+K5sM05/2l2TFdnx/AQ2jiZ7+54+eQd?=
 =?us-ascii?Q?FxYko027x2NOpdzkwjmcpCfHBPx0/aS/DtZ6eq6Z70oCrvgRDWFIvcGugMIt?=
 =?us-ascii?Q?MU2/S8lj1rLeBD1yJ2yz1XF1tTDI0VrPiRCfSYuJeue4NT+cmN233LwUOeC7?=
 =?us-ascii?Q?UJelJhGDguxATho9AgHGpfyq8iQDfFHMY4Ud/QWwXeCj253TLhV2C0zg75cC?=
 =?us-ascii?Q?Zp7wbS7zuBsfvPyBib5kyEHbxiHM2srFSkSjFvA6N8zmTgqNPDFLoPVilx4q?=
 =?us-ascii?Q?0jxww2x3VNQSDOfMtwvkJF+UfKQ5Ri8qB+bdUfsf3dAN5FhW9sDG3pPeqNwu?=
 =?us-ascii?Q?JNTle2z89+5J42LHXxXo8gfIYKvoduFGO0eWNvKtPv3YNxDNaFqWjbbinuJe?=
 =?us-ascii?Q?coWyO9c+e3+YWnJOcnOj1Mjh7oPDWASyyrCYw+wTWTHlfNIfX21Os4VS4EVf?=
 =?us-ascii?Q?cECri1ev//ODrCTOKuTrxnn947ERBh+GkNBT6aA1SD27qRhIdFbr8xp4qzxB?=
 =?us-ascii?Q?+XsQnu9aaHAYOqsesU22BrzvHC5B0y9s05/8C2x2D29WeO30DgtMCTxnzNnb?=
 =?us-ascii?Q?S56zfyqrwSWlQggYBDNd65rThsr3uQg7lPnCPeYv2srxLRq/6BZ9NnufO7YH?=
 =?us-ascii?Q?YCFzYiiIYIfoYjrkQ2W4JjeAGEXWMQsyjdgGTt/ISMacUTZcYVBcpcGUJRH4?=
 =?us-ascii?Q?7ILIt9L/hxYahNa4Q27fUStgAb0HFPdiGNToXh9L7EE0qMTJhQu8ldNAmrvo?=
 =?us-ascii?Q?bnPJvPKQVF3towz+iZ+xreMHpc85BTCRNoQ60GX9HpCG5A0UYXgkdrpPGKRj?=
 =?us-ascii?Q?JNmAStU1PfWit079qsRzIhTtLJ/kzYKyPVOJK8wvOhhdeBkTxzTUrkc8bmya?=
 =?us-ascii?Q?HHIUQu5GL2grn7Zwq30cVIGOKcyZ1ZvxdjX93iXIgE16VlD+g5b7Up+d0JpW?=
 =?us-ascii?Q?x1DYBcSihYG//riggYG8iL7KSIxFk26jqDnwil2wuYnzwJWhOy2buRc864g+?=
 =?us-ascii?Q?HUnL3Q1LEXyEf2A4JK+n47zVHrxI75SAtDwTametXM+jyERBs/y0H0a+cgx2?=
 =?us-ascii?Q?NqRzpAX7bdTRrN7GJz+zxPbBrFi0pIZNeRbLxVsVGNMrNqfJipRGU6PoHzGS?=
 =?us-ascii?Q?pxeZtVA7brrJeArcxgG/tZCLJ3IBgdek7KVn/lKqeofWjWDyKH9bxXVmeBbK?=
 =?us-ascii?Q?ZFnZpzKT4TIwTB6KNQRckIMXzGbHuFAyepEmR/gq?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2611c030-d768-4b4a-f9bc-08dc41e52d6d
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:06:14.7001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ta8R8lVAjnIkGuxjr6IFegOR4HGlsipVnhagAJBp7cd9FhVdk+QiQtrsMhzYDG5MOhauuku2q1DfRMqRFaaOBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1961
X-Proofpoint-ORIG-GUID: pe-AGKD-eBD6zHrJHg_L14V3fON5oAHE
X-Proofpoint-GUID: pe-AGKD-eBD6zHrJHg_L14V3fON5oAHE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403110122

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add WoM (roc rising) event as accel x_or_y_or_z event for all chips >=
MPU-6500. This requires to create new MPU-6500 channels as default and
MPU-6050 channels for older chips.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 67 +++++++++++++++++++---
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index d49c0ac91a59..281fbd8eb791 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1348,6 +1348,15 @@ static const struct iio_chan_spec_ext_info inv_ext_info[] = {
 	{ }
 };
 
+static const struct iio_event_spec inv_wom_events[] = {
+	{
+		.type = IIO_EV_TYPE_ROC,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 #define INV_MPU6050_CHAN(_type, _channel2, _index)                    \
 	{                                                             \
 		.type = _type,                                        \
@@ -1383,7 +1392,17 @@ static const struct iio_chan_spec_ext_info inv_ext_info[] = {
 		},						\
 	}
 
-static const struct iio_chan_spec inv_mpu_channels[] = {
+#define INV_MPU6050_EVENT_CHAN(_type, _channel2, _events, _events_nb)	\
+{									\
+	.type = _type,							\
+	.modified = 1,							\
+	.channel2 = _channel2,						\
+	.event_spec = _events,						\
+	.num_event_specs = _events_nb,					\
+	.scan_index = -1,						\
+}
+
+static const struct iio_chan_spec inv_mpu6050_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),
 
 	INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),
@@ -1397,6 +1416,23 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
 	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
 };
 
+static const struct iio_chan_spec inv_mpu6500_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),
+
+	INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),
+
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
+
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU6050_SCAN_ACCL_X),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU6050_SCAN_ACCL_Y),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
+
+	INV_MPU6050_EVENT_CHAN(IIO_ACCEL, IIO_MOD_X_OR_Y_OR_Z,
+			       inv_wom_events, ARRAY_SIZE(inv_wom_events)),
+};
+
 #define INV_MPU6050_SCAN_MASK_3AXIS_ACCEL	\
 	(BIT(INV_MPU6050_SCAN_ACCL_X)		\
 	| BIT(INV_MPU6050_SCAN_ACCL_Y)		\
@@ -1876,6 +1912,12 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
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
@@ -1889,13 +1931,13 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
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
@@ -1904,9 +1946,18 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
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


