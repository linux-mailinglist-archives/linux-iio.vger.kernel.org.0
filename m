Return-Path: <linux-iio+bounces-5871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 096DD8FD6F1
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 22:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001CF1C21E71
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 20:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312F215534C;
	Wed,  5 Jun 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="iolf/KuJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276C155353
	for <linux-iio@vger.kernel.org>; Wed,  5 Jun 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617648; cv=fail; b=GslwktG1g2nH/2Q7rHw2Y811wTvjZqlHEcOil/V9x/DIi9kmJw/9ZXzGbkkYB3H9/KX7YMqMV5SfpHv14EygePlpGbivyHHh/+p9sn1Q+I3bv/7W9oB0Dz9jPk8b9KU/cK9styzC7e3d4SsTLa2BL/EVQw/b9aWKxhxdMOV81PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617648; c=relaxed/simple;
	bh=LliGq3EdtFTUow0w2Qe137B3mZIRgRsUn4rxq8aDQ00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s3+n6XC4KbvXFC33q5tZsAxTRPjyPvPMARmV0SRypH0XhL6E+cfiFtltP4Qh7LDiFCVGh85kBPjx/sWHyypy+Mhq3toeIoCwtXBCh0VNT1mEoGn/YNICyO1vL1H/VtHRYMq4mtYTZsX9GmknxBkbUHDI78AxWBoK3UqgSZHK4Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=iolf/KuJ; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455JQoGf011062;
	Wed, 5 Jun 2024 20:00:21 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17010002.outbound.protection.outlook.com [40.93.73.2])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3yfw0wk9q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 20:00:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC7Q/I7b78/9BsnyVVugbSZW8hdXWEzSFsJer5FhJaTtKmenhKt9rJjH8gl75j7mXUs4UeCuWtbtNQEFJZB7aEVS1zrfNp6oKJMOzNFY9lWr8HSaVhXpIBbYbXswp+zrCpQT9UPXA+3wU31ggpkqn6BjJaOVIyyluu4lQsgKlq3+ZG+eCPJ4Z/kfsu+yPMrKAZqBuSrqrhhIDMBn8FIEAS+4OpdEmFfDhc4RFjE3a9D1N+JmyfLS80GKAkv81wva1xLFSUhc/uBlSG1UV65g3vv2uFyK4NdkxGZzykC4xmi/iqa8y23GiR/8thI1BUFErNS8YT2RhXio020EpAQFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggt555Co0QuIA1NHBFCT9UpUF5eZIN2srNqKh/a3PAo=;
 b=UuCG3Y2uINpL6wEqAOhV4eWWxLgipMtfmAbAXCcaJ+Tt5YgTC6+YYion9pvLATLAoC6+RmflzydWYp6SgY3fqNLw/TTvR4ffbsF51H28oyv6oUxq5PC4s5TE83aS5/F66WR5OfV/Hah6GuzXUloFD47eXkKem7vJzQENw++T+Yn0bA6ljPJ7nQU41SHbect0opOM1ugdvN9ePY3mS7qnRCl2MXMwgb39BLjjBvnZ2rJqxTp8BxmMo1Hqj9QosZbCsxJAb95QgCbM7/LNc/sF7yDf+b+J1yncR4kj+cfSh0fWMmApWf7+5kQ9aH3IMF1Hx4T0YrnMoHESA1MK8CbIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggt555Co0QuIA1NHBFCT9UpUF5eZIN2srNqKh/a3PAo=;
 b=iolf/KuJyjwyX1/mOBI8ewqSYAsel6GfS4RNHacfxK+R6Zk0A8N8UbaN/+9qgDoPWcNmApTkJgBZbdgsBRgS0LBZUm2dhG20FlCIifpxyXv9ACVJUEGLDeipOLQ+KB6yLd/sBuEpAU483MLR/Xbb5frPYXfhWkwvfzYM01F5J0VNLzU3GekHVDwX0i5KJ9cDfdfu1znMjqT3gIsokChFq54YKbyowFERIF/GM9Oo1SyXy1luUddjOEsPeHsb6EOzB6GakLqAwwg1MvXuBRTBy6cIkkee7pm8OjU6mvGaa2ND3mdEr3Iow49SCey9grJSNvkZDH4Dhvnw4KRrIIjC+Q==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYWP286MB2172.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:173::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Wed, 5 Jun
 2024 20:00:18 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%3]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 20:00:18 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v4 1/2] iio: document inv_icm42600 driver private sysfs attributes
Date: Wed,  5 Jun 2024 19:59:48 +0000
Message-Id: <20240605195949.766677-2-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240605195949.766677-1-inv.git-commit@tdk.com>
References: <20240605195949.766677-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0042.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::23) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYWP286MB2172:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8aed80-c152-4ec1-535a-08dc859a1f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|376005|1800799015|52116005|366007|3613699003|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3Bc0LI3u1uDHBeOM7JtYO/PQm3F/3206rAOahoo/5HO+6uZ1OQ9HWPL+ftTW?=
 =?us-ascii?Q?eoHpP/omSu/QrlcwTQLN03vWu3b7P2kWOQzEO/XEaBwIBDaIjIN0LM1WA6uN?=
 =?us-ascii?Q?3lxysMdXgGGDkDJMePn601OnNrAfbYVduagirqx/V1xcgERpu0Wmnm2HHx1k?=
 =?us-ascii?Q?HElGo92Wziw95CokDe8BBCHNX9gfTtrFzHHv61stpv0tGkKXOGZU20TSJqe1?=
 =?us-ascii?Q?AOhqUovUNSb5uxk7KYh86100vd+hEwabAWB50P/PgmYoOXlONzGlgfuGKHV2?=
 =?us-ascii?Q?NqyxKot7vzPLgRWB+tPkcgp+NTDXZP72KBaXcXwyuvLYhHsTuUNEG1RKCqF2?=
 =?us-ascii?Q?0FjDz7OfRS+K7SUR2H0BD2Np5nrriFmCxPqByogeSDJkqJAOZ/aZxPVyjzTc?=
 =?us-ascii?Q?fCIV2ARE8tXZp8jHvjPCI58i7vd3sqeWXVC4UQvZsMLcfTMse5CMFT0QA2zg?=
 =?us-ascii?Q?IFIFKB0PvX9z1lGOJC6QbQBfQKZC/OPPcf0TGIuOZIku22RmJvAdr8+ta7b2?=
 =?us-ascii?Q?YyvdV7Y/E2M7rs6yY2/R8/cvWvd1WE9es5KXm3LjzlJfuZuRSAIPa0NmZAwG?=
 =?us-ascii?Q?BrT0y8+9VhPX1OkZKneBTQnZr1sTBbtuYF4olHnFPD0teD2CKOvYiKd2T1gf?=
 =?us-ascii?Q?LQNWdidt9UITifOiiBTjX52FHnWfOYTdqD4qxZouCPY1/kzj/1vYCKsbmanc?=
 =?us-ascii?Q?F2MMktH05up67FAh2z4wBvXb6DmWV2kPjFDbxv9IrExmQ6u4hjn65RJ9wGbf?=
 =?us-ascii?Q?8KdPx64VRDoZr7ExsWKWsfOKEMbHf8ULqyPvjLx6lTAA5L0K/k0lU5E2rz7M?=
 =?us-ascii?Q?JiPwJBg3rMqo4QphvzbG0/NrwOu/zP6IvWmCLwp4mFfi6rVpDmXLQNnWsFdu?=
 =?us-ascii?Q?jo907lbJdowJzUVk5jmncEEIYDo00LnrA2M+noWicl7hm2a1lnDw7Gq2477X?=
 =?us-ascii?Q?H2BB4ZZUz/UYU8zl9pdrIbM6WBXeQ1flilAniDE8G/y74RpIsSFqVz+i7WCU?=
 =?us-ascii?Q?tBmFHDoBRVwI5jw2TcCnOHjQ2ZOxTrT32N+QzR8fh6Bo6ucNwJWrnHqgyUHm?=
 =?us-ascii?Q?oNbEIgKAFflKQsdmuU4TeaxEO0PY64yu6LphaPwy2NLZ7KWFKk4ipen2LVtx?=
 =?us-ascii?Q?hwj/ZMC7aqIkGwmILx7nLaceVDLADXGCxcJZsDuhx1no7i897plFi84c7wZO?=
 =?us-ascii?Q?T94CLXd4XtJZW7YF+L/+WCxMDH7B9Md7a2wy1GETvSW1zC14Tcy2K1SzfTZY?=
 =?us-ascii?Q?9yb2Bfl1KoaaUbAL9mUCRASN7CN1Iz2kXveDLZyL4e9DalJZLTjmcfr+DcOK?=
 =?us-ascii?Q?BWluVm0O5QwygICIcrk2kvfd?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(3613699003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+AnO5Di841FWZZ1yrkOa/osva9wsxfQ8nvDJrugyYgveEk3OAKW6eIGlfG3Z?=
 =?us-ascii?Q?1nmYrdADs/0A/FC8FKz2zLjuhbCFt19UbQtYTs96/a7gcCADcB8WMYMY6pF9?=
 =?us-ascii?Q?XkOr8SWOMc1FDUKYoaC1h9JsWIB3r11fWxHVmRnSKvy8RZFPdcBB2QVWKIXZ?=
 =?us-ascii?Q?tc/cNlV4DCTcbbAixkJvpG5i/LDqq4xe5Rg9qCKJMQY52N7P6Sfuu8CSkE4z?=
 =?us-ascii?Q?VzQ54xKCYGBdXDL0a9IbC0oWK1fLbcdJP++Z5cL8lhjO2fq0XM0047iCzxXC?=
 =?us-ascii?Q?znlHyt7MclVzTFjsZj6uXOO4H3oitaRdvnBRms0zcSFiMwD8t9eXxzJYLHGN?=
 =?us-ascii?Q?fXCLKubSWIAH4uQh3Pw7Z8Tt67eAxkralMdmWURVmur6N0P+evfdcOG/v4Ej?=
 =?us-ascii?Q?wqLZIut3qyDgl3Bu8SW/7dyhCw8DnUpExbQtsqCXkJOJd2MYhS4xrp0WY/62?=
 =?us-ascii?Q?O7YyD1pFtBwpCE2Pt0G45rzO627EUvhXJh7Sh43SVZdCXc8nQSUcIJ5PHnd1?=
 =?us-ascii?Q?7Sy13i+REliF2grvfdkLMLRpivVAIfG/a4aX1IjjW+3ZoqboJ5WrJPtkC1Ei?=
 =?us-ascii?Q?WPixfLM2pEqSihMgHt/lM6KPjfpE0dw/ip7OsrHTnO/QRWh/oXQUtgZNHy07?=
 =?us-ascii?Q?eKgIK1upNb1wDNQufUTqKhkHmbGCsrmA/3szbbAF3sWM4DPiYOFyqH7iWtX8?=
 =?us-ascii?Q?VlFIxD/05AJY4D7PrwvldySetQ9MdTxDQHtioHt4vmD5ql3xXulISjEaVLWG?=
 =?us-ascii?Q?rXsC5dcsvRZQclYWYdxWH3x7nabWHXdiAUfmhwbG9ZkfUJjqO/UFeZ5XQYum?=
 =?us-ascii?Q?YYgzVjA4ZRCXPsGFBZnOg/7QP/tTjnxSTTJ73A+gh3VKfjep0/9+FRp+3iow?=
 =?us-ascii?Q?QBLg/K1rlwBRbMeSrw9cP9kDoTG8sfamAMePJJEEzReTvIeA7xp+Rjj4z1Uv?=
 =?us-ascii?Q?cWsOInpYL1zIlvmDj7ToqwdJJEsYbHMmEXtDeQ8b4X8K3DBfeR1BtOorIcKJ?=
 =?us-ascii?Q?BT6ULvskOihAA3PXn2nl92d0zfSYcFnrAD5hoKhI7zEnm0EiqSHCLsrm3yER?=
 =?us-ascii?Q?hMDtF5fjKemyDDvdPoe6yomFx/Jcmzz0zqXIeFw0TiHQ7srTprzoJq1d8yT/?=
 =?us-ascii?Q?DlYBLsRxpqCf8SW5yEdBAr+WqcLnwh2vvog+8gPsxrqRNSsxRzOR86MiExgD?=
 =?us-ascii?Q?x95jAhc5mVIIFWQbqw/YkGIgyQ1jvDfK2298BZurdhlnmcJl0Mw4vkSyZGvb?=
 =?us-ascii?Q?IDGX4nvWlB9QznZAxcGxrxXvBaMEy9pRnzOjlV/X7VfoOOgwXh0b8SSX8997?=
 =?us-ascii?Q?q6ft3cBcXLxFN+OM92bo4L+NqVIOltsr71UcKu7Q2XUMZxTA2LebKXN9j2VG?=
 =?us-ascii?Q?+Yk776f5hSnwWQmF3GqEz3x6zYvGsNjJ11OwnK1liKMe0qgg9ctK/D+t9yt7?=
 =?us-ascii?Q?WXk16iiCxl9nCxAfYesquLBXqKySdvWMqZQYXHWPICp4r7niAogij7JrC7kM?=
 =?us-ascii?Q?ozW9KW4Fg+/jAW6YAO81VlwBfDDkwMZyPI5/+00UZLKCDo3JNh8cW2S3Wnpb?=
 =?us-ascii?Q?il7Ar9wVxzU7bKpwlMaMfkUohjqcmSbIxA+J1x4t?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8aed80-c152-4ec1-535a-08dc859a1f9e
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 20:00:18.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WH5mSqc/FNxm6bjGMAGVpG7RauVdigEyM3oPDBsyofWexcHLnBIpk/U52NSLzOTFoFMj+3ZVLgHMRiOSMnCZtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2172
X-Proofpoint-ORIG-GUID: etI2Q5bscDAYUvCz7ZzZHsA3ufe75DwU
X-Proofpoint-GUID: etI2Q5bscDAYUvCz7ZzZHsA3ufe75DwU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406050151

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add ABI documentation for inv_icm42600 private sysfs attributes.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../ABI/testing/sysfs-bus-iio-inv_icm42600     | 18 ++++++++++++++++++
 MAINTAINERS                                    |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600 b/Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600
new file mode 100644
index 000000000000..7eeacfb7650d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600
@@ -0,0 +1,18 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_power_mode
+KernelVersion:	6.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Accelerometer power mode. Setting this attribute will set the
+		requested power mode to use if the ODR support it. If ODR
+		support only 1 mode, power mode will be enforced.
+		Reading this attribute will return the current accelerometer
+		power mode if the sensor is on, or the requested value if the
+		sensor is off. The value between real and requested value can
+		be different for ODR supporting only 1 mode.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_power_mode_available
+KernelVersion:	6.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of available accelerometer power modes that can be set in
+		in_accel_power_mode attribute.
diff --git a/MAINTAINERS b/MAINTAINERS
index 304429f9bfc6..23526cb6ac7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11336,6 +11336,7 @@ M:	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	https://invensense.tdk.com/
+F:	Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600
 F:	Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
 F:	drivers/iio/imu/inv_icm42600/
 
-- 
2.34.1


