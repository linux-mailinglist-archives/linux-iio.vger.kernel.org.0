Return-Path: <linux-iio+bounces-4439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FA48AD12A
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 17:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF7A2814F8
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC56A153583;
	Mon, 22 Apr 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="aanJ/WUB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D031534F7;
	Mon, 22 Apr 2024 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800770; cv=fail; b=As+ud6GskyVGFOwSZ8IqIiCO/pNGmEDLdVHvETbyrJUnB9rAatixshcyactj1AdaC9JQldC4gvHOrvLm3NqwYfGokPMjSGAo88gh6vmiHQWEjtAmb0E5ijxk7kk4ZKcIEaFz3hJ3JBvzxhlDh5+X+xDrdunNJLj9BEq5XUrp8dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800770; c=relaxed/simple;
	bh=sqC7frUAItejBp841eVb7VMHTAMbn9Lo24sr0ATzoz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H7BDp4YXS7vPjjEsw1iAqdOxjD1LlNreqtfzAPeBJWXnsi7wEcs1DHwpkUEPnvFPI3rFxq4Dv286W1Om+X1Jgy0mMOODH2y7QaRH8OgGB571+iYSc9LrRiI2hx4smi69Ts/jU0kXNHpLTz91O39Q3yVzFc7n2VcjzcQcJ7ubGMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=aanJ/WUB; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M7tqRo010726;
	Mon, 22 Apr 2024 15:23:13 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17010002.outbound.protection.outlook.com [40.93.73.2])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xm72j9aw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:23:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H58AC4LufESH57RnPx107N0R59GKS2/YZzW7nFdQWGx9Q1v2+FDplS54HhAQT9Wz89/CbR1OfIQ4kJpRyhqauSnnqKuYcS89ZDn1Tbl2jkFFVlrA3AAS06Vl0n6jPq4nVArI6F83Cv/yMUPlOKHvOwqoj+bOZfALu3xGlaTDxCBjkYNCyI8PLrpefSU16ZAvncEB605l4hqMYoXZsg69Tz5IP2KtiV9Wnf2kTfIas/5EVD0WS/yoqLkREABWL3ilJ4azHPXooJstyFv6GanX6+ROAkYRjXNvC5uBZaZpQZ3VHHBJLR3RNyabJWC5RhFxirLoRDAGDE/IAj1kXLYOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3TK5j6lhxARCtpfm5FeC6jeLrnd8Y+duuPDiEXrI3s=;
 b=BjCBKPfx9FaNTU/X3YAURLUZQLReu0b/nFmYAO1cyXjyqc5f2xNwii5KPT3oHFxvBsUWWl9m8F2fnGKGAE6spTDmNfDSTsUFN4RD+5gD6TsKeP0eDmDYJqyxAVYz5NrsAw3meYZsHy+y0HUw53x1jZc08s3d8TnTTlM8vVIz3X8YQJh2N85Uh199AAdzshXcbku2NjlQvQpn+w0XEHCkM/fN/vB1y02TZk5o/ypy7Oay+ncUalmM2/wrLaUnCiHXGaBV/bPWBwQg/k9CMNGeFBG3HHUXae0cy1kVq9bYuPBBjuSFq5RT3n5qLIfsNiw1wm4Xw1a1IGILoh1MkN1OTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3TK5j6lhxARCtpfm5FeC6jeLrnd8Y+duuPDiEXrI3s=;
 b=aanJ/WUBcQaUSYpKEu/1a4kPlB4h0TVDakmBTVAlVY8bwn72XP6FN+ztcTLu4L/a2bN9RRL6lNDWqWX8LGQF/dnfUer2cFROpeaT6JJBnXVcjujHwP19I5R1a0Skebu+K8nnuAmo+lteqx9fepP/f5Qhn1TQf5VxqFdnvVSjE9LXmgQ3AOZ2ZGV7KSph+vPH8eNcZeweHFCc2rlcuga0wh47iRSx6Ch1l9nHRnQZuOij4IrOUgpfdMtzBD5uTTbspDUQT6xRaKtd65RSAzU3+1Q7+CeaQeSaaToEZaGN6W9lM7b8zdHJ85xggIpUrc81SpLgYaiibPpEsCJl16T/Iw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYYP286MB4079.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:23:06 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 15:23:06 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 2/2] iio: imu: inv_icm42600: add support of ICM-42686-P
Date: Mon, 22 Apr 2024 15:22:40 +0000
Message-Id: <20240422152240.85974-3-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422152240.85974-1-inv.git-commit@tdk.com>
References: <20240422152240.85974-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::6) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYYP286MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e31f0c-7069-4e56-1f55-08dc62e01bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?a7zCPj7aQXZIPWjjEtebUWz2llvWw0X4j2hcyCgNsxPTFdvjSgY9XtBYztVD?=
 =?us-ascii?Q?ZPIee6BA2GEVQD+uvTP3wZLouFpTS0jv84J21nSe7pklAhQP4qzjJuRNlQFP?=
 =?us-ascii?Q?zdgSB0+k2q+W/Ttj+4s2wZyl65AI/FvT6UWvB3Su7Z0itsm877KPJe3nktBV?=
 =?us-ascii?Q?LwmfozzwqBhpRklFgKoW4oI3n7Nv1rpgLiRYGH6kyL+lkxWNXc4Zq2lIqWzm?=
 =?us-ascii?Q?7PmMc+5M5Q3yAiQtNwOSZdmt1J+sQVfp4ui/MLkm7tyCLMOlMlQa/qs68VsR?=
 =?us-ascii?Q?LeUVziY5q/NKS28ME11T0wrmvKQYML+MuJoFcqec6ljpKTLF/9Zje6fLvSkO?=
 =?us-ascii?Q?wBHCvZVNkN+qtyh6FP2cncX6WjeGBCVIYb3zk//pHcmXYCPK34hjVSC7qjKu?=
 =?us-ascii?Q?gzilFZQPsmwmeMgMmmnMRPcn4z0K+bgOLymUlLbUHa2Hr3+S3NPnX0ZnY0pc?=
 =?us-ascii?Q?09mliK89cZ2XnqmIaoH4lM/YNYE0m/NK7xqem0QlkUwD/mB+Wyim5xCQFTKL?=
 =?us-ascii?Q?xl9+y2IqvxTWFADzafidym066yCVr9Re2NqF9MDFiQcVxrNHkuV11CoLOWx2?=
 =?us-ascii?Q?g7PNPr3/Xbyvo6rR+2bh1hpnW+onOJ+fAwlREty2JSLNNYOaj/J7rIA36E7N?=
 =?us-ascii?Q?niqe5WqP2ayeQeMp9OFCspMA74nmwLolcPHrjUxHvZXnNrsOUiC9HJckro9H?=
 =?us-ascii?Q?F8gehQ+xZz7GthRH0D/dI/kM+/UN4adC+Ft5TJ/s9FazhovZlP8gIYITgsgF?=
 =?us-ascii?Q?0HAILTjBPR0jaIt1JH5+zX+/EVJkEs3j4cSqwIc5g6+eNNgmvWqX+QltDVNs?=
 =?us-ascii?Q?ImxPddQOtwXhjXj0Vy54FbjlkuVJsq0CVf/HfbKEsjTqRWrcFpIrJWhsTucR?=
 =?us-ascii?Q?/bxeFJx56UYazZbBlv737QofKvnHwkeE/BT3tpZB/oS4tTwPo029fBDTnXUM?=
 =?us-ascii?Q?Jij8ix/d1ugD7EqYjTZcRvmJFv3B2nhHmINT8DVqVI39YBSszbqauUjGPIX4?=
 =?us-ascii?Q?lDzUk/bpG3bXe8w4/kJ8ykUNRE0q846NqilVKJ6006gHWXm/mo3bg6+Ke/rg?=
 =?us-ascii?Q?80IIm0adjiDRZO7IGK011TymHVl4HfkiO370k7VfUjSCpWxQKjyAW0UeqK62?=
 =?us-ascii?Q?iwdFfJYLVSlzNtPyOjpByiRQHsNM5jLV9t0gExE7z+Li7HHrbEITfkevIsvh?=
 =?us-ascii?Q?hFz+QUzE2ppjFOMRYcQBIAM4PIEr9740M8kJbMmlCg2N67VEsq/u1Gp3wv+a?=
 =?us-ascii?Q?pDA7IMhCcTwEhb9JjrSlcoTw3Ep2c3Fyb9mugO09oL85xb5nuQ89WVkEuzP+?=
 =?us-ascii?Q?nv07onw8dHBYZ88N9ZRMbmOuI0w/4Aj8/J6c6A8OyFwD5gaY8QxN7fNFmjx+?=
 =?us-ascii?Q?yV/5vpE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+lBdI6NFlhh2WphdQZXOyxzEMlTd7Zmc2q100/XIfQBKomkVHMmqgxdIdjlX?=
 =?us-ascii?Q?AKSkCMpEEl/JbEgZep7aG/pr4IycB2Nv/r55C5J3aDdUu9/fXXCwUwOmWq5o?=
 =?us-ascii?Q?H5P10JvB/Gvhjl6JrX7BkTYJtJCzhLkM2X2Ji2Zn/iKJZMWtoYuNdzxfGltc?=
 =?us-ascii?Q?Lkew1YOmHwUglwGBp0zg/itXMBRbUEKJvRbdyrmCoeUe37+bban1bHQMgTYJ?=
 =?us-ascii?Q?bIUk1g6nIJoYzHCDTdtVyiIGYV+fxm7FKLHLjdzERGOpGXKTBpPx2qq/hE8N?=
 =?us-ascii?Q?X18cG5F6bljTTOoDqGG6FgDCftrvGtLuypnvYO5UzZKrmC0ZvYpT9+c3XxhX?=
 =?us-ascii?Q?zi96dLphUSAenXDRVZW4XYI2BV5WTWmb2qrttk1o3HG5Pl1rGqe2DOVWDmvz?=
 =?us-ascii?Q?PW8xbsniF8xJXPwAyZxuM3zhG6XBu5oSFX1lorw5XXoqJgGzGo4NOcfF0rbP?=
 =?us-ascii?Q?BJFIEficuYnvedhkzqdbdP/FJVxHq5CJI7kdtaKm3qi0CkkYqMKPoCOwln6Q?=
 =?us-ascii?Q?5g6la1Net5mZ/qnuA3Qv8MdaE6eKXAbZ26f7uQvMBRpWNTwCt4uitSfhXFHC?=
 =?us-ascii?Q?WD9P0GdX+cV7gg2rrKZSXahCLcEe3rQzRToHd7o+fImYjw0UkaNAE6k7tTXf?=
 =?us-ascii?Q?hmK0BZCxBEWsMBTwHWQiW3j7yXXeS2n1hVdWC1Je+TTh6cbxbFG5pXf2tDqy?=
 =?us-ascii?Q?XB9+yjot5JVySpX9YWsNsnOtIjoNsKGw7lKoKCvuM0z8woZAAhgQ2+RnMaM6?=
 =?us-ascii?Q?nA6nsu8Jtlz8NbCV4LCp+dXVlPZx5AjSM5D6aper5uePjQQCWbAg+EROYIxg?=
 =?us-ascii?Q?+FTuW1mR6IDfzE17dVUmC20gQs1kQbkZ38MjAuHecHd5s92JINMjOnV/cYCe?=
 =?us-ascii?Q?X3a9y2IfPETM3M82LE5xG69slDl8/nU+EV4ztYUMChG7KN4asic7PTBqfz84?=
 =?us-ascii?Q?qyMQCO208SP2OsPteKP+Dj+HJJiSiBpbXkRCsli5D2cxdkMUE8REchjxNsjh?=
 =?us-ascii?Q?v0Ribznl56z9kuVaDezNVv4DXuu+RPq4QynzA8ZkjUfJ9/knTn5JULZQfh5E?=
 =?us-ascii?Q?gmDkNetZ4w9sy9y/EPRtfn9Qj5KvBJJsOfv1b2eIYgEcTPXrMPbtOHc/RiYF?=
 =?us-ascii?Q?Mbwt1b64ZbxKT6G4rMPX2SUzwOh8Sqm9nXv7jqKDaWQn8ZLLKxBSfY5J/YMb?=
 =?us-ascii?Q?TcKHxFMql/DQcYyHFyvRAL7EobnVdF0o4mN/ESS7K2HrBmMeVIDDPNlXJc5Z?=
 =?us-ascii?Q?IhMp8PhmdU8DskibRHmfEXBnNmOBBd+MB81BXYMrBqzYS0m3voJeB5VAaSZx?=
 =?us-ascii?Q?GzKI1ib0nz2kOPfsdRJBqwqr0Mz6ZWfyv3UyH112mQrySIrB35FjjH9lQEri?=
 =?us-ascii?Q?/hp0qA8tmRyl7WEMkeUsvOctTWwmHVj6rGLk6OQllbkIUDAHgBZilIe1+jp9?=
 =?us-ascii?Q?GsLtC4EHVqsweY/ocYsVbDVM+UuO3sEY444SCUEM3GSG18A4AbIDuuh+q4aa?=
 =?us-ascii?Q?Z+ru5Bc3HYqx/lzSucX7mKbvASrB2iHSejCHFACFwWp5fiyrOcHYEI5QVSI+?=
 =?us-ascii?Q?CEr4pmvh8n0jrn2LcuHbiT13vzSBoSJ+ZdMZUCda?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e31f0c-7069-4e56-1f55-08dc62e01bde
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:23:06.3942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdLo3ifnZXx5Ei9zchifRrM0Po7lImMEX26bp1bhZcw58kL+ykLudyLV2wdsGEqbYM2Q1DfQpRbFZgRyYCrKiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4079
X-Proofpoint-GUID: xa6BYPs1cL4vWQ5La3rFBAGwDi5JUYRb
X-Proofpoint-ORIG-GUID: xa6BYPs1cL4vWQ5La3rFBAGwDi5JUYRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220066

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add ICM-42686-P chip supporting high FSRs (32G, 4000dps).

Create accel and gyro iio device states with dynamic scales table
set at device init.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   | 35 ++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 75 ++++++++++++-----
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 15 ++--
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 20 +++++
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 84 ++++++++++++++-----
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |  3 +
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |  3 +
 7 files changed, 192 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 0566340b2660..c4ac91f6bafe 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -13,6 +13,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pm.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
 
 #include "inv_icm42600_buffer.h"
 
@@ -21,6 +22,7 @@ enum inv_icm42600_chip {
 	INV_CHIP_ICM42600,
 	INV_CHIP_ICM42602,
 	INV_CHIP_ICM42605,
+	INV_CHIP_ICM42686,
 	INV_CHIP_ICM42622,
 	INV_CHIP_ICM42688,
 	INV_CHIP_ICM42631,
@@ -57,6 +59,17 @@ enum inv_icm42600_gyro_fs {
 	INV_ICM42600_GYRO_FS_15_625DPS,
 	INV_ICM42600_GYRO_FS_NB,
 };
+enum inv_icm42686_gyro_fs {
+	INV_ICM42686_GYRO_FS_4000DPS,
+	INV_ICM42686_GYRO_FS_2000DPS,
+	INV_ICM42686_GYRO_FS_1000DPS,
+	INV_ICM42686_GYRO_FS_500DPS,
+	INV_ICM42686_GYRO_FS_250DPS,
+	INV_ICM42686_GYRO_FS_125DPS,
+	INV_ICM42686_GYRO_FS_62_5DPS,
+	INV_ICM42686_GYRO_FS_31_25DPS,
+	INV_ICM42686_GYRO_FS_NB,
+};
 
 /* accelerometer fullscale values */
 enum inv_icm42600_accel_fs {
@@ -66,6 +79,14 @@ enum inv_icm42600_accel_fs {
 	INV_ICM42600_ACCEL_FS_2G,
 	INV_ICM42600_ACCEL_FS_NB,
 };
+enum inv_icm42686_accel_fs {
+	INV_ICM42686_ACCEL_FS_32G,
+	INV_ICM42686_ACCEL_FS_16G,
+	INV_ICM42686_ACCEL_FS_8G,
+	INV_ICM42686_ACCEL_FS_4G,
+	INV_ICM42686_ACCEL_FS_2G,
+	INV_ICM42686_ACCEL_FS_NB,
+};
 
 /* ODR suffixed by LN or LP are Low-Noise or Low-Power mode only */
 enum inv_icm42600_odr {
@@ -151,6 +172,19 @@ struct inv_icm42600_state {
 	} timestamp;
 };
 
+
+/**
+ * struct inv_icm42600_sensor_state - sensor state variables
+ * @scales:		table of scales.
+ * @scales_len:		length (nb of items) of the scales table.
+ * @ts:			timestamp module states.
+ */
+struct inv_icm42600_sensor_state {
+	const int *scales;
+	size_t scales_len;
+	struct inv_sensors_timestamp ts;
+};
+
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
 
 /* Bank selection register, available in all banks */
@@ -304,6 +338,7 @@ struct inv_icm42600_state {
 #define INV_ICM42600_WHOAMI_ICM42600			0x40
 #define INV_ICM42600_WHOAMI_ICM42602			0x41
 #define INV_ICM42600_WHOAMI_ICM42605			0x42
+#define INV_ICM42600_WHOAMI_ICM42686			0x44
 #define INV_ICM42600_WHOAMI_ICM42622			0x46
 #define INV_ICM42600_WHOAMI_ICM42688			0x47
 #define INV_ICM42600_WHOAMI_ICM42631			0x5C
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index f67bd5a39beb..83d8504ebfff 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -99,7 +99,8 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 					       const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &accel_st->ts;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_temp = 0;
@@ -210,33 +211,54 @@ static const int inv_icm42600_accel_scale[] = {
 	[2 * INV_ICM42600_ACCEL_FS_2G] = 0,
 	[2 * INV_ICM42600_ACCEL_FS_2G + 1] = 598550,
 };
+static const int inv_icm42686_accel_scale[] = {
+	/* +/- 32G => 0.009576807 m/s-2 */
+	[2 * INV_ICM42686_ACCEL_FS_32G] = 0,
+	[2 * INV_ICM42686_ACCEL_FS_32G + 1] = 9576807,
+	/* +/- 16G => 0.004788403 m/s-2 */
+	[2 * INV_ICM42686_ACCEL_FS_16G] = 0,
+	[2 * INV_ICM42686_ACCEL_FS_16G + 1] = 4788403,
+	/* +/- 8G => 0.002394202 m/s-2 */
+	[2 * INV_ICM42686_ACCEL_FS_8G] = 0,
+	[2 * INV_ICM42686_ACCEL_FS_8G + 1] = 2394202,
+	/* +/- 4G => 0.001197101 m/s-2 */
+	[2 * INV_ICM42686_ACCEL_FS_4G] = 0,
+	[2 * INV_ICM42686_ACCEL_FS_4G + 1] = 1197101,
+	/* +/- 2G => 0.000598550 m/s-2 */
+	[2 * INV_ICM42686_ACCEL_FS_2G] = 0,
+	[2 * INV_ICM42686_ACCEL_FS_2G + 1] = 598550,
+};
 
-static int inv_icm42600_accel_read_scale(struct inv_icm42600_state *st,
+static int inv_icm42600_accel_read_scale(struct iio_dev *indio_dev,
 					 int *val, int *val2)
 {
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
 	unsigned int idx;
 
 	idx = st->conf.accel.fs;
 
-	*val = inv_icm42600_accel_scale[2 * idx];
-	*val2 = inv_icm42600_accel_scale[2 * idx + 1];
+	*val = accel_st->scales[2 * idx];
+	*val2 = accel_st->scales[2 * idx + 1];
 	return IIO_VAL_INT_PLUS_NANO;
 }
 
-static int inv_icm42600_accel_write_scale(struct inv_icm42600_state *st,
+static int inv_icm42600_accel_write_scale(struct iio_dev *indio_dev,
 					  int val, int val2)
 {
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int idx;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	int ret;
 
-	for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_accel_scale); idx += 2) {
-		if (val == inv_icm42600_accel_scale[idx] &&
-		    val2 == inv_icm42600_accel_scale[idx + 1])
+	for (idx = 0; idx < accel_st->scales_len; idx += 2) {
+		if (val == accel_st->scales[idx] &&
+		    val2 == accel_st->scales[idx + 1])
 			break;
 	}
-	if (idx >= ARRAY_SIZE(inv_icm42600_accel_scale))
+	if (idx >= accel_st->scales_len)
 		return -EINVAL;
 
 	conf.fs = idx / 2;
@@ -309,7 +331,8 @@ static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
 					int val, int val2)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &accel_st->ts;
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int idx;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
@@ -565,7 +588,7 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
 		*val = data;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		return inv_icm42600_accel_read_scale(st, val, val2);
+		return inv_icm42600_accel_read_scale(indio_dev, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42600_accel_read_odr(st, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
@@ -580,14 +603,16 @@ static int inv_icm42600_accel_read_avail(struct iio_dev *indio_dev,
 					 const int **vals,
 					 int *type, int *length, long mask)
 {
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
+
 	if (chan->type != IIO_ACCEL)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		*vals = inv_icm42600_accel_scale;
+		*vals = accel_st->scales;
 		*type = IIO_VAL_INT_PLUS_NANO;
-		*length = ARRAY_SIZE(inv_icm42600_accel_scale);
+		*length = accel_st->scales_len;
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*vals = inv_icm42600_accel_odr;
@@ -618,7 +643,7 @@ static int inv_icm42600_accel_write_raw(struct iio_dev *indio_dev,
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
-		ret = inv_icm42600_accel_write_scale(st, val, val2);
+		ret = inv_icm42600_accel_write_scale(indio_dev, val, val2);
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -705,8 +730,8 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
+	struct inv_icm42600_sensor_state *accel_st;
 	struct inv_sensors_timestamp_chip ts_chip;
-	struct inv_sensors_timestamp *ts;
 	struct iio_dev *indio_dev;
 	int ret;
 
@@ -714,9 +739,21 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	if (!name)
 		return ERR_PTR(-ENOMEM);
 
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*ts));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*accel_st));
 	if (!indio_dev)
 		return ERR_PTR(-ENOMEM);
+	accel_st = iio_priv(indio_dev);
+
+	switch (st->chip) {
+	case INV_CHIP_ICM42686:
+		accel_st->scales = inv_icm42686_accel_scale;
+		accel_st->scales_len = ARRAY_SIZE(inv_icm42686_accel_scale);
+		break;
+	default:
+		accel_st->scales = inv_icm42600_accel_scale;
+		accel_st->scales_len = ARRAY_SIZE(inv_icm42600_accel_scale);
+		break;
+	}
 
 	/*
 	 * clock period is 32kHz (31250ns)
@@ -725,8 +762,7 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 	ts_chip.clock_period = 31250;
 	ts_chip.jitter = 20;
 	ts_chip.init_period = inv_icm42600_odr_to_period(st->conf.accel.odr);
-	ts = iio_priv(indio_dev);
-	inv_sensors_timestamp_init(ts, &ts_chip);
+	inv_sensors_timestamp_init(&accel_st->ts, &ts_chip);
 
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->name = name;
@@ -751,7 +787,8 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
 int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &accel_st->ts;
 	ssize_t i, size;
 	unsigned int no;
 	const void *accel, *gyro, *timestamp;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index b52f328fd26c..cfb4a41ab7c1 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -276,7 +276,8 @@ static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
-	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
+	struct inv_icm42600_sensor_state *sensor_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &sensor_st->ts;
 
 	pm_runtime_get_sync(dev);
 
@@ -502,6 +503,8 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
 
 int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 {
+	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
 	struct inv_sensors_timestamp *ts;
 	int ret;
 
@@ -509,7 +512,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 		return 0;
 
 	/* handle gyroscope timestamp and FIFO data parsing */
-	ts = iio_priv(st->indio_gyro);
+	ts = &gyro_st->ts;
 	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
 					st->fifo.nb.gyro, st->timestamp.gyro);
 	if (st->fifo.nb.gyro > 0) {
@@ -519,7 +522,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 	}
 
 	/* handle accelerometer timestamp and FIFO data parsing */
-	ts = iio_priv(st->indio_accel);
+	ts = &accel_st->ts;
 	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
 					st->fifo.nb.accel, st->timestamp.accel);
 	if (st->fifo.nb.accel > 0) {
@@ -534,6 +537,8 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
 int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 				     unsigned int count)
 {
+	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
 	struct inv_sensors_timestamp *ts;
 	int64_t gyro_ts, accel_ts;
 	int ret;
@@ -549,7 +554,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 		return 0;
 
 	if (st->fifo.nb.gyro > 0) {
-		ts = iio_priv(st->indio_gyro);
+		ts = &gyro_st->ts;
 		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
 						st->fifo.nb.total, st->fifo.nb.gyro,
 						gyro_ts);
@@ -559,7 +564,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 	}
 
 	if (st->fifo.nb.accel > 0) {
-		ts = iio_priv(st->indio_accel);
+		ts = &accel_st->ts;
 		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
 						st->fifo.nb.total, st->fifo.nb.accel,
 						accel_ts);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 82e0a2e2ad70..42316fb72674 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -65,6 +65,21 @@ static const struct inv_icm42600_conf inv_icm42600_default_conf = {
 	},
 	.temp_en = false,
 };
+static const struct inv_icm42600_conf inv_icm42686_default_conf = {
+	.gyro = {
+		.mode = INV_ICM42600_SENSOR_MODE_OFF,
+		.fs = INV_ICM42686_GYRO_FS_4000DPS,
+		.odr = INV_ICM42600_ODR_50HZ,
+		.filter = INV_ICM42600_FILTER_BW_ODR_DIV_2,
+	},
+	.accel = {
+		.mode = INV_ICM42600_SENSOR_MODE_OFF,
+		.fs = INV_ICM42686_ACCEL_FS_32G,
+		.odr = INV_ICM42600_ODR_50HZ,
+		.filter = INV_ICM42600_FILTER_BW_ODR_DIV_2,
+	},
+	.temp_en = false,
+};
 
 static const struct inv_icm42600_hw inv_icm42600_hw[INV_CHIP_NB] = {
 	[INV_CHIP_ICM42600] = {
@@ -82,6 +97,11 @@ static const struct inv_icm42600_hw inv_icm42600_hw[INV_CHIP_NB] = {
 		.name = "icm42605",
 		.conf = &inv_icm42600_default_conf,
 	},
+	[INV_CHIP_ICM42686] = {
+		.whoami = INV_ICM42600_WHOAMI_ICM42686,
+		.name = "icm42686",
+		.conf = &inv_icm42686_default_conf,
+	},
 	[INV_CHIP_ICM42622] = {
 		.whoami = INV_ICM42600_WHOAMI_ICM42622,
 		.name = "icm42622",
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 3df0a715e885..e6f8de80128c 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -99,7 +99,8 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 					      const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
+	struct inv_icm42600_sensor_state *gyro_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &gyro_st->ts;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_gyro = 0;
@@ -222,33 +223,63 @@ static const int inv_icm42600_gyro_scale[] = {
 	[2 * INV_ICM42600_GYRO_FS_15_625DPS] = 0,
 	[2 * INV_ICM42600_GYRO_FS_15_625DPS + 1] = 8322,
 };
+static const int inv_icm42686_gyro_scale[] = {
+	/* +/- 4000dps => 0.002130529 rad/s */
+	[2 * INV_ICM42686_GYRO_FS_4000DPS] = 0,
+	[2 * INV_ICM42686_GYRO_FS_4000DPS + 1] = 2130529,
+	/* +/- 2000dps => 0.001065264 rad/s */
+	[2 * INV_ICM42686_GYRO_FS_2000DPS] = 0,
+	[2 * INV_ICM42686_GYRO_FS_2000DPS + 1] = 1065264,
+	/* +/- 1000dps => 0.000532632 rad/s */
+	[2 * INV_ICM42686_GYRO_FS_1000DPS] = 0,
+	[2 * INV_ICM42686_GYRO_FS_1000DPS + 1] = 532632,
+	/* +/- 500dps => 0.000266316 rad/s */
+	[2 * INV_ICM42686_GYRO_FS_500DPS] = 0,
+	[2 * INV_ICM42686_GYRO_FS_500DPS + 1] = 266316,
+	/* +/- 250dps => 0.000133158 rad/s */
+	[2 * INV_ICM42686_GYRO_FS_250DPS] = 0,
+	[2 * INV_ICM42686_GYRO_FS_250DPS + 1] = 133158,
+	/* +/- 125dps => 0.000066579 rad/s */
+	[2 * INV_ICM42686_GYRO_FS_125DPS] = 0,
+	[2 * INV_ICM42686_GYRO_FS_125DPS + 1] = 66579,
+	/* +/- 62.5dps => 0.000033290 rad/s */
+	[2 * INV_ICM42686_GYRO_FS_62_5DPS] = 0,
+	[2 * INV_ICM42686_GYRO_FS_62_5DPS + 1] = 33290,
+	/* +/- 31.25dps => 0.000016645 rad/s */
+	[2 * INV_ICM42686_GYRO_FS_31_25DPS] = 0,
+	[2 * INV_ICM42686_GYRO_FS_31_25DPS + 1] = 16645,
+};
 
-static int inv_icm42600_gyro_read_scale(struct inv_icm42600_state *st,
+static int inv_icm42600_gyro_read_scale(struct iio_dev *indio_dev,
 					int *val, int *val2)
 {
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *gyro_st = iio_priv(indio_dev);
 	unsigned int idx;
 
 	idx = st->conf.gyro.fs;
 
-	*val = inv_icm42600_gyro_scale[2 * idx];
-	*val2 = inv_icm42600_gyro_scale[2 * idx + 1];
+	*val = gyro_st->scales[2 * idx];
+	*val2 = gyro_st->scales[2 * idx + 1];
 	return IIO_VAL_INT_PLUS_NANO;
 }
 
-static int inv_icm42600_gyro_write_scale(struct inv_icm42600_state *st,
+static int inv_icm42600_gyro_write_scale(struct iio_dev *indio_dev,
 					 int val, int val2)
 {
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *gyro_st = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int idx;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	int ret;
 
-	for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_gyro_scale); idx += 2) {
-		if (val == inv_icm42600_gyro_scale[idx] &&
-		    val2 == inv_icm42600_gyro_scale[idx + 1])
+	for (idx = 0; idx < gyro_st->scales_len; idx += 2) {
+		if (val == gyro_st->scales[idx] &&
+		    val2 == gyro_st->scales[idx + 1])
 			break;
 	}
-	if (idx >= ARRAY_SIZE(inv_icm42600_gyro_scale))
+	if (idx >= gyro_st->scales_len)
 		return -EINVAL;
 
 	conf.fs = idx / 2;
@@ -321,7 +352,8 @@ static int inv_icm42600_gyro_write_odr(struct iio_dev *indio_dev,
 				       int val, int val2)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
+	struct inv_icm42600_sensor_state *gyro_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &gyro_st->ts;
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int idx;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
@@ -576,7 +608,7 @@ static int inv_icm42600_gyro_read_raw(struct iio_dev *indio_dev,
 		*val = data;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		return inv_icm42600_gyro_read_scale(st, val, val2);
+		return inv_icm42600_gyro_read_scale(indio_dev, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42600_gyro_read_odr(st, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
@@ -591,14 +623,16 @@ static int inv_icm42600_gyro_read_avail(struct iio_dev *indio_dev,
 					const int **vals,
 					int *type, int *length, long mask)
 {
+	struct inv_icm42600_sensor_state *gyro_st = iio_priv(indio_dev);
+
 	if (chan->type != IIO_ANGL_VEL)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		*vals = inv_icm42600_gyro_scale;
+		*vals = gyro_st->scales;
 		*type = IIO_VAL_INT_PLUS_NANO;
-		*length = ARRAY_SIZE(inv_icm42600_gyro_scale);
+		*length = gyro_st->scales_len;
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*vals = inv_icm42600_gyro_odr;
@@ -629,7 +663,7 @@ static int inv_icm42600_gyro_write_raw(struct iio_dev *indio_dev,
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
-		ret = inv_icm42600_gyro_write_scale(st, val, val2);
+		ret = inv_icm42600_gyro_write_scale(indio_dev, val, val2);
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -716,8 +750,8 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 {
 	struct device *dev = regmap_get_device(st->map);
 	const char *name;
+	struct inv_icm42600_sensor_state *gyro_st;
 	struct inv_sensors_timestamp_chip ts_chip;
-	struct inv_sensors_timestamp *ts;
 	struct iio_dev *indio_dev;
 	int ret;
 
@@ -725,9 +759,21 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	if (!name)
 		return ERR_PTR(-ENOMEM);
 
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*ts));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*gyro_st));
 	if (!indio_dev)
 		return ERR_PTR(-ENOMEM);
+	gyro_st = iio_priv(indio_dev);
+
+	switch (st->chip) {
+	case INV_CHIP_ICM42686:
+		gyro_st->scales = inv_icm42686_gyro_scale;
+		gyro_st->scales_len = ARRAY_SIZE(inv_icm42686_gyro_scale);
+		break;
+	default:
+		gyro_st->scales = inv_icm42600_gyro_scale;
+		gyro_st->scales_len = ARRAY_SIZE(inv_icm42600_gyro_scale);
+		break;
+	}
 
 	/*
 	 * clock period is 32kHz (31250ns)
@@ -736,8 +782,7 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 	ts_chip.clock_period = 31250;
 	ts_chip.jitter = 20;
 	ts_chip.init_period = inv_icm42600_odr_to_period(st->conf.accel.odr);
-	ts = iio_priv(indio_dev);
-	inv_sensors_timestamp_init(ts, &ts_chip);
+	inv_sensors_timestamp_init(&gyro_st->ts, &ts_chip);
 
 	iio_device_set_drvdata(indio_dev, st);
 	indio_dev->name = name;
@@ -763,7 +808,8 @@ struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st)
 int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
+	struct inv_icm42600_sensor_state *gyro_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &gyro_st->ts;
 	ssize_t i, size;
 	unsigned int no;
 	const void *accel, *gyro, *timestamp;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index ebb28f84ba98..8d33504d770f 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -81,6 +81,9 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
 	}, {
 		.compatible = "invensense,icm42605",
 		.data = (void *)INV_CHIP_ICM42605,
+	}, {
+		.compatible = "invensense,icm42686",
+		.data = (void *)INV_CHIP_ICM42686,
 	}, {
 		.compatible = "invensense,icm42622",
 		.data = (void *)INV_CHIP_ICM42622,
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 50217a10e0bb..cc2bf1799a46 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -77,6 +77,9 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
 	}, {
 		.compatible = "invensense,icm42605",
 		.data = (void *)INV_CHIP_ICM42605,
+	}, {
+		.compatible = "invensense,icm42686",
+		.data = (void *)INV_CHIP_ICM42686,
 	}, {
 		.compatible = "invensense,icm42622",
 		.data = (void *)INV_CHIP_ICM42622,
-- 
2.34.1


