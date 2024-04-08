Return-Path: <linux-iio+bounces-4150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 491D089BC2E
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 11:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D6EB207EF
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744E448CFC;
	Mon,  8 Apr 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="caMJy6TA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43501481DF;
	Mon,  8 Apr 2024 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569531; cv=fail; b=uClv+xZijQCEAENJ+yb6xkyvVhx/2XzZp8JmmleuEz1aTPHmtlszKS/kPdurhZ9ZECVWPQuqeDGNLanXw4M5g3iHltshP888/epahI3cunsNQgQVk/84UPtYFHjHh1gMHOlgT+YNfh9iG+1YqDQmTD9lasqhoRHFYr4bOEwUECw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569531; c=relaxed/simple;
	bh=ZLgv/W7BSsouSMBByUHwXUrrZvWIeaQuSAAX4jzSBe8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tHJPglZ1tKfTWty7t1BQfYr1PisFwMOa6xXhtoEmupSjK/pigfW4HIi9rbW+y5BgnzFsZlLnTYdNtbXbbVCFQ5CgFiIkXbvBI+e2yH2Ek6ZLnm9emDI/4gp5/mSAIkvVl0ZU0atdR+y2xo+R4+H0sXtZoxcvnwggzQkXi5sxKdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=caMJy6TA; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 437Ml45j024444;
	Mon, 8 Apr 2024 09:07:39 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17010000.outbound.protection.outlook.com [40.93.73.0])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xavryh6a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:07:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAaV3V6Q2HwwM6z4OFq1FBdjrJFVAw7GJG1osfPGzqPJXekIHHEymjaCcjDpmIN8xMnww9VgAf3HpO4T5Yh/s/diujxyz14Sw0PpZKdfcTSxC9oiU7nE+W+dRzr9Bgx4uEnfhp5WHUrMCkOHJ6GwndumOJLogvXIbtu55u2/xlwP3iHJqGBSvaldSW4fvDgSByMhE1W1y8i74aeNWF13WmH7tD2xxqBLcpEW1pjq2e0s2IX+DcwRU7/ZMqdTqb+LwQlV6dC83oJtifn+JP+H1oYr3v+wH253QRo0W8mJbi+yJdG2luhuM7WdiTQTwrca22og5zJBep0+7h6EzoPPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKAYCmCcfNkipyco3MYqBl0Fl3ziFWl5z2pumOgM3kQ=;
 b=oB8IQIMT5N5hhGbCgATbNi0H1obYR4ChyPSN145NcPXQfPKJ4/2TncZm/gtqwBrIk+nUVAM6F908XobgekdZtnmW7+TdBsZyIia/vslT5U022iIpK6wuP8x0Hk6CPZmUhuEuZuP2cmBe1V6z2fEsLhJEv2uuwPti0Eu+opewsukXisnk5qLLRNHgxWJtV1FWA+YsB/nDoL2YT/o82VSv3g5EU5p9rQWO9rI/kUMA/j0UWhkg4Y1xOWCNvGfiRZw2YuhJ4mSTXrdbqL4SM85kwJ6tGVcm72gX4xzQ+gWcl8Sra0F9qOGqTd0G9Dpc7iEGfGTYl8qQdU4FF9TIpIbHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKAYCmCcfNkipyco3MYqBl0Fl3ziFWl5z2pumOgM3kQ=;
 b=caMJy6TAiwk6f9dIIz58yCE+eUBFTG8t6PrGX/YGM5mJ88TG/oWtY/pWcVxZR9bqnshW7wZzsc8wOY8eJA46rJ7CHO7MxoOHwYv0JkAAzClGbRvEbN6nSSf8oOIm5mdKlqXKk+ZOr8hKTb7NLKYpu77d4bCBVZyaEFZY8c8BHjLoSe86q1+1lIc0KnEfVnjBzKVsq3E2C9G7qCZyZaeJLUap84obVokctQNllwAGjHvBOLU2MQxa4Qse2bb3avsaL8u89lxEphi6LtriMEzGklmKaQYQobk7TVRVc+xHanT2dY0NGhV7q7rWQ6D4FRLMjnDZqObvJN2VlSGMVLZ0gg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB3342.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 09:07:36 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 09:07:36 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v3 0/2] iio: imu: inv_icm42600: add support of ICM-42688-P
Date: Mon,  8 Apr 2024 09:07:18 +0000
Message-Id: <20240408090720.847107-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::17) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB3342:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q46csIrbSGAJsz5duOHlIgjWQPfCfafJ527AmvfOVd1jlDZFt3tmdmRJ0BzxGHtjjfx2QjDC+hi1ZF2urwE4BpyKBDa+5u0gxp3YaKswZ7Gex4LVln7dxIOyXkr7lqgrBkOZdswOjZTCeA6szWApZhH10TRiMdnNtZipHq6p4kzNPG1EdiHrTkp/yb835m6U/KvR37t4IfSo7Si4U8U6zRSi7JPcOIP+ynaKl+FTvGsPPVzjnXno8WrKLMzoSBvOptbqlb8A1RuhRaRhDl3L2oFgRpN5UR66mIMXxqKIBNGq2X/zvLpmLlQqXr2jfFaBVgn7Q5Ph6EAQuB1zdO+TB2mcua4+nOiC2QOOXa1iXUW9b/IxKGHWZHztujGkEyWfFNBvzXdtYKCYZ6aVJbYMBjBcFfD6GFk8F67TsXEJKDx+1AP6WbVWLzP78rWjY+Eu9CoFvsET5rz4r2yQVWg/CIYibS6aO60mswdbx6DLc68lsjdoIcwcRQOrPgRs2svDWb/IBbo/efMojBSICrvyMrPofY3CnXCQExmCYJ81dQcERjOBQxyiptAYChEXFObAhQctmcONTfX6qSdJUPar9Zox6HSi/4MNfj+lRkCEFr8kvhu2Mw+ZFn5aEWFSBJfFN+ebRUbniMH9X7anhMnLHYznFY5KmBdHx+u65wBmOofiEOAEDHmFeE2/pLpQ3NxC3hP/6Ug1EEUWG6WrH5bHbl7iIMMCqYLQBLR4bCcssKZu6CLVoilb4SMNoFeYrC+m
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(3613699003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uopaPnCY97z1xWFQn9t/vz3meNjOm8KxcwOROeyyAMgjDVr1mjbJ8JLv5bWD?=
 =?us-ascii?Q?ZKg9sfuwBIPZ3vTbfvXZ7nx7sMQ1W0DV/8+/s4viuThfEoyc549M1jeR7mba?=
 =?us-ascii?Q?yYaldIrnHqmNAoj/CcBLPIl90LnG+K228nbRnh3eWEU1YeAewmm/+SIWfD54?=
 =?us-ascii?Q?WMVJyyL8z+26G7Rg6HAdlO9nnjlINWN1rtij1RzKQrRyHpEeH1c+og6CeYjK?=
 =?us-ascii?Q?/0K3tOTe0AU2oNtvBUSK5h5TCYAwbsLM/2w+3dLmJoPueNrEXMNrpNFlAVdf?=
 =?us-ascii?Q?vtTqj+9PhuYSxNFJA8gua8CwLBW1BmE00TRfhtqPLd+2HjiiVMotZohsjpvq?=
 =?us-ascii?Q?Xjv/kVmgbswxK+3sSvch0YFJV3h4j/a9K+SM2wBMsjigFShDmSqjzWb9i1Ld?=
 =?us-ascii?Q?pzTupkHI/BSnx+WouA6vIFRgmi1FZbRC/sUiX4LX76+4HU4coldOXVQuu7KF?=
 =?us-ascii?Q?YVbFWOT07ul+ORj+KMQqk35FEg3QuL2BR/9fT09iIMZ4khGVEDL4F0uFEVH/?=
 =?us-ascii?Q?FTK6FbH3P3FuOycxwM2RMWx8QbsjXu8sTgECC5zAOQGHQPneGgC6+5dlTMam?=
 =?us-ascii?Q?Lxu5vmMUhipv+XwSDHzGNkDlZ4VqGZRzXcVS7l6+/t9nt43iS4t3lWDUPt8f?=
 =?us-ascii?Q?110zoeALeWPKJBoWOCWp1kSqEI9fTTjmmfS95PXw508Bh+PZOJUjYRC2mUTO?=
 =?us-ascii?Q?wlVLhliBb1URv0ploYtIsuucM8wCyuFmytg2n2hKBn9Vw1QBHi+zWBUmlRDu?=
 =?us-ascii?Q?QIm0U6SKbwtO3e6kCo+l7L4WrqBhK/zy3A8ybAnbevkNzr4MJZ6uUlun1OX2?=
 =?us-ascii?Q?4nJTUStn0BKiwuFmKTWzbBaST2jym4JhNN/mzAZNe+OZRt5KYlMo/PImKjzd?=
 =?us-ascii?Q?tuHI1yqAtcGU9KWlSXsZdmgf9xUYo0z+zvgmhxBovBgRm2m0XW9Ka/FI5jcB?=
 =?us-ascii?Q?raz2/h86ePWTtrYgoDT37TLYnT0vEGAd+ZIQDZlO/GQsqDsNCK7EvQEmyRTv?=
 =?us-ascii?Q?hSiQjQ1WEFM8GaaWuYWTQYreKe7VvYxYe22wP6JR+pywXNRPKrV6emzCBDsm?=
 =?us-ascii?Q?TwDFKmCGf2tXpkpC4Lh1WQ3XuhREexAnlSbEg1CXOkVXVDoEX+1SP3fui2Rs?=
 =?us-ascii?Q?WRnrC8GAgCD0Kk98DCY+yW6xSFLWS4GrM30wq1jwrHT8VtZSqYAHcM5kfdMC?=
 =?us-ascii?Q?r9njPJXMdtYxc7uruS3CRQVdwcAhPjvyozjN0RSMHtDeoCwJu0W92sFbcg0F?=
 =?us-ascii?Q?gPWei15/VebgyhdB/WzXmXBYazC9T+JUHUHWV3LForjLJ+pCnfapjOSHipnt?=
 =?us-ascii?Q?B7F2Sa6J0fH1iCZsSHLdjDvcEoxwv61F8YYE7byXgcGYt7fwmCWB2xRYxHRH?=
 =?us-ascii?Q?rPxsQJHjwkIcO126/q9+FdZ/ot9tiN8vXKDNQ+eHxdoMxgRPUf47Ns75FBQ1?=
 =?us-ascii?Q?2cnxi+kqqdB56yUk6mzI4Zph01TekS+B1pC2sfmD/mpNaDq5q9nE9vUTdfeD?=
 =?us-ascii?Q?hJdb/VdRaFGdJZ5mggJJKim9LTNxgRAP764y3bcej8bWeqv+ZVto29Dp7W4L?=
 =?us-ascii?Q?zQ6t9Ah7yh4NMRY0qONibGcRt1Y0GrVDqhURtNc1?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deae64a7-1288-4765-437e-08dc57ab54dc
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 09:07:35.8894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iki/LjhTyO93KkD9mw+elplBE1GgkmPf1aJzjqa3IF4z4cSo3qLGkaFCdq2ytFyLWQJ8dGUvYCs8JjNuX19+Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3342
X-Proofpoint-GUID: dt9ItZBScrvWKnsF1ZqYyIKzIjkGQEMg
X-Proofpoint-ORIG-GUID: dt9ItZBScrvWKnsF1ZqYyIKzIjkGQEMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404080070

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

This series is for adding support of high-end specs ICM-42688-P chip.

Changelog:
* v2: change order of chip definitions and order of patches
* v3: add patch description and resend without email IP header issue

Jean-Baptiste Maneyrol (2):
  dt-bindings: iio: imu: add icm42688 inside inv_icm42600
  iio: imu: inv_icm42600: add support of ICM-42688-P

 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml     | 1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h                  | 2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c             | 5 +++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c              | 3 +++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c              | 3 +++
 5 files changed, 14 insertions(+)

--
2.34.1


