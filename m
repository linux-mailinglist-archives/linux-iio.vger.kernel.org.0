Return-Path: <linux-iio+bounces-2776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF5E85A4AA
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 14:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE921C21004
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 13:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF9136138;
	Mon, 19 Feb 2024 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="X9tpBCiC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79738E545;
	Mon, 19 Feb 2024 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349578; cv=fail; b=VjhkxAN154SaKdRz+GYQCUR/axn0eGNDqkTctmkYbMk6eQ3LOtp1EZJYFu94ml029Do9egVngjGMIiuLaDgOtg2jY60J5DsLCl4VPVtPxPtyYwe6+Msq1iSzGKCKGRDFIbGx1xYaKPTB1N06xK9rE4EbwrcyfhgFjr0+yU4cibw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349578; c=relaxed/simple;
	bh=ljont0EOtMS9zsM4H6012XOvX4tUcAhaX/QO/TiYnlE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=czY6uP2CCOw8ErQhj3pimtIHw127HNysBT1ri0pNlThmQ0nYjv0/myw41+6QK9TGUjNKwstWe9Z3EyTJYySdbAsXD1ps9i9hPijLd53uXyDFR9Skj7oY38SpUN0v6kkAq/WEi3U2125f+EQioNMi1eLDOsnjia0Wal1BdIPB5AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=X9tpBCiC; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J9840w004093;
	Mon, 19 Feb 2024 12:55:43 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2105.outbound.protection.outlook.com [104.47.23.105])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wak5y19ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 12:55:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXcchUlgJHZiuHPlO7V13i1jS7SBJCPw3R4bMGNn9dsbHFKtKifuuOAEN3+wuQV7ldVBkRHQOyZQdjyPKwMvNFI7u6nHMHRe1ZV2N6fU6FPzfl1k2Hua8FEcF2GJZcgnVAZruGywYtHHz6IIHPVP4gzyB8J3p0Or7K7YH6iJumkpd/4rTPWYOsfH2v/S1iyMSP3n+JUUSPjMIKzLGMFk5azNXF7cYavO6cg6/GhkFg/xey081QhfY+ePq4vHRX6CoVHrhF4c+Bfqmp5waexb891mmSOQLlS+IJpc67IZIe9np7ypk3jOEtGnahRslIEDBThlBqjwypS6226NoIOu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsnfK/V88qRM3L+aHmNRg6VClRGzZcCn87cibnECSZA=;
 b=F4RJoUjHTaHDd8u52g+Z5r5P1E0N194sC+KUj+40hMuMnIG7CtzZ3o0E3Ld1y7A/6Fs6g+1PWQStpVYL1fACtCbQ3ADmwTZQqi+lh75mOv2L8O9z+zAogNWSvFy1rmc7Fuw8KdnGkaxbIcibnwGhCacSHliWDyAh/PuCHd6InSlreOkemvJrPAd2EpqJbSiLE3FquMSkogd5/NqvtCEC2DHkm6yPrgma945Cf2heRTVumQZ2DubVao/7Snawf3UY3FzXy8gQqD1CsJygSOfibL/pviYgmTyxOdTNLj/YYjKQp2EM6mAXRLxEh50YgsYWzdtIaSKcbbwltgDJlgvDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsnfK/V88qRM3L+aHmNRg6VClRGzZcCn87cibnECSZA=;
 b=X9tpBCiC8pp7R42dBSwsMd6kd360EEz3xb0QZg7BBOH1zU5Bqw+ipWE3dizNSeycQGFD7rK+KoXYq1EkEnBvOhQNR1Ze1Z+5hmPxvlxYVCxvfTBCrtw3e0WWClaC2bN5lUBlq7NierbYhyEzsqg8mivYH9KNd/W+3nYkFThvlSELZVvq7Omj9EpnCDsboqCux25+eb71wyC43F31BW0HxhgPHkHkbqVkDm2FuwjqdKQ8pJMaYD0RyWx4rVRwMQDQXmdVrMaes/0iZalffgI7Mg14sSWVGLqB1jdHTIlqNqlpRTQhHG9ySIBnr/n5jCjKyB25Ks5lSTy9jTRlCx/ScQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYWP286MB3110.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 12:55:38 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 12:55:38 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH] iio: imu: inv_mpu6050: fix FIFO parsing when empty
Date: Mon, 19 Feb 2024 12:55:23 +0000
Message-Id: <20240219125523.89431-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0307.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::6) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYWP286MB3110:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8bd498-4578-4f20-dd49-08dc314a11de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kRR7UM5wVSdQsCXg1ZqFbGDYScDfByJy6kpPrmm/PLMvqZFAIwqbWRrsCoX9xi61HqHK0BzBjJRPZ6CZb0CN78IMDIDzeAhBLPmKYu84R03Bz31TOsjDwqsiprA5zDJXu8G+8BZPaNy+xosBN3WSgKK3CNQ7DkJqRXRanZYmcEoESZVvwB3i2JiHYRZDbTeD3VzfftaBwLTLzZZUwyN2wDwb/QSPN85/xQyQIZl0xEobYWRTzR6xYTrFxMLdG6fUuHrLHnTPYL6/fgpALvH+C0T+vx0gseWBGBNaUdrmZsM7i3sbOoLhMAHo6JP32/LUlzOkcB2MCe3H4pPztSe1YIhGPw+zPYuR/o8xvvAO8/2nl09oC0UGXxymc5qor9ZWIWmHN7L23+kuYLK9byUjeFJCPbvZ6qat/cQtG89s2JL9/rm/hK2MzCZYbZXz77KTNWeW861HzU/LKwH4Pyo9SZCFry2CZVGWtLc9dc8dLo5gKSDZvaDicDZBVgkDp9cpP9BTJVgNBZ1iflIlVwbJ6t/bgHuuRKKtgII3soIfWJAfdo6qOw9J9pT6vCUXCOaMz13fB1LPoadujWGqfHv5wlZNDbM/hu3lrEWsSYvOBXpGomvoD9raJIoxtXOcVY0pakn4N8ISgWs1AlGxyGEjbQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?U7wS8Mh4kB91foq/cL8qLY/YTF8knUgoM0kGMhYIDnRgl+LCchhzne5WC9Rc?=
 =?us-ascii?Q?BK49e+QYe7kQ0SqN5L6Zl+i+GBgTocac572ZrVgDtzJc6kOKkk0PsfPA3BHU?=
 =?us-ascii?Q?fJk556E/FgVk8ve+23fWGGWS7q6bNI9im77UZcWO7gtfHmva3LUzka1y7rEA?=
 =?us-ascii?Q?RHMD6EazTyd5rLpomOEU2G/URPgFHQuoZlEMz9HqdmJxqDAuYHmkpRaDKjcZ?=
 =?us-ascii?Q?A4b2Cu996HS5EoWyN99r3uUKmI6O1pV+VFuO/vYfHYn1ekWtIhx/82qQWNx2?=
 =?us-ascii?Q?KpGqIZ5NgWyXlTvFJPpwwXfNgl8Nu3spyuzq6xeEbMSBr7naEv7O1SA2U35A?=
 =?us-ascii?Q?DNFQwTIAjQyPJAw0eiEKSJJzM612hF/f2DClz7Lr70qK6z08wMYu/xkmOSIg?=
 =?us-ascii?Q?6dkM/Jy/ZsPT61xh/zyJHc2LJxSBfDy6NwAZmZjXEYGFn6LNT3yHc/b/XCP6?=
 =?us-ascii?Q?5rlQ3TKn466zA7FJOvX6NEehm+1kYBpLivVq2Gws0mOnE1p919FxnTGzJj7O?=
 =?us-ascii?Q?P/vq7lkHSD67yF4hKGZ+2zPVFnf+0tx+5dTNW6Ri3jwlxMNnyHfaC0arM3Zz?=
 =?us-ascii?Q?h3GlUvddEKmLyuYtc0WSmQ2dtJ+ZatB2w5TNgmnIpzWJdHhnnXXzyjpUKZlA?=
 =?us-ascii?Q?ijlbAdOnBVn0iz9QFZcGbZc0hxQVgvrQSUGt5fKge2MFzddyNUc6OH6dk0ss?=
 =?us-ascii?Q?Vc0zEQwKWW6eHs/cuAM4WV/PvqNkL/kSn2Bl1z1mNN/cHJOwuoacXN86pCnh?=
 =?us-ascii?Q?H8+JSKGhad/f7qwBkkJbQfR86HXO0jtjsgyhs6TDbp0+ADTQsFGr4IqER+NI?=
 =?us-ascii?Q?vocYlnkE3077FWuTpDI1IybOwf1ki3KsNJhHAuKBuk87YqrhF46z475Yuqox?=
 =?us-ascii?Q?NECcrv0JKGGnYsH5JQ2VQl0+G+BgoJRMJkL2ba3wDM8sSAtlvNW3E7dPVGWu?=
 =?us-ascii?Q?blyakhKE4yfo0dGWkWmC0r6zPe6HFP+heP5spqZIouIsXAVRwjVpGLg1tDN4?=
 =?us-ascii?Q?Mjb7dKsR3dQ2Ie2Vu866okHdyQMDLp4fE+B0qBHT6OOKlO6GhdZvjiapjtRn?=
 =?us-ascii?Q?WHD8lO0QkJTAJ8tTJk22rOXO0yrKv1fK82qQBiwyqqH39rNompGw7hd7FJ9I?=
 =?us-ascii?Q?jZzziGQMBVoBABpqTVAVgI2tfbB7605gWRvFi5U3+gYY1WD5DQs4QgZEZ4FU?=
 =?us-ascii?Q?dVGDzqe5z10KY8e+d/ctAp6eWJOO/OhlExYeSduobpHT26y2SkSfnoJlNGrc?=
 =?us-ascii?Q?7kg2lbc4+uGvecSGumXfzZyK6a5FRFUv7P0m/WqpkUe36m9NAJhr0Ckel/9E?=
 =?us-ascii?Q?mlh3g4Ho1tQY+nE4BzmNknZNw7gBf18bzEenlIBuY5Pr0e1vhX+QGt4SWmCk?=
 =?us-ascii?Q?uLxIUQPPTWbucvUl0C2GmP+qaPoCpMHE6c98FE+ITIjLFTW/niS54yHF4mxU?=
 =?us-ascii?Q?jsKULNeGFHJOY+dg+RJgs24+SQKr3GFp4GFwc4KhP8usYgTy2A95TcKcLwRE?=
 =?us-ascii?Q?IemfFIs8AzB9t9T5p0MugJgbr/41FB5OUgF5JG2FvfzVC2gEpuOh51SsXcZm?=
 =?us-ascii?Q?/MS+RpIPKY1NY+IEEE9+67i5gzh8qjEtyewhU07W?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8bd498-4578-4f20-dd49-08dc314a11de
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:55:38.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4jri5h8/Maz9PnUqbffx9bkJFcl9cy+7hdHn7gwBY+f06yog3v9ufGEGHkU+2wvoLNcKJNtfZdEXWUx7kyFyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3110
X-Proofpoint-ORIG-GUID: L2JWo-4Q6inveg2iPLmWK43gRTxQMucW
X-Proofpoint-GUID: L2JWo-4Q6inveg2iPLmWK43gRTxQMucW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=774 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402190095

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Now that we are reading the full FIFO in the interrupt handler,
it is possible to have an emply FIFO since we are still receiving
1 interrupt per data. Handle correctly this case instead of having
an error causing a reset of the FIFO.

Fixes: 0829edc43e0a ("iio: imu: inv_mpu6050: read the full fifo when processing data")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 66d4ba088e70..d4f9b5d8d28d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -109,6 +109,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	/* compute and process only all complete datum */
 	nb = fifo_count / bytes_per_datum;
 	fifo_count = nb * bytes_per_datum;
+	if (nb == 0)
+		goto end_session;
 	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
 	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
 	inv_sensors_timestamp_interrupt(&st->timestamp, fifo_period, nb, nb, pf->timestamp);
--
2.34.1


