Return-Path: <linux-iio+bounces-2785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 503AD85A7CC
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 16:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB3F1F24BFF
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D343A267;
	Mon, 19 Feb 2024 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="HXHha6jI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1C38F98;
	Mon, 19 Feb 2024 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357746; cv=fail; b=tPjdP7o8iEIKIJpTrmXpzcAMNYi8CVqy08S7e/q6UCNcybR8ywFeTLw2gPgelcu3p0kWHz1vsUed+rwg+Xhqx9Wla1oRslCeWnr0FWz1B3LRldsVUH/HDLR/2TrmJm0OCx2+f7nj4Ga5W/7eOTxOlttpercvLlEPUMFTtrJ+Fec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357746; c=relaxed/simple;
	bh=uTAaerVjtJf6D2mOoMr99NYLbmi1JlD+stMxO/wqcXU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TzREbXsK3Eg8lSayHw8hVJ5U9lydvylVTrYSVrgh6TkBvzPCzdDuumLwQRbY4p15adFjokzEm6WLwbsLD/IVsZGQpld32U2HvqixD13nsNkB+WfzwhIgbZyZVpZ+9VE2bsGSRx6JxioyZpDbdepc+zQBrXaUslVk+RZReXa+wFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=HXHha6jI; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J903pk016591;
	Mon, 19 Feb 2024 15:48:48 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2169.outbound.protection.outlook.com [104.47.23.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wap5jsb32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:48:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElxxR9MnF8ggKj9eGoEz2ei8wz/c5nCSt2hA1SOtGJH8mejcXp83JmHM0/evJfE0X7SN9owwJ5l4Fx+92Owd+B2jOPElUjW0n/1jIUUnA5zqLgrEuQUH8MzS5EK+AnTcGRBSO4TDTNxyGaD5ZqSQZYe6u6Jka4+dnPYJMRILt3TWWj37GjnxjdFmIaWBc5ex+gSwSMZLahPM68/RlIXZaXl0Momf5VCxo25hQTAMyLk+9y1P11PjB1qVC9XI6S0zcHKoJ0I3SzOS009qG8aPDnGEe3sohCFOcCJ/nTSYV1v0NS6xbeg15Z+mj6Q5QXvO97foAHs/i3CY+W/ZXaJ4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPifrOcZzdOx0Ed4l1OV+dtaBf8gMC+ejyttGcP0a4o=;
 b=oH1e8qfe7ozs1PjfBO+CbNPCnnDV1dCzhKkq+1V89kKo3KDK1jn2E73I25YFfxn+oATC1LIYFV6pwwHkxWkIS5067aINUlzvSnmRBOW35R+OP/FigHhKtnCPyOOLZhJlPCQxDW0JRc99bv3O4SzmtynO55V1/II72DUo2JN1tPB04LBbOKrOTl/Lv6Duq8T6nfsHbfHRtG4LT3oVelG0do8Wnj4qoTweOsnYdLP12NIGiFD9P68MsJdiIR9x2oFlE+xbOu4QGeN2icJuaHCFq/e7wzFHt3jYTHvKlfh92rFpoQM+1F5q11FXBNFbpXpk3ldC0gQnIqVPjIhMU8smJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPifrOcZzdOx0Ed4l1OV+dtaBf8gMC+ejyttGcP0a4o=;
 b=HXHha6jIGABKF9rcPvS7xmVQ6KMdII/v56ljdl9iEfGrLtMjyD9ftNZmERDLqHrptlataNQbWUmPLrCQ0xu7vYNTTAKiVXb6ihQCohhYxCr2JZVpNIhM450o6PDoz9jeEDl2302X+KAHFZavo/8fg3ZKsEgVjDBxL6LHCoJcept6gPNBE5vo4xrOD5/pvYWZrL8tHalaZboy8h8h+JYWI2DJiQQhX16/U7RcM7aNRJ3LZ+S4H373+PGGjxgn3F7wvq4+ksXHWu4WkudqpAJBIp5pRgUihAvEqo3dMkqOCLPsCvuRU9lAjNiVhGO1QZ0Cn9H4XoNGki/nH/GzkRrmNA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYWP286MB2249.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:172::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 15:48:44 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cb8d:ccc6:f2:ff8f%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 15:48:44 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2] iio: imu: inv_mpu6050: fix FIFO parsing when empty
Date: Mon, 19 Feb 2024 15:48:25 +0000
Message-Id: <20240219154825.90656-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0198.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::11) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYWP286MB2249:EE_
X-MS-Office365-Filtering-Correlation-Id: db25daf7-f4e8-49b8-deae-08dc316240c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1ovZo39PADKLypdn/Kzc8u4rIRC5ijmALFL5xz+pcFCNeH0seJpAI6uvGQIbSGYoJEVegmsy7ICtyhu+N35fDMI/v6eQZhkq22BegDPirYJYOQ4ylG0JnTnKHFCZsCS8nGgBSZPssjhAl4kORKo1SOuTYQU2U27P6DSJmu65oa/+cm8+pPvi37eztjVhsD5QXEHkS1pRc8lQ2VnbGgtyrN3Pm1Lc8688Il4gDVFFXRPQDDP4AWD7djR9iz952e1PzO1Kww2Fs9+wD5y180Y1nni02EiLKmK5N0EUG4ThicpuiyQRDPGuYHYYCcVukbsC2aOP33DHLPYjNuY0YXlhDiSoz/o+JM0Vqav4Y9w7Jqn83dmlj2EvRFBbml9KCPJZtkf6kdWNLLTy4MR7rYLlW03QbPQm2dYHaSCHpWzdfcKfprlrLa103SncaAisrbTuGgpfura7bt9utOXcHu8aYOI2choY6kwbocyJaycZNtVri0TmPEVsy1Ilt1JhQcwI3t/4BIFhFSd/AENER+QuRMX+YLyIf8u4LstAfE7JGM0GMasFdmNS5yuFAbnrIYuNqtVfog7q+DbXItzWi7V1j6Xu7YVjDVqbGAxeAJf7qCao2EtoFJDUWQzKIhw3EAOOSlx3eKpYBt6YrnxT32Tc2w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(3613699003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a4B1XGh1hSaMPWdNM2p8Yv+Pfbfg2nCTJ/eAIIX5s3HAXnAbkWU2MlBf+Snm?=
 =?us-ascii?Q?d29QVBs7r1Qrcg/OpcaKmzgygSLysM/M9/cpLpj0aLmzFpzL1b32V6M7G2Rt?=
 =?us-ascii?Q?Hj7w0QNzCifuqY9pLVyQ1Xtht9xQA+V5W8BATnbkNwnDcVgiL2YgDgD+kXSE?=
 =?us-ascii?Q?vHsJgSgXXe5WQo52KbeNJir0Y0gFvniEQ8NquoWhaelrZY53SlRijVwhW14h?=
 =?us-ascii?Q?UWgQG0xhUiIIykXDUpfghdgIoxyEiCjwkz/jRlQe4p/U1uuxBC6H7E+tnli9?=
 =?us-ascii?Q?mdjQouFoJhLhd7/E/yFH8nSwQR0MvtAPDAdhmpc0a5Q3fiVkvDBGeo2wcx21?=
 =?us-ascii?Q?KF2yNPH5crU+h7XLvh+3H+JHzvMgJmRIpQhLG+nKvpteDBY5A4za1V7Fkm0Q?=
 =?us-ascii?Q?Uis/x53ThUNzXOJdJDzjB4pxIpZ5peOHo88dOsJjdr0V+aHS1ZalEy3dWLl3?=
 =?us-ascii?Q?PNc4ZTt7nIEaSQS7K/j8BvYRhRW+QQV6LJPgiGm1WFPD0bVTn9YvBqMcKYSd?=
 =?us-ascii?Q?L1ul5U+Jvgm+hOf0UzwTY4SxGqGMuLuF7UHHARXOO3uJVEbvNP8AZFAiLOEs?=
 =?us-ascii?Q?7AG9saN8V6f2CkJPwnWvzpBNwJEaUBrtYtS1ZyvuDlgkIs0xZD/5TYjkN+ap?=
 =?us-ascii?Q?FD7YdulWj6Bljlu9eTRVs7T6F4pbG47pxCXaYBbX2KmLHjOcPXB7yp5adjey?=
 =?us-ascii?Q?Obl1y3ZkibXxxaN8mLAUzixXeYMYkTFTWjiEVQl2cOf6VgFhgZ8nFMOvsYJl?=
 =?us-ascii?Q?nr3kOH5yJe3Ng+QZIOmQm5B/EUb9NZJG9lcwk0hoRuC+V5tBm49X1xnDKmGL?=
 =?us-ascii?Q?/cLWPFgHHaXKO6XJRoEFH2fWfD0QkvMS/2bZFGR2wm50YpyZm/Xi+i/s4czU?=
 =?us-ascii?Q?aGI/Qd2PvjgYHsbtscO6ImMuB7wT7k2ZHmv63cLBSIHnEMDdM32rav9YahzU?=
 =?us-ascii?Q?woYSIZdp7JGGsKTu9BurihnxQvPPNWF6YJ0gcZjdkRSk6KDUEBwmEvXyN2Tz?=
 =?us-ascii?Q?y+Nf5/qb+R+OHpO9Fogx9vLcR2H1HhQmOKxOAXzzAlvQ++nHW3AhNgjp9Wog?=
 =?us-ascii?Q?BpkLn3SOOki9p74OAdvB4Fi7sR9TnXLvay3hQOn4rFjh/UqbeeGN75gAKu6v?=
 =?us-ascii?Q?UhwyLmobBOUNumZrExnmey2gBhg1tgRM0U1NSwvJp5LtjV2dQjYzNT3tf+aJ?=
 =?us-ascii?Q?scs5Zx2zv5aRgXdruRaYke3nXuKrPGDRO8DFLNuWOyBZusLyMoeHKBROq2e2?=
 =?us-ascii?Q?BzvPZfp8mF81e4HR99ASrlZVUwt1uisaefr1kk7/IK9w3YBtM3gdhkuOkQ47?=
 =?us-ascii?Q?QXeY6jx9Rl/t85rV4Lt7JhtiWfF+7nq3uAD8R8BWWh349GrN1RaLiPgaTSpY?=
 =?us-ascii?Q?ZxJtgrcR7W3jW/VIu6v/RqSEPz0rYaCXZbWCRNaHgLZrbvn79eKv9nfauA69?=
 =?us-ascii?Q?KHwUMIKsbaPcqWKJPauRs8pHFw2NZZaTyDEEcuFdawmCP0pHtJc7B8dtD+F4?=
 =?us-ascii?Q?qvSbQHEAAMD27stcy2scQ180klsbOz5ZG4DonmTOnB899pTUlPyC9tBqBPyq?=
 =?us-ascii?Q?S7bsXcVuqgbdqiOlQj6BejDh7Zy0s4GyBw89lHHWv+qmL/wBoL5JbDZyeXMR?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db25daf7-f4e8-49b8-deae-08dc316240c8
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 15:48:44.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiF0+nzzHxwo6bqlrB/I8qrHV4kkrLNmJzVRwyuPjR2OqgBl5Cc0iulpVpqkxgMW40qhBCrIQT/h8T8Ck8jjLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2249
X-Proofpoint-ORIG-GUID: YY-n9lv7Ac5WxbKd1RQ0y4XlyyLtlMzG
X-Proofpoint-GUID: YY-n9lv7Ac5WxbKd1RQ0y4XlyyLtlMzG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_12,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 mlxlogscore=733
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190118

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Now that we are reading the full FIFO in the interrupt handler,
it is possible to have an emply FIFO since we are still receiving
1 interrupt per data. Handle correctly this case instead of having
an error causing a reset of the FIFO.

Fixes: 0829edc43e0a ("iio: imu: inv_mpu6050: read the full fifo when processing data")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
V2: add missing stable tag

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


