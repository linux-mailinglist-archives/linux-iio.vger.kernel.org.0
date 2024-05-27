Return-Path: <linux-iio+bounces-5381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF4A8D0EE1
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 23:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73559282085
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 21:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E19353389;
	Mon, 27 May 2024 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="V36eucQe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940CF47F59;
	Mon, 27 May 2024 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843650; cv=fail; b=FwLOvH4pgivds27DldET4rCbFDOX9p/K4CNsQOJ4gedSR9UsdH78QRBK7y3CvQpZlNf4E/iu3wuv6pGH7xUi4kuk7cEDBbo6H0pSzilxZ7P8OtxNk49yYTTyyr3YxCPhmCWT0BDf9CgjesIY/x61saEzTxKEtgtnNkCZ3U1VhSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843650; c=relaxed/simple;
	bh=+FxJIsWZX2rYECSSpbJHLeJTf9hO4PhggJT0R1TEI+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iPipMyZkjlGeWEhKtmVVjZL3a4NHPdsLpPZ0d7L+LYW2zCCkazlTF/pt+I5SYf7LvH7rKGenGRcEq6AdKJRY33y0l/6Y1zHFHJsnfwwh9BkOapRcwoRiXnpW/0WpjWjOkrbJBoPLqjdQVA0wKPP0jtaU1gBrVmKc9SVwd1vnnU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=V36eucQe; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RKt2UQ008246;
	Mon, 27 May 2024 21:00:31 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17010000.outbound.protection.outlook.com [40.93.73.0])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3yba4x9cx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 21:00:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW3GG59vqG1Sb45qZPOjRgagNISRfufei+Ze0Fx7U3Kbfev+RtB2skkoBFA1Z/gB6nVL2nmewyMeWilvSsp0DP5+m2ATyhPFxaomJmXP0HBiiqAwL0KnWATsyA29G+adoytkLo2BLgGpBRP6BJxtxJklvMgvHTNg1e6ilCkXMXd4tLfvv2na/MvQnL53MOVnRF83IpiPxEH9hc6gbdc5KWToNwF0b0zAYdfICQkET0zmbhOsnbrmr2MDHaKtBj8SKJ5stNVpvwhfaaU5ZGV8D+ukDNmYPwngf1UJrOl/CQL6sd4c6jvY0FxYBlpGescPWgZHUwJtOJDaZaaJptDfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jllvrll6q/NWwTO5Dk4fv9/RIa69WQlssvjawcfNMl4=;
 b=P8HdGnHPw0icfr9qDmviYqKhAHVk2SaQK2DGcEuO1YqIgZi4OKncukV4SMmxwda590TLM8n28/nSqxnFEHI1WFwDguOedyV6Nj48jBqdXjE1BwEof5RYtj+6IgoELEQ7Zc6HRhDOrcspdd77S93Wsrew4L4lceyifiWfBeHCFFFNete+OFQcUDCSKZg4XE/e13A/DssAZQViFG8MCvtufPAPzWNU6SZxk0BGbT0kbU2BbBYSX9KSPGPwFUY62ZiYyfnYEFu5zmHALtEj/ocm6SHrSOUqUfK/J6JH8WVUQcxz2UcENz/Z/u5aGrVdv6E5fJehI4LcGn0K7HKA4dtMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jllvrll6q/NWwTO5Dk4fv9/RIa69WQlssvjawcfNMl4=;
 b=V36eucQe0iEgDnuNpubVM4SGGy1B6uWrBMyawpzvx6JK9juzQtup+HG4Tg39maeRFjWFvGYmmqp7P7srVhxQG84ee5xmkv6vnOk2SKMI73PGqx0mb9xvSLMO2EhaxrXp8eceJW6SEb9Ji/BLePAAYnd1Qso8X5lZ4K6X3U2W7Dgf0ZgyraR26l4vfTJuNV2uqDlvMBLtGR5kNKFnic8pzLJ13NHSCf2A+fCe2ExWaMK2j4QX08lD8OKXLndD5jg8IWHV5GVT2+JwLVhezlgGOrUwSnXfps7WRTyBy9fgqW+FmsQNRcEm7O96+UQZHBxTJKY8M2ydBqpmJbRR5XuhTg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB1757.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:162::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 21:00:25 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 21:00:25 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH] iio: imu: inv_icm42600: delete unneeded update watermark call
Date: Mon, 27 May 2024 21:00:08 +0000
Message-Id: <20240527210008.612932-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR2P264CA0018.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::30) To OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:174::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB1757:EE_
X-MS-Office365-Filtering-Correlation-Id: bd96dd88-f11e-4750-0c2f-08dc7e900776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|366007|376005|1800799015|52116005|38350700005|3613699003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?S7jjrn0yHC4m06a5Y+EnUoqhuT/ei2ObtGaK1GwGVhKM3KucFbAsCkW+VNrO?=
 =?us-ascii?Q?fzsWQHnhsgHGBWeQYjMKfZkSZInbaj0VnWM3h3R4JLEStQstYst5AfgXyWff?=
 =?us-ascii?Q?WjqtiC/3w2WXAgKgZJKhu8O8WfahivgWKEBjyFRbnHNytYFQhsZZGcfiKn8G?=
 =?us-ascii?Q?VISzWeLgAr3LYl4w4BUcniEselhnbBQHWeCcHx2v6B9PcehP0iX7l1ddDIUd?=
 =?us-ascii?Q?OL5KDH8HfJlpoDImDXi/b8+npxB4rMdyYkemBtBWU9CO/loqtLb3VDp/R8yJ?=
 =?us-ascii?Q?53fwhRTdTD6hElzgks6xlQT09jxzwo/b+AcWp7jBJTfNX18kE3boH0O90vna?=
 =?us-ascii?Q?/YVjinhjak6hTEfHMiHCK4RBd8boFpZp5iC/7s5GZtDbOtPIvG6qIqN+42WH?=
 =?us-ascii?Q?oSDIBibDKfNRR6H19e2McTpwCSIEfVLo5JP7i+7SZTCKeqw3AeE0dq4rNkDj?=
 =?us-ascii?Q?L4QN69DFss3xj7EgwEy0Mlt9Iuh3XeGe/N0js9bGtNsNQ4W1bJL/G5vTPlQh?=
 =?us-ascii?Q?PjS41i9dCzM2P16ON2KnqExsfKAK4mARws9KOwhzfN7D3aQtNllZfK24RhTI?=
 =?us-ascii?Q?zqIlMrJAZEZyChjnDHW6RcvMxXz/j78YfbDqGkYm022Z/Z8vKYdSA1BwXvyB?=
 =?us-ascii?Q?n8R/fKP4gKF9WrILh73RnSJg2+yo7zK6vQjbzxbQw+7iqs2AOYWEA9Pw69F2?=
 =?us-ascii?Q?vKt0tOJmCAKUGAIJ7QSIFBTGR9GaygNSjWddjCD/1oJb+r271+TA16Xv416V?=
 =?us-ascii?Q?M+IOyEGNzRhc6HrppKLAHFMU1n6ob8airMQ+KmN+6730HLn2A5npmKTt6m7b?=
 =?us-ascii?Q?dvNDg9Ee9jpMttztUV3QDggA5FWqlTcjSx4RaIweVIao+F0l7SdogO5EXgoo?=
 =?us-ascii?Q?ZmBIFGK2LI1ogNsBftO+afSJaGPP+N4RptJwI4+3Wv+giqZVLQj/FfM8BVqD?=
 =?us-ascii?Q?3mLN2B4N0c4BXu0m6j3qxnEDZAFVd2vMiw12HejcZtSAWNmAEfcWftjegWvo?=
 =?us-ascii?Q?rwYE2UDVgiMqbmbJ9OcQkT55oNtHhkylvfNPUwwY6rleii831G3F+VCV21q0?=
 =?us-ascii?Q?AxU4CuND1KygYesqcHuQ/ggm4lsPZGSZNLxuIWW1OEoLJU9THeGKt9gYyT9m?=
 =?us-ascii?Q?iaVeu++8LU2buxGrhI/0s55barbqGeiK+AkjT289Kk8UNH9sZv0dkp6aIP4I?=
 =?us-ascii?Q?ZqrINsZtfqXGEscZ1BllDkeHVR3TmVSK3JkQ1tmICIj/4N+viKyrtFulBODT?=
 =?us-ascii?Q?c/H3y5wjbMLGlNDf0znmNny6HsChFADiIUnjcpkNZA0Ql1bF5lbNEUToKv8e?=
 =?us-ascii?Q?CkrbLHSo23WVfS8jtEcJEadsZl7GX/zdqB/8D1PSxY3EKfFwDcMQGglUX9tJ?=
 =?us-ascii?Q?FKhlFUQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NeUgsyXhg3UYKyCY2do+ndVV39uO+32k5A5OTjXiINxXpv4X3psNkzM5lBw0?=
 =?us-ascii?Q?yRU9QOmz4CBmVtqoFZrxpW3MLkqDTqezETzed/O4azHry1d7S3Bc/m7sChWY?=
 =?us-ascii?Q?xH0cfdchj5jRraqJxBQPvC4u70ZYjNNk3Ojy4N4XBKwpAZBuzLVNHWRLRRGG?=
 =?us-ascii?Q?HO+7h/uZSSsyASElcG4WMnDNqtEMxB/pUTlNGY1ebaMDkqi6PGgB7+gaw6my?=
 =?us-ascii?Q?or46XCkLoCtXYCLuwGqjc+acSL7UJTUdU9bT7q6zAkiieUGOstolQAcWZ9b4?=
 =?us-ascii?Q?lwq4Pb7ydld7peCSPpAWyaJojVGBUe3xhB6O+MgOxGqHzx/Ta07+Bp6qpT9i?=
 =?us-ascii?Q?D97+6xedJmrmlcN+qN9bHDB5RpKz6FeMAyJUqldw3lylBMq1+rlMeT2JwvzF?=
 =?us-ascii?Q?E98QPYiJWVXbnv8DxriulA59ZMC9+Tg/Y2ivup6xvUbsz3AoHiDD19W1BK2w?=
 =?us-ascii?Q?KLDpTZoOEFfJNGuwDwHQvwKeIaHOEdQ3XPMCFKUrgj0cw3V4iwzoql7T0EvQ?=
 =?us-ascii?Q?bN7EurCUzL+D3O5xH047vVceyndoSZku/+kYXrYWfnjwSlT78riprLXqmSjw?=
 =?us-ascii?Q?ah2WOvHNXou/XaZW7/JeZR/RLw9lc2pq6YYAhNuwJUP8EFxpgxWzQQsmRnwu?=
 =?us-ascii?Q?l6v0RGULSu1kljF7j9+l8NHOUNYTunxh5tCdeSoRhakUb84pPc4y8MOo5tBH?=
 =?us-ascii?Q?pDIp5WZWqF+Ma7BxH6FgULzixtFdcOczAyGkfdAq6jRJ99W3MpN2ZVbT0jD9?=
 =?us-ascii?Q?5nTyjJW6WYtpCca5Ch3mvgAHX1AgmkraJjaDzZ5+qcUYnMNAhZrF3QHGwCmd?=
 =?us-ascii?Q?AzzjIy8PHFWnqZ4foUPKB4l96j328sH1WZOg2otvrBY+Y/0ZOoLFcCQhVEp1?=
 =?us-ascii?Q?EYcWAWZ8UMKam0ubLFZ553z3x+lsshvzsmD4++rnkkhiLlUVoQNUJ6q3iiNM?=
 =?us-ascii?Q?L/6EKmlG4gr9NMjuvgSmYPyqUzXcfzUjn4T0bmjUqzaxq8XzgToRPuQPoXAk?=
 =?us-ascii?Q?B/PbJY0ZonsOpEBUTqy+SAtaD8qW3zV91CmP2kjuPG1QaQ+VhbDAPlrtgC7X?=
 =?us-ascii?Q?5W52+MvvzCF8Rqijpf0sUHHQIUp0G/0BaPfQt3K5UYHedfRoAKjj8WYw6dGn?=
 =?us-ascii?Q?+IzHKv+4nLhhjxRcFpTww8wUDEmc52Uzchf6llAw4AMwcrxJSR2ZA6Hk3Qbd?=
 =?us-ascii?Q?zfsKwQ+gCexXwDjKU3qlWlMqkbi9sp63I/Xds4oXiSujuopMgwBehH1tyxsH?=
 =?us-ascii?Q?wZUSGFx8rHK8xYBhA0vB97Lpu9uaI+X8a70YuvkZlZa1s4UfvTGL7mzkJdU8?=
 =?us-ascii?Q?eSQKyypBo9v4MXyk4YDXqeF3shBcRx/RBIhrrzS2El5bYms55e90CoiYwNMw?=
 =?us-ascii?Q?oP4qJyV8d5jYr1pZpnpsjdc9vZMzqHbx0jODX7/WfYG7k+HSuIkEA4R1nsp4?=
 =?us-ascii?Q?f2NmLQMdquyp4iq1sTwas6MBs1ThqF3pJ0ZDr8HZO3WAOXsTcqg+6IjY02sw?=
 =?us-ascii?Q?AuWprZBiW4fJ8PCj2vVOghlbIIilxklwDud4bZm2MhyGsunYiogIuY7Ey4t1?=
 =?us-ascii?Q?D92PzNpxcQfgGYnIskL7NfRAABtXjbHtSw4D0WQo?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd96dd88-f11e-4750-0c2f-08dc7e900776
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB1950.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 21:00:24.8209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJiR4EXaB6wv3ptePWGo0oX1RraaxVBx1U8h04t22nYJwFAANxMdjahFcgwyt7Yu84rZ2jUBUOtrt/cypX0+sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1757
X-Proofpoint-ORIG-GUID: Su6u-HezlyaJ_-pxXl8eSVBFydhevrfX
X-Proofpoint-GUID: Su6u-HezlyaJ_-pxXl8eSVBFydhevrfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=903 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405270173

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Update watermark will be done inside the hwfifo_set_watermark callback
just after the update_scan_mode. It is useless to do it here.

Fixes: 7f85e42a6c54 ("iio: imu: inv_icm42600: add buffer support in iio devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 4 ----
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 83d8504ebfff..4b2566693614 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -130,10 +130,6 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	/* update data FIFO write */
 	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
-	if (ret)
-		goto out_unlock;
-
-	ret = inv_icm42600_buffer_update_watermark(st);
 
 out_unlock:
 	mutex_unlock(&st->lock);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index e6f8de80128c..938af5b640b0 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -130,10 +130,6 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 	/* update data FIFO write */
 	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
-	if (ret)
-		goto out_unlock;
-
-	ret = inv_icm42600_buffer_update_watermark(st);
 
 out_unlock:
 	mutex_unlock(&st->lock);
-- 
2.34.1


