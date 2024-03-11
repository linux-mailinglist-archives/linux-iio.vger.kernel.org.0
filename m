Return-Path: <linux-iio+bounces-3463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1B487859C
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 17:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C341F22576
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008EF42073;
	Mon, 11 Mar 2024 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="tZp4znfI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A78405C1
	for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2024 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175259; cv=fail; b=bfrU9HfaqnHbjETEYn4PQQl05Lu1tsOOldhU+461Cje39rWPnKBVMNEqf9p+nWLkQ85lGflfmw7UlyXn87yLYaXwBnjy7Yl3DDETp1P0gVxFPe9jBXmlp42TNQxg2h1fKwhfqq8AZkuRCenZz47LSYvUoVuvo9DID5/1S9ED7gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175259; c=relaxed/simple;
	bh=l9Ls0+hh+ZteB0TOQ0TjYzPu0NP1anTE9Lqnm5Ha3Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IiVhkKqpIq9DRlG6mrSEU0CNlMqK0GLaxGEHNtWbs7VvL2i/GgodGlJWEhDr4aw/OVlTmah2gwMw4IhhCsZwetwJ2Fy7N8T86xUbLVskqJU6s6dnRTyr+D2WCTV2eZzqsH0QO5kNXO8qgsywJvpINEKqfiwyHtoLkk9QtoEeV6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=tZp4znfI; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B9SP30018770;
	Mon, 11 Mar 2024 16:06:22 GMT
Received: from os0p286cu010.outbound.protection.outlook.com (mail-japanwestazlp17010000.outbound.protection.outlook.com [40.93.130.0])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wre4xsbjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 16:06:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTTMuvX0ecNdMcNwztOyZs7wieat1DHfpX1Vvv7DZ0l9jVNME46eVccQvL5q+229rr2skoBSlMsHDeC5ayOTTuKbbQA+/U2s7z/ExSD6ZAO5MohdBAa81AdJw0XlVQl+c9RZDqeZ3CjbDMwgWYPRnA+srTZvPR2sOI5AzBD+bxJ7KSILciL5HliqixDC1mM+qhJUInMoST7tgu6259ghs3HEdji9a7WelMnuJWnWMSwfAZIZ1O7p5zmfXj+QVwqd3VJUEAW7BOfV5g+ZfuECOHKiQvkP4C005vi9o5YzIiqJYab29J/OXtIR/uPeW39fXr9iH2au0R7aso0w14pSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eipdkPfj8YpXZ7eHh9U8768O/9LoZDWbP6GirwR8Z4A=;
 b=EQ06LBJA7lPs096A8QYA5u0LwCoye/LkOimuIwsn6qpu5zZ4Iknw5NO/9Yj9oiQpr+JxJ1M15LC6yGZSB+ypUyzrWe/thei50M2UdlXaQZ0RTK4q9o8VlpxEsp2bQdP01E9Owx/tJdMi9kgO19K5VlcUv/ZaVrhFSJaZwd+KNdxIFYxNBXRBqHrPIaSP0N6eqvkREZRYBFZdCKPp0/t5+t4XEAIzbV2UqENiBB4I2JezVkLforSGmv+IvU7V4CvYxyu9tgVfaWN3ZkF41lva1VBzILNtEJhJ5XgipgDfKdj/aTjlmkzqAd/v/3UawDc/WZxb6uvTCkmnUIkCeroEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eipdkPfj8YpXZ7eHh9U8768O/9LoZDWbP6GirwR8Z4A=;
 b=tZp4znfIlhQhxOIJOSgYEdm7rlwDaLtwSFQpBf0EV/fpJ3LzwksXRe0f300FFdQFTgt2CDMFfINSEImW6jY03X2LSmRmbnE/uXWPWD5qtIu7U+DSpeFtYIVg2Qy2EOxz6JhohAZSlxG5fMwSS+YjXOfELoNpLL6+YW7DwpBmVpDX97iapuZmPk3Ulfr83MmgdXa+T0MP3f7QR3k0wW5I/t4LeKk4iOShJXoGom3P48FxzSmlcwQg7kOCjvYESh4N7pMPYH+HhckbDtWVcx9czcG5PcrMHjQThGJVHrHwMtj+QWHuvzPhw9UTO13SixbirF6oBTY+od1r2kQyAvLDjw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB1961.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:06:19 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%5]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 16:06:18 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v3 4/4] iio: imu: inv_mpu6050: add WoM suspend wakeup with low-power mode
Date: Mon, 11 Mar 2024 16:05:57 +0000
Message-Id: <20240311160557.437337-5-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311160557.437337-1-inv.git-commit@tdk.com>
References: <20240311160557.437337-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0074.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::7) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB1961:EE_
X-MS-Office365-Filtering-Correlation-Id: eab0e3f3-3016-4e7b-eeae-08dc41e52fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RQGOdZmKHFH2mQRmH6/Qkjg0ZfLHwf6veD18yiDFt0upZz8IXvq84zrIh1G1KiBYTlNgXJNIPb0Z4chq7FOaKs7sciknZZxcIXox04TPDAidaE1q8wRQ8LUWjzzVwTKytiJ3znnQJgx6w5Dr3ZjgGXbWbgRaI9TrntIYK1TJ+qWwTyEHbbhn8d+RRf6BhVoqOLdQz4oE29DeKn0mO6ca2Pt6dL2iDzITtabkp44nkSxWVO1G3hWRuPS64PxS1KiPbbRrzS3vZy4JBrHOdGs3g40IpoeHQTBASOudJS6kxNoEJJopqheOwYu/7AVS/UBH+wHUyq9ALYqEP0b6KdrHTcnx80HD0++YsS4C5qiQYSlYRJvEvEDks3sye90b7vpUA5HGlNpUwrEwq1YFj/9Qv9g4iA2kOKM4BXQ1aEOP8qkmG4m0/K9CvQJK4la3WEDOcBoZY3estnrIge/MkhwRj662wxuHPDfyBW+adYhu32Pnl1VzRQ7e/e815qp+GZexdHgD5eBZUaBbZ1rc53nwXUAqovBKCbo/SZ7YVvLTFxaYk/BlPw2KIDdN51S9zIdlLXUI5nPw9s+yEhFH7JNEB7Y609XASRHu/7vaatJcdUAmkBas2RZ+DN1jM5ISDVoBYJHbNq8TdgDY5POH0ohhJkFX6/GzWmQIhJau8rgIIFpip9Plc3lAqqZn9m4+CYF0Kq59VnMXWFUfm+RhdfntWJHeVDr5dLFhHHaaAgaZvlGDpEPXo7FOQMKNZ0KxAiCC
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(3613699003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dLSTxX2U7SgpvSyxcxp47qF0zYBk3VDitV500pUomFkesbCSyOe5+cZyFsW3?=
 =?us-ascii?Q?8BXR7giq8M56NUQbZSvke2onGGPTAZ5UoxN1nIMf/Ksk8BBtqxklee9PWhgj?=
 =?us-ascii?Q?J25RaJxvjgy1ZKmtSMn14iiyR6ulUlFDkC0jKTl7plAYsJMV7cc8Tf/z8at/?=
 =?us-ascii?Q?p6m7F1/AbNLJqpd3DF0EqQpwS8Lkqe3Z+Bm699A+f1JxHVpaaALTdSHljYal?=
 =?us-ascii?Q?FSxtQlXOyjULChZOiDt4h+BFO8qKzZxCCgklIgofCRElXmS3Zsu72rPoFsqQ?=
 =?us-ascii?Q?6k1F/rFpjg9l52CiYjfeh6Z0jic8Z+mo/EQDMYJudXpd8OlFkTNg1v85XE4U?=
 =?us-ascii?Q?9/rvwzZLnmlEaR3cAZ7IFmAk/XG5Ah3YEwINFScANBqEU46JHhQQMd8ZcMEH?=
 =?us-ascii?Q?K5qD8m8uZ1rY46FsS4x9clVVEGVUSYisMj5ECXsw8+vmBWIJsFcOAax6EWQm?=
 =?us-ascii?Q?t9D/yaOokeKuvrE/C46eb6FUMIAnSAKIdzcE6S4laLpxeqVR5noUR+w1NttW?=
 =?us-ascii?Q?LCBycaktRIwx4aXL6PswJNwEdjw7MxsdCDxCKV44U4MFem/DP3dvqSi0Wbid?=
 =?us-ascii?Q?9mXiHB4fprs4WKUvaszI7s+ibBuZznJzKA6MmryqfH7WDdvtaC+zxYh/tfzG?=
 =?us-ascii?Q?nciayCWvqdUGluMQvmoG+wUpWmd9UlrR+RRnRYBi8Vv/IFhFSmzCgJPGx3YC?=
 =?us-ascii?Q?A2dU+17e1k31hvswmIOKHD2lahtjuaiTJAuJn8sDWpA1y7nCOR8GWFlL8lcq?=
 =?us-ascii?Q?0Ztqpo9B5utLGD1wz2vYiLM0KnODErR/QmbatF+e0pmbEkwKKa7cW0+Kyo3l?=
 =?us-ascii?Q?xQavxFc1dN6QAtPJfSkVzMOX/n9p3HSBwr9O8UPIvRlCxvHzBh1WtEdQGVk1?=
 =?us-ascii?Q?7SG0YK9CmlaLtMrj5pFyFthovTZSDD4wHmL41IvjTG7pxZejGW3QUWhS7EV/?=
 =?us-ascii?Q?vxqGG8K7WfYIkiKk5m2vh6uUOwIlJkbu9sb9H0rdqjMQkeDPde6OS5TzMlnK?=
 =?us-ascii?Q?eVUu80qk0WLsn0teMO0SxdJi+vJ1K063oUgRV6sWT69R/VUgrFHBPXAy/l0C?=
 =?us-ascii?Q?SXyCguNcisjnfg/ahT61WLGKA4Iuu+HjgX8NhiUheN3Vyw+w/Cwk2zRGfaJy?=
 =?us-ascii?Q?eKOXgc+lrBnkH39ENQXVsD0BqKXi/Fg6mIXgHeapORZAZVv72XWkhars+10W?=
 =?us-ascii?Q?7O0E8aWQIOLJ8HbL1Qilgo08LYR4CkqD3LFuWXtqM7MY7Uer8sZlu8wFmxyU?=
 =?us-ascii?Q?G3l2m7tPGmzaL6qt6j8OZ+iENth0RXk+UmGzvwhG/bSE7fMn3Uv8c/5CQnX1?=
 =?us-ascii?Q?FOjFoD4vwTFU0XApoXI9BHBSrzxvRWuSTyUtXi+oc/hfBnFENH6y9R1VE+jP?=
 =?us-ascii?Q?uDgHigznQ9tg7aqsjCmw8XnmHjH/0mjLiG1ThjFE+B8p8wobR4wUg/628MFR?=
 =?us-ascii?Q?zjhLBwrexovi5DjVpXB3uD3a9eindlI2mZVexGkfcY2wCBaI2kKo/q0Moy/8?=
 =?us-ascii?Q?IB7oLgUMfHGrsEImAjZ/L9n5uN9kp7bPU+3hVr1ABOn8R9Oa7+Qh0ShqJcbG?=
 =?us-ascii?Q?sonExNj5ExZFPoiD18fMw8DNJzc7Jxoh8UmL/1f6?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab0e3f3-3016-4e7b-eeae-08dc41e52fc6
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:06:18.8531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVUCY7zdBz38LDw8BEaN29vN957igw+RyXv5yO9raY86kSUaM5t7X+4nJT/VnbNUWYALeZtcLIku+s6f5dbOKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1961
X-Proofpoint-GUID: gY49OkwPSbWXmI0edhJCcKvhYq3gfPUM
X-Proofpoint-ORIG-GUID: gY49OkwPSbWXmI0edhJCcKvhYq3gfPUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403110122

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add wakeup from suspend for WoM when enabled and put accel in low-power
mode when suspended. Requires rewriting pwr_mgmt_1 register handling and
factorize out accel LPF settings. Use a low-power rate similar to the chip
sampling rate but always lower for a best match of the sampling rate while
saving power and adjust threshold to follow the required roc value.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 203 +++++++++++++++------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  14 ++
 2 files changed, 166 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 281fbd8eb791..caa486bbe865 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -289,7 +289,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 };
 
 static int inv_mpu6050_pwr_mgmt_1_write(struct inv_mpu6050_state *st, bool sleep,
-					int clock, int temp_dis)
+					bool cycle, int clock, int temp_dis)
 {
 	u8 val;
 
@@ -303,6 +303,8 @@ static int inv_mpu6050_pwr_mgmt_1_write(struct inv_mpu6050_state *st, bool sleep
 		val |= INV_MPU6050_BIT_TEMP_DIS;
 	if (sleep)
 		val |= INV_MPU6050_BIT_SLEEP;
+	if (cycle)
+		val |= INV_MPU6050_BIT_CYCLE;
 
 	dev_dbg(regmap_get_device(st->map), "pwr_mgmt_1: 0x%x\n", val);
 	return regmap_write(st->map, st->reg->pwr_mgmt_1, val);
@@ -318,7 +320,7 @@ static int inv_mpu6050_clock_switch(struct inv_mpu6050_state *st,
 	case INV_MPU6000:
 	case INV_MPU9150:
 		/* old chips: switch clock manually */
-		ret = inv_mpu6050_pwr_mgmt_1_write(st, false, clock, -1);
+		ret = inv_mpu6050_pwr_mgmt_1_write(st, false, false, clock, -1);
 		if (ret)
 			return ret;
 		st->chip_config.clk = clock;
@@ -360,7 +362,7 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
 
 	/* turn on/off temperature sensor */
 	if (mask & INV_MPU6050_SENSOR_TEMP) {
-		ret = inv_mpu6050_pwr_mgmt_1_write(st, false, -1, !en);
+		ret = inv_mpu6050_pwr_mgmt_1_write(st, false, false, -1, !en);
 		if (ret)
 			return ret;
 		st->chip_config.temp_en = en;
@@ -467,7 +469,7 @@ static int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st,
 {
 	int result;
 
-	result = inv_mpu6050_pwr_mgmt_1_write(st, !power_on, -1, -1);
+	result = inv_mpu6050_pwr_mgmt_1_write(st, !power_on, false, -1, -1);
 	if (result)
 		return result;
 
@@ -497,22 +499,9 @@ static int inv_mpu6050_set_gyro_fsr(struct inv_mpu6050_state *st,
 	return regmap_write(st->map, st->reg->gyro_config, data);
 }
 
-/*
- *  inv_mpu6050_set_lpf_regs() - set low pass filter registers, chip dependent
- *
- *  MPU60xx/MPU9150 use only 1 register for accelerometer + gyroscope
- *  MPU6500 and above have a dedicated register for accelerometer
- */
-static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
-				    enum inv_mpu6050_filter_e val)
+static int inv_mpu6050_set_accel_lpf_regs(struct inv_mpu6050_state *st,
+					  enum inv_mpu6050_filter_e val)
 {
-	int result;
-
-	result = regmap_write(st->map, st->reg->lpf, val);
-	if (result)
-		return result;
-
-	/* set accel lpf */
 	switch (st->chip_type) {
 	case INV_MPU6050:
 	case INV_MPU6000:
@@ -531,6 +520,25 @@ static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
 	return regmap_write(st->map, st->reg->accel_lpf, val);
 }
 
+/*
+ *  inv_mpu6050_set_lpf_regs() - set low pass filter registers, chip dependent
+ *
+ *  MPU60xx/MPU9150 use only 1 register for accelerometer + gyroscope
+ *  MPU6500 and above have a dedicated register for accelerometer
+ */
+static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
+				    enum inv_mpu6050_filter_e val)
+{
+	int result;
+
+	result = regmap_write(st->map, st->reg->lpf, val);
+	if (result)
+		return result;
+
+	/* set accel lpf */
+	return inv_mpu6050_set_accel_lpf_regs(st, val);
+}
+
 /*
  *  inv_mpu6050_init_config() - Initialize hardware, disable FIFO.
  *
@@ -1002,6 +1010,84 @@ static int inv_mpu6050_set_wom_threshold(struct inv_mpu6050_state *st, u64 value
 	return 0;
 }
 
+static int inv_mpu6050_set_lp_odr(struct inv_mpu6050_state *st, unsigned int freq_div,
+				  unsigned int *lp_div)
+{
+	static const unsigned int freq_dividers[] = {2, 4, 8, 16, 32, 64, 128, 256};
+	static const unsigned int reg_values[] = {
+		INV_MPU6050_LPOSC_500HZ, INV_MPU6050_LPOSC_250HZ,
+		INV_MPU6050_LPOSC_125HZ, INV_MPU6050_LPOSC_62HZ,
+		INV_MPU6050_LPOSC_31HZ, INV_MPU6050_LPOSC_16HZ,
+		INV_MPU6050_LPOSC_8HZ, INV_MPU6050_LPOSC_4HZ,
+	};
+	unsigned int val, i;
+
+	switch (st->chip_type) {
+	case INV_ICM20609:
+	case INV_ICM20689:
+	case INV_ICM20600:
+	case INV_ICM20602:
+	case INV_ICM20690:
+		/* nothing to do */
+		*lp_div = INV_MPU6050_FREQ_DIVIDER(st);
+		return 0;
+	default:
+		break;
+	}
+
+	/* found the nearest superior frequency divider */
+	i = ARRAY_SIZE(reg_values) - 1;
+	val = reg_values[i];
+	*lp_div = freq_dividers[i];
+	for (i = 0; i < ARRAY_SIZE(freq_dividers); ++i) {
+		if (freq_div <= freq_dividers[i]) {
+			val = reg_values[i];
+			*lp_div = freq_dividers[i];
+			break;
+		}
+	}
+
+	dev_dbg(regmap_get_device(st->map), "lp_odr: 0x%x\n", val);
+	return regmap_write(st->map, INV_MPU6500_REG_LP_ODR, val);
+}
+
+static int inv_mpu6050_set_wom_lp(struct inv_mpu6050_state *st, bool on)
+{
+	unsigned int lp_div;
+	int result;
+
+	if (on) {
+		/* set low power ODR */
+		result = inv_mpu6050_set_lp_odr(st, INV_MPU6050_FREQ_DIVIDER(st), &lp_div);
+		if (result)
+			return result;
+		/* disable accel low pass filter */
+		result = inv_mpu6050_set_accel_lpf_regs(st, INV_MPU6050_FILTER_NOLPF);
+		if (result)
+			return result;
+		/* update wom threshold with new low-power frequency divider */
+		result = inv_mpu6050_set_wom_threshold(st, st->chip_config.roc_threshold, lp_div);
+		if (result)
+			return result;
+		/* set cycle mode */
+		result = inv_mpu6050_pwr_mgmt_1_write(st, false, true, -1, -1);
+	} else {
+		/* disable cycle mode */
+		result = inv_mpu6050_pwr_mgmt_1_write(st, false, false, -1, -1);
+		if (result)
+			return result;
+		/* restore wom threshold */
+		result = inv_mpu6050_set_wom_threshold(st, st->chip_config.roc_threshold,
+						       INV_MPU6050_FREQ_DIVIDER(st));
+		if (result)
+			return result;
+		/* restore accel low pass filter */
+		result = inv_mpu6050_set_accel_lpf_regs(st, st->chip_config.lpf);
+	}
+
+	return result;
+}
+
 static int inv_mpu6050_enable_wom(struct inv_mpu6050_state *st, bool en)
 {
 	struct device *pdev = regmap_get_device(st->map);
@@ -1836,6 +1922,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 			irq_type);
 		return -EINVAL;
 	}
+	device_set_wakeup_capable(dev, true);
 
 	st->vdd_supply = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(st->vdd_supply))
@@ -2001,16 +2088,27 @@ static int inv_mpu_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	bool wakeup;
 	int result;
 
-	mutex_lock(&st->lock);
-	result = inv_mpu_core_enable_regulator_vddio(st);
-	if (result)
-		goto out_unlock;
+	guard(mutex)(&st->lock);
 
-	result = inv_mpu6050_set_power_itg(st, true);
-	if (result)
-		goto out_unlock;
+	wakeup = device_may_wakeup(dev) && st->chip_config.wom_en;
+
+	if (wakeup) {
+		enable_irq(st->irq);
+		disable_irq_wake(st->irq);
+		result = inv_mpu6050_set_wom_lp(st, false);
+		if (result)
+			return result;
+	} else {
+		result = inv_mpu_core_enable_regulator_vddio(st);
+		if (result)
+			return result;
+		result = inv_mpu6050_set_power_itg(st, true);
+		if (result)
+			return result;
+	}
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
@@ -2018,20 +2116,17 @@ static int inv_mpu_resume(struct device *dev)
 
 	result = inv_mpu6050_switch_engine(st, true, st->suspended_sensors);
 	if (result)
-		goto out_unlock;
+		return result;
 
-	if (st->chip_config.wom_en) {
+	if (st->chip_config.wom_en && !wakeup) {
 		result = inv_mpu6050_set_wom_int(st, true);
 		if (result)
-			goto out_unlock;
+			return result;
 	}
 
 	if (iio_buffer_enabled(indio_dev))
 		result = inv_mpu6050_prepare_fifo(st, true);
 
-out_unlock:
-	mutex_unlock(&st->lock);
-
 	return result;
 }
 
@@ -2039,29 +2134,30 @@ static int inv_mpu_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	bool wakeup;
 	int result;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	st->suspended_sensors = 0;
-	if (pm_runtime_suspended(dev)) {
-		result = 0;
-		goto out_unlock;
-	}
+	if (pm_runtime_suspended(dev))
+		return 0;
 
 	if (iio_buffer_enabled(indio_dev)) {
 		result = inv_mpu6050_prepare_fifo(st, false);
 		if (result)
-			goto out_unlock;
+			return result;
 	}
 
-	if (st->chip_config.wom_en) {
+	wakeup = device_may_wakeup(dev) && st->chip_config.wom_en;
+
+	if (st->chip_config.wom_en && !wakeup) {
 		result = inv_mpu6050_set_wom_int(st, false);
 		if (result)
-			goto out_unlock;
+			return result;
 	}
 
-	if (st->chip_config.accl_en)
+	if (st->chip_config.accl_en && !wakeup)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_ACCL;
 	if (st->chip_config.gyro_en)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_GYRO;
@@ -2069,21 +2165,26 @@ static int inv_mpu_suspend(struct device *dev)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_TEMP;
 	if (st->chip_config.magn_en)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_MAGN;
-	if (st->chip_config.wom_en)
+	if (st->chip_config.wom_en && !wakeup)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_WOM;
 	result = inv_mpu6050_switch_engine(st, false, st->suspended_sensors);
 	if (result)
-		goto out_unlock;
-
-	result = inv_mpu6050_set_power_itg(st, false);
-	if (result)
-		goto out_unlock;
+		return result;
 
-	inv_mpu_core_disable_regulator_vddio(st);
-out_unlock:
-	mutex_unlock(&st->lock);
+	if (wakeup) {
+		result = inv_mpu6050_set_wom_lp(st, true);
+		if (result)
+			return result;
+		enable_irq_wake(st->irq);
+		disable_irq(st->irq);
+	} else {
+		result = inv_mpu6050_set_power_itg(st, false);
+		if (result)
+			return result;
+		inv_mpu_core_disable_regulator_vddio(st);
+	}
 
-	return result;
+	return 0;
 }
 
 static int inv_mpu_runtime_suspend(struct device *dev)
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index ca5f7d45a6d4..d65b8776004a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -305,6 +305,7 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_REG_PWR_MGMT_1          0x6B
 #define INV_MPU6050_BIT_H_RESET             0x80
 #define INV_MPU6050_BIT_SLEEP               0x40
+#define INV_MPU6050_BIT_CYCLE               0x20
 #define INV_MPU6050_BIT_TEMP_DIS            0x08
 #define INV_MPU6050_BIT_CLK_MASK            0x7
 
@@ -336,6 +337,7 @@ struct inv_mpu6050_state {
 /* mpu6500 registers */
 #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
 #define INV_ICM20689_BITS_FIFO_SIZE_MAX     0xC0
+#define INV_MPU6500_REG_LP_ODR              0x1E
 #define INV_MPU6500_REG_WOM_THRESHOLD       0x1F
 #define INV_MPU6500_REG_ACCEL_INTEL_CTRL    0x69
 #define INV_MPU6500_BIT_ACCEL_INTEL_EN      BIT(7)
@@ -452,6 +454,18 @@ enum inv_mpu6050_filter_e {
 	NUM_MPU6050_FILTER
 };
 
+enum inv_mpu6050_lposc_e {
+	INV_MPU6050_LPOSC_4HZ = 4,
+	INV_MPU6050_LPOSC_8HZ,
+	INV_MPU6050_LPOSC_16HZ,
+	INV_MPU6050_LPOSC_31HZ,
+	INV_MPU6050_LPOSC_62HZ,
+	INV_MPU6050_LPOSC_125HZ,
+	INV_MPU6050_LPOSC_250HZ,
+	INV_MPU6050_LPOSC_500HZ,
+	NUM_MPU6050_LPOSC,
+};
+
 /* IIO attribute address */
 enum INV_MPU6050_IIO_ATTR_ADDR {
 	ATTR_GYRO_MATRIX,
-- 
2.34.1


