Return-Path: <linux-iio+bounces-5216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8668CD50D
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 15:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E541F236D0
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296AF14A62D;
	Thu, 23 May 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="XqWHUAeN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436751D52D
	for <linux-iio@vger.kernel.org>; Thu, 23 May 2024 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472402; cv=fail; b=XQmPPhMNl6pHIKeiun/TprRSUUf0WcTbR4WEPqxSU9tQlVWjl+YMAyhrCnee6uG8WWnpKxluE88EOGSH7ZiACYbEBO0CMM4UiuYvg89jkSu0rD1H/qOfvRjbTczLoHSnKRorI6o8ciaII5zS+haCWZd2Ij2uS7HYtHDF/X4YIs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472402; c=relaxed/simple;
	bh=77Oxg8PTDT2gOvP4k0Pb3+i7uyApH7niYSmJSTt1RzY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lt0Mo17rZ6Gv74mUE6UsHAoDA4WC1DqLqvMaamolHSVigjN7VH+/RSiTQicgVaaY7I8cTshQ0KqvyXGFEDcFh+lXBWQr1c11mmizl3CzvoOfBLalDniMcprWFOWdSSUSjyc0R6xKlonszehdxiiz0f//2iCLd3YpMKZcDjD9CzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=XqWHUAeN; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44N4u0UO011629;
	Thu, 23 May 2024 13:53:04 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2105.outbound.protection.outlook.com [104.47.23.105])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3y9y75gede-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 13:53:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+I8uioDLzNHatcu8G2BOa6b/sUhmAkzTMCax8ZJPNdEYMQ/kFHF9MZ6m/cs/4gRj3B/r9kGXvPp6kld8IWN+B+4hN//03c1xWJUBq0+1+QdppDB9nD5Sagrq2XDOPQJ9B1GnqrFnaZ3jfShHFjxjzI9DFQgGKqJWm2HhpswdEnDv5f6HzRm7v2yVL1H70wM3Mwoe4pUfHAAIMJjtbgi8ETsVTnrUQl7uuPjLk9xRbLYq/P0fR4sbbTGh41YPqDTWXM+D4UqKAzA66VO3l4PovaaH98sZsHzBktT2ZAW2iZMJpBawR8GS9KRBp0H+g88Vv+/GuqhFhNxEAXynKoocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JmjSoWTtJQrAAasudWj4jfO2XSeq64NlvyQ/TqhDMU=;
 b=VnOkZQN7OAZMtixTRXnyAzk+Ej/y5G7jF8G5KT3hzY1Bd1NBLOXHdKSej62lHUba2/ysbgA2qKkStYGFyGX5BYyf/omuKiuf8uMjhgd1LvGlYM1ljSDXMuP6kAnmRjtDui+5ie8zgnnVWX/litL0dAvpklMHMhDAFlnWGP9wMF8oFmPUDDUA7NsZ6WDDzRh+fC7PFjVDdtXECotvY3uRk6fSeXKjGwHFv02vi+dYi8kXNyg8c+YUJuBLCiFKWebd2hblV+l30sJZn7s1HwoL0UwKNRTqGgMPvZY2j8Rl8ecrIuvRiHGdjfFVAXl4enIXGxU6FXtyGlQYbM0PXJb8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JmjSoWTtJQrAAasudWj4jfO2XSeq64NlvyQ/TqhDMU=;
 b=XqWHUAeNlLrvbPVa4n0Wmmwm/zXVYvg13VGGym/TASAW5LssXi/Vx9TJRcmuRQUrYlycg/WNC8latZ4g82+7hnm7gYSmMEM52NkBY6dbUZF6GtUUPNuX4L+21XbhFpH2ulgmp+HNWgULXckn0ZxmAFsE8gyVAfyep1lqiCQ/yKracMg6ZN9sTz6+Vn4xAWSf67bRc4rUESRgXal9swqrFg7sFFT/HC5mV2qJ58YuRSom9cLKmWcLP1OBIzyn1m5drmguR/BrTJB1NnGEp4JUqO+rw1WHiMW/Vk0jv9lVNPWFrKzL/dBTHyyOPwWB2sGUywSixLgAXWXksXqSZbgV2A==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB2608.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 13:53:00 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 13:53:00 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH] iio: imu: inv_mpu6050: stabilized timestamping in interrupt
Date: Thu, 23 May 2024 13:52:45 +0000
Message-Id: <20240523135245.552999-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0061.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::12) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB2608:EE_
X-MS-Office365-Filtering-Correlation-Id: 057255ca-64f4-4c6f-34ba-08dc7b2fa765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005|3613699003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rzWQ0OjYr1E+83x8hjDsie8suPTUFoPg2Cs4B89oBqNDjfxIBPkZS0g4d/33?=
 =?us-ascii?Q?HYee7VrOJZtEpuADwcVSEoJLp2fdoqmKiYF4S179IPImKTJ5lc2T9hSnrp8c?=
 =?us-ascii?Q?GsYjgpcnOOwsgl724YhA2m6WbNZ5hQbycOsjTFVmnfKKrgms/EDhAcjuzn8m?=
 =?us-ascii?Q?h7JrAk748CkEAEjv0nGrhDho827FXCeUSliCR19S0nDS/RHImD3JydwsnIxA?=
 =?us-ascii?Q?B0mm6RFBYrbRwxX4bWS56dZcsGm/CaFvR0F4oDMDLBr9gpak8/tsCSRElC6P?=
 =?us-ascii?Q?BAfVU7tATeF4pNhN+opMyuprMuU6jQV+Lcgc0WMF5rSNVwPQmpQS79f7g1gc?=
 =?us-ascii?Q?F80pvd6QgP3/CSkmdi/0qb8HyegvocmiRYKoKPxsm/95fiEoXZVxaSBRK9Hi?=
 =?us-ascii?Q?FmykQjLjUZAQ8CcPUb70SD0iCVg1R/hgOSLGaMHRlbuEZnvK+urGNX5BMA4X?=
 =?us-ascii?Q?Q1swEOIzfye4ZP9emk5XVoqT8LWrp3oC42HPOP7zNNF2cLISoEzJ4pnEWUpw?=
 =?us-ascii?Q?1l57tKKqN2SVnlAVxbUsOtdPP1dgNwZuh5Usv0kv9MnSpjoYdWihBn4uGr0j?=
 =?us-ascii?Q?8J6vEf7Id+oDvuUjJGOhYm3+y37ZUqV2QFh3MuiXuHv/JSt6FNy9mrnV8ffO?=
 =?us-ascii?Q?mOt2CjD4UBjQ0aPbo7Pv2Yb7+PCZPyh76NqcU0YS5KfpNw2m4HhRn71rqpP6?=
 =?us-ascii?Q?Fryq3/9EoftTzD+w1m2J4uwTdmZalugYKLa10GyDwUn1eX+C6FcvFPGf77Ii?=
 =?us-ascii?Q?Zld3Nd/GZDrv3zHaiKte4jwUQCHiorfvbVxv7vBbJuftJqZ3faWowqYxpPRr?=
 =?us-ascii?Q?BL6Vh5q9QC1tv3taQ16uebQZktuDNafxlvcxU+mcypeqCtlsQmHk6RoXTWd9?=
 =?us-ascii?Q?gmZeizON/BeWZ/bF8xzN3nv8/Ib/pQTHK9GOHpOvqCLSimNNLZXvEP1+b2+x?=
 =?us-ascii?Q?uxIIR0AVwLK9nEkRmSmJSo+CEuym4D0avc/xY9qL0vEz6KLtJtXR6cbK4Wxn?=
 =?us-ascii?Q?DhBSjEpjwn0V1JZE7nxKxUEswSanjzA5sCd81+s6WD4psL2t7ALs0GzBlfJr?=
 =?us-ascii?Q?VFDJbpCNlfyJK7k9auxYNFAHW08ZeKSTEGq37VQdHcw+Txf7Z68z1ALJOUIy?=
 =?us-ascii?Q?ocQzxQepAui+OHoe6rt8j6yw7dpJhHtZt0C53FU/mvpDXTNvfn4Lp+sAtt0u?=
 =?us-ascii?Q?5YVL7M/UQY5Kdpj8EWl04BhXE+vZRzfWn/61WELznomn3LMmkJ63POFmH8x1?=
 =?us-ascii?Q?eBtmF5dsAUwb/IR3aQPc9eSq6cR2h8rrT45WKT7DD9IDE58Q4GNtVH4Xv2ZT?=
 =?us-ascii?Q?jel1fYvYBqK2FtBMWLfyMP1WiNESDDMzIIWQdjDKCZyuoGbWPjvHJqj2UTFs?=
 =?us-ascii?Q?9sFfja4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6DbXo8TFxjDAsfoEnVAf/WTSsqBZswwfpJKTWnOqAyMxJtlgBAF4Zu1u0UwM?=
 =?us-ascii?Q?Lu8Z6zCv2UagCTVbKAIppS3sIgcO8y3V2985shV75NqlUki0XlyloIEGWW8J?=
 =?us-ascii?Q?k5MA0fKsPS6+6fwlJ547vjsNSmtIAKn9ZYGo2ItzGM7L7aQs6tvuOrLY3OS2?=
 =?us-ascii?Q?Ju96Wl310brEdv0Upaf2kiHQQ2qVNW8W8Sort/MYDnUcVaPM3RWxF7nEA6DH?=
 =?us-ascii?Q?A4P+TU/zUo5Nk1/ft6kRvhWGIU1+z6MfxtiklE8Y5kJwGQcQAnnmR1EWtKlI?=
 =?us-ascii?Q?JgUszr7C5ecL7932NivGXHkcLXbX2VDHX7cFDeAAP+YQ1ENBBkQM8H7MetFi?=
 =?us-ascii?Q?9qyJJxpBTaKH5GLNllBkvi/FCexv2Tho2dg9y4qEHCmNcXbVeZgmhYikGXH6?=
 =?us-ascii?Q?SI9MLSz85M9jO2zZjIZJ6WQl2q7nrz9OcFyeDgOKpaRCuB8x9zYRTTuDbLuW?=
 =?us-ascii?Q?yPaQQgB4/Pj+BzQvEXJSsJzPinTslq9sL/poaMohjFvA1CbJ+0rYCl8gKeDh?=
 =?us-ascii?Q?sB+EjX1B7WLXvgVLUNyiDof1/tEnLO/FPZv08kXL2Fbps6GbZsJR+HFLO3qP?=
 =?us-ascii?Q?j8L6PYOc4NxG+jXWUCxd0izrGnZd74pI2dEO0knffZqQIfOkp2lSETam8tIQ?=
 =?us-ascii?Q?jiy/HPoXiiMmXZEbr2ZeSfwTzLpxVEga5GOkxBjXigbrbm/SZ+7qpMUERQ3Y?=
 =?us-ascii?Q?ib+9Nccmatz1Wfc0ouotO6mi0R9lIJ4DwRYdAEa7+yHBRVeVLk95pQbThCHV?=
 =?us-ascii?Q?tQzCB2CQngFJa/dQFDUT4oYclf3cecP5amaz/9J/hHUGjFVLCgqgt7cOUyav?=
 =?us-ascii?Q?ZobyM54I03amybzcODeuwzYqZ2D8eJ9k9UrjHNpe7VH77diyvQ5YJwKskxc4?=
 =?us-ascii?Q?ctOvf5J1TJDwqJIFD9+sxFtiT8+jmPZrxDz3L2CoeHzcCuZz4PhpcaOSmoD/?=
 =?us-ascii?Q?0Uk6tX0MBtlIRkCmZRYhXCXhPJVWMih1Kmryi/XUf/EyjiPFLXwFOLbUgfL2?=
 =?us-ascii?Q?z1KaCk/EjiqI0p5IS4qwEvwVxkz+jz67qsr84FhaHyTAnRFCi4x+1sAmQfVQ?=
 =?us-ascii?Q?au7UJBaeRvtg34jyAUy6ZAZ5cdsx8EiI9YAUuH2Gi6kZlU0t7I7Z+9A4dlgI?=
 =?us-ascii?Q?nM3wnhBeFq9K1ZNDCyzDbqU6pdfzL5EWVcYpuAVQHbSVG3ExFhFwJLBYi8Pg?=
 =?us-ascii?Q?+WV8VQ6caDnkRgRG3QQ+Iz/YuHXAwwuXpBhziu+/Zhfr7BDXp46h5Kbv3WiN?=
 =?us-ascii?Q?a1uY6ExEAwIbY9ozPS89ecAKKqTxL/B9hwgkjbOx90l3+1IozcNCK9XTKfWl?=
 =?us-ascii?Q?U0/KHikvvnTkJjn7SqvYvR3IOTcVC/4CxQStxAec8hbnC09cpjVvDdJQVGrQ?=
 =?us-ascii?Q?apWE5N3Lmigb9tFbEjvhvAaupUor3yyDoMeDahGfvynnQWV2ZyeGP9SDknwC?=
 =?us-ascii?Q?ndt56Msr8Ew0Qr+ufed1VMJbsLfm5EHPEUMyYjW6QEkMrjxVQEFK3VJe7jcO?=
 =?us-ascii?Q?frE7pjri3l+6rMpld7y+ecNep5oCARZHNAbKPo+Y6M6sdr3fr1kSPtVV4PTs?=
 =?us-ascii?Q?iTZKbYuNjXPfyDRGwdSAIzBLaVbdDZOc+ZN/lNGA?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057255ca-64f4-4c6f-34ba-08dc7b2fa765
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 13:52:58.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaFVaJHxubawVv0T4QmV4ZgqwwbtrhcC1CV/hVzv9tdLp7woCAKsURBopw9xAdof3RtJiRa+6LBNQRtk/6fYjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2608
X-Proofpoint-GUID: P8Sj4zZx_tt4IaZJ0252lG2Cft5e6Rpc
X-Proofpoint-ORIG-GUID: P8Sj4zZx_tt4IaZJ0252lG2Cft5e6Rpc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_08,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=882 clxscore=1015
 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405230095

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Use IRQ ONESHOT flag to ensure the timestamp is not updated in the
hard handler during the thread handler. And use a fixed value of 1
sample that correspond to this first timestamp.

This way we can ensure the timestamp is always corresponding to the
value used by the timestamping mechanism. Otherwise, it is possible
that between FIFO count read and FIFO processing the timestamp is
overwritten in the hard handler.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 0dc0f22a5582..3d3b27f28c9d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -100,8 +100,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		goto end_session;
 	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
 	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
-	inv_sensors_timestamp_interrupt(&st->timestamp, nb, pf->timestamp);
-	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb, 0);
+	inv_sensors_timestamp_interrupt(&st->timestamp, 1, pf->timestamp);
+	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, 1, 0);
 
 	/* clear internal data buffer for avoiding kernel data leak */
 	memset(data, 0, sizeof(data));
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 1b603567ccc8..84273660ca2e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -300,6 +300,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
 	if (!st->trig)
 		return -ENOMEM;
 
+	irq_type |= IRQF_ONESHOT;
 	ret = devm_request_threaded_irq(&indio_dev->dev, st->irq,
 					&inv_mpu6050_interrupt_timestamp,
 					&inv_mpu6050_interrupt_handle,
-- 
2.34.1


