Return-Path: <linux-iio+bounces-3382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAAA876710
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 16:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAC81C21854
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 15:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD9D1D558;
	Fri,  8 Mar 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="CSGvAxL5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409444405
	for <linux-iio@vger.kernel.org>; Fri,  8 Mar 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910689; cv=fail; b=Ng9llBoFbavU1I7Ns5NSNI3ACuBsP6wc3A40WIy30Ey5Wc1nVjdioU1Mu3rvtUU2Gl/inbAilZQjTS9sMxtJNYzCRHe/cCOxlQsIoMGsT962DetZRYPImCoBx//OG8kKzpxM6UXrijo1HUMLQignEz6YHcZQcdqFZxOCk/SmMsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910689; c=relaxed/simple;
	bh=3T01nf4DhB5Xp/sWd3kAfW4unryf76NDdhsyHhuRFFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Szym6T9Hvben2xdsdVXPerQPCKLwSxkbym9ThoQzzZNVEuOPkVGMlt5F0j9XOx6RzB920KC742jgBREWmEZl4t/44Zkl4IGcS2a6T1lXNC4sX2Ehmrjt/7478QYjLdb3yN5VfgbActGCu1Hx+a7p0kjCPRSKIrzdfprPuBzi8wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=CSGvAxL5; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428A25tJ016412;
	Fri, 8 Mar 2024 15:11:00 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2105.outbound.protection.outlook.com [104.47.23.105])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wkwfjmyah-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 15:11:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F32bXs8505F56Ya4zDsDBUtEmWnupuPUphB1vnye9JeI0WHsrg/PD1zLPp84EPTq36fxnQUPyeng0DJRL139hoquqctJxcFVIqQ7IICOEHjLr9TnxUZcurmhs8+wqNYrACeFz2nPHgzH/whGpk/+9P7+9hwU6uJKTupXH6OwTiv9vGy3LiQEZA32uFUdPrNlgMlR/kwmm8Es1yHCv8M+ek/hSOFZFbp0Ksg3RuW6L+dBeXUlYdlKxXJp7jAanCYedRpxKOzP+mqITVwFu0fcHrgHSIc37eIFSRMHh/n+1GKt6HUDetqoUWVzx0dcv4OoE+xYojPfMb9VJejHPZ7ESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaZ91oJMcjbJ4ADy3556eyzAFidkeJjUcPc7ClNEihI=;
 b=UWSByVTWOgOZp86J6b4643hdsgeOIaOZ3R/9dO8gLll8HZgPzuaHQ94ozMP3Qhym6nR18Bes2gFfn+79f5usxJbwDZC+JFiZCT/HX/SCB/eJyG6e+LZxjLF+/KKw1tDKq4ADAp2txkcqi+vuRsZm7xZQMyaIosz64oRYFVspcY2u8zx8BwuhYNpvJaypbN5fEnsrp1BU3BP9JWV0J8xQvlexbm/5Q6e5z1/dTQ7lVbIInc3De4InWcEZCvjFAZ5zdkQ9aDX6HOef9OjOkRV/NE3jhLWg7XzQe9ElIXK3Urh2m5++1kejalVTLeI/uEJ7P3+dBvf/dZFBClNo2Gi5SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaZ91oJMcjbJ4ADy3556eyzAFidkeJjUcPc7ClNEihI=;
 b=CSGvAxL5ityavsWYfGG78OQettDbNYzp1OyaB43vvUR7ddQSkT4/3DiF84DP6CtFCm1+6oJLHkdQcBQF0oUu3a6BOUx+8d0o4YwRSOpjqK2Nm+gxKM2hjDqoBo2FEJIuIIHxSDB4K96CrRNalqmFt3T2A/pPhKICZymvJexNG3bNOncxTs394F6bEwLHCix8hzh48jf/vBz43TS8DAUofkblVuUjnWCOmnkq07/EWtqB8l6mhNwJGrXl+7X5p6ePprSqEXNGhz1YgtETOxzU2KVnMq91MG2OI98vzPHpYR3+1PZT2+zAaEwry2bLELQF2rB1qq57dNDEJ6aGJ82fZw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TY3P286MB2564.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 15:10:40 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%5]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 15:10:39 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 2/4] iio: imu: inv_mpu6050: add WoM event as accel event
Date: Fri,  8 Mar 2024 15:10:21 +0000
Message-Id: <20240308151023.379705-3-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240308151023.379705-1-inv.git-commit@tdk.com>
References: <20240308151023.379705-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::6) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TY3P286MB2564:EE_
X-MS-Office365-Filtering-Correlation-Id: 1293c556-1af7-42e3-5f9f-08dc3f81ea81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+yzsy9U4gJ+Z/IjlN6n6gyCeSIBWjD6ub7tO+kS8Q2ANUtt5jjf81opMK+vsVU2IYQAo66zmQiTKjejpTa9+q2tqeovEwoW9a/s75Jld88I1wqIbQ70m63xzRHCBHF+RYkhZ/jxArIRmr8azfUkYKyh5bSECvJZpCcKAfcY4eJ8Zp88qmUSzYMl8oy71QGSnlkgwvu1k4EpqFdVgC3JZnvToWRsc7d+lgapncoqQOLYW7xXoBl+n2pBc4P78EiciAicxJQ02lIaAQ5oHkPW7ARcUf401D56CzWEdE4o8gGelIERl2K6qPhf91lqgbTt6A/X2Ab1groMG3uq8BkmkpUbGm7Q21eloHUTvAWFEozKBZ+Om0XljOlMATFvAdzgJsB5+QQoKLa08UVw3ZfPN6OlzRULdqppZZvwlPMJcai5eXi2pf8zUEah8CUMy98y4cYla5Y33mhXsJ7WrLOX1tomhWnrm7B5gwWr+8cigOPKYv07NMzfU/xu5a7pv8QAVDq9aA8+pYVidEGHPjjXgTT6mhBCosxVdTYUYddtgCebUVaAL+Kf7/4xQVAt2IX3UetNJGJMZFxeKi96e7r2a0UNQUxzMKgXdWEjGdkf7XojF8o0SGJGTOF58fxSbf855plzCXOy06VCoMhxIG869r54KTEvbWhoiyzuC5qXySW/HtXTjpreekZIXBEwRMEfC1iQMCjlFkD6s/2xD+insGMiAWM/Nn65DuE5agNYY8p+xdVoeGzS4kqL1kBrwRN1a
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?f2hVReJ83sp7TLcDj+GDBojHVx+XBymmmkZyDAKY7VO8KbkiHJ2JKJGTbDQf?=
 =?us-ascii?Q?TFZA/vrz4KYs2+cA5XmaiHGANfWcElfJOZfRaE14yg0RbgVpPvm9tJfZch+P?=
 =?us-ascii?Q?UkK2ytsnB12cvzwWrpLwkZ2M/zAfanLMEFuKztPqmGNQyL1q/ttBkYt8EUet?=
 =?us-ascii?Q?3f5TmY7v2LI1im0qYAwEw24LzgaYCaIGfDhlBbu0gtIqSgv9hbzJB8RJn7oh?=
 =?us-ascii?Q?E3jMWKeEQgoN33NCwyJLq2tTm8//fpuCkzNK1df4j3HDniYLHR9rXVIiOG+C?=
 =?us-ascii?Q?DJtziiBEjekfQ/jOCxQtCn9DjCzhWsV/AUANShorl6HXBX7QsSlNLg7f07fQ?=
 =?us-ascii?Q?ensdfyAiObzms6142vU37syHIp1VuI0Hb588W3bryJezbuO4ZnDIpFDmUilN?=
 =?us-ascii?Q?VfTj047HX4AAse24jHkPhKm0+ZorOh44pZE3ycZP+gl1JK9hwy3KCe47DvPy?=
 =?us-ascii?Q?SWYpxkK0ghZYCgLqfGsrzUQadtMIQa06BiyLPvj2hdRpFiJyFCEfm48uq4Lx?=
 =?us-ascii?Q?DMXz5Dz2GkveGUo3wQRzMxgRRw5aVoC4Vw0ue6PN1qk0sAySF8TK7jmQ3D+O?=
 =?us-ascii?Q?WrhipiBwCU3HO0NkxZ6YUZSIR5FLBai+GXQcN2MUsPd5WwW1EICwoDOmG79A?=
 =?us-ascii?Q?+hHgQW9u1ON8yG5H4t9dGsiFWogCxD2fx2YPwnl/EK4HLjDKfbOii9AyHki4?=
 =?us-ascii?Q?yGaffaCBpVG6nZr4ZySYUwlca7MXjVVxlpNf0r2XdHf4n2fwrlJksiVfef3T?=
 =?us-ascii?Q?U0RD61+F/HOYX4MIwwYCHX08zCUE93a39wuN48FAt6chpQWp3A5E+xRL2dXu?=
 =?us-ascii?Q?dQWw+6LLeOOOm9EntF/SgHv1p1zV6Qu+7jHaXzCkg/vlBP+AzSWzYrZ7OxhE?=
 =?us-ascii?Q?w1SA5qoFNponWj4Ifce7TsKruv7aMABaXzvMn5epeIX0+ANRJJRcn0n9DCGT?=
 =?us-ascii?Q?bLSvdKuQ0ib5wTSxrr0Be76zyxz/PtyL0Qc9I7FGkdH3SNzovqvw36x34RA/?=
 =?us-ascii?Q?VL1M35if7g65SLdmAlekYWQCeORPeSCMS3/osca4Q/cT9siAN3vA/GGUU20S?=
 =?us-ascii?Q?pPGrsVsVr8hgSaDOgktdQj6kpmnDtFXwPs11z66gSBfkWodafv7P7XYMHH0A?=
 =?us-ascii?Q?NhoXfKYmXntiz2DSN/DLUI4sAtG4Sf4FuULrRUbjxsayT9bRQHjf+wcK2Ie/?=
 =?us-ascii?Q?kdHUrmSnGD2AYdsCyApSGlzT7ygfbqrrL/ov9ONeCxPqUal6vpSO9DvMFRwQ?=
 =?us-ascii?Q?zleeuqfZnDKwabVjqMOrkfw+cE3TUSCikcCJZalh3bbsl423loz7hzT+thQp?=
 =?us-ascii?Q?XnYJ4XpWl/FPd5R9K+AXlx2t0wIsa8dgDLQnfSvnpOyAmJm6fXWFQq5h/zwW?=
 =?us-ascii?Q?Qm2h1h5+cYuomOY5oqdQShTH8Hagd0tjn+Ycalbvqpse3Ldsp3A/KEQWrpwa?=
 =?us-ascii?Q?KTywyne0gmermyG54cunosSFnjhHCK0O6mPOYCjcZ69d04Jx/ek3PAKT2rja?=
 =?us-ascii?Q?Ix3xia/kXN16R1lqyA6FccPdv67CBijGk7/NXnHDLlzKpSo14eD+AP2VGlku?=
 =?us-ascii?Q?8tMT2JCkV3f1UHVfIfP42PlGKhksTIhI36gHgYp1?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1293c556-1af7-42e3-5f9f-08dc3f81ea81
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:10:39.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iz/PIFz1k1NNmmPjmKqzh3QFeWSk8J0wyGqEIGNAWDsk/VRMmOfrWDav+yeyzZAipS/CvIzohETpd12a5TSEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2564
X-Proofpoint-GUID: UVxOVr4LBWA8DNzdRazAervhJYssCc7M
X-Proofpoint-ORIG-GUID: UVxOVr4LBWA8DNzdRazAervhJYssCc7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403080122

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add WoM (roc rising) event as accel x_or_y_or_z event for all
chips >= MPU-6500. This requires to create new MPU-6500 channels
as default and MPU-6050 channels for older chips.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 67 +++++++++++++++++++---
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index ad42be809f09..ddc905bb74d6 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1359,6 +1359,15 @@ static const struct iio_chan_spec_ext_info inv_ext_info[] = {
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
@@ -1394,7 +1403,17 @@ static const struct iio_chan_spec_ext_info inv_ext_info[] = {
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
@@ -1408,6 +1427,23 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
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
@@ -1887,6 +1923,12 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
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
@@ -1900,13 +1942,13 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
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
@@ -1915,9 +1957,18 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
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


