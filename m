Return-Path: <linux-iio+bounces-4152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD6689BCD6
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 12:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35BD284EB7
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 10:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D47C52F86;
	Mon,  8 Apr 2024 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="fn7qHl3Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE155524AD;
	Mon,  8 Apr 2024 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571459; cv=fail; b=YLbbVXpqYS1fvm02GVt+brvwEIi/w0E9TKrY2HcoNidFCrotGd0iI7nTpa0yxpSlKC0ncIIZG3QNCOyDW76ocHCJIq9D8sYxatAmkOeAcdwhBsP/uXkWHsfUSzsBPN5Q7BIumBMklTZBGZDjpr4F5OrlCudnEpb70dwAbEuMjHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571459; c=relaxed/simple;
	bh=Pyza6lewOnQeokaHuWn8lycBhcceDnipIpc+j9ttMgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jTDrTyigNklJfsoCpGjaYlPAGlxGNR9+EMGcLFSOsfpaoviQudVKO9FX6839vl1V0TDcgCc/VRVQrR5V+9BbVqBAmCC/7+GLnbRhwT/Nsq7lBggZ47gdqPqZjWcjSXNK7wQjO8r7Oujq7XN/VSFaPqzgA6KGdkxAq/Fvr87wwsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=fn7qHl3Y; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 437Mo3QV030593;
	Mon, 8 Apr 2024 09:07:45 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17010000.outbound.protection.outlook.com [40.93.73.0])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3xavryh6a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:07:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nbuv4ZXrkA5EcbwBdl3k0rkek/X7F55c2cO7IHSza92dNpzHSnkKBF+PfeJxQQ2qQ6TqqbK6Zj4UpE/8FWf/nOFLjEs+TDnV0GTa9MgpmVE+8T7D3Me2Whaouqo5mZCn+6UV8cOLUGbQKw+6ddNmJ5O2u9uvp0uJeHhw/Gzrr4v9hhbKwdKr7GwQldfHWfm8Ht8VS4keyDWzvYOoKFGYhHZva8qrVlntmdHZ601m4wHjYEE1vLy4C9NdBW+ZAWuWr7hs/DJMeOhrAuBdbDg3BBAnyalEPJQ0YHAT3/F+EucyXR4nIEwuDJBUemX9YJjTxDuQtkUYCQvoEGoGlov2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0aoivwitiHhfLfo5XHVZPedKsHvdSTRbKEdhH6rjQE=;
 b=fqL2qKuzey/bOkN5Y+PA5Xq2GWH9VPtp9XSUaob0RrbiE51egCVpBRH/lO3ivESonxuXSYW8XIogumydelX+skJWxfZwlGSV2ieCHxJoBqTBYRR25jlRwViEJhRKxE0en2T6owUS3zPxr04iz4sG+klu0uuHD9AEyR1QHCx/7J/ZrDEI6FweTOZ1XRaZnUW3FBeYCNmzHeTiRo6zCplXSc3xcUAcqt3Qojnou7aYgLBIMFrPFjU3g81qMikRpjp4K7tLrHwhyq5htt6LTjunxuawfS8pvZLDbGsGSASeW6Pdjhky+SyjuRtfj+Bc8dJo2kNKCqbpFT/VLoIPc7E0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0aoivwitiHhfLfo5XHVZPedKsHvdSTRbKEdhH6rjQE=;
 b=fn7qHl3YjnUq2aYx8ST+n9ufxS4n02cF/HO0QRCqWn6APHM1aWxXlj6ug3hysLHhEBQpDk1ouV1INKYaFFHf4kMC6wRU10d8DPGVX8o7/DcviuvaqbKXUOA6a6YV2EAC/OTo/MU/1QXAeIcTdN9yxLoLDev+1qW5AENCAC0mysDMeNHdwpL3S191xUxpZQxmC4jGHp34SagMsBrTsSW9H6YfYYiaqWeJJDZSXiEh8kxlIPyundh+6ysRLnxOsQ+HqWW0VJm2bLpghgbtumXQ2U+gP+PWDYGZ1IujoyQNshZa7h83hOPR++hOL2iMMOnlgaxttNbLlp+LMpX8lRaoMw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB3342.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 09:07:41 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%6]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 09:07:41 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v3 2/2] iio: imu: inv_icm42600: add support of ICM-42688-P
Date: Mon,  8 Apr 2024 09:07:20 +0000
Message-Id: <20240408090720.847107-3-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240408090720.847107-1-inv.git-commit@tdk.com>
References: <20240408090720.847107-1-inv.git-commit@tdk.com>
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
	rgP6i5Lpv7B+seuGLPCGiI6/ka02O3JIaJc2KyTT7uuOs2lTWa86toLJVfvo4xZXbhkn8L3DmLJYV3TqyPQKJFDzR+UHgJj6PUNJqUEHwMj6QOM3Ks1k0YVUSDEvxdzbMO+GRyffmkry6dKbVQeKBJPyAzvO8SS5u++BN+ZNLhZOfafAlXyCj5ZGO80+rMLYIh+t65B6Ccnva3DeeU8o80/aRJ77NIyBWsgTsfZlUEiMoiub47HFmp233wmZWAho2nnuRcQHMbtX97m/QC+5kkxoKGdNAWp3tMzacmq/LYVxHC2z6PB+kQYJvWb9ZM4GDDmjnVf5n5bEuqCpdVKDVoAEVVfhUuJQO3izgvbsUoXc2kmsFrVikTs6RrlNzVC61xpUgDa2zKaZksuqI4G21nIBdbaMCiH3OXAvNVJq4kWIED0ijNj/D2ttUpz0V8npakqSNYqZnu9XyORcsPISt0vTKgGvQApVo2wrmQ9j54FsjNw6fIOqsUQGCkp5YrpFgUughzkrwCMr/eZC6xtRaOiVWAosjrGJTsrUXQDQXdvyGzpc9aI5auTQJNJdNJ5bfea6PSgcIrsXYIiMBlL7Cchh6wZObNI5RbyHoNoji6i56+TlfvrxHSfsotY9hkSI4CFbTA1qPd2DWCaKfP0000uCrqw0UrkXqjdw9r3elmfteuepLtl8q/nDIJKBHmti3a9wzNA+Y5H7GGpGqtMkOninTRd+miOC1s7Ud3M6RTVXNT4DWUCncGyvgL7nPpas
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(3613699003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nMk8FnRnnJgzi1swVQW4uicNXZdgYFPioLo2Gnt+SB+sHr0B2Mg4+q+i1Weo?=
 =?us-ascii?Q?z2LjgU03Nf/jVkmL/g8/gS2bAKG0LjwwFtJOOAZnBMtRIUHXz9Wd+c6++2wZ?=
 =?us-ascii?Q?254SA79apEHZNf5jThBuPpT1eF/rSHPwVFjG8uSQzWa2ikoFFE3WEraAXAsW?=
 =?us-ascii?Q?mJJl9+XqiYfJyICz0hUcwbM9KIEVpv6RJ8GXoGM7Glejn6uQUBxmcqzttHZQ?=
 =?us-ascii?Q?bjszJuGxIgRLPgu4tZGpqa6niw9xVqrDkRxzGyaMqxiAhjIiABf2OqCvcovr?=
 =?us-ascii?Q?8DOaywfFy7aPxHygxYZJ4uOKWIzKlg4mehf9up+20/vPFigtV2Xyb4OcFdDc?=
 =?us-ascii?Q?8P17+hnh5OoLj6MH1CXfw75s5hu6O1CR8RWdBloozNzmdvkbUIZGEWrJcj83?=
 =?us-ascii?Q?mFMV7Y9cgmzOKKH3MgBV2cTdeM59jqDAPl+1Hyo7PNYyI42Uer5CCXxrW6os?=
 =?us-ascii?Q?tjobP9hE/qg+z8EZslH7NE6U3NYAmqraz0jJwtcHYhunuVU05FgcAw99wqQE?=
 =?us-ascii?Q?pprjpXf2nCfkxUqzgzQhk25790vJjfBhVVe6VDebmrkgFI47CnYB5F2v7uiA?=
 =?us-ascii?Q?vP9SqB232htKDeuG1zWNTrBhOvDmLXQxUj26/SdzCmtSH1sH02yapo+Y46cS?=
 =?us-ascii?Q?nPjwx/B50OXoeKfzYwHD87QT1DD3xaO5RqsmUPIsV1ELvKC3D6a2o9Yu6C1T?=
 =?us-ascii?Q?sSAoQaKAykTPtJ8x3LZPQ43eVgeebQTym0uZqsAd/mRzqlAnoO8ricsQtwGH?=
 =?us-ascii?Q?v1E4PWdul5LQE45POfl+U9Fvhk0Vr7/FkkFhhcIsh4lR7q36KIJdNq8Aeskg?=
 =?us-ascii?Q?cOwbc3rfsZJXZNmplKD+9p0JkIqJVPW5kMVO5YUVfqfn2vGRdyRNoxwl0/B6?=
 =?us-ascii?Q?BIcRXrvRJ+5u8Rmg/EWRo6Dpc7uo3g3YuKxSLIg9xXdWnNZZOoqnizsL7I7G?=
 =?us-ascii?Q?DRKVbbxYTD/HW8bMGcmIsraj79erEuQlN8+3RzmJPgl/cqxL61GEiem6BxME?=
 =?us-ascii?Q?HHVhguu1NtHjpBqlvysd4Uhgwv6Hikeh9VkwePWdJjNMnZMabNaTKHhtXCNJ?=
 =?us-ascii?Q?J7A+7Cuv2Gs6rdXYn3kPKTRtN4yqrlomDq1L++9rUTKubhvqv2nYii035dwp?=
 =?us-ascii?Q?DP05CWqE0myVIFNvPS4RQEfd4Ah96dhlSmNrtIBHCXd+ccYjDE9tvxic3bJR?=
 =?us-ascii?Q?2kF7xh24D6UUjoJ7xg9TtFT0V+GI727qhnzqADKYkYKC+e4H2/JRBZ5SXBKr?=
 =?us-ascii?Q?5IYq1epHwfrmayzO34VV6F0ZynlHJrjTJ76FFxQJy8/G9JQBLeikRIDmfGeH?=
 =?us-ascii?Q?FstYt5qamPNUUnCOvfXYuhiBwrtqNgXCkTHRephGLvcIv3hdF/9xPmCQ8U41?=
 =?us-ascii?Q?ReNYOPyOYS7EzqeGHab6fCdULuE/9Hz/5uojueJyqgUzQDRhM4Iqo/lSmMsO?=
 =?us-ascii?Q?e4yX9BIMRyxAHRu5I9R+0roj9hFwkDRbP2YmNy/+N5nS4lzBVK/dVdnjDPLA?=
 =?us-ascii?Q?W2NwQM86f93qhIqQyAiHlDJiteOLuWg/aoqsRjAvL8aUaeqsxCuWL7SsQX/6?=
 =?us-ascii?Q?0FB5hPCN+TPM5Vwx9CLeYFGQhUIYu1q1vAYel6TM?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1576513b-0fc8-47b0-c477-08dc57ab58aa
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 09:07:41.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjVPTykhQYU76p0S1Ng3s7fHo3jzwHITSorYov5CGzqY4NXhB1WYyOCwE8zSbrNPm5T0qmeVS+h1FyqGw18lnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3342
X-Proofpoint-GUID: x-RptvjZAnUQikveOk7v_1uVWBoVnPPo
X-Proofpoint-ORIG-GUID: x-RptvjZAnUQikveOk7v_1uVWBoVnPPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404080070

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add ICM-42688-P support inside driver.

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


