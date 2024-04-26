Return-Path: <linux-iio+bounces-4539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB488B3952
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 15:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7452428829B
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 13:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B241487DA;
	Fri, 26 Apr 2024 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="ODV17OJD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BBD1487D3;
	Fri, 26 Apr 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139939; cv=fail; b=E1DdXy9Q+7xoCq76Kv440dXTgjYV0nRdSuws8LFi1y4WDZjPawoUDa0YjtSJBPj3kjoF3HZtQxmGIolDnxpuHakqfmB7JQI9bUvxIC5HGibcgQ+pDDwBKNQthpCk6Hqg9A0oiDubbMj1x0Mmzo8PwWXxkb/sNBFI9ClP9NODpVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139939; c=relaxed/simple;
	bh=kTVcpKVJ1Jk/nBgMyGmmHMKJne+0jejqRwQsf4G9ya4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A2Ivxd9E+Iw6lgY1goVJHioQTxmLoUo8WKoz7rNc19wfkbSvkcfinFwJpS1JcJk90ua2jPdELODqdqiaXPJkL+vxISQSU7s27kUb2SbyFoambhbm8F3Hb5GYB2R0bY9Hy6SteuscOCzWQrhuv+Qv6qnA5gOztuT+dPdHfL5HuJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=ODV17OJD; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PMmvp2028344;
	Fri, 26 Apr 2024 13:58:40 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17010000.outbound.protection.outlook.com [40.93.73.0])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xm49gd3me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 13:58:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ig+nUkuIhafAWCmnKx1ybF6e2vdaMh3afYtDTUAjDSH+r8WW/U+BC4J77TuHX9GJeln+QJ7DrmMwLThYYcgJPIpE/bRs63nz7ijAxkqX8YKcPKxreGQ3tkbyy6FNyeSxOW9ZHFF3L51HjLHKh8CbbijKxw9NLALM06aRI5kowLwuF22SuzUDOXf0rVaGEJsC8cLAUWAsyIhXlyY18e0iv9oWD7cWDt3O3zQZVnApzzf4zXd7fhS83R+w3qz6rEPpXBRa+vZfx7DklokEHNUPPrm+N2cbRwKobGfRsJnl26u146jyEzlpF5ZxMlt/GWydX+PgHAl0qHPOA+WiU9hO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkGr7L0WXsYLd2L7vDCBIxfVARc4gxYyYAbnnvEhQbc=;
 b=kOe+SAf7RVn3cYoS+5yQYiUtUFqoERhJXzqHHlCLhZkjK2xCkzDsxt9nRjKA4gBIanqN9csXn2E/0ar+rrGdi5oyKftIW6U5ISvLGEThJYoMpCx7tsnTRpH6qDFlirQ176EJl6nfF/sXm9Dbwyb6hp7MHNpmGyFLCA9zNmpk+538vGivck26kEIiNAKDgxdg9yVZyIs5V5HJ9NP0gnA68SSV/Gu192V1QsAKfNx07iB2eq/5PkQVgof4cmJu/8MC8c0bSDOM9SBE+ItjDJQw1+lqcw+AEo31b0gVBkL6OGe285hsf7gTsHrJJN52Z7i6Q9rcAybfOfKflfOoa+nkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkGr7L0WXsYLd2L7vDCBIxfVARc4gxYyYAbnnvEhQbc=;
 b=ODV17OJDzifWd0l2JzWkc5P7rwHuM5UZ41TvSTgzr4voAGKLf+WRmK70XZYXZvAzL6jEeJD4iljoSgyJ0ZP5yON+T2W/zRm+EH9HXuOLzAJwdHs3mAdjSUje3MZIeANn630dKFX/tZV6MR3zVvNGyl8wgllfsUKh5Cu43cBxX8GiicvUiy0nYlUxhEodhCzzsHeUN+edanDrYgEOw+tuelwpb0Nt2MJ6hZH/Zl1a7fyNtoyiRrKjFkbVxMj4wLDLhcyQob//u0lvK+IXCt5u7OsKUlWqxSIN185j9q2DbBZtDcKyqpuLKc41sKdDcD1jmy+vIA1zPvENPPWnMNVJjg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB1961.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25; Fri, 26 Apr
 2024 13:58:36 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7519.023; Fri, 26 Apr 2024
 13:58:36 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH] iio: invensense: fix interrupt timestamp alignment
Date: Fri, 26 Apr 2024 13:58:14 +0000
Message-Id: <20240426135814.141837-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::25) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB1961:EE_
X-MS-Office365-Filtering-Correlation-Id: 74902066-3748-4756-87a3-08dc65f8f749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UtgR49oxQfu8b97gmE1nS8y96YBaHTG4QZ61ts/cXaOPB9UP6GUOI7XoYuGt?=
 =?us-ascii?Q?tRjSsu9viQb9KhhL1CP+jBvl8czQECb9/C8xr5Y4jzCYXW9YG3mGApSgbh2L?=
 =?us-ascii?Q?3xc3WUAq185E06IvhD2KTtSuj0yjM/FuG80EZXxoLknnFDerHGOE4ujmIb/X?=
 =?us-ascii?Q?vSZbRZ5IHjJj0bysDW+3ImuMklpucAl9wURlfU+eDQm62cbxUm3xVmhflPdh?=
 =?us-ascii?Q?CavWYS1N/TfdpgsQR2GfFHMOwlxP/rHetdTGu1LZFdZ/A+u1WY1yBl8hyWqm?=
 =?us-ascii?Q?oww9IL4EMUO/zvqMQVYNUjvcHNUv3TeUBRBK/J8xzdyPJEusbPD1iOYd0jk/?=
 =?us-ascii?Q?BPwUIXKqLNRoBOD+cOH1LSDpHGwpZmgJ028CUz0+2EQgYxBgt8dqQ6Rqp7/t?=
 =?us-ascii?Q?O9uJ8U7aYQg0Gj6WUMI0vgLktWNGeC0SAUc03eYXXe99pD/BpXog1XDLbH9N?=
 =?us-ascii?Q?HgYsxWlERd1BLNq2cKX8pWn1lrOKAQ9YK+Eucz9NH1MLylR8PQK6EzjY0+TE?=
 =?us-ascii?Q?dHKaetu1XMoLJGJOW8ofVb3V5LR38965n/wAMS5mPmhNjZhGOrDQqU7vSAQj?=
 =?us-ascii?Q?d35Ocwb1nfdu9tS+jOViaayU78sqzGys6teP3vLWB5V0Xm5sO39Zj7sMpdYc?=
 =?us-ascii?Q?npwgi8n5amcqXDI5ddbdU3H0yeCjRXhCetEHgk7shmbGkgoMM6kBiuYH/HMZ?=
 =?us-ascii?Q?U0Y2hZb+maz7SryyLuWbDNcVcaZb/cyN/Tv+9GfRt5FFv93YfSgYTWoE0/mz?=
 =?us-ascii?Q?7alit/wlENgLcmIrj7ymjZnejE0MrXSJ7pYRjKhm/Sb1hvSlpujEwXwSHM8h?=
 =?us-ascii?Q?2ZRKh/dErdUv0ULXK5f6NPmDfviJ2CF2EPacb/swkpOhSrwObIJWEteLfIak?=
 =?us-ascii?Q?Ln9dmPJ76X9akNbrWjsiPK3DUGH94q/Fb4mbsbe9THZpfTtJw8ap0pWWw2nx?=
 =?us-ascii?Q?+pJ7t7SgFkeBB1/I4BUPgRSD6b57ie3ZPBpDdrLLtfdMagYOY5lZpl6sII4v?=
 =?us-ascii?Q?TrcmGC4xPfUWUNStzwFRi73cDdJt0Ht1P1pqAVNXmY8KJJO5D5zJhiNwQLaj?=
 =?us-ascii?Q?A5xYIPhcDSYmFkhGE3NcKnOW6yxJwHCgWEYl+xEHO8Vf3O/g9fQSL1RcY/PP?=
 =?us-ascii?Q?Hv6A4zgOKre4JIhaFmahxkDxAw1n08Ar+SGGJP+wTnutlhvCL+ZbF06gd0og?=
 =?us-ascii?Q?oirG5JjDJYLZmfM+x1BBouCjXtaXaDREnHXwQoKCH3m/r+5IVfIWMo/elc2l?=
 =?us-ascii?Q?mNCJ6s289mfJPmeRTIpc7YDVlBI4VObWV3jmwW5QkdfZgHb+2oXCjCvqEEMD?=
 =?us-ascii?Q?FceIB3GfVYsMHI0UGGQuFYsNkH3gkevcLASolmg++vZWmg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IhPRgdhU0FrNownvvMZZuSXWKOxArWdVCSmCSJ3ywQzmZ3OGhzjN8gHIzDr9?=
 =?us-ascii?Q?ybc1nfolbhf2yfqzVeRIU8HBj7VNLJM6RoaFBVM5iF8U4Wqjg7G7HUv9v8Hy?=
 =?us-ascii?Q?IW1JqXDWlg8xhu11CdPWxYgiY9ohm97wxWrUqIRamNqu4EoxmdaW1LLX1q/t?=
 =?us-ascii?Q?OISFNlloeUmzh564SwSyMr0J9lJtzzkiWj7f8Ubz4k1toZRxxKpbGRWfbTqC?=
 =?us-ascii?Q?LG1og85EqhBRYUsvkE6j+kUhfbp7CRwHyghdOlCeuEnmbwJoZxw7lE2BTnwt?=
 =?us-ascii?Q?c6Io4LTrtn+LKQwOHLROsSGvIj9FssNNgNNACIIXUfHAHHo3Q2/Xtuqn+6pu?=
 =?us-ascii?Q?TZjwNYvlTZVRFiP3rlBWo14rluViaXoX7SFElqv0PdZAc9oPkOPfovSXj34L?=
 =?us-ascii?Q?pWITkqmS26oZrG6SkXxmgltJNpJ7WIj5Z28VZAOd0yRJrlr4qDnin2aThyia?=
 =?us-ascii?Q?Q2Z+oOqVb3Bo/wyCTkkohLU8EOntZ3/+UGwTqKohPr50xKNNkypSF7iryzG+?=
 =?us-ascii?Q?ae4BVPKiZhCLpiGttSnITdax0/g3nNJhx03nimyD2+b83ef3/nOjmug0MC0Y?=
 =?us-ascii?Q?fWpyMckmp+VvXwP0OgKbZDP/SSZOawYqcVMHPa1+wCmTNdhQyKGgcxuvDZVQ?=
 =?us-ascii?Q?aDhEEZxHDMvflXNBVPrmW09U1CQo9xHlS3l8u6Tfo7a/zxUWLABvan4rl9ZF?=
 =?us-ascii?Q?eKItAJHrDiVUQqMHzVs9XJH7X6S5WhPMV2GZec8RNoE5FqDCzOSU1UPSBlxy?=
 =?us-ascii?Q?XahiE9Kz0xzuNGrN9yQ3ez8R1+aBNtlVzSf6S8Z79R7Zq0pzzCtkTlbPIqNw?=
 =?us-ascii?Q?zxjALZCFlWIkfE9KdAz+82HhZP+At4PAVtfBHez306jCTaF0u1BBRkwzR2sA?=
 =?us-ascii?Q?EMdLtTDjjYufFVbgUkH/scfN3Kc6r+xLXJfkRekq6nT4Ff8TQra4vrw51vpO?=
 =?us-ascii?Q?NndMmQhFe0W4m+pTVaRGvzVU303YEZose0IboV6RoH//RdKYC14vY4yZxIlD?=
 =?us-ascii?Q?Z5MS009SJwpQE5bpXDB/3zq96hOXWmKEp/p3Xu/6z1dG5phpmTAFYQ85hzIl?=
 =?us-ascii?Q?hooaPaPApFIHsrtqkkGEhsTkVLJ1BL+LVS29OnBrH4NVrNMbTsZjallA8Ywx?=
 =?us-ascii?Q?JmDpWz5zq+Px3vUEpUNz3r6vwWkmZJj8Z7RdnPEnJxk65ioqE4EtpOJ+B0j6?=
 =?us-ascii?Q?mrmcZV29acb/1r3F0nCt0U8BBowEeZHfHCXbe2WvHpfHJss77cpyXKdN0XTx?=
 =?us-ascii?Q?tYXFpvx/SwPDUK9UEr4igQtcBJeTIhln7xeXe1R2udJ8UUs6ywR971aq/uZZ?=
 =?us-ascii?Q?4ycUPps7WqROuc7jUeBFmEEyrn3iFBATacJ3EhAjKeyK0bpp7PMvigENGpbA?=
 =?us-ascii?Q?CrfWe5TtC1BQHMGL0Do5g+s5E7qkin+diQkVxtfyJnWwquaLnc8B+O3oqF8j?=
 =?us-ascii?Q?ysW1Tz+NauX610D3Y5A+Go+9fK8yRjTw9IOArsgkFqNDhNo4akEX0Ii1js/B?=
 =?us-ascii?Q?Q3Qli4NJsZSGjVqIHgNrziGTCTIi5VnSDAThAzUxpooecRAb14Gy6Qk907cQ?=
 =?us-ascii?Q?YK9lXB8VtVxFSZhsMbntxty+cyua7brMX7kx2T9z?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74902066-3748-4756-87a3-08dc65f8f749
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:58:35.9823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6lvrSJZ20ivoAbOCQ+Spe4ffcFEHiDfTCYWIwVQ6ARYJfDOekJQH9QBoJU+W99/aOqAgE/o20uFbhoaSylQsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1961
X-Proofpoint-ORIG-GUID: S8MVCDFtng0s4RsUGrzGWTBHMH4gwDcN
X-Proofpoint-GUID: S8MVCDFtng0s4RsUGrzGWTBHMH4gwDcN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 phishscore=0 mlxlogscore=870 bulkscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404260093

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Restrict interrupt timestamp alignment for not overflowing max/min
period thresholds.

Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 3b0f9598a7c7..4b8ec16240b5 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -101,6 +101,9 @@ static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,

 static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
 {
+	const int64_t period_min = ts->min_period * ts->mult;
+	const int64_t period_max = ts->max_period * ts->mult;
+	int64_t add_max, sub_max;
 	int64_t delta, jitter;
 	int64_t adjust;

@@ -108,11 +111,13 @@ static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
 	delta = ts->it.lo - ts->timestamp;

 	/* adjust timestamp while respecting jitter */
+	add_max = period_max - (int64_t)ts->period;
+	sub_max = period_min - (int64_t)ts->period;
 	jitter = INV_SENSORS_TIMESTAMP_JITTER((int64_t)ts->period, ts->chip.jitter);
 	if (delta > jitter)
-		adjust = jitter;
+		adjust = add_max;
 	else if (delta < -jitter)
-		adjust = -jitter;
+		adjust = sub_max;
 	else
 		adjust = 0;

--
2.34.1


