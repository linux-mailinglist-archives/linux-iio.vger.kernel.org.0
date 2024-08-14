Return-Path: <linux-iio+bounces-8466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F1B951D70
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 16:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B9B1F2203E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 14:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD481B3F16;
	Wed, 14 Aug 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="MVl08go8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A21B373A;
	Wed, 14 Aug 2024 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646295; cv=fail; b=jkoPwfsfeRn188MXJ3JJ5wFiPsBt+tQTrCcRtwL4uM7GpUwB5SWKB8VNb7d73FXGgYwlfdXu9f6PqxIlW6MSZNnk7zPUd7H93eWIzP4rHPOEeashWn9Z8sLsTFr4rLveO8BO8eYi71w8MXK96BXX1E0QsvK7kP8QF/NYeQjCwBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646295; c=relaxed/simple;
	bh=ITGXqWzz2ZoDo1UJnHd12kV8DTdq0oFvsribj07jJd8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k0ZH0GDKHlt8sA2iDSVCcuCKvb8g7I0fbkO71F4cKohhkjgNSGd/cWBQkmQpKGOBC+VYrFSWdTlqw5PoepmSGroda1OKx4WYBxkMEKzxUIpwNd0vrUYZKmg9bvhajAygUcOZ0L89crZh9guS7PkBw0Mqvn1YGADQEG7wpDoJp9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=MVl08go8; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DNP1ti018710;
	Wed, 14 Aug 2024 14:37:56 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17011024.outbound.protection.outlook.com [40.93.73.24])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 40x16yjje7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 14:37:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pd7SertyJCGh4r/kyNqu6zJzDrv9yEkOuVc7grsqQtKQHPY0NLreoeIeldTGK7Nw1EHDS3g7KbFONvTZ1kGXQW1JP+i0OrFPWQNP+cFXZAdReJyyXe1t8Zw0a3/qFxjSOlaLtDLCp7kHQim0VQCIOr8YKkLvcgQkMPh3gN4cwDJ0730uCMYRKPSDaukHjnyU/1178LnR4/FcmvkpheSBPmi5mNGqwkkJM1YUjrXqqBz7K9mcq/UCeioAyBnih8FWrNrI061ZGK3ahm1XVFd6LczVD/i+oD9B+IpXdJN33j1rpVp+EA0nF6lKUFJ7cYU+HsB4V64kOX3NU+caS0+QDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZI88vzL1ncIfGFTBb2f4+KDWBlIJef3INa4xIHKTKNE=;
 b=OESMX3+74GdZeu0Soer5X9Urzor1BeVbQcd0dbHM8E5w+VW4G2JFeme5bRBL6n9P6cNDFb4Yqw83OFThdJVOJpcf0J9bR7NJyHXaeFyeA9d7N56LD+jKXAqTnxPLLEykGxFuzWRc9BawO1GP83AM3pTZUjjXfDMPP1puLiOcv9GeI5vWTCwUil3SRMZ46dmmJSA0UaZI0sMAMZpobos0bPK+F446zlmAPIszCA8DvxZ3OmNAVi1y1qZS/zXapZZqMF0RU6DxRZllD8fvnPcUdPG4+EydfQilAzjqEAVMacwwrcCbyvYgCv9a+IX7ovsK5Bejitp58ihggMwAemwcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZI88vzL1ncIfGFTBb2f4+KDWBlIJef3INa4xIHKTKNE=;
 b=MVl08go8dq/SLyoC06VzWLbVNetrh+bcZ2oJBkPQqprv6A2WQRsWerxXcNaWwMKYfQ/l1HV/5HgUM0LKx5lW5idzYMpJRMGEpS9aV+ueifT/6ZyboSuSePAe7mBM3YAZHc5Wcl5AutqFtYdzWkPqZU+dBxNMDUbB7fZhpUHDgEBWQgthdfY7oYHAslz3OSvJfcOM9gr620bGzlV84CgJ7+8Qcs+UrnZ6/g7EF979MB+bsY/w3aE3Em5Cwc1JFMw8lk9NTSJE1Htxh0FOrhEtOZWrzR6QKC/f49gW7TvEM50KsYn4PMefi5Yif8T4G5lUrLa/VZwHdxlMwpmzrquYZg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS9P286MB3980.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 14:37:51 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%5]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 14:37:51 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH] iio: imu: inv_mpu6050: fix interrupt status read for old buggy chips
Date: Wed, 14 Aug 2024 14:37:35 +0000
Message-Id: <20240814143735.327302-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::6) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS9P286MB3980:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dacf1ee-accd-4c3d-2c76-08dcbc6eac78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|3613699012|38350700014;
X-Microsoft-Antispam-Message-Info:
	ZFMtICmeDsTyPyBBQwgILXDpybDAEe6MZ88Yyn6j+/1V+f/llDmIILcydNgrDjZgXLH5aXDVeXiY4uMwL2ExG66Ah44ButyKyl/T2PGUfFT/A6TDDAFFiJbxzp63dROsq2v0M7uw9ZrNI2WRhZE/UDCJ1ugs8mfghxbB4qc3YpcjuDDO9KrMn9sz2SeAWzhv+gUB9pQOaWusUsw+jwepJyKM7XRolgeq3pS59LVhAGpUz+9PJ9m78tlXgSd79agRIt60ohQ15d25WQDagBRgjiifejxHGy1kNGWuEX5JoxW3fESpssh8m6H6HAcZRyfNNvdHkO7GkCsXKcH+gh0uwsXTTB3x80ddT2oxuykePotQzFLvN6b1nc2HhcDt6OsQDxDlwbStWEO4hjKG2kCsp4/5RfFCBM6upG5MCRJqIwvK2ftm3nTV5U8Xbz98siLdWKoljYrNNXKtZ0TskZjF7KH9J78ar9TemtBv9dcT8bJ+4+eDGmOQFI1F2yOHWaxPw9vMnyO9NoSRA8fC+Vz9Qr6l8ideaDZAdzLgcFKLTUiIYKe9XnaP1CYOsNRCwi+UB+KmrO4PZqmC454i+OwRx/tsCePbmYSXzJopdp+I4a48BxWxfhQkLtTx5hseAma0hm9L7OFGyE9B8CkV6apijJViYw5SZsM28Wo/brPQ8c6J9RktYtudYIrrau9YSsy9oPNbRmcf3ybjKOqKaO2XfejaweL3G9IktjIaGu1CHFnn3rv9C23XPGm1PXUn/jUQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(3613699012)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WTldTkgdRI+bQGmBcFvjnsl65QrSQFDH4kAq/HNzlg+pzFhv7i82dhLeTS1y?=
 =?us-ascii?Q?PM9OwEQzE4sL7v09CFf8+9jFNiUwew0M6JhJCNH2NJUox1oWyMmPUu68b5Rx?=
 =?us-ascii?Q?1l8eXN9I9IVExijI/ZgO6l4ZyaYin8RVgBaoVUTyaz+6wU3RDUFi0wDZNj4i?=
 =?us-ascii?Q?EEWCpJDefuEy+tgKAdt88753icwq2/ntTdcqmkTUuNmp65+8SDbTt6M/I4yo?=
 =?us-ascii?Q?M0iGDqVAhiw8/HiA9CHffSBsvNkdF16RJw0kcOI2o8EmOQkv3DuL/j80r5xa?=
 =?us-ascii?Q?TLAHhQLod296wl0XQMK6p7fa6eEeIGsUtoFx6gpXAQ0lLZVuxlvn/VF1vXyD?=
 =?us-ascii?Q?mghxZxLhoF9IZR4eXx20q1qI6F509/VjbYeGzuv7mEJ5WVCcAyVBnHuoSooL?=
 =?us-ascii?Q?1k1DCUjRRSpMddBx/sgQoQQOHR+1M356vvtkPTSNoI47fPMsEBT+Gg8kNELy?=
 =?us-ascii?Q?t4HyCINkqrdsTZaruuv8U81Nd0uUG2iNUYKJwZU/8Db/AeXjNWalWmnzi0Cw?=
 =?us-ascii?Q?L7sg5M4LJyEYLipRwV8dvvbKCxexhfOJVaT2BdNNvWlZYMW145B9YUNqMU8R?=
 =?us-ascii?Q?kisvLhBB+N8wT1BM1kKDAeGnVZBvk/ATaF+QL2EQ4ehH5fWWFu3vrRewd93k?=
 =?us-ascii?Q?wEL8t3xjPAriz1F+N6OhV73DXAFueamNqQY4HYuLo4QFFsgwCbuvQgAFoSC0?=
 =?us-ascii?Q?Xe5CiYvyv1B68AE3SuLRRwIrAETjZgi5VnRvF9W7F9GwDfsKpGh3F86fIk0b?=
 =?us-ascii?Q?Ryqfc6CBCFxYkxkTGepM880dw+I+jsE1+KF7RvrYWmRGB+QuF0UABMLEHKkB?=
 =?us-ascii?Q?XmEJuFCUp5tF+1DkBC4XELduwwRHWNokid8UXyiEA7CX1IsTdJB7ll9KAYUC?=
 =?us-ascii?Q?GUVbNRrV2SWDuGZ/S+9oJRVYC+FZCV9uEW6vR/N8U7jMYBl5XMrqa4Mb81ca?=
 =?us-ascii?Q?CBAsDsRNoYIuYJtULmD452wcz3F2WVc5pSEAs3Kemes3/L1Ue0Ep0N8UNCtl?=
 =?us-ascii?Q?1JcCPSQndwaif+mkbQtJgADVAYrYbfWlk2VLqKOOSNHnTHY6eeI1t5s3FH1m?=
 =?us-ascii?Q?7Jc0InYGcdjFBSjoROd7NTzTAJHqJpR2VtHyllGaGhXKoQTOPDiJuOMJa8ku?=
 =?us-ascii?Q?0UOvgfTxB9pF9mGEQ8//DhXU917h1K1si7ch8uO2xT7yDAoX51mXX0oD9+Rt?=
 =?us-ascii?Q?qA9irUvGUn+/Rq82kc8CPBPP7N5XxbKRl5A/VIj29GJGcNromeHCXWGyZZtc?=
 =?us-ascii?Q?6MAi9V5jB8d1GkaICCvRvkb6tU261ZHmifDDEgsfhoG7zxCElHLXHZKBe9R4?=
 =?us-ascii?Q?UL5c5QUD+1B68iaXWVmHfiSwl8Iv9PW8koATF2qzVTe98CdjaGJHP7ve/1KT?=
 =?us-ascii?Q?ksjvU3D4Om4cEenO+QcBmlDl7MkEDrjXtfk+DEO3qwb0IEB+/uKM32ZBD7Nu?=
 =?us-ascii?Q?RfQUZ5JJvgoLi3spuKhAaBjNrS2irI+UPTVJQCjtybEHR+1SoZAeFdbOdppk?=
 =?us-ascii?Q?XVmv0lFwMyZP41aJVmYqlRnFly+kvneOPpQ5uDlXE7nR3xmLgWPyi7410LrM?=
 =?us-ascii?Q?28/vxuE7TPYO3yNH1+NEIIi2JhDlge01J9j517Ey?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dacf1ee-accd-4c3d-2c76-08dcbc6eac78
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 14:37:51.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXXT+HI8RyZLt4cBKwjj1zm4xzVSgJb5hxZR/fBx8Kz9zxs94X8n4OJKqDjjkaRJT9v1UhoaDMmvE4edHZtzzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB3980
X-Proofpoint-GUID: lkgxA3X_NgiguBxaHIrTdZHPe7M5Drbq
X-Proofpoint-ORIG-GUID: lkgxA3X_NgiguBxaHIrTdZHPe7M5Drbq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_10,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxlogscore=970 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140103

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Interrupt status read seems to be broken on some old MPU-6050 like
chips. Fix by reverting to previous driver behavior bypassing interrupt
status read. This is working because these chips are not supporting
WoM and data ready is the only interrupt source.

Fixes: 5537f653d9be ("iio: imu: inv_mpu6050: add new interrupt handler for WoM events")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 84273660ca2e..3bfeabab0ec4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -248,12 +248,20 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
 	int result;

 	switch (st->chip_type) {
+	case INV_MPU6000:
 	case INV_MPU6050:
+	case INV_MPU9150:
+		/*
+		 * WoM is not supported and interrupt status read seems to be broken for
+		 * some chips. Since data ready is the only interrupt, bypass interrupt
+		 * status read and always assert data ready bit.
+		 */
+		wom_bits = 0;
+		int_status = INV_MPU6050_BIT_RAW_DATA_RDY_INT;
+		goto data_ready_interrupt;
 	case INV_MPU6500:
 	case INV_MPU6515:
 	case INV_MPU6880:
-	case INV_MPU6000:
-	case INV_MPU9150:
 	case INV_MPU9250:
 	case INV_MPU9255:
 		wom_bits = INV_MPU6500_BIT_WOM_INT;
@@ -279,6 +287,7 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
 		}
 	}

+data_ready_interrupt:
 	/* handle raw data interrupt */
 	if (int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT) {
 		indio_dev->pollfunc->timestamp = st->it_timestamp;
--
2.34.1


