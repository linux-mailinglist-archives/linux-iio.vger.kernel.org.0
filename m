Return-Path: <linux-iio+bounces-5973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B61A8FFDD9
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 10:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC581F238A5
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3E115ADA0;
	Fri,  7 Jun 2024 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="Vm0raCCW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7054115381F
	for <linux-iio@vger.kernel.org>; Fri,  7 Jun 2024 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747893; cv=fail; b=dPtVbFc6bdf1aKAdWChCTGEoZkpXtCOZPhZ00ZC4/FK9EOvPzXyn/ScyQRBsMJPwah8rAoSFWc0AnQy7FTp0OuH1+Z6g8wkwL6f90qZq0rpMKLtN9htQGux7vNR0clFQcMFwMajPQjjUhoNcTDZs+0webhtr50ZIIGHh3ZqkMPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747893; c=relaxed/simple;
	bh=dnl/W/wd4yBSOPI65mG0urF9M1/1SEWdruSgyEOlSKc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=X3cd+DqqA5WHMzctWUqRyH5p+7PmhEPjBalSBLnIo05KwL8FpkY+dnYi8I4qtMkSlpz3qPJ6KHJWqV1V7VLZNZjBJtslRjEq8gpY6AiIxP5oB/mAYqAH7wINwNkyePx8F6cq5RJ+lx0GY9jRaPzFOzo/9mGSB0u7b5xsOP/mVfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=Vm0raCCW; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456MHhdC001637;
	Fri, 7 Jun 2024 08:11:03 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2112.outbound.protection.outlook.com [104.47.23.112])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3yfw4evqja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 08:11:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFrV/PVaQoqgEz/fJtSuVQt3bAXqNm0aJgEiNEyd4liC9y2/eRnRtVx8zA+ZBdkofhvjFxJtZi0En3CZEDj4CufmqGZzm/wf9G8v5MPlzqanRN0QLDztZSTSFm6cFIFyXaty2gyWswpDzLFF2/kgGYSnyvYilDmc4sXl+mNnaeBXjYK7EnJaeQ1SZ9xhOlXHKarzwK3TosMDhENHyYQcmVE+6dBfZa6HLUVUVdaT8c4ojMrRuErpVtjue9nii30QkdEWAk0rWdwZj8dXP2ilYYqzo3Ya0rCfJK83mP8TZDvAXYpQj9LmXnuicOmhjcVHfqEUhdnepmYCbNIn6kLAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdEAD9MhtSXlVVudeVqHOFbBCcNZm0kVoMgnkITwqY0=;
 b=O9P2doeIiTr+QrqxurYpwH0uSniGad6MBPd7TJrfwOpMn/w4aacGcQcF4Jt19yfuvu2Nwvn0ckg4BLQOtUiiuOLHAjui1hn5GM2Fbv+3noVZZJn3PTcveSKnCOgDY7snPbh4rnBGVWm7fwFMtA1m95Rm6wPf/XsJ2LgHr2xsyEo2/h/0FFIXzgx5aAuDLCJohoNYmH0vpPbwjjlFVqrSeIoHeFvM/UaNoTlYA2kpolWAvxjGHMz69rY1guoXIouZzKHi/mCOnwrvv3qxLIjmnoIRU20GtKDcAgcvqLanI4usbI3k0hN3oB1+29mJ+W2bd8kx1OA3oM14WIPE1dYC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdEAD9MhtSXlVVudeVqHOFbBCcNZm0kVoMgnkITwqY0=;
 b=Vm0raCCW3VOxQo1FfFcAmxVO3FpnXQuekrpb1Me6R6a+R2/k2aagb3W6RZm5JxiR+QFoCrImoXqusnjp39u6cSQ71FnAvHWitBBnGlK3bE5sYnpXFcXR0ZFQrKGaQgNzDMwNwOhRV79FqGfC/AgyB7plqMnzaOJLT4ntz/Q7eTYbRGrauNTwmL5GJvyTKZ2TwJDcZmuFjKeFUaowFwAAxjxoyQY2Q9Pf5ZWygY5ygzsbHOPqPnymmnuu9/sxo9oE3tVTqYwLBsqkEk//I1VvLUaUvgp9t0PHnHl9A0Rx7bpb7YwrUE8XHp2viclgw5COf44gW0MG0jZAf6qN27aYkw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS9P286MB3980.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 08:10:56 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%3]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 08:10:56 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH] iio: imu: inv_icm42600: add register caching in the regmap
Date: Fri,  7 Jun 2024 08:10:39 +0000
Message-Id: <20240607081039.789079-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS9P286MB3980:EE_
X-MS-Office365-Filtering-Correlation-Id: 3998834d-f184-4600-af74-08dc86c95b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|376005|1800799015|52116005|366007|3613699003|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ostEzRRXVzY1hoNP89a51lL+pXFagdDfEM1E/bqanklOHpBaJSxndLeqB4hN?=
 =?us-ascii?Q?llxCFjZW+BWznazBHR8iSihyx5LA3Ou9yiSqh9I7Ndj+Joj/h0V1o0sjMewN?=
 =?us-ascii?Q?+M86wAkprFpX8C1WDaYwwAG99WCvL7w2F1dJfLS/aowbef9dg/geIwf6K5h3?=
 =?us-ascii?Q?C4K28648O4STHuDz2/JDL+j14AWTS3iHTSo1ttMx8PU1cqfdQUCTiUaDUwxj?=
 =?us-ascii?Q?VXc3jk5Q2n4hu7XFaiRsZV68ufQnkoHL2zThVG9CPZAg1ZQr39Z4oCBgvTwX?=
 =?us-ascii?Q?uI7XjZyiDVEtWNWkZErq1k41ie4THWX4DsHuqNBb6o1KfJndk/oiom1IegKw?=
 =?us-ascii?Q?1OgrWAeV1zrhqLJ7KunwSTVG8C2YJQSmPHV39xg9XWSUkLMVW3Ci0iNTj+//?=
 =?us-ascii?Q?bBm/cluWxTrTutZH7MZz1zRygxYg2ibGd7Zb4znkpzhWI1ouHxAl1A1fi8pQ?=
 =?us-ascii?Q?wcwN2qQQSZwkoCLW73BP4mFi44CCB1hyV/PEG6nTfGps3vbUjFhBD796/unT?=
 =?us-ascii?Q?k2KNJLivWuAy5e13QVBxhh8yS51/VbJv6gTMMLFNDytQlUz3luNr7iXcqt6+?=
 =?us-ascii?Q?LnZShjUARFLlLzx29507vhCY1GN4kMgvx5TND8IRiuvFXr/IiCo6CW5e+NLj?=
 =?us-ascii?Q?i3CWkpP9tUsTnL3qaK43mY3za+Y8gkhnh3ZEMv2YPgAchPBRLpuyrYzGzid+?=
 =?us-ascii?Q?szI4mfhp2EUCy8jGJ/viaGUWT69cFCzZCrYCyIppziDaaaF9+ypfHFE8YU5/?=
 =?us-ascii?Q?eEm1dNVC4nLCEgdoqVs79qvJeFqWGk/I8HlsXSx4wU2sUHUNx2rL7sZR/ruR?=
 =?us-ascii?Q?lCPCyfmgl6MJF2u2cP2USXh2Ooc+SFIG7r/ddXEyCjhsBJJV4ixnal/piJpI?=
 =?us-ascii?Q?S/Ysw0N2eSuOAlLwz6WyAjwlbJYcDVh5TMxozllMzLL+X47xkdfZRyOuTerR?=
 =?us-ascii?Q?u9bOl96gG3Vw8mMQOHdsAidf4iVXmNd+QpktMe1lGkAGhtPg74CLv3ecA5+w?=
 =?us-ascii?Q?uJWZ5wQw7weLqxEm602caHgPhRdRwEQSyvrc+9U1QAVHXfvr5eFI9JCsF6cO?=
 =?us-ascii?Q?gg6ZKb/6+fhV20V5tWFZXcM1ozFMuzpc0g4SZhlzs8293NWkL+goBLNIYb4y?=
 =?us-ascii?Q?hjelvUp4I3/Du3MGoH3qJaq0DW1hLYKQ5bKOdwz4OcTmKqR1lSDtt8ZMiENS?=
 =?us-ascii?Q?/mQQxXPEaJVE34cvFUnF5/0/0hSRU80MD4iTJ5Q2wBhDZ0KMb8mTcAru2w2f?=
 =?us-ascii?Q?ukqDd6alaiDuLYbLD1v6q6h4+AM56mfG3Bq6FXFNM0RxmAkQTAYEhANDQoCn?=
 =?us-ascii?Q?Q0zq1FfcWDIRipWHAnQTy9gsjkyTr78Abmm24mOg00MDmA15Jkx6sJ+YUKe6?=
 =?us-ascii?Q?TGFBRcQjyJYpiZbxV2pw9n0woXntTLF2yL8OrFq6l1v+TQpE/w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(3613699003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OYhJcu5UcmehqROuV/Wqe8XFjTW09hrySpltfyjFmNK1y8oEbqNeuHZmmrto?=
 =?us-ascii?Q?yVJcApYWdSUOi9Q/DPm4tvFXZhkLQsyhuCpyns8mQr5h36JMs+vV/dJB9C8s?=
 =?us-ascii?Q?M9DMVlbZhWOwYBytCUt46uZS/BD0IREfGF8KcJ8bOtPMdF28zCHBI95WzSMQ?=
 =?us-ascii?Q?k/PT3LdXLIKjqpjUoBHH37pO5QYIDEhSHJRZLNVksewk9FpPi+aJUEukIJj0?=
 =?us-ascii?Q?z+rHxNXzxHMTqObfmzwUb4YoukO6/ZEXkBm48fxLHl4FgdbsHUYHem09OTVB?=
 =?us-ascii?Q?nBOV7H6zBUSRZIL04f3B0L70MDSVHyixxwmWY6kNvYUXWg1e4V+ZTwXD6JKe?=
 =?us-ascii?Q?1tLmlJ9t9UT8LE8ZSX0aSmEp0PQ6XzuQMnsDBNMlG4iUEraa+rhRYrebhj0H?=
 =?us-ascii?Q?v/e1V3V3KcT6uHM4DK3T9+qpDBclmOwCCt8pj9uCoDod9vYsLHoFNMY4Rxqn?=
 =?us-ascii?Q?gmma9ONvyPUA3Ect5m7pRQIRl68eOABfQ+HE2hWTsBlE8G/iCEtLvzOudDkb?=
 =?us-ascii?Q?a1PYrOWQJGONE6HDzLE2F/t0raLyNeUdgrPOy5mT0srTSkjya1/iw4Bmojcu?=
 =?us-ascii?Q?IfAS5WH5fSKgp0ifY4IBnWhg1LVutvKur9bBx2uscoT7M6t1nZNJakUsGgmx?=
 =?us-ascii?Q?dAWpBWkzhwFGnyg78JeSVwTfqIIXcr5h8X40ba76Cn4NK4r8lnc+bVcckZQx?=
 =?us-ascii?Q?OCF/lGh10RlcVLx+/aMD6UeBtXz/2gUQKVS7ztglOELyqRXK+VUuMs9/R3hJ?=
 =?us-ascii?Q?Q+deqZZsjlSjvzaji5GtdYTSGxlc4WxyulS2/Unze8mUcSqdaTAbt7l6sXkP?=
 =?us-ascii?Q?eClcq5vyl2rwSdhpGuBAj/urZ5a7bjNFfTERzjrbvKkSCmDYqIR873E7MPQZ?=
 =?us-ascii?Q?ypxR9eerQKSy6n3JXDpiIH40ivcymicYNuOE03eGRiQsMZKpBo2iEkrba/tl?=
 =?us-ascii?Q?ULxjoSE++HsTYXtJRETDfr0X820VH+HzziBRVYNTByHmU07u44I1nvNO8ErY?=
 =?us-ascii?Q?8bg0Od6BnL7bhjKHidz2PWXxNngCS6UitCFCVCf+JqScV0CN3L9jCUyL9a+2?=
 =?us-ascii?Q?qHpvB0veYRizHSBwQvCnhYWY6eOHWLVuqVZJLQMBM6n+B/4oOHrazEcvJCRd?=
 =?us-ascii?Q?6QX3K1fuaGb5aEPodetsBZ3IRUxrrGg42yAit0byaOascXizIRd9jAqMqBLF?=
 =?us-ascii?Q?R7crhTGTqABgkEuSZgpZHvsLjeuEORkDQ/AOeJH0VVLE3npzTKv62aO54bE4?=
 =?us-ascii?Q?ign5DQKaZFy17rLURIGSG5s6mHpjMfIdOn3kQ/Sxr0pakBlD7t5oa3iVhQ94?=
 =?us-ascii?Q?qAd7P7HfifWsS2xMbj3EdbxFrzZMTSmU7nT7kC+j+hEeiVT6VUsy3rYh+ViN?=
 =?us-ascii?Q?Ny/oiG9pwaSuQhrG/LZb7KQqjRcmSemxXEZyCVPJLyDK2qR+WTHL2Xui6qjM?=
 =?us-ascii?Q?MHqo94S5ru5nFONyYtgtPuWT/ErNJNTrRNJt5hCCgJvTUBfkIUiMLLo8a1/N?=
 =?us-ascii?Q?IuG02yZpWjylpy6ur4MrP7edL1dxireI2TSBPsvi5V+kumJTB2h4NTAEtRni?=
 =?us-ascii?Q?8Jd9U4KUNY+uc35by29V6jJBKFXPiEUfuOwbTq+/?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3998834d-f184-4600-af74-08dc86c95b55
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 08:10:56.0540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rnXLIfIozvRJLrx9ZZrRHo0JKUNaCP4IrIX6dwA/9zFNOXbjOGfsCUR4fwFGr4bnIBtQSlliiILi34ap6FqAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB3980
X-Proofpoint-ORIG-GUID: zGzsKFyHwnMUR2chcNWFXG3DQ_yv9GDl
X-Proofpoint-GUID: zGzsKFyHwnMUR2chcNWFXG3DQ_yv9GDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070057

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Register caching is improving bus access a lot because of the register
window bank setting. Previously, bank register was set for every
register access. Now with caching, it happens only when changing bank
which is very infrequent.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 8892ce34a33c..ab1740d4b50b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -34,12 +34,56 @@ static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] = {
 	},
 };
 
+static const struct regmap_range inv_icm42600_regmap_volatile_yes_ranges[] = {
+	/* Sensor data registers */
+	regmap_reg_range(0x001D, 0x002A),
+	/* INT status, FIFO, APEX data */
+	regmap_reg_range(0x002D, 0x0038),
+	/* Signal path reset */
+	regmap_reg_range(0x004B, 0x004B),
+	/* FIFO lost packets */
+	regmap_reg_range(0x006C, 0x006D),
+	/* Timestamp value */
+	regmap_reg_range(0x1062, 0x1064),
+};
+
+static const struct regmap_range inv_icm42600_regmap_volatile_no_ranges[] = {
+	regmap_reg_range(0x0000, 0x001C),
+	regmap_reg_range(0x006E, 0x1061),
+	regmap_reg_range(0x1065, 0x4FFF),
+};
+
+static const struct regmap_access_table inv_icm42600_regmap_volatile_accesses[] = {
+	{
+		.yes_ranges = inv_icm42600_regmap_volatile_yes_ranges,
+		.n_yes_ranges = ARRAY_SIZE(inv_icm42600_regmap_volatile_yes_ranges),
+		.no_ranges = inv_icm42600_regmap_volatile_no_ranges,
+		.n_no_ranges = ARRAY_SIZE(inv_icm42600_regmap_volatile_no_ranges),
+	},
+};
+
+static const struct regmap_range inv_icm42600_regmap_rd_noinc_no_ranges[] = {
+	regmap_reg_range(0x0000, INV_ICM42600_REG_FIFO_DATA - 1),
+	regmap_reg_range(INV_ICM42600_REG_FIFO_DATA + 1, 0x4FFF),
+};
+
+static const struct regmap_access_table inv_icm42600_regmap_rd_noinc_accesses[] = {
+	{
+		.no_ranges = inv_icm42600_regmap_rd_noinc_no_ranges,
+		.n_no_ranges = ARRAY_SIZE(inv_icm42600_regmap_rd_noinc_no_ranges),
+	},
+};
+
 const struct regmap_config inv_icm42600_regmap_config = {
+	.name = "inv_icm42600",
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0x4FFF,
 	.ranges = inv_icm42600_regmap_ranges,
 	.num_ranges = ARRAY_SIZE(inv_icm42600_regmap_ranges),
+	.volatile_table = inv_icm42600_regmap_volatile_accesses,
+	.rd_noinc_table = inv_icm42600_regmap_rd_noinc_accesses,
+	.cache_type = REGCACHE_RBTREE,
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_regmap_config, IIO_ICM42600);
 
-- 
2.34.1


