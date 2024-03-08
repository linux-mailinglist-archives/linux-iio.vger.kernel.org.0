Return-Path: <linux-iio+bounces-3384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24E2876712
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 16:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58337280F14
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 15:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB73568A;
	Fri,  8 Mar 2024 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="BWpdWFZC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1F1BF37
	for <linux-iio@vger.kernel.org>; Fri,  8 Mar 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910690; cv=fail; b=M74MS8ICtedcFpgG0LWb6cMvQfrhs5xlyWux6GhDlI25AlvgnbB3qQbpevXPoW+dLHRWY2NWjatsQMFXLqfrmt6n5csymBPuS5h3RfpguugA5YKHP28JbR2xGcfKLFMoqo49GL1C7XvO1sZyahtqzXONMEJ8QpF8+97Bxc2fbcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910690; c=relaxed/simple;
	bh=+Z5F/SjboyJrxyP1NEEYTr9bzrq7oY0jYwSaK43n8g4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t7yX5pMPtaE2tHpkfgyDu74JWH61bMJu2Uqf1PjSmVuyQoY4S+8nx9YPWZ8oTjLDr7rZTtPbHGPtyIsosiLUWjByvWDfMpzVjn2wYif0B6fG4qoPwTDnejKTJQU1XKl9a8LQMIIzgnykuMRmU/Rgekp6DNhYQPz6eQnwB5/ZGcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=BWpdWFZC; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428A25tL016412;
	Fri, 8 Mar 2024 15:11:02 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2105.outbound.protection.outlook.com [104.47.23.105])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wkwfjmyah-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 15:11:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcTfJNwaMwH0GDR0oF+CvVcDAA9jMhQSAnk0HcnmiwCaURyB1yRHO8L/5Aode/YfuDShxFFtIOicIy4PAXxzcaE8wcDWD8VoQHAyGx0e6B9tnU/vVHEQmjEl1H3Ke9orforZIfTztFjpaTvJmj/MZLn01xvTjuull4yQT2UQOrsHAM9A6XBsyPXRAmxu1J2qHHlWzvDOgTnVm+5Ky6+w+kQ44XHSRTH4f74ewogyiUketMy4fRtaPwdMhyAPi36XTJc0iwO7Fdf3CaYyDEuIoUWu/7pNLRzFHH6n0P9ExOO0NGNe1oU5MmqTf2WzRWtlRAAvMne+6jScBFi5ajlnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgEMkt8fd8fYHvKq5/rf0xlR2f/FIPqdnQJBSPMulfc=;
 b=FHvRq954DQ1T/iwjLHUscoIS1UwuJHbz0/fD3/exHr8szLf/2hc+y2hYybYZI8jmmOgB6IL5dNQwSMMT5BbC6uMxvCQWBvB8E/gnG+4gxLKattvxCbO3cLPgUyZoL2JE11VHrtY+kYcJNFnEIgUvDBSWSsBOwRm4CzsQojAFN27p+d5CxC0PaLE5QQM6umQ+U9mfzE4ygQ8LCk1x5TDZbC5n+MBdzuJ0WQnofvujqc13dORoJ/zb2sgxQ2ad3V1yDICbiT3GLz8WAVKECem8ayZdukku10QJEe+BdX2KpZS+o6pUrO3t5PEkg8ZVnc4uQK+zCdSOFV7kO2YF9NWUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgEMkt8fd8fYHvKq5/rf0xlR2f/FIPqdnQJBSPMulfc=;
 b=BWpdWFZCAQznlnyizR7p61g3ZCK88ZXn3hOubl0pleQj9sMS/OZ04nrHVLfdpziiI/G4EtfGD3Uvph7HBaLSjmTivpj9UweN4ICGE9g+OkNtSWX+h8k0AKCnE9Buwj+D4+FybI01jgBzvlRBk7yDc1sK54wFmFlu/3gKw/v5YHDRQbLUY7eGo5AK3G5Lt+gvLqPOGMqXAskHqCLQXPLvnuZ3uhZbQl+xQsRtaDdXAvhIW82PdMg9SX6cL1PHELCYk3na1TYzv9GJF1XQ6Vy57TAEKdNA5/nDR1ViKpPQug/OzE5VC+IXBMcZ6gTe6FkHv/Qi7OPjaOTOI7bQx/fJBQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TY3P286MB2564.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 15:10:43 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%5]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 15:10:43 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 4/4] iio: imu: inv_mpu6050: add WoM suspend wakeup with low-power mode
Date: Fri,  8 Mar 2024 15:10:23 +0000
Message-Id: <20240308151023.379705-5-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240308151023.379705-1-inv.git-commit@tdk.com>
References: <20240308151023.379705-1-inv.git-commit@tdk.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::6) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TY3P286MB2564:EE_
X-MS-Office365-Filtering-Correlation-Id: c527ef31-4222-42c4-22c7-08dc3f81ecc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FjQfz2VdvcQj9P6TSzdQFDFl4evfNFclmG59238zgfpXySmaxKV3uB10eAIkx99r9uBsMTBjrVnrjGk1h6QhjG0TLoApWysfs5ndH8+QW/Yc7uSDOvO+Vhh+G9sHX783tUwTN1j0V0EemGFCpAgrwtjKd0mkrEgyHo1skQZE+PeNgJArpgFs1kslwNaLuzw4EW3yJ20FUnPLW7DD5GEbO6n4xPT3D6e2o1EOUfbifycjoy7RV82hDkHD/tBAQKE2UeZxgVsLRHALmMsa+X0+co8v1wJw9r2psOc69SnYcTbHLWq7FMvL/FAhdYUCc4Trt8uI2LOl1/hDxrrqdE1ZmjDW2Rtk6Mk6bjONfcdHwUqBMbXHFpRLVYxAucErmgVLmtYcsXh+Cqt8pl/NiPk0VQ6qO0ygJFUU4Z5wlJCAbJkjVHQvlscl6+EAR7L+0LYe+XP11KSuuGX3NYHNatLLzgQ5GsZo2en1l4zDP989WBt25vhTSN9sa2qFzhGL35H0P7o8BURh2uWyBY9GX0OK5NdcwXAJsKMSJSpCjgFgws0eckGsJKN5gcGQney3BxnmGVr1su53wYTYteh1uNeEiDTCyEnTsHlDEiu6L97RvmIZ/eZQ/QkfD9SpVhhXCHvdkmjsoe5om4U3pbc3n2z/yBX6Ll4RX6SGkf4zBwzV00whPXA9+5lndqbL7H/WHS5OUiQGORiDInXVSGfAATTEkGeF94LRLukpz/yNyQNLhliM3gebXahKivYGYA0Nq4m4
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?67zLWmXx2V0GEEd1HbsS6RuGqh+74qg7kovAHBrVdFq1yeic3OqazulL1UkK?=
 =?us-ascii?Q?PtHZevLuS/oEXFm4zpG7u3errhckTa4Pc23xX+lVEXnHZI/dzlZP6PNfGFZU?=
 =?us-ascii?Q?6BY+a+SmCcqKiZxlsWSxq88OhlaxIEhxEpcJs0cD9MhT+fjnN08ot9U/e1u+?=
 =?us-ascii?Q?XfaZAosMpGffRJnslsAXi9qEtBeAPi47+R4OeGjRqGE3cF+xX21tQhYxrGU4?=
 =?us-ascii?Q?07OCKhaKkFJ9aUjWXt4uRqySfDyiEltVjK4eColTVEAVGPLASpCLY+rQRrP3?=
 =?us-ascii?Q?5BLurNngo6GQ8iR27NNfILkP3N5mIOxdX5sFM2XB4QnIY8XLLICL1ARjuuP+?=
 =?us-ascii?Q?3By7CGNyLWFE9YrNWjKhsFGt3oEeIVf3JNH2we098yM5+wR8a6AdWqVuVbhW?=
 =?us-ascii?Q?UZqTfolpoxHCQ2g+wT15YFMYsT4Q5DvwfRtY6Z5ktdW3BgqdYyuN+8uHPSmj?=
 =?us-ascii?Q?zM2NSb0tMBNW17kTbqUwlhNZi9Bpi7x1Kidl8bDWvzhtQLbB6UA7odL6logE?=
 =?us-ascii?Q?rCsrsYg9V5AmCaZAGMje9p8Av7CMgvURND3JRMFYbQ/VjC7UrwLpuj4B6KRt?=
 =?us-ascii?Q?1TjmmI369CUAeMg/l2/xoUsBeLcdvBKx4KrVs1H/9xmP5EzeOQVe0aj1ZuS4?=
 =?us-ascii?Q?htKx5931aGVyVuZ4Y7WEZDGBAmYXTsxQjsQPc7mp3Jil4R3KQrhcmh7WcVJ+?=
 =?us-ascii?Q?E6HQrLiNVvgOmTHF8licrsVKzhxrBaKKM80hgfK/779850GGimU5VLB8f/tM?=
 =?us-ascii?Q?P+m9RQvn2cvNI7sLjvRl8XaRY5+mkErfKEglw9OsTIzDbvn7AYNB1VRLtQ6c?=
 =?us-ascii?Q?Tgkg5X/kPQ8aY39kO5uo2pSIhQVak4BwAWW5uJiCPqZha2ykkZJau4utG0vZ?=
 =?us-ascii?Q?TNOS7lqZXjUAvmP8qaNa6XzTZ9L93xSu2DZz9QzOpMKzYZjx1unIcwPvT2H1?=
 =?us-ascii?Q?IP5pYOnvk6WqPmZtYoN1aVNnW1750SHiZ4GhAcgQ741q5mIc0c8OSCxc6RJH?=
 =?us-ascii?Q?YNG+QZKuxqUbS12VcViVoOTMT4vYHJ/QnlQFHLeSDwYe0IbkM8b5x2dpEb97?=
 =?us-ascii?Q?HW+XhgHE2MSP/RpaVI1UpZHoYJaMNrr5bTJtXnopmY1v4cGA7KYJpUGmcU70?=
 =?us-ascii?Q?0wRdU1hrD+QRcWcnb0aVbSnIeHbggPk5ChEOhff6S4qyk/J/bYgVD99hNqrf?=
 =?us-ascii?Q?cH+sxGt95L0fSs7Plq2tHgio4hdRci3P2bqSL2NYf2pUZwmxV3exptgZ5wZm?=
 =?us-ascii?Q?/Nz5PhukPiZS7vmvvw6B/SDzk5g6IIcisIfl1v/2DQvmmv+eFbu2j0SAUdFB?=
 =?us-ascii?Q?r6VytQ1uRqp/dpmg0PSo5uLuqtrHgA5Z7XpjiCCAAo9zW5ganwRL+XlbHIQ1?=
 =?us-ascii?Q?dGAHyIiproNg6YJBomXsn9GxyX5q1ndZIMCxw9CMmZ3S4LUdJ3xHJ3Jl+NYM?=
 =?us-ascii?Q?m4ZNvBI0knjiaa0qle6RZ1NRfn5IPVG2gBVaRPABhqrtLhg+IYX6UA0xu95F?=
 =?us-ascii?Q?5hrJiPt1pbhhs61sLU0OnMgiaAenn7gHBcbKN7v5NZs6eWjuaI89EA+ON/Gj?=
 =?us-ascii?Q?Np516FVVGAnWuUK8Q8Gkkf/RiPWJogom8eEItw3v?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c527ef31-4222-42c4-22c7-08dc3f81ecc0
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:10:43.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sz2J0NGvYlMJw8uVZWTGkXF5GKz3i4GFupX9X5uAb79E8HyUd3iOgvc74pgnqufM4XltdHC9a70m5UY551LAgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2564
X-Proofpoint-GUID: vb4MS-_oSLgxh46uZJcDhmbifuszo92I
X-Proofpoint-ORIG-GUID: vb4MS-_oSLgxh46uZJcDhmbifuszo92I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403080122

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add wakeup from suspend for WoM when enabled and put accel in
low-power mode when suspended. Requires rewriting pwr_mgmt_1
register handling and factorize out accel LPF settings.
Use a low-power rate similar to the chip sampling rate but always
lower for a best match of the sampling rate while saving power
and adjust threshold to follow the required roc value.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 175 +++++++++++++++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  14 ++
 2 files changed, 156 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index ddc905bb74d6..17844390b786 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -288,7 +288,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
 };
 
 static int inv_mpu6050_pwr_mgmt_1_write(struct inv_mpu6050_state *st, bool sleep,
-					int clock, int temp_dis)
+					bool cycle, int clock, int temp_dis)
 {
 	u8 val;
 
@@ -302,6 +302,8 @@ static int inv_mpu6050_pwr_mgmt_1_write(struct inv_mpu6050_state *st, bool sleep
 		val |= INV_MPU6050_BIT_TEMP_DIS;
 	if (sleep)
 		val |= INV_MPU6050_BIT_SLEEP;
+	if (cycle)
+		val |= INV_MPU6050_BIT_CYCLE;
 
 	dev_dbg(regmap_get_device(st->map), "pwr_mgmt_1: 0x%x\n", val);
 	return regmap_write(st->map, st->reg->pwr_mgmt_1, val);
@@ -317,7 +319,7 @@ static int inv_mpu6050_clock_switch(struct inv_mpu6050_state *st,
 	case INV_MPU6000:
 	case INV_MPU9150:
 		/* old chips: switch clock manually */
-		ret = inv_mpu6050_pwr_mgmt_1_write(st, false, clock, -1);
+		ret = inv_mpu6050_pwr_mgmt_1_write(st, false, false, clock, -1);
 		if (ret)
 			return ret;
 		st->chip_config.clk = clock;
@@ -359,7 +361,7 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
 
 	/* turn on/off temperature sensor */
 	if (mask & INV_MPU6050_SENSOR_TEMP) {
-		ret = inv_mpu6050_pwr_mgmt_1_write(st, false, -1, !en);
+		ret = inv_mpu6050_pwr_mgmt_1_write(st, false, false, -1, !en);
 		if (ret)
 			return ret;
 		st->chip_config.temp_en = en;
@@ -466,7 +468,7 @@ static int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st,
 {
 	int result;
 
-	result = inv_mpu6050_pwr_mgmt_1_write(st, !power_on, -1, -1);
+	result = inv_mpu6050_pwr_mgmt_1_write(st, !power_on, false, -1, -1);
 	if (result)
 		return result;
 
@@ -496,22 +498,9 @@ static int inv_mpu6050_set_gyro_fsr(struct inv_mpu6050_state *st,
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
@@ -530,6 +519,25 @@ static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
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
@@ -1007,6 +1015,84 @@ static int inv_mpu6050_set_wom_threshold(struct inv_mpu6050_state *st, u64 value
 	return result;
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
@@ -1847,6 +1933,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 			irq_type);
 		return -EINVAL;
 	}
+	device_set_wakeup_capable(dev, true);
 
 	st->vdd_supply = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(st->vdd_supply))
@@ -2012,16 +2099,27 @@ static int inv_mpu_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	bool wakeup;
 	int result;
 
 	mutex_lock(&st->lock);
-	result = inv_mpu_core_enable_regulator_vddio(st);
-	if (result)
-		goto out_unlock;
 
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
+			goto out_unlock;
+	} else {
+		result = inv_mpu_core_enable_regulator_vddio(st);
+		if (result)
+			goto out_unlock;
+		result = inv_mpu6050_set_power_itg(st, true);
+		if (result)
+			goto out_unlock;
+	}
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
@@ -2031,7 +2129,7 @@ static int inv_mpu_resume(struct device *dev)
 	if (result)
 		goto out_unlock;
 
-	if (st->chip_config.wom_en) {
+	if (st->chip_config.wom_en && !wakeup) {
 		result = inv_mpu6050_set_wom_int(st, true);
 		if (result)
 			goto out_unlock;
@@ -2050,6 +2148,7 @@ static int inv_mpu_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	bool wakeup;
 	int result;
 
 	mutex_lock(&st->lock);
@@ -2066,13 +2165,15 @@ static int inv_mpu_suspend(struct device *dev)
 			goto out_unlock;
 	}
 
-	if (st->chip_config.wom_en) {
+	wakeup = device_may_wakeup(dev) && st->chip_config.wom_en;
+
+	if (st->chip_config.wom_en && !wakeup) {
 		result = inv_mpu6050_set_wom_int(st, false);
 		if (result)
 			goto out_unlock;
 	}
 
-	if (st->chip_config.accl_en)
+	if (st->chip_config.accl_en && !wakeup)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_ACCL;
 	if (st->chip_config.gyro_en)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_GYRO;
@@ -2080,17 +2181,25 @@ static int inv_mpu_suspend(struct device *dev)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_TEMP;
 	if (st->chip_config.magn_en)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_MAGN;
-	if (st->chip_config.wom_en)
+	if (st->chip_config.wom_en && !wakeup)
 		st->suspended_sensors |= INV_MPU6050_SENSOR_WOM;
 	result = inv_mpu6050_switch_engine(st, false, st->suspended_sensors);
 	if (result)
 		goto out_unlock;
 
-	result = inv_mpu6050_set_power_itg(st, false);
-	if (result)
-		goto out_unlock;
+	if (wakeup) {
+		result = inv_mpu6050_set_wom_lp(st, true);
+		if (result)
+			goto out_unlock;
+		enable_irq_wake(st->irq);
+		disable_irq(st->irq);
+	} else {
+		result = inv_mpu6050_set_power_itg(st, false);
+		if (result)
+			goto out_unlock;
+		inv_mpu_core_disable_regulator_vddio(st);
+	}
 
-	inv_mpu_core_disable_regulator_vddio(st);
 out_unlock:
 	mutex_unlock(&st->lock);
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index e97a63ad2c31..6ba9d42b2537 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -304,6 +304,7 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_REG_PWR_MGMT_1          0x6B
 #define INV_MPU6050_BIT_H_RESET             0x80
 #define INV_MPU6050_BIT_SLEEP               0x40
+#define INV_MPU6050_BIT_CYCLE               0x20
 #define INV_MPU6050_BIT_TEMP_DIS            0x08
 #define INV_MPU6050_BIT_CLK_MASK            0x7
 
@@ -335,6 +336,7 @@ struct inv_mpu6050_state {
 /* mpu6500 registers */
 #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
 #define INV_ICM20689_BITS_FIFO_SIZE_MAX     0xC0
+#define INV_MPU6500_REG_LP_ODR              0x1E
 #define INV_MPU6500_REG_WOM_THRESHOLD       0x1F
 #define INV_MPU6500_REG_ACCEL_INTEL_CTRL    0x69
 #define INV_MPU6500_BIT_ACCEL_INTEL_EN      BIT(7)
@@ -451,6 +453,18 @@ enum inv_mpu6050_filter_e {
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


