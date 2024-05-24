Return-Path: <linux-iio+bounces-5268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5644C8CE57E
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 14:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7724A1C213E5
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 12:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B5D86250;
	Fri, 24 May 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="O8AZzoDx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD685640;
	Fri, 24 May 2024 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716554985; cv=fail; b=Podth/bDi6o1/l8jFa6SsVVq3QTew49RDoKdSnGflpAaPYE8EGKHlmmJLsXu2Dk2M91GJd6JSAffvo8/nDJPKRdGEV/LXSUOKhXNI2nHrcTKrwZKs0CCqKxM3ocWOsBeT7gZEKB8w/Y/McsgufUHjRT8s2S74pBB+YW5VjA7oqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716554985; c=relaxed/simple;
	bh=/0AgU5E4yrcUpCk2SjXm7Rtvul/vcqLdKHvHiJn/wv8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MEUyyzhzO6L2V8ot6+D9mySbvk20qddfoyCpRfMedZIjMNdEiNNmnAKRF3zr1+n+cYN0OndLlhiSMBQ/BtI3o05Q05ymi2TS8bbDacF7t/ALzkdXAQApZRa+p34YRjaGChGT6PcdUcGT8I5N42x0TMbEgAX1nyWSaAFlqKHGsfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=O8AZzoDx; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NMQNUT015530;
	Fri, 24 May 2024 12:49:16 GMT
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2169.outbound.protection.outlook.com [104.47.23.169])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3yaabf0s7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 12:49:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CP6/8U9Mfa3Qt4pn8JSTvjCd1cDJu2KW45sZSeocZSL6wEHQfvHz6p2cqij+jjJrJ8lzxm5Hh0Wkfy9ZhvZT0o5uHvwkUGy//wvXoSFiPoelysPzr/Vv78F2KLKKpg3BGNWPtKuTZ98qJ9CTeiB/0kJQVX7c0TqYLfYkfo76KgiFAnyifWb2NLkLqh9H3eCuSXp6dc5hD1dG+TSZYX1y/tok4LDBSSzMUF0Ga47MXnISFDuxJmP9JofQifr5JCCFILl1zbT9oYPEsPfuB/9QwbG+aQk1/VUs454nbZuIZRKaFh8ZOZ6MnT4A5DW3Axxo1JeuA5ye3VrekVkARtGpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qU0TqVHlq3Ak2EeMYDZkh95HAzzmfRM4JM7+54AyLx4=;
 b=PyryB3FhUpgwQQQAv6w9YpeJjkwF63B3yx37VTCTfebi1TTxBkYEb2GVbHI3sCVL9FQLp8BuOi8MBOtW9Ps7+I+o9eRrwdOeQJYCoXNMK5XmW2ZwD1hmpFEIk7lV6NTxt4dK2YGi2TxIatbl/EBVvEjqMtVAM4hxhPBWgy95TkalDNZFI9mWqCQGUD8uWqMKUSNeFtQK7fbryC1yOuJfQOzV6SpB1j6ajh1orBSCsKyQMsvFB3ak29nCl05EtNYSNFsCYt0LeNmYplUcdgG0S0KI+IOstlqkvAdDTMyjQmDmIL9IgKRtjk/19BR72kg+Hkj8DfKraEOKCf5JfLb3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU0TqVHlq3Ak2EeMYDZkh95HAzzmfRM4JM7+54AyLx4=;
 b=O8AZzoDxZI++E/lw9+glf0hsRmF0QBZrpFKM6fIaolfSImg0CEfEQlVDmAXXwN72iejlFuGSkdO7E84x2/MFK1H1KL77lDnyJySg8pf2v2mxWc4f4A218hICy/povaSutbeVpkNFYuR44t2QEh0A8sg2bhlLNX6H942E2KciTRGw6Oel/CpH3l6lG2Hfg62aYivtNqAsFWbNNTTe1z2HlM/PhXKEN5GMTVJt652IeJd0wFT7NRYBoAuZrCo5cyJcKAeNg0wY1Ts3A+hRjeJKYAULW2WeHkwtlrXxSIGyrbDIjFnh3+4O/vYFZVsEAPDIVsl4XMSzJdqioMxxKU2ZNQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB1876.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:101::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 12:49:10 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 12:49:08 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH] iio: invensense: fix odr switching to same value
Date: Fri, 24 May 2024 12:48:51 +0000
Message-Id: <20240524124851.567485-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0181.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::14) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB1876:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2dd2a7-170a-480d-1d7f-08dc7befe6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|52116005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yp7C/33ZESsSHjIbj8x4kTMWhj4e3UQJfUmajqOeSW02ykSME7CKZnGXfTzC?=
 =?us-ascii?Q?lrgqLUqfsb5AV41I+rjHDvmJ0Sv8jFUCFqekF5Aru2qsMPjfFIYJMAIgZ/QN?=
 =?us-ascii?Q?O7jc/snZvaVYa7Xd5VsZq/Mtf0zr/EO/IyWH90fB2mppyBkDkqXrDBDa9la9?=
 =?us-ascii?Q?+T5Jc5qsuY9ryDKReYr2zGMzD8VZoIKRbKVi7DduGZW7fXT44hVJo+xaPM57?=
 =?us-ascii?Q?4giRgMbn2GQbVFv72RlLwvGPtnIDCvCnc4E9jLwpHYMqUTjb+EHC/3eSyh3b?=
 =?us-ascii?Q?P7AwpxAP0c0z26TvFkHfyX8UvPdbDOhGh8822/QFD0jWunMr6LTiYLEaYAHu?=
 =?us-ascii?Q?QCmbcV50pc2m/8ISomUWkyDyEhO5qTHsSS07TZpbzUITRdpgkdmkLkwrF5ke?=
 =?us-ascii?Q?3GGa8NiWkOUMnR/ehhXChBfC6/tRropTZHcKmGWtHJqsUuYMRPiINILCDJ7+?=
 =?us-ascii?Q?pBNBp4aNDpdWve9dRX6qUE5Y3aEX6qLYId5mwVcWMtKUz91xfZXcAxA+/aJn?=
 =?us-ascii?Q?o3sQ1pMDno+VQTE2WSWspq0HRe9jRwVT5KsOEGa7sPpTuz+8SZv8S+qpQtsC?=
 =?us-ascii?Q?gfBW04PpzeITaq/xkLLK31QnfwZ+nTqv4Ac+YLImC/VePRJFdQY8ucXbeD/d?=
 =?us-ascii?Q?r+HnmTYEQzw2p6Xn+92Qid6QD3eohp+UgQ2oQfZDUqGU5FCUOIZDT5vbt02/?=
 =?us-ascii?Q?zdDOtl3TuVdUhGjB+/v9/ksGFqzslorqc0NVLLMAgfo+Wt8Sj86olj0Lk8eQ?=
 =?us-ascii?Q?e/kDDl6wntV7/2j9siZKA7KSAdG3c5hgx5EY19wUlZtXBNIzvSEvEusJPOf5?=
 =?us-ascii?Q?XM7mTYDVHg/ZmWjrFaRahUcShYVrWvBUEgyGZCVl4kqLSrLhDkZwF5+GtCjR?=
 =?us-ascii?Q?+GSJ0ZVlmM7SQSCV0EBR+rQWvR07YNm2nGpUuhtsxWL0AgvCNSUpr48S94ZM?=
 =?us-ascii?Q?03EPA6uMGXzO15zvAcqrZEmyxvtqCq/cGCCHUPYQp6tkJwYd7bxmJsNVeHKT?=
 =?us-ascii?Q?kLaDM+1BXewaxZy3c3N7uam3KHOer4iZh72RpbggTjEP4IcGClUvBUQAg+GP?=
 =?us-ascii?Q?KPwau3HqfODMcALY27iVHRslX3QnAKuSMdOgn6DO9B5J6v78hRX6+APjYhX5?=
 =?us-ascii?Q?nfYzR9yYuY0C4f3s5TV4I+q04GBlxiZ3n3kMubkGlKlWcL7Jj1q9eScBOP9l?=
 =?us-ascii?Q?58Yz/5HANrEKKyeGtnFKt7MJFSfq4zl4jyeaWsskCHB8Jgio1Mo6725c068U?=
 =?us-ascii?Q?DXXTwLQHsLoM5G+GZU7Jk2hZLvIOaxPvyomRKYcOraSDQsQqH4IUvqSRTbEO?=
 =?us-ascii?Q?yOmA4ZkZqeRz1si1DEsOEH6LJdm8vkyf9/h9rIkUWdf8ww=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eOvVFa3H2QEx5XAD/tFqJSLz4G5dN1UE4F3LtPZWCbxPAXbg3g4ba5Ygu6Yq?=
 =?us-ascii?Q?Pn3f5WUjZD31lOyVMgwC/6Z3jzNhGafOL/0BtTeBZExPBfqMLWCx4wuytGqa?=
 =?us-ascii?Q?SxhhU54rRx0752YxjXw0duic8szbbYow6n0eW1O8VsICdvbYgNIzliJfxJp6?=
 =?us-ascii?Q?ss/Y16cBkUZxskj9sRnk27UGss4H7gDivTYwJBh/ajz4RLeB+r7DbWfpZAl5?=
 =?us-ascii?Q?2yCFAbbPZZ3eQRAkL5gtepf+9s6DQvCzzZyeNBEsU5ktqoWhCVXv1Ox9YxuY?=
 =?us-ascii?Q?COidhtjfivtJUU2YQitvBV6wm6f5SVklF2VCkyjiW4kuqwSyiVNzvSD6oJRf?=
 =?us-ascii?Q?labLjNNzQDrUi+mJF5L71vWEmHhsJDx7IbarEYBUlvWnVhybY5375Q8KUCLu?=
 =?us-ascii?Q?8cyktSQL5BRCmMAnWKoXu96GNeDm14cJWdzY/+b/tgMLr2XuaEmV6q66dT+V?=
 =?us-ascii?Q?dRor7ZoBpmk3pD8nFjxespl4Nm00UfP+KG/H4FWQ0kXrGM9GBGhPT0gf2GhR?=
 =?us-ascii?Q?2WdWzYZ1bbO3xjHiBYytjs6/cDV8nCK5hKgYGHmnHBq7bdNXdWBFM5TEylgN?=
 =?us-ascii?Q?eJdWDIwCR5YcZo77g6iVlO+sPLbzrc5uHpiY7N0my+6/EURjYvSVO9yw+0TN?=
 =?us-ascii?Q?0u09YlYvXHyl1HTrZ1NBkRpQ15QuW1FFD5ipLzv+NO3v0jwp4Kj8NsMOJsFu?=
 =?us-ascii?Q?3zXjuQDlzJ5SEn2goJg2JG8x8r5eNSav3JnwuB/zT47pWDqRM+/FDGBYUvUp?=
 =?us-ascii?Q?D5DYd1vhqoLpqxxpWOVpppTO7FLrNU3kR3N4RVrluSz1sa1dIqz4TRtdyQa+?=
 =?us-ascii?Q?mZBxrsJYbXAI0lDc5aTKzmql5/I4ASR1gFUxBWKxGdrw1vRPtgis75Eiy2Uo?=
 =?us-ascii?Q?VIkjTjoH+YWxU/YJy3FzONgIVC7wsEjfP7Kl38iw4vHonSvDl4jAk8zkVr7i?=
 =?us-ascii?Q?ea1FgKbaugRh8q+ZoWdZ74q1OahFD18Fvkk5ZeeRiaU+gFcJz8TJ2d8XHQ0R?=
 =?us-ascii?Q?59ttWd7ZsOm2qxtZ8undBywbGxtzuxslZSINiQquDwrrnpiddu3vKrwf4npY?=
 =?us-ascii?Q?jnLkQ342WOKN9ar0Tkbrew2o9lB1gEh0rr+rmPnfg5AoAkC9aUfRBJxfkXT5?=
 =?us-ascii?Q?KrS+MaJMrXxYJRqLEd/MindbCB6NrrSkn+yP/jfGnUQT9UvFNeAkpHLh8FeF?=
 =?us-ascii?Q?Wp1yO9fnOpW+HS0e6mDmmqooKCgGvkVLjaPfjyzwQNx6nObXgCUqNCzOhckn?=
 =?us-ascii?Q?h2hnUEfzPXLQIV1XjU0vABjfvEmxBKLane9wsP0TaqrwqS8xwxA7zA5k4/OM?=
 =?us-ascii?Q?Vn/sWbm4TIFBdKZTGODEzNx/fpdFM9qm8Y2mUsjsl8oS2Bby8CJavPf9Db3M?=
 =?us-ascii?Q?P5Tv1RbOcYFMrRJrGWv3Oq5IyXh1xn94N8S9/gjEy+fcMr9k9dPomG5/ozuR?=
 =?us-ascii?Q?Eu2L2CkveA9A7esvE+CO/RESz022FDPXVe4ubh6QtflEsnS6fimCU2OF5mJq?=
 =?us-ascii?Q?zDVCNdV78JvodXYOKYHgCc4Zc/F+ql6Y4fO2vBJYcG/u/Hkx5e36HOBee5K4?=
 =?us-ascii?Q?GusFoJUIPFRbRSLW2TIPr0XV4B4Kkpfgb/zguOUb?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2dd2a7-170a-480d-1d7f-08dc7befe6f6
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:49:08.3569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58PsThw34gBRQthJOu68JVmSk68nimfBKs/e6AnlnN/6UGruE4tCCW1/QSRP4mAtHSXsBtCrtp8WhoyVaU66jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1876
X-Proofpoint-ORIG-GUID: xxvCqCDzn8gCKVytfzWH64S4lbf-Lixk
X-Proofpoint-GUID: xxvCqCDzn8gCKVytfzWH64S4lbf-Lixk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=979
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405240088

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

ODR switching happens in 2 steps, update to store the new value and then
apply when the ODR change flag is received in the data. When switching to
the same ODR value, the ODR change flag is never happening, and frequency
switching is blocked waiting for the never coming apply.

Fix the issue by preventing update to happen when switching to same ODR
value.

Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index fa205f17bd90..f44458c380d9 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -60,11 +60,15 @@ EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_init, IIO_INV_SENSORS_TIMESTAMP);
 int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
 				     uint32_t period, bool fifo)
 {
+	uint32_t mult;
+
 	/* when FIFO is on, prevent odr change if one is already pending */
 	if (fifo && ts->new_mult != 0)
 		return -EAGAIN;
 
-	ts->new_mult = period / ts->chip.clock_period;
+	mult = period / ts->chip.clock_period;
+	if (mult != ts->mult)
+		ts->new_mult = mult;
 
 	return 0;
 }
-- 
2.34.1


