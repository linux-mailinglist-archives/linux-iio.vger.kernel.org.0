Return-Path: <linux-iio+bounces-9669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6DF97D63D
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 15:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E388F1F24B9A
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A73317A589;
	Fri, 20 Sep 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="cYdfyDwj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0862D178399;
	Fri, 20 Sep 2024 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839417; cv=fail; b=R/3YBTVgxrYAlSgF99FX+X/oANYC09iwlooe9NH9TYynvZOsVOhXU0FHhkcllWk+bKhKmxW0n7d4nPHWBo8OCpV/sJqYI5nE9ys0YB1LfVTKqW5xpg8nLhr8/l1vGo7XJ5ehUq7U91klXWRWZi5SVmNI1Xt33oFFVfQ5fnD/wvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839417; c=relaxed/simple;
	bh=+a9Z2hu5Mo1AL7p+LEPZflOHQjL2mlmv4N+7bwP4FH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ATHV8CwGBAN89+weAtmTshGGoSZcaGz2hp51XyF37FF8O6akqcSPMqxb1xKhOn8QHcg54oo42QbVrhP48womu+Ixf92hsOBrVJpOemRechRU8jmhu+P9+F5ZgXJ2jVFCopTQuk9SUBvVhBHlFyw6xdIN8zPS6TeGaRx+K5VHi2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=cYdfyDwj; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KBJ94Y030372;
	Fri, 20 Sep 2024 13:36:42 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17011026.outbound.protection.outlook.com [40.93.73.26])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 41nt89v1ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 13:36:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmxxjRfFWWHdn4lzsIiH2Did7/EePBVAr4hVWob2WOgt9mK24yqIpIqo9ymGK3cPHrlzPZyg9sTZ4e/nEyWLY0Hk0o5e9E1WINRWtT5dFRscSWc2pDQqtdHZqBg+fvkNEgjJJNoqjxVIAjQQRICxANTaSYV7d2mnsLyyZ4zxAwYOtelmYG70ipnAPD52eL+MqJ1nDnuWoQqNy2us4zIGSiBh1sXL12MPxTp06bTfIvkNkFqU0A9wLRePgbuTLFhrGk73pcqNyfF466ocbUVF7YParaUHdCBsYbGBEWtr0g9rogrmEsU+CF7ou1hxetqPQXGMeLmecTAGZDFW0GtpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUvhriuD7Xj2+Ado0Pe71smU+9eGVd08YzI2njhokuc=;
 b=c5hk7iEeQHfWkPOMkGg+Qgst6Wr0ZMPalZw2/HyezrVYEevrk+2NrLPxrIaP9y3/PjljLvVzF5Z2wy+an+xhWETPkwk4BKPeQw/BReFJUy8fWX04zHnsWxpsdB3FtQEXsJPUnHDC4olwyk5GmQfO73O/gNuCLz3iV6/K7X7NttcxTU+5sNTyNDXZbfF/KRzQbAN8nLjAPe/g7FEZRZIg8k1D4lfylenwG22P+LGTDX6pWzCbvtOmjd1eYbgIasWUK4OTEl54alBYAdd2HgKe5Qe5EqXMsbjM11QN/3Y3L7Ha8iQgpclmsv0yPDy4m5ZRe6qZTaXTtL4HzyVfN58ZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUvhriuD7Xj2+Ado0Pe71smU+9eGVd08YzI2njhokuc=;
 b=cYdfyDwjcCf3n81iCM+uLAn0LJk8Yufcbi6CVUOV/p0vSiGDKtrciroNRTHA2/eXkOAcDODHPw/6jKVANXgjudatBx5royWWw1NS3aLSHR1ZuLEvFtR8sAM2PYMF01irZryf8ssKYN8pDMPUlwjvipHfyrsw3JiPzmQINA25TBwwJtKAU2lqTWtwRbpj3D4kYvdDLeF4mnSP+y6CVZmweciY7htoXakXNtcNLuP5vtgWH6VJPsB5myeUXE3AHgHj2QT4zPvTKs4vZY/t30GY2jWODnu5t0IVp2Wk2+1DFV4FT8u4rR2Wlu7Br/q0thind636/BcwY0NcJSaMKy7Jfg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS9P286MB5256.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:310::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 13:36:39 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:36:39 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 2/2] iio: imu: inv_mpu6050: add support for IAM-20680HT/HP
Date: Fri, 20 Sep 2024 13:36:15 +0000
Message-Id: <20240920133615.167726-3-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920133615.167726-1-inv.git-commit@tdk.com>
References: <20240920133615.167726-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0136.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::15) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS9P286MB5256:EE_
X-MS-Office365-Filtering-Correlation-Id: 933a6ca8-72c8-4c9b-ba60-08dcd979414a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PhhTrkWYCEbkCxJXw/0wzEqJEBfRuiUlTygOnMhFwUmzh7tNXSKQb7fs+yIE?=
 =?us-ascii?Q?C+raUlV5otczfq8ehFHIuUdEedGSZUpCwoi9JBdJpNJtxIerpjtisoFZHRxq?=
 =?us-ascii?Q?rCP7kB17IyfU7dUPlqWWiB0X1NH9Ijy7Zt/OwaqgrIfIdxLKiNxTy5hoTtMJ?=
 =?us-ascii?Q?EPxRqQTQbDfzz9OlyLeHIKCmmN9/LZrwAGYlm11QIv5OkA+j3O/dUORV9SzS?=
 =?us-ascii?Q?ZZ+edbNy1up6Cg9eFiT/fs4wB7eRMhp29NlNF7gwxx0dAvb1PRaeVrflCSDY?=
 =?us-ascii?Q?xz/3l/OPbMKmjtnkd04v0ZnoYozKPIsszPsteUDnVlnTQXJiu1dC4WJlQBC1?=
 =?us-ascii?Q?pUFi78qM0b0ZRLIVN9K49NRWXqlyLO3gBT5jlndf2iolQ+JJqgH5BYo42Wg5?=
 =?us-ascii?Q?RoovuTnFY/blBwCe8CZxKO7a5OMFHjDS0y5MssrQCTvg8GB569u061J3v9jy?=
 =?us-ascii?Q?vI+o/TN2wnUrLMAm5COGh4bT8JZm8MQHBzKSWxOdbW8ThYYYDVc+09r0DLzW?=
 =?us-ascii?Q?bFZOc5YWVS/EnO8nrhzTO8AMgcucIRb/G/T4GqQZZ04ovwPnhgV3YnLbARGc?=
 =?us-ascii?Q?QKysz6mXJOjdkEoARYvgJswEofuR7D9Lcm5Tbi9luxWvdpiIkN0Fw5Aao9V8?=
 =?us-ascii?Q?ECRZHglPas/nLsgfUSNOAMw8yjfq/TeP7Aacz3XeBmDt2cxTnyelKbp1nGNd?=
 =?us-ascii?Q?vi0dZ/cgD+3JHxayD+vr2kxEpyWpenFxSb29WVVtFUWreWnrqGe9+sdsLLKi?=
 =?us-ascii?Q?3uiv/V8A9Dj0UISZAHtX+mwsQlFZWW0/RhRq4Vo7Fig7KEmZsiNoiuNff52S?=
 =?us-ascii?Q?8fVk90vBJTw+Md15pXnD/2FZcSonE/zliH3qAkjTHfi+q37dDfurqv9/LgFJ?=
 =?us-ascii?Q?MV6EqKh3vhTOk5aVXsME/+kOUSgh/uvC6s7Gm4lxzECeMjUxh73zA6fc59CX?=
 =?us-ascii?Q?yXhnFoCwwJ0rL+Sp8RisUMv7/zbxlrondZGJ/vZ7w7i6KIJD/HNYEwvX0Esg?=
 =?us-ascii?Q?HCpiu5kQAgPDOCJthJpadGwV0w1nosHiAce+wCFzAwD95oq/XmOZjTFS5LfC?=
 =?us-ascii?Q?vUjXjo1C8ld1rx2IOpJg0xqzxr0a5RfDoSnTFicy3rKf2azDGus7iA2Lk2ad?=
 =?us-ascii?Q?T7q9oxyEuoGAOddV+dILA71hgniPd17wpVLko+xVuv7pZxyqFx2CHCDH6n8l?=
 =?us-ascii?Q?yVqRb3JAHKBvI4NZkWwT1WjsZRM2HqwMUpHNnqjv5uxF2g3mHe9yCz1+Bp1u?=
 =?us-ascii?Q?Vu+G83YiDkjyrSuqcV6S3ShYBHYyMua8T5VbmoqZ9/C6JoIDMNom6IWMZxpZ?=
 =?us-ascii?Q?fucDGMxEO+Oc/NkH8Nt6l8qB//9sKv0k9sWO6D8j3tweL8L9dr8pJRsaDR4O?=
 =?us-ascii?Q?L8cOPiQt8+IYZGQL4yQlsku0qvF3L5+PyOcNaMQ3/CpE2dURqVEGaiHYhlN3?=
 =?us-ascii?Q?RamTrnctZ2o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u5Dz9yOtC5wFK9EaUqIQo0ysIJI68/sqGSssHYMldfvAm4HB5GsshZoqqFV5?=
 =?us-ascii?Q?GpFUzSqh8P9RDPCxDXTMPQP+QY05dElihYchWulPDGGe/JRzZDriYDFqZru+?=
 =?us-ascii?Q?9nQwv6hh5dWk1/HlhBdtY5oL7HlU/ItfJojcovHDfURCQpbbtSI1IBXLLSrc?=
 =?us-ascii?Q?J/XSkMSfLuf+k27Q//QxCI9skL5AEZAzjXAjpUCv+RoII0TUtV4T1P4rdb4w?=
 =?us-ascii?Q?Ybcn7PswIyJfLyrsL3sy9k5y60Uzjw5j57Tdtgrg9xOhs+c36Kc9W3PTdB5j?=
 =?us-ascii?Q?IAEg1HDgrxJj1yKvc7rvSZhLqfSKUcEZFDVgWexdGE88EiWa3GWu4Iboi9Ns?=
 =?us-ascii?Q?qqqAeoSROpiGXnmzADz8JSV748EmdRnvQj593930WFPOUEocySF5Ut80UMnM?=
 =?us-ascii?Q?YNRAm/GFF15nCXy1eBR4nVc6oVIDLvgrpeZoHprwhfkWnixCgoLkGWNgUxHL?=
 =?us-ascii?Q?uMnVar+eSIxDnJvSfLH/lBDbgIpOC5fhQULV9cLU+96yXfVKWnfaOyaUQ/JV?=
 =?us-ascii?Q?txCt/CY0IMSag/UIWwWI8964rPh+0zho7AYnMIzYqrWYj94ZMOMBzWxhIplf?=
 =?us-ascii?Q?qR14K9B1wjHAd0D+88UPOsqTi6AZdk8cEjK66Le5dxN6STLlstmpQm5fBjdH?=
 =?us-ascii?Q?kWVMJ74YbD2mxxvgPdCFkl8OcZD1fa3WHV2pW8EXbgDvhreo8fQAiXvdY90c?=
 =?us-ascii?Q?Q0jRLtq0kkPmJbs6z8p69FnLHOKat1/G3KV9byVt8m7xKtaRWYKtFpDAfhjk?=
 =?us-ascii?Q?z29oLyFUw+hmQdV2EvMOm/yaGPfS5wy38LgP7+gHuju+ac48JHrSabs46XdU?=
 =?us-ascii?Q?7qibqwYoMOF8EGbJ11TO9RsH4WgA0NRMe2mO7z/07mZY/Osa3kIzxLtfJJAZ?=
 =?us-ascii?Q?xSarMU9cAo8qiYnNzVwa/SbnKgGevflxcvS5JBQipG1hpgBM2CGnnoTWbSrf?=
 =?us-ascii?Q?i20Wd6wL+D0uNo/9EujP1gFG1dbV7oIorA/thfxuN6Vb24NdbnFZAr4jSpAO?=
 =?us-ascii?Q?PCH22OaItjPb9MLP0pLq9WvXWb5zAuDpqrrUKJ9C8Bh6cy7cB95u4+BnvnWh?=
 =?us-ascii?Q?kOP2WiV96xcHMKCc9un//Mx/l8WLK8900cgl0o5CMsWXGNtRu28uYYaTiAeP?=
 =?us-ascii?Q?U4Dv4BxXsvbrO2PEvBWiO8wvv1yhEm2ahSpo8JnqoxJNRaG/XyI1CExPm3ve?=
 =?us-ascii?Q?BEzgwaRLwAWy5lwhX+TMtRWcYM4mNTn1q6uCg7ApqpISAhs5RnlV22BIs4Ad?=
 =?us-ascii?Q?UpTgktEjrTTqFtjs/O2LY4uRGytC9+1ij/5fRt/uL+erUOOyLKi6me/U6CyC?=
 =?us-ascii?Q?EokZzK18fVg1+1tEPvkSsOnu5W3cfINUk80ue7s/8hNgpjnO2vpg5O8Cd835?=
 =?us-ascii?Q?D/x5F9W/xBBWCHCf6plukRGHQBqIsDuV+RdcE7nO4pe0VIcCJKnj4+x5oFlz?=
 =?us-ascii?Q?AsbRUcxY6iNLwImfA2oilm20s+eGwBTNN9HzZgNO2eqbUUof06e+McrPZRra?=
 =?us-ascii?Q?SbeI8GXiU7UuSk3iw2hoYXUAH20768WOcDQfJBn7IYkkt+knGxdD06jmAMK5?=
 =?us-ascii?Q?ouc7fAClT6X2G8PyrjY3/YJkofoBeOqBc6VnBmfx?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933a6ca8-72c8-4c9b-ba60-08dcd979414a
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:36:39.1231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loCwl3xNGNsoYbJvm3YknN78UR1eHOiWjwodkQoGXGp7LqqWnFu6/+9VnE0DcMv43Wr9RVPSCnpRDINMN1iGiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5256
X-Proofpoint-ORIG-GUID: J58JEOggp1TFm7soE_Xd4aADfkYVLFYQ
X-Proofpoint-GUID: J58JEOggp1TFm7soE_Xd4aADfkYVLFYQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200098

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

IAM-20680HT & HP are 2 variants of IAM-20680 with better specs,
wider temperature range, and a bigger FIFO (4k).

Fully compatible with IAM-20680, FIFO is 512 bytes by default and
with correct register setting we expand it to full 4k.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 20 ++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 10 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  4 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 10 ++++++++++
 4 files changed, 44 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 14d95f34e981..6b0adb7f9ae3 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -286,6 +286,24 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
 		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
 	},
+	{
+		.whoami = INV_IAM20680HP_WHOAMI_VALUE,
+		.name = "IAM20680HP",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6500,
+		.fifo_size = 4 * 1024,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+	},
+	{
+		.whoami = INV_IAM20680HT_WHOAMI_VALUE,
+		.name = "IAM20680HT",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6500,
+		.fifo_size = 4 * 1024,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+	},
 };

 static int inv_mpu6050_pwr_mgmt_1_write(struct inv_mpu6050_state *st, bool sleep,
@@ -510,6 +528,8 @@ static int inv_mpu6050_set_accel_lpf_regs(struct inv_mpu6050_state *st,
 		return 0;
 	case INV_ICM20689:
 	case INV_ICM20690:
+	case INV_IAM20680HT:
+	case INV_IAM20680HP:
 		/* set FIFO size to maximum value */
 		val |= INV_ICM20689_BITS_FIFO_SIZE_MAX;
 		break;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 0e03137fb3d4..7a5926ba6b97 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -188,6 +188,8 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"icm20602", INV_ICM20602},
 	{"icm20690", INV_ICM20690},
 	{"iam20680", INV_IAM20680},
+	{"iam20680hp", INV_IAM20680HP},
+	{"iam20680ht", INV_IAM20680HT},
 	{}
 };

@@ -254,6 +256,14 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,iam20680",
 		.data = (void *)INV_IAM20680
 	},
+	{
+		.compatible = "invensense,iam20680hp",
+		.data = (void *)INV_IAM20680HP
+	},
+	{
+		.compatible = "invensense,iam20680ht",
+		.data = (void *)INV_IAM20680HT
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, inv_of_match);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index e1c0c5146876..a6862cf42639 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -85,6 +85,8 @@ enum inv_devices {
 	INV_ICM20602,
 	INV_ICM20690,
 	INV_IAM20680,
+	INV_IAM20680HP,
+	INV_IAM20680HT,
 	INV_NUM_PARTS
 };

@@ -424,6 +426,8 @@ struct inv_mpu6050_state {
 #define INV_ICM20602_WHOAMI_VALUE		0x12
 #define INV_ICM20690_WHOAMI_VALUE		0x20
 #define INV_IAM20680_WHOAMI_VALUE		0xA9
+#define INV_IAM20680HP_WHOAMI_VALUE		0xF8
+#define INV_IAM20680HT_WHOAMI_VALUE		0xFA

 /* scan element definition for generic MPU6xxx devices */
 enum inv_mpu6050_scan {
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 05451ca1580b..e6a291fcda95 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -80,6 +80,8 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"icm20602", INV_ICM20602},
 	{"icm20690", INV_ICM20690},
 	{"iam20680", INV_IAM20680},
+	{"iam20680hp", INV_IAM20680HP},
+	{"iam20680ht", INV_IAM20680HT},
 	{}
 };

@@ -142,6 +144,14 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,iam20680",
 		.data = (void *)INV_IAM20680
 	},
+	{
+		.compatible = "invensense,iam20680hp",
+		.data = (void *)INV_IAM20680HP
+	},
+	{
+		.compatible = "invensense,iam20680ht",
+		.data = (void *)INV_IAM20680HT
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, inv_of_match);
--
2.34.1


