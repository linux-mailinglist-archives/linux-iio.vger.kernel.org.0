Return-Path: <linux-iio+bounces-3459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE5D878499
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 17:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D23C1F2240D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E05047F63;
	Mon, 11 Mar 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="dISzDTsx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB18E44393
	for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173205; cv=fail; b=ekv+10YQnlbavnwXrUzpm4EJoR67trIUyuzRtxK4XlK8YolF8GvtD6xMoVlC4lXyfveVu7a2/u4cFPbXKfEUTkf3MKg8WQUos0HA3T7aXC1dUxhjTKMZW3A3bsmGQu4eUUrj7TReA8z4Glyzr8GHevf6UwIgwfhaLnqIXzAMONo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173205; c=relaxed/simple;
	bh=HufJo69z3Gd8MxXIIqo6Fr2nU3CWDDyoh1oHAutNQC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YffbU73KP9WhxaTTvSzd8J1sBpDALfHBtMnrglaNPIYnTS1tveYF/Zwl7h666u7DpduX+E/qZj+x79hDmiun3/PSgkd3txZgV6wglPqt3j9ccT43u362pYcV2YJZXcKxxxKhiU3iRfC+12S4IXpeqYUfqkR25TDGKp6Pz19sEpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=dISzDTsx; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B9oV0j032277;
	Mon, 11 Mar 2024 16:06:16 GMT
Received: from os0p286cu010.outbound.protection.outlook.com (mail-japanwestazlp17010000.outbound.protection.outlook.com [40.93.130.0])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wrh4j19vn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 16:06:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acFFxFmD/49DoaUIJvaBv/LjM4jAVzTtBGOVI5dCTXn/g0NtwpvvDTvQtPYckF9HTMKNOHe3CBzkqka2LG7dUtFE04UYfkpGe23XiitKwVg1pZMZqSo2hmC7q9E5xpMktm/P1JtPg7ltQ9r0YCaECrLgYRCSrnNGhOXC80F2uSkGXfGKBQG6nebuL+NEW7CfUTtOJu8xSyYcTGchuHlNpPfbCkUfm/EvdcJH4NyB1sSYb7k3/4lh1xUJz4Z+1KDSgMGSd5MvL6JYLrNqnGiSO7/fYgEg+JuYDqBzXQJJuTcXVZByMifmI7lj0DWyVmraaYV3Xg9s1NdBhCHhB1dayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaEpqtIKDkQji52A9iLbEEAVwnjKr3Ezo1vWr3/CiQY=;
 b=kggzU+5Hrskqg2q7LJZrC+35u5cMj8T+EmT6nb6tz1uoJI0jTLW6/pECSoVKaUBTAzrNEDThDDxsAMVqSi4UXKsNZM7cDv8m5veIIwEAf51f+ahxlAnDoirSVJNt8EqDGD+TUDXgMVivtiYbNk0FD/Ui0cktGRuXc/7RzhAUCQFjcirh1nDi1JLrdaHVwXHfsCGcay83Yjv00QHx2InuCyfOKPgMNt/xzXdHcyAvKPN0DTjK/EieOCaLSwnrED2FLF2/CPg/SNF/25R9pPwV2XvPyuElmDryHYvOyZiMgOZRSxnbf3NbcbxQFsGBXElNzF436jAaN5BBVln12dWeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaEpqtIKDkQji52A9iLbEEAVwnjKr3Ezo1vWr3/CiQY=;
 b=dISzDTsxDq6bxFDg1l/rOIPOLs+oSECuY26KQ7qvZuqsIMXhpQ+Tmg/9F9uilDU3vP5QkkFXXcj/z/z0567FjumYMV69J1DNFPt0UIoBNZjunFk4f8SzobDbRy++RobzPWc1NPi7nde0d2WO6HEL2Og0EQUAfEQkhZNCVEeRX1ATqqwlLLQeqLfWT+XeCiPTkqU9Bzjz1niihYgexRx1+KdEmzRf8JqqryDnpMMhB+gO5vYJ7KmrUXGCMyK3332xK2BeDR0pcPwec9/zZWsEjpzDEgaX8IIm5QK5zq7o0IVOnyhgGwGNhJhlpId4hbK9pu53iGvRff8Vd4Y1SxdSdw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB1961.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:06:12 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%5]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 16:06:12 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v3 1/4] iio: imu: inv_mpu6050: add WoM (Wake-on-Motion) sensor
Date: Mon, 11 Mar 2024 16:05:54 +0000
Message-Id: <20240311160557.437337-2-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311160557.437337-1-inv.git-commit@tdk.com>
References: <20240311160557.437337-1-inv.git-commit@tdk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-MS-Office365-Filtering-Correlation-Id: 1209070c-029f-47e7-5dfd-08dc41e52c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DCp7NgbiQid5H+T4FO2ohIB404NQ5uzy8OCzH9lwlcHfud6ChFFZmWYsRLBfXEGavCbSo3MXRid4No4dLFiv8HDhda6ZYbAGvuDSGPW8P3p9II8wxcPEmQcebzDXB18ED/hlK7SA4/KR5g8NHdaiDYBSj157aZaOBxrSw7RBu87tKCZGYOePgExS3ju8Rw/V8FP02VI0iCB932BEHLgKevaJuLwocEryPJb9j0zGYXS/zapIo2BDgAel/bO/TepSU71vm7+AELbP9IDHXhv+NFmaoS+S2kwm//jw0aeBQEeY46InAZH6ensb7UKUy0KBFGypDGYxdE7q9z5RcnFDmxbduL6/z8e7v7g2Xsi2xFMU1+0pYlNiblR8obFahFwqZQgQPdPYWYw74AadRxRhnHyZBWwqwJHv+2i9HErwcsyLPMIsOMoXMz8MgsNLh5ls5yv544qoB7clV04xF7y2bOUSngHtY1lBGrW5wvzXDVSEupFF7gJDFeC/+Up+scXJ7xzWpO4z++Ct2nDVSBbKCQpSUib+efrQFlG0b0vcxDNqem5QM8U3h8YWTcFioJZAtJo+0DqCVmHIhL+KKXuklKpS44n6QPw6bZCQ948nY+62FvPhMq4g8YKO0MwvCNg8Tgdbs1hWiuayp9Xo9n3ZYaqBSfkZHgdnpK7AvcoxDYi0+OKtGXVGQi97LMW2S7OD5jp9cd/j9ytRfcdF1lEDbouP7r4OfVuQr51LPE0OWf851VNn/v7yM8qNEikCWtaR
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(3613699003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0ZvSWcvdy9OS3lBS09sYXpqM1dReWFodFN2Q0JNUnNUNkYzbGxncUVDMk44?=
 =?utf-8?B?cTczRkNaUW9HZzBJbVJaUEc4MFgyb3RDMzRzVytxbDZ0ajdnNE1rN0wyc3ZG?=
 =?utf-8?B?a2hJaDdKSXlkcCtyd0Z5M052MWZmZlFBenJNQ2R3WHB5NmxHQ0hIRmY5a0pL?=
 =?utf-8?B?aytEcFdmZDdncnBuOW0xTmVkYlNvUG1XcWxhN28ydFQ5YjBFTUFVSk4zTEUx?=
 =?utf-8?B?WW8yZDRoMy9pemNHNHJjOFRmeVpoYXRUbFllT2FUa2p4MVpUQzBtVzhJcFht?=
 =?utf-8?B?VjNFQ3dCcDgxZ042SXpES1Y1dm1MN3NPQUFwbm80L1NqNGZ2OGhFQnNyb1pm?=
 =?utf-8?B?MjRLYjdTanR4N1huaVpqcXJFWmNUS2x1NWVxSmIxNUlvS3pqUlNId1BXbkNX?=
 =?utf-8?B?blFGRmpyWUpCU0h0UTBCNlZ5RU4xZXFHSXl1cEdIam5ScjJvNERDckhkajVL?=
 =?utf-8?B?Qm1Kb1h1Z2FlT3owbm81QmptVEczQ2oveWxUV1B0eEJvZnBXUk1jOWZPblVt?=
 =?utf-8?B?cSt5U3M0NG9tY1daRU8yMDVBNVM5YTZEMFI3RWlLQnFKc2VvenRtRGlGRjRY?=
 =?utf-8?B?SytpWDJkbC9oYmRBdmlmenJnODB0Q1pGakxEeDNWN1k0M2xzZk55V3d5YXNk?=
 =?utf-8?B?MDFScGlwTzFibWpnd3JtaEl3YktOQWFGR1lkNkFZU3VDYnpjMkNWRnZhYU1j?=
 =?utf-8?B?QTBiSDU4WlE4NlZ1Zkw5WlhyUTFZQ1BwOTNGbzl1aXBaOGVMeW5vWGVLSm84?=
 =?utf-8?B?d1FhZmtyV2FHeXpsWUlEM1RZbmx0YUMyeHRYb294YmptYWlQZXpqTVFPcFVi?=
 =?utf-8?B?YnNYUzBnR0dxR2NBODJUNmViK1k5eTVKdmczTjFyWW9BcU1pWnBOZng1RmY2?=
 =?utf-8?B?WitGaE9yVDVkejZRNU40Z3NOdGQrdUVobTc3Z1pHZnRNOWJQcDBCZE9CbHho?=
 =?utf-8?B?dlFudzg5ejNDMWl6dzRxYXVxVFdkRVBYV0xXODhPcjNnY1dDWWlrSGQvay9v?=
 =?utf-8?B?VnRLYTA4eUNSWm1MdndRQitIL1phUjEzVHZCUnAvVDFIUFFPN0xxS3c4ZTJs?=
 =?utf-8?B?Q3pWdWJhS0FsRGhvZHNCdzh4N1ZwZmpaVTM0Vm8zNUZWak9RKzJoV2Jnbmlp?=
 =?utf-8?B?d0s5b0NqeXlZczQ2UFlDZDgyTVpvL3laeVR0UmN2Y3M3MHg3Mmh2TDFTbCsx?=
 =?utf-8?B?MVB0VVltTWVCd25CeXN0dzFQSWZhYkc3NU1kZUtDcFI2QlMrcC9RY21ydWZ6?=
 =?utf-8?B?WFE1TmlEeW0xYmROYkRnVzVOVFpXeVRoSGVVZFI5YnlsNksxdDRqMlFZWklj?=
 =?utf-8?B?bzBWRmdLL0xzb3VhRlZpdFBMRUJjTUc5TlJTN2d6VW9hbjV5eHNvSUpaUllW?=
 =?utf-8?B?S0xEVk1QQnJpTUFGZmxMUmNrRmh0TldSVnpQRnkyTUtvMmtObTFNU3dzbEJy?=
 =?utf-8?B?ajcwazNQQkxNaWhpeno3ZW9YVStUUXFndlV3MFd4MDRqQUpVL0JXY0MwUmRj?=
 =?utf-8?B?d2xLTklBZmp5S1M2M0lpVlpCL3MvU0JPOEEzVTJpRmtZZTRoR2toVW4wUUpD?=
 =?utf-8?B?QmpXamJKUmhhK25weEpLVEFscUhEd0h2NjhuU0l5M3RuNVhocjMzSWxqZTVj?=
 =?utf-8?B?Q1U1NDFlVmxLbjFBaEpueGx0WVZ6bzdRd0NrTU81ek5QOGJ0a1o5K0pnaVp0?=
 =?utf-8?B?L3N5clZFZFpFVWZqc0JNclA1eUVteG9WVC9OVGhYZVh2Mk01NUdybWxWNkFD?=
 =?utf-8?B?MnV1UzllQVA2cFBlbmRYeXkyMHNUanZmSy9lNWRDWVJBajNPb0lHV0R3MlVE?=
 =?utf-8?B?QnNncmI1TjIrQ2hNQkx6UUIxTUtDYWJZL2l0TDYzNFErdW93VXlNTWVSclNv?=
 =?utf-8?B?ZzE5RjAxRUhjbU1UdGptWUVJUk5hYnkyMkI4Y2cvNkgwbWpSTmNsWnYxSU9W?=
 =?utf-8?B?SVp4dGNrZzl0OGR3VFpiSkYvUjh1cUtKMXZsdXZNSXZnTnZZU0FnK2o5YWpv?=
 =?utf-8?B?NVhjeXR6YW51S2dtVERVZ2YrQkF5a0NQemg4VzBzUzlvZ1VOR01tc0Nualow?=
 =?utf-8?B?MDdjbDNnRUxPMGNKU0pQWUYxN0JaRTNBR1BCWnU4K2ZFQ1MweTErUDBGTEV0?=
 =?utf-8?Q?vxhA5jCDHVDChUTkJOmCMfhrz?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1209070c-029f-47e7-5dfd-08dc41e52c1e
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:06:12.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoyC8o0lEWrXEK4lS0fnooPU9nMnJ+rBdQC09QhjY4/+6TMnUSH9VSACAm7s8qTjz2KHx/u5dmEll7xnk7GWMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1961
X-Proofpoint-ORIG-GUID: VRAaeq7EZzQFp6BfItzkPq0bPMvV0hLm
X-Proofpoint-GUID: VRAaeq7EZzQFp6BfItzkPq0bPMvV0hLm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403110122

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

WoM is a threshold test on accel value comparing actual sample with
previous one. It maps best to roc rising event.

Add support of a new WOM sensor and functions for handling the associated
roc_rising event. The event value is in SI units. Ensure WOM is stopped and
restarted at suspend-resume, handle usage with buffer data ready interrupt,
and handle change in sampling rate impacting already set roc value.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 282 +++++++++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  20 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |   6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  14 +-
 4 files changed, 309 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 0e94e5335e93..d49c0ac91a59 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -15,6 +15,8 @@
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -332,7 +334,7 @@ static int inv_mpu6050_clock_switch(struct inv_mpu6050_state *st,
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
 			      unsigned int mask)
 {
-	unsigned int sleep;
+	unsigned int sleep, val;
 	u8 pwr_mgmt2, user_ctrl;
 	int ret;
 
@@ -345,6 +347,14 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
 		mask &= ~INV_MPU6050_SENSOR_TEMP;
 	if (mask & INV_MPU6050_SENSOR_MAGN && en == st->chip_config.magn_en)
 		mask &= ~INV_MPU6050_SENSOR_MAGN;
+	if (mask & INV_MPU6050_SENSOR_WOM && en == st->chip_config.wom_en)
+		mask &= ~INV_MPU6050_SENSOR_WOM;
+
+	/* force accel on if WoM is on and not going off */
+	if (!en && (mask & INV_MPU6050_SENSOR_ACCL) && st->chip_config.wom_en &&
+			!(mask & INV_MPU6050_SENSOR_WOM))
+		mask &= ~INV_MPU6050_SENSOR_ACCL;
+
 	if (mask == 0)
 		return 0;
 
@@ -439,6 +449,16 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
 		}
 	}
 
+	/* enable/disable accel intelligence control */
+	if (mask & INV_MPU6050_SENSOR_WOM) {
+		val = en ? INV_MPU6500_BIT_ACCEL_INTEL_EN |
+			   INV_MPU6500_BIT_ACCEL_INTEL_MODE : 0;
+		ret = regmap_write(st->map, INV_MPU6500_REG_ACCEL_INTEL_CTRL, val);
+		if (ret)
+			return ret;
+		st->chip_config.wom_en = en;
+	}
+
 	return 0;
 }
 
@@ -893,6 +913,239 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 	return result;
 }
 
+static u64 inv_mpu6050_convert_wom_to_roc(unsigned int threshold, unsigned int freq_div)
+{
+	/* 4mg per LSB converted in m/s² in micro (1000000) */
+	const unsigned int convert = 4U * 9807U;
+	u64 value;
+
+	value = threshold * convert;
+
+	/* compute the differential by multiplying by the frequency */
+	return div_u64(value * INV_MPU6050_INTERNAL_FREQ_HZ, freq_div);
+}
+
+static unsigned int inv_mpu6050_convert_roc_to_wom(u64 roc, unsigned int freq_div)
+{
+	/* 4mg per LSB converted in m/s² in micro (1000000) */
+	const unsigned int convert = 4U * 9807U;
+	u64 value;
+
+	/* return 0 only if roc is 0 */
+	if (roc == 0)
+		return 0;
+
+	value = div_u64(roc * freq_div, convert * INV_MPU6050_INTERNAL_FREQ_HZ);
+
+	/* limit value to 8 bits and prevent 0 */
+	return min(255, max(1, value));
+}
+
+static int inv_mpu6050_set_wom_int(struct inv_mpu6050_state *st, bool on)
+{
+	unsigned int reg_val, val;
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
+		reg_val = INV_MPU6500_BIT_WOM_INT_EN;
+		break;
+	default:
+		reg_val = INV_ICM20608_BIT_WOM_INT_EN;
+		break;
+	}
+
+	val = on ? reg_val : 0;
+
+	return regmap_update_bits(st->map, st->reg->int_enable, reg_val, val);
+}
+
+static int inv_mpu6050_set_wom_threshold(struct inv_mpu6050_state *st, u64 value,
+					 unsigned int freq_div)
+{
+	unsigned int threshold;
+	int result;
+
+	/* convert roc to wom threshold and convert back to handle clipping */
+	threshold = inv_mpu6050_convert_roc_to_wom(value, freq_div);
+	value = inv_mpu6050_convert_wom_to_roc(threshold, freq_div);
+
+	dev_dbg(regmap_get_device(st->map), "wom_threshold: 0x%x\n", threshold);
+
+	switch (st->chip_type) {
+	case INV_ICM20609:
+	case INV_ICM20689:
+	case INV_ICM20600:
+	case INV_ICM20602:
+	case INV_ICM20690:
+		st->data[0] = threshold;
+		st->data[1] = threshold;
+		st->data[2] = threshold;
+		result = regmap_bulk_write(st->map, INV_ICM20609_REG_ACCEL_WOM_X_THR,
+					   st->data, 3);
+		break;
+	default:
+		result = regmap_write(st->map, INV_MPU6500_REG_WOM_THRESHOLD, threshold);
+		break;
+	}
+	if (result)
+		return result;
+
+	st->chip_config.roc_threshold = value;
+
+	return 0;
+}
+
+static int inv_mpu6050_enable_wom(struct inv_mpu6050_state *st, bool en)
+{
+	struct device *pdev = regmap_get_device(st->map);
+	unsigned int mask;
+	int result;
+
+	if (en) {
+		result = pm_runtime_resume_and_get(pdev);
+		if (result)
+			return result;
+
+		mask = INV_MPU6050_SENSOR_ACCL | INV_MPU6050_SENSOR_WOM;
+		result = inv_mpu6050_switch_engine(st, true, mask);
+		if (result)
+			goto error_suspend;
+
+		result = inv_mpu6050_set_wom_int(st, true);
+		if (result)
+			goto error_suspend;
+	} else {
+		result = inv_mpu6050_set_wom_int(st, false);
+		if (result)
+			dev_err(pdev, "error %d disabling WoM interrupt bit", result);
+
+		/* disable only WoM and let accel be disabled by autosuspend */
+		result = inv_mpu6050_switch_engine(st, false, INV_MPU6050_SENSOR_WOM);
+		if (result) {
+			dev_err(pdev, "error %d disabling WoM force off", result);
+			/* force WoM off */
+			st->chip_config.wom_en = false;
+		}
+
+		pm_runtime_mark_last_busy(pdev);
+		pm_runtime_put_autosuspend(pdev);
+	}
+
+	return result;
+
+error_suspend:
+	pm_runtime_mark_last_busy(pdev);
+	pm_runtime_put_autosuspend(pdev);
+	return result;
+}
+
+static int inv_mpu6050_read_event_config(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+
+	/* support only WoM (accel roc rising) event */
+	if (chan->type != IIO_ACCEL || type != IIO_EV_TYPE_ROC ||
+	    dir != IIO_EV_DIR_RISING)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	return st->chip_config.wom_en ? 1 : 0;
+}
+
+static int inv_mpu6050_write_event_config(struct iio_dev *indio_dev,
+					  const struct iio_chan_spec *chan,
+					  enum iio_event_type type,
+					  enum iio_event_direction dir,
+					  int state)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	int enable;
+
+	/* support only WoM (accel roc rising) event */
+	if (chan->type != IIO_ACCEL || type != IIO_EV_TYPE_ROC ||
+	    dir != IIO_EV_DIR_RISING)
+		return -EINVAL;
+
+	enable = !!state;
+
+	guard(mutex)(&st->lock);
+
+	if (st->chip_config.wom_en == enable)
+		return 0;
+
+	return inv_mpu6050_enable_wom(st, enable);
+}
+
+static int inv_mpu6050_read_event_value(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir,
+					enum iio_event_info info,
+					int *val, int *val2)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	u32 rem;
+
+	/* support only WoM (accel roc rising) event value */
+	if (chan->type != IIO_ACCEL || type != IIO_EV_TYPE_ROC ||
+	    dir != IIO_EV_DIR_RISING || info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	/* return value in micro */
+	*val = div_u64_rem(st->chip_config.roc_threshold, 1000000U, &rem);
+	*val2 = rem;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_mpu6050_write_event_value(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir,
+					 enum iio_event_info info,
+					 int val, int val2)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct device *pdev = regmap_get_device(st->map);
+	u64 value;
+	int result;
+
+	/* support only WoM (accel roc rising) event value */
+	if (chan->type != IIO_ACCEL || type != IIO_EV_TYPE_ROC ||
+	    dir != IIO_EV_DIR_RISING || info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	result = pm_runtime_resume_and_get(pdev);
+	if (result)
+		return result;
+
+	value = (u64)val * 1000000ULL + (u64)val2;
+	result = inv_mpu6050_set_wom_threshold(st, value, INV_MPU6050_FREQ_DIVIDER(st));
+
+	pm_runtime_mark_last_busy(pdev);
+	pm_runtime_put_autosuspend(pdev);
+
+	return result;
+}
+
 /*
  *  inv_mpu6050_set_lpf() - set low pass filer based on fifo rate.
  *
@@ -989,6 +1242,12 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	if (result)
 		goto fifo_rate_fail_power_off;
 
+	/* update wom threshold since roc is dependent on sampling frequency */
+	result = inv_mpu6050_set_wom_threshold(st, st->chip_config.roc_threshold,
+					       INV_MPU6050_FREQ_DIVIDER(st));
+	if (result)
+		goto fifo_rate_fail_power_off;
+
 	pm_runtime_mark_last_busy(pdev);
 fifo_rate_fail_power_off:
 	pm_runtime_put_autosuspend(pdev);
@@ -1326,6 +1585,10 @@ static const struct iio_info mpu_info = {
 	.write_raw = &inv_mpu6050_write_raw,
 	.write_raw_get_fmt = &inv_write_raw_get_fmt,
 	.attrs = &inv_attribute_group,
+	.read_event_config = inv_mpu6050_read_event_config,
+	.write_event_config = inv_mpu6050_write_event_config,
+	.read_event_value = inv_mpu6050_read_event_value,
+	.write_event_value = inv_mpu6050_write_event_value,
 	.validate_trigger = inv_mpu6050_validate_trigger,
 	.debugfs_reg_access = &inv_mpu6050_reg_access,
 };
@@ -1706,6 +1969,12 @@ static int inv_mpu_resume(struct device *dev)
 	if (result)
 		goto out_unlock;
 
+	if (st->chip_config.wom_en) {
+		result = inv_mpu6050_set_wom_int(st, true);
+		if (result)
+			goto out_unlock;
+	}
+
 	if (iio_buffer_enabled(indio_dev))
 		result = inv_mpu6050_prepare_fifo(st, true);
 
@@ -1735,6 +2004,12 @@ static int inv_mpu_suspend(struct device *dev)
 			goto out_unlock;
 	}
 
+	if (st->chip_config.wom_en) {
+		result = inv_mpu6050_set_wom_int(st, false);
+		if (result)
+			goto out_unlock;
+	}
+
 	if (st->chip_config.accl_en)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_ACCL;
 	if (st->chip_config.gyro_en)
@@ -1743,6 +2018,8 @@ static int inv_mpu_suspend(struct device *dev)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_TEMP;
 	if (st->chip_config.magn_en)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_MAGN;
+	if (st->chip_config.wom_en)
+		st->suspended_sensors |= INV_MPU6050_SENSOR_WOM;
 	result = inv_mpu6050_switch_engine(st, false, st->suspended_sensors);
 	if (result)
 		goto out_unlock;
@@ -1767,7 +2044,8 @@ static int inv_mpu_runtime_suspend(struct device *dev)
 	mutex_lock(&st->lock);
 
 	sensors = INV_MPU6050_SENSOR_ACCL | INV_MPU6050_SENSOR_GYRO |
-			INV_MPU6050_SENSOR_TEMP | INV_MPU6050_SENSOR_MAGN;
+			INV_MPU6050_SENSOR_TEMP | INV_MPU6050_SENSOR_MAGN |
+			INV_MPU6050_SENSOR_WOM;
 	ret = inv_mpu6050_switch_engine(st, false, sensors);
 	if (ret)
 		goto out_unlock;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 5950e2419ebb..d5b0465d1f74 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -88,11 +88,12 @@ enum inv_devices {
 	INV_NUM_PARTS
 };
 
-/* chip sensors mask: accelerometer, gyroscope, temperature, magnetometer */
+/* chip sensors mask: accelerometer, gyroscope, temperature, magnetometer, WoM */
 #define INV_MPU6050_SENSOR_ACCL		BIT(0)
 #define INV_MPU6050_SENSOR_GYRO		BIT(1)
 #define INV_MPU6050_SENSOR_TEMP		BIT(2)
 #define INV_MPU6050_SENSOR_MAGN		BIT(3)
+#define INV_MPU6050_SENSOR_WOM		BIT(4)
 
 /**
  *  struct inv_mpu6050_chip_config - Cached chip configuration data.
@@ -104,11 +105,13 @@ enum inv_devices {
  *  @gyro_en:		gyro engine enabled
  *  @temp_en:		temperature sensor enabled
  *  @magn_en:		magn engine (i2c master) enabled
+ *  @wom_en:		Wake-on-Motion enabled
  *  @accl_fifo_enable:	enable accel data output
  *  @gyro_fifo_enable:	enable gyro data output
  *  @temp_fifo_enable:	enable temp data output
  *  @magn_fifo_enable:	enable magn data output
  *  @divider:		chip sample rate divider (sample rate divider - 1)
+ *  @roc_threshold:	save ROC threshold (WoM) set value
  */
 struct inv_mpu6050_chip_config {
 	unsigned int clk:3;
@@ -119,12 +122,14 @@ struct inv_mpu6050_chip_config {
 	unsigned int gyro_en:1;
 	unsigned int temp_en:1;
 	unsigned int magn_en:1;
+	unsigned int wom_en:1;
 	unsigned int accl_fifo_enable:1;
 	unsigned int gyro_fifo_enable:1;
 	unsigned int temp_fifo_enable:1;
 	unsigned int magn_fifo_enable:1;
 	u8 divider;
 	u8 user_ctrl;
+	u64 roc_threshold;
 };
 
 /*
@@ -256,12 +261,16 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_REG_INT_ENABLE          0x38
 #define INV_MPU6050_BIT_DATA_RDY_EN         0x01
 #define INV_MPU6050_BIT_DMP_INT_EN          0x02
+#define INV_MPU6500_BIT_WOM_INT_EN          BIT(6)
+#define INV_ICM20608_BIT_WOM_INT_EN         GENMASK(7, 5)
 
 #define INV_MPU6050_REG_RAW_ACCEL           0x3B
 #define INV_MPU6050_REG_TEMPERATURE         0x41
 #define INV_MPU6050_REG_RAW_GYRO            0x43
 
 #define INV_MPU6050_REG_INT_STATUS          0x3A
+#define INV_MPU6500_BIT_WOM_INT             BIT(6)
+#define INV_ICM20608_BIT_WOM_INT            GENMASK(7, 5)
 #define INV_MPU6050_BIT_FIFO_OVERFLOW_INT   0x10
 #define INV_MPU6050_BIT_RAW_DATA_RDY_INT    0x01
 
@@ -301,6 +310,11 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_BIT_PWR_ACCL_STBY       0x38
 #define INV_MPU6050_BIT_PWR_GYRO_STBY       0x07
 
+/* ICM20609 registers */
+#define INV_ICM20609_REG_ACCEL_WOM_X_THR    0x20
+#define INV_ICM20609_REG_ACCEL_WOM_Y_THR    0x21
+#define INV_ICM20609_REG_ACCEL_WOM_Z_THR    0x22
+
 /* ICM20602 register */
 #define INV_ICM20602_REG_I2C_IF             0x70
 #define INV_ICM20602_BIT_I2C_IF_DIS         0x40
@@ -320,6 +334,10 @@ struct inv_mpu6050_state {
 /* mpu6500 registers */
 #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
 #define INV_ICM20689_BITS_FIFO_SIZE_MAX     0xC0
+#define INV_MPU6500_REG_WOM_THRESHOLD       0x1F
+#define INV_MPU6500_REG_ACCEL_INTEL_CTRL    0x69
+#define INV_MPU6500_BIT_ACCEL_INTEL_EN      BIT(7)
+#define INV_MPU6500_BIT_ACCEL_INTEL_MODE    BIT(6)
 #define INV_MPU6500_REG_ACCEL_OFFSET        0x77
 
 /* delay time in milliseconds */
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 66d4ba088e70..13da6f523ca2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -33,10 +33,8 @@ static int inv_reset_fifo(struct iio_dev *indio_dev)
 
 reset_fifo_fail:
 	dev_err(regmap_get_device(st->map), "reset fifo failed %d\n", result);
-	result = regmap_write(st->map, st->reg->int_enable,
-			      INV_MPU6050_BIT_DATA_RDY_EN);
-
-	return result;
+	return regmap_update_bits(st->map, st->reg->int_enable,
+			INV_MPU6050_BIT_DATA_RDY_EN, INV_MPU6050_BIT_DATA_RDY_EN);
 }
 
 /*
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 676704f9151f..ec2398a87f45 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -134,11 +134,13 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
 		ret = regmap_write(st->map, st->reg->user_ctrl, d);
 		if (ret)
 			return ret;
-		/* enable interrupt */
-		ret = regmap_write(st->map, st->reg->int_enable,
-				   INV_MPU6050_BIT_DATA_RDY_EN);
+		/* enable data interrupt */
+		ret = regmap_update_bits(st->map, st->reg->int_enable,
+				INV_MPU6050_BIT_DATA_RDY_EN, INV_MPU6050_BIT_DATA_RDY_EN);
 	} else {
-		ret = regmap_write(st->map, st->reg->int_enable, 0);
+		/* disable data interrupt */
+		ret = regmap_update_bits(st->map, st->reg->int_enable,
+				INV_MPU6050_BIT_DATA_RDY_EN, 0);
 		if (ret)
 			return ret;
 		ret = regmap_write(st->map, st->reg->fifo_en, 0);
@@ -171,9 +173,9 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 			return result;
 		/*
 		 * In case autosuspend didn't trigger, turn off first not
-		 * required sensors.
+		 * required sensors excepted WoM
 		 */
-		result = inv_mpu6050_switch_engine(st, false, ~scan);
+		result = inv_mpu6050_switch_engine(st, false, ~scan & ~INV_MPU6050_SENSOR_WOM);
 		if (result)
 			goto error_power_off;
 		result = inv_mpu6050_switch_engine(st, true, scan);
-- 
2.34.1


