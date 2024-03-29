Return-Path: <linux-iio+bounces-3923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF67892196
	for <lists+linux-iio@lfdr.de>; Fri, 29 Mar 2024 17:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DB81F26765
	for <lists+linux-iio@lfdr.de>; Fri, 29 Mar 2024 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484BF8593D;
	Fri, 29 Mar 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="VrfR5OEU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B63EEAA;
	Fri, 29 Mar 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729543; cv=fail; b=HhYYDcJokbRCKRq0uRxgj8vEhcyP+EYcX96SJ7QxeyfAUV5QEij3njssF1KKdu+ILP/Kt7KISvD2kfLPi+4yZabqvyLe9STfEAEwpEtPk9gyoljJBdEGvxp0yCsu6jBGUCh6nLvpP7iIXI60kTD+bP5voMJd7pP9uvxnZiS31Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729543; c=relaxed/simple;
	bh=ojnIokdQvRijcz3DTboXdRtO0o+cdGI6WFkVpnW+0dY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f9cwN/6awymFqH+H8pPnh3S51SYLKUQcDPVP7JF5gGizZHi1YGkXXGmf4Bfwj9HCREpOesym7eja2ZIVPrCfDLWEyGwgW+2QnBPvoZy2YWXOhd1u9qhCwOo8zq0f6WpNdFWQamxXkHeufL50b9l/hH/kI0AOh9jtdzOekRbrPqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=VrfR5OEU; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TEdxVK003047;
	Fri, 29 Mar 2024 15:16:13 GMT
Received: from os0p286cu010.outbound.protection.outlook.com (mail-japanwestazlp17010003.outbound.protection.outlook.com [40.93.130.3])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3x56f3gxkv-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 15:16:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNjxVGaIMZsfelwKRecEqux82ruLX3O9L2iS/pywkOlmOnr8FpUNdfXDcx65VvGpbijqKsnVcwkARy1tGNjOIasLd+54MX0A6bJ0yDAR2ef4viSyE81vLToqKH050Nfelpcl8NjpuugZuYE8WRwzXhjn+c9smxIwncRBxU43rXmmEoa185hcqU+Dpuh+xR70fsS2gSbd/mJ9Ty6L1AguFatpUxNLZxco5e/JhZWxbE3yentzhSvFG1HK2rxbI78F2Lh3+MBSReCTHkwuMuioJH28OiSqq6NATPp+n0h2EHhsXtiquKxKL9TdQN9LlW56O1iDPnMncZtKTT+8eHD5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgnbG7wkpM6p/PgWu9V/UDwZfU612cj38daOsGO85vY=;
 b=dEXuNIhnJfraliTxHSO/B7ujlZLwIwkrd1pdY1cHHZk0RE9/g1SGQNSoEUap2T0VwN+V7Fl8l9AM/wAKmWcnwnDWCqjgSZAsLuIncZS9yL9++eTZWyhc/xLvhiEsCMsO0+I0C8C3Cdw+XpRsla1W6fGV1oFf9R2MeN3wub0AacZAzL6JTvg0z3jHPzlkFsijVPya/kZfglTajesavjXHkSOgdtuAVw5c+mZbo6rPbqtdau58IaAU972DfJe/7Zb5fXm6aF8e5jVOuWS0++wULwiUnDGNwXt8pfeUgQslx/TqcQYZAd6KD1iKNbcHhllL6fGVrAimkm5nkmxJE7Lqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgnbG7wkpM6p/PgWu9V/UDwZfU612cj38daOsGO85vY=;
 b=VrfR5OEU61NCYA46q3z+MRKuaAyPGN1Y2mc7wwKo2UBR5v2VOlY1Ic+P7NKwZRp8yY3VE6+bDBmXIpGqqvIDcngCFre/BBX4TO6GSxCnWdknImYK4nxvviZKtUA2miaTlPQmCIgnnplekTAb/nSeHFHnkppYxhDtpFUOCJVOKIKZv8lIe7NJkERJLMUk8pfgp72VDHPcPBfsMQSLUZoXh1sZOBGbeG/NYjxekCvzoMipGNzxupXpo/7cU9Unh/Xmtgemn7G3OOVpXZo45tv7beINyzaxYoW7x36p0WhFfrM7H8Ng9MlzSC1ez/np4bQgSBKunIrJ5qqrho+NoNLpTQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB3434.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:308::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 15:16:01 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%5]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 15:16:01 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 1/2] iio: imu: inv_icm42600: add support of ICM-42688-P
Date: Fri, 29 Mar 2024 15:15:34 +0000
Message-Id: <20240329151535.712827-2-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329151535.712827-1-inv.git-commit@tdk.com>
References: <20240329151535.712827-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0050.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::19) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB3434:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Y4DF7k6NFV11KRX7s9Y7XKGzO2fwumrdufym3UwtiCSKAXJ1RsLAdsVOmX23P37JHi2J8AqxbTWh+Q+NlDXyMLdnb+sLzhWwh1al/XntK/4jVvGq9AKvY/Ka+laDB2fELe3BhQ/AuO3gcDylr7yfZx5J0Oh4k5U8m+1O6uGpnTyZYFXtgOykPBPjrVQYV5BYT/be4vH7DOF1q4sn/9nfiZ5K4ftWH1GqkT8dfCa6Ycm+ZmJa74TvepwYHFAr5VI+AxtTaVga7Qb5STwYAIQrin3q09DBErIYX9MAagTh+rww5mUGmSTxmYt7YBonOzNrOD009E0DQ59+g/maDhOH5CKqRFjkhm8OaYD7yM923onK0IJ6/+LboIiKn2KsKdxFJkVaARlEKHmPH0mGp5wO+9PVpEXUZkC5xcr3pRhgA0xfSPa0NFchRKUg4FjlyfCb041MVjNvPI3r+9INjHNzGn8BKsE/sfSKE7E9hxq+HwbTZUVBOzLCnD6StU5VKsgcQUkukWIzEKjKO19RJvFdb5Q6eZ9AG4DJingbGZJpmNiZhr8moDLJkmvi4zetMf6gk/3m0+O+1oFgJJsxpkzaOdO30L4iSWoiXEAB/derb7uOKnlFFrrcWTLtszyvpe4N64JxZStzfwHCvZV5gcS5t8fvWm8gQmVAhBMnZQesOfu2Xy6Rdlhes/5qupB5kEDoJMBM0g1eHcnm+A7n6wDgjStQcmqhiLmXRHDqqcmM/oRm7e8sfil7003tktmguhDR
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005)(3613699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7fCzaGeenVzS3bc7HWM7zIYMUIexSL4XQPQdoCgGpkeYfvHH0/NGPBNvApjf?=
 =?us-ascii?Q?9hRFfBNEQmtIs91/7KSajnRlV6mz1nmb8HngivK79exXR3II6xBym62Ehehx?=
 =?us-ascii?Q?uGuQTrfx2zTw5NKF+GEWboeAGrmCup45eVtj2dAsG0AoSfRQhHNMSECbX15y?=
 =?us-ascii?Q?a5gVNVHt4jbP4blpCN9NR+dErvbXj21kGNzvaY75HNHmtWu59ROeBogDUAd2?=
 =?us-ascii?Q?dLCYxa+4i8uzWlDbvncDfKTdaGbVZMEv1oEPasv8nkn6914ZrNuvCYtlxM6J?=
 =?us-ascii?Q?f78xQbQ69YuGvGcQfy6X0TpI1fn6FCcit+HRe1sBeXOYOMKoftPogYAhnefM?=
 =?us-ascii?Q?aPeKvhKdMIK/fbXSW/KUWgd/+R5Z72tfBj5or5+WbVm3WTBdW6THwCutiNhO?=
 =?us-ascii?Q?4CFUa/xlq7Cg67pXJREIMQVCBgk7HOO2oO2I8J/zmfSbrr8FowXoqxOSlZz1?=
 =?us-ascii?Q?RlRtNmSgip2DbMXegatO7IMmXfKOmMl99okU5Wg357eKxlD5EqN6er1aYat2?=
 =?us-ascii?Q?DFZnsPrmJFZNFQ6nsd1vogeW/xHdgHQa3HstMrXv7sSAkotra+p7Dsj4yx/j?=
 =?us-ascii?Q?WKFPCoJb4mKUDdiN3Jg34HclBC8fS3uSbkRolXtQkkvijJLCMn+fzc+S9pKk?=
 =?us-ascii?Q?vDCrn8JJBdxvoAaqg0ANmyiTPL+RBpeQKZII4PPabOj0bEmQ/CR7hIg2Rp/C?=
 =?us-ascii?Q?8VAI2t2IchepBDu5HEyVLr1+wajHVrSjcO8B35Cn5FJ9N0MRq/q3iTicNum7?=
 =?us-ascii?Q?aJZrG1fT5cNIEpDcSg6sfHuDTqt00xatFbOY+PXIkGLpt+KOhmL3dhj9KqDX?=
 =?us-ascii?Q?rapvAknlzbuHAb29lYRxZ9hCPck2nSQPEqgnmMjRmyYEo9nMCvlX8fsfNdbI?=
 =?us-ascii?Q?agiOjuOi7pM7rdy++Mmsr9OEZHTMw16kPP0byhypUvrprpCcnjzFItqYr+NM?=
 =?us-ascii?Q?CyV20ostz1+EUtsgnblyFMQnUqRBReHD5hoNjXzEjuSX5J9sIHAfuev6KZp+?=
 =?us-ascii?Q?YD4wL2mKU3MDbhMh5Ph1L/m5jvvo0fDR5bFV751ZpTHccjIu2s2AoWCAv/I/?=
 =?us-ascii?Q?c5HGiI3Wh/ly+kDP5eu4gahgPWIJcj+SZcw8BrBK4OOSxTzyv0XfhN2ixCO8?=
 =?us-ascii?Q?vg3vscEctACuliLiDh3fXu30lxcMxbIrVjmeU84FjZegyWoms7S1hItnKV+j?=
 =?us-ascii?Q?7AGGbRejKqBLxPHRVMVK0LQrBY96QeuotR4YXLpSoi52nmdcu+RSybTWQLnr?=
 =?us-ascii?Q?mcMRmPUKn4s/bWqU5FetVGNO0wQoLtLcyB30fKZi6nMgBmWRPrp0pz0E+2o9?=
 =?us-ascii?Q?CTBC6s+OIU1jlvYCm4/DHqNvFxxcWTPp1roboXRwr1qcRr4oqFSrpyBQfkTt?=
 =?us-ascii?Q?3vs9Qvzlino1JvFiaccHf5/9GVWATRkTiSdupyfOqokA6PNI6adgGLa3lz7G?=
 =?us-ascii?Q?PPUa9lI8voy5L46Ji+EuVSzN+y2oQu7YkwSTOSKycI/1egigMH/0G+JSq7n4?=
 =?us-ascii?Q?YSz5DFPRfJuSGQ7Q94eSZoTcPHIIKfd+vr8wFvRI2wdkiwmeAaXBnW5nLZCZ?=
 =?us-ascii?Q?bENXPPfaHxhr2ZFA1O3bCa3RucIcetg4+EvphmNP?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3a856a-1d32-4685-8304-08dc50032518
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 15:16:01.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uz9KpsgCKv/rz6IcHJnAa2oo8eRYn2YLHxv3wS8ACrVXncqHtBGD3m5Yx04wJD3LCw75MdpMxbwGoUwZ/wTKTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3434
X-Proofpoint-GUID: bO0woLLfaLfSy9FeusafloF_8bLnjMxl
X-Proofpoint-ORIG-GUID: bO0woLLfaLfSy9FeusafloF_8bLnjMxl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290135

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      | 2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 5 +++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c  | 3 +++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  | 3 +++
 4 files changed, 13 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 0e290c807b0f..0566340b2660 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -22,6 +22,7 @@ enum inv_icm42600_chip {
 	INV_CHIP_ICM42602,
 	INV_CHIP_ICM42605,
 	INV_CHIP_ICM42622,
+	INV_CHIP_ICM42688,
 	INV_CHIP_ICM42631,
 	INV_CHIP_NB,
 };
@@ -304,6 +305,7 @@ struct inv_icm42600_state {
 #define INV_ICM42600_WHOAMI_ICM42602			0x41
 #define INV_ICM42600_WHOAMI_ICM42605			0x42
 #define INV_ICM42600_WHOAMI_ICM42622			0x46
+#define INV_ICM42600_WHOAMI_ICM42688			0x47
 #define INV_ICM42600_WHOAMI_ICM42631			0x5C

 /* User bank 1 (MSB 0x10) */
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index a5e81906e37e..82e0a2e2ad70 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -87,6 +87,11 @@ static const struct inv_icm42600_hw inv_icm42600_hw[INV_CHIP_NB] = {
 		.name = "icm42622",
 		.conf = &inv_icm42600_default_conf,
 	},
+	[INV_CHIP_ICM42688] = {
+		.whoami = INV_ICM42600_WHOAMI_ICM42688,
+		.name = "icm42688",
+		.conf = &inv_icm42600_default_conf,
+	},
 	[INV_CHIP_ICM42631] = {
 		.whoami = INV_ICM42600_WHOAMI_ICM42631,
 		.name = "icm42631",
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index 1af559403ba6..ebb28f84ba98 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -84,6 +84,9 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
 	}, {
 		.compatible = "invensense,icm42622",
 		.data = (void *)INV_CHIP_ICM42622,
+	}, {
+		.compatible = "invensense,icm42688",
+		.data = (void *)INV_CHIP_ICM42688,
 	}, {
 		.compatible = "invensense,icm42631",
 		.data = (void *)INV_CHIP_ICM42631,
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 6be4ac794937..50217a10e0bb 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -80,6 +80,9 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
 	}, {
 		.compatible = "invensense,icm42622",
 		.data = (void *)INV_CHIP_ICM42622,
+	}, {
+		.compatible = "invensense,icm42688",
+		.data = (void *)INV_CHIP_ICM42688,
 	}, {
 		.compatible = "invensense,icm42631",
 		.data = (void *)INV_CHIP_ICM42631,
--
2.34.1


