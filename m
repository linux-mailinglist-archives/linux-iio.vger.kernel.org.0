Return-Path: <linux-iio+bounces-3383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D945F876711
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 16:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D901F2398E
	for <lists+linux-iio@lfdr.de>; Fri,  8 Mar 2024 15:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2848B1DDEA;
	Fri,  8 Mar 2024 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="fuG8qp/m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE0568A
	for <linux-iio@vger.kernel.org>; Fri,  8 Mar 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910689; cv=fail; b=B6ieIA9GjvQRK8SaiDK/MxDaWKJ3RkTWoSXr/KslWccaAi9/DArGaCHqOIVytsdJn6qEsRJszreBKc47eJF6BcvGlLy2zqcMaIYXAwL6Htie+nhjnVwg1IfXphTJjy+FjL3d5NHYqCbutCFU1Z1F7XKytTlce6HhCYs/gAJhMtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910689; c=relaxed/simple;
	bh=nxluuw1XuA2Tq2N3+mXlfkNGKQPDhtxnpvWw+cRM+3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tdap7kEAEuQvY/PQ80EYF0nGsbvG5Dil2F6whb7A6qfmB+dNULy7lh2Cvvt9YoCJHT1RObZmH0cmX6r9lLXOtsLxiSEeYD694vtNz9rivIGY69UbDGNkebq4S11/eruVWiLLjoBP6MlCESGrRBiA7i+V+hS7bkPOjF/Xz/q3kJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=fuG8qp/m; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428A25tK016412;
	Fri, 8 Mar 2024 15:11:01 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2105.outbound.protection.outlook.com [104.47.23.105])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3wkwfjmyah-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 15:11:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0BO76ed0mokNK39y9+F3eEbnDMSboQxEJ0Lm+4nTJkELE+otJPYon6tiqMFiqSdF9ixaP/ZqxmSogq4hhX6xEpgKtiDeggzKC91N7qYyCrhHud1Nmui/ZIlM+8u/aj+//8jhf2hYiYc5v1MP/lmc8q9XQBnkze68ftzH0HiYS7yipzpkGKUMfrLCwyoj3M+c/PkmYYriDudzQKKsaQDBNTmcTr0TGg0jsMpYBvDzBBpVrWTwMwZC8k+rukMxFVMHZb9V5kl3RTOLFzyM0ezfCPwAwyI2nsLIJ9i+YQ0UiNh2MirQwO3MgCHW1nyByd7/jauwTMkLX0azdlYLJNFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItSEIXqKBH5LvC1064SnsO/FTPVBjZUYgm/Fx44o018=;
 b=eEfIJWsO0ZmLJP/Y90HczMTrgtK++jwC9bGb99WkAeZ7npau1JV/ZZwp02KxsBoHfcGRt8trkP1PPAX26H5NlBA1FVS7nSkH7L78vN6SGNqXTsfQjB7F9RpXslStGV+5M7mfs69FrkDriXx+8u/uwVj7n59a1SjLOufSU81HpJetYdRiedk9xtYvYmK4C8gibU1SNO/wLsQ714ihsDR6BeEakNkfMN6sDa0eqD3ABTOsALPhBXaVxmZRazH8dTnJGtdHkzYv4QcpkiMcNswouY2a3CQvmwbVgSzFDoSmjGU4n33X8Li9MFIfFgQQtB2aMe4IJ1lv+EPePtt58SL7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItSEIXqKBH5LvC1064SnsO/FTPVBjZUYgm/Fx44o018=;
 b=fuG8qp/mgbZGDWfJI6xBG25hLfPQNbVYkbqf19WjzlxENPBbs6bS4HGOD3zbldT5z95ogxKHVt20My4WAyQXiFJeZGDHXdp/ozO6/VawtuoYdMNQheAbX5ubKIPtT9cu3oG5NKPmQD4zAWIKHYiBNaxbA1YewASax/+5VnY1KNLjQ9pnk68kyHVA4iT5IrC7YbSD8BlYVlfVNayK2LKtPeen7+d3t/yg5iOSeiA0lZww2XqxDcy24TGrnzpeZ/M8WAlV6jOPJAolrir6Jct6HG7UBPL8RN4myKm67ObpkQ13P2Hmqiu+wroEJyngXZXi2QWiFdCQACI9s2Ef5WImQw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TY3P286MB2564.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 15:10:41 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9119:3ad4:c68d:9da2%5]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 15:10:41 +0000
From: inv.git-commit@tdk.com
To: jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 3/4] iio: imu: inv_mpu6050: add new interrupt handler for WoM events
Date: Fri,  8 Mar 2024 15:10:22 +0000
Message-Id: <20240308151023.379705-4-inv.git-commit@tdk.com>
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
X-MS-Office365-Filtering-Correlation-Id: d39df35b-635a-42e9-0273-08dc3f81eb9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oazcSchiMKfoRnWgoDJDvgsiEAXBLj+orn8U77+56X2l+dY10hw2ieckjBKsw42Sn3ZYSztN4cPEhMFi0jUfmrY6IgCsZTdGSdKBLCBTnXNpcL1jiO3UYy65aaMf9H/zUQOCUNMXfN32FU9r5R1k/oYdbPdWfoqh5EtpVP2ELjs3gjGd8EKTw1iLHpjCu07BlYEDidUxyo/ptgLOf9Y53sT+/8Tcu2U+euxSopVtfubJT3MdZUO2d13arhten9ktlelJblU51tRJRFKLhDKb9WONpUPboTCF2DDWW321Wn+yoVIgd+NRwKpNhQoBPc/U9DUdFz+ziUCvL6PNOOgaTJQGyxOjK1YljUDIJ4jB4fRE00lqK8oIhGJNUAnvCZLbY8WSeOS4NLMl7n+TNH23675NOCACzel+psasUZA9lZpbAaen3BjifBZpOGwNpOcK4ySlpuwlxT8VKdTBvtvJ1+caieAciOa+/fhWsKxW0MBRbw8J/Bih5jIeMkPoUMQMcnM9H8+JUopNU0+jDfmKhKUE69pmsfK8sHIOc/H8pVVRXnpq7jkhMjI2ZZj6NE36snrmvZ1QClkTSkpbXX4xlrbwSoHNAWEmFCXbPU+IDkTULGmNN4k7wiYeW0VPxhvuS/Y1Tu5SJTxarVOnYCXfvpBnmT3l8cU0g8rB8tgEYuksMJquwgGJUoQDTE18R857Y/6IQ2QAn+8fTRNlpBzcgGXKjR4K9VEQ6/VwYpcGYVYPc2o1bGKJo9+W9D2pl3OR
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(38350700005)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0GaPY02Dx1enCy3ryXubi31FUBaIEFjXm8RhJT5ihmBuEeJ1icGuJpqDS+mN?=
 =?us-ascii?Q?nDTLBjMYGnJNewddX/GGb9PYnZPjttYbKj0BLX0PGadJ7lCDH1PvVVtBQDtM?=
 =?us-ascii?Q?p/HTn71WugVXubT7WBpDzmSdTTUxDTMnGNrFKLMlcIhkwN/kgdO2lRj185N3?=
 =?us-ascii?Q?tdhw5kAHYQn1PfcFm+LYU2G44ycX2k0cC/lI1ijY+ChwN02fA32sqQ1snk0R?=
 =?us-ascii?Q?P916ZW2fEqoOZkWrRUgK8ri/MwhBFQIbng03k1Do8It+6nFOITzsubYDaCKw?=
 =?us-ascii?Q?L6fNiHbkckfGzZSfVzBcggb2BXWIDDZs0FSBZRVFs0E4RI4q+ZUZ/iuVoP4s?=
 =?us-ascii?Q?b81ErvYoNQE4R9+aAvo4PpaWT3jYjucOgIKol1fbm6F3IJYMh+8IfpmsXdA0?=
 =?us-ascii?Q?G0cLDbrbt3NNCmWGzYIa16Z2/L36bHCANXRIMRB9tZfo1u8WpjUF7JBRnCTp?=
 =?us-ascii?Q?aUYhqL9kYhu1gH4k/Ioyi6+kG7/FHErWYg6jB6VkpERuhAToiAeHnmrj7T7i?=
 =?us-ascii?Q?RyfsIcmaqzqOyw6zYqmEppL751SpV90YERhTMRuCX+sJk77ayZ+cJ5Ss3wbG?=
 =?us-ascii?Q?D7kVzFXEWRLNOEyfFLW/A5UlO8e9xIineExYkfeP44j0F7AkTGVzcSt2T950?=
 =?us-ascii?Q?PKThGAkL8XO7zw5I0vJEtMgGCyeDe1CewXnT15fdseU2m90+Alct4gwNRxmm?=
 =?us-ascii?Q?k8N7RPfCm9P4J+TdkRqRNjAinJ06DiSlznkqbGiZ5mv55pie9m6JUtbKXxJy?=
 =?us-ascii?Q?DLtLn5sNVfegOaZQIQJfTOP06R+zPSZvtZ5cFsrGrF32La7q+YTRlPzalglr?=
 =?us-ascii?Q?8n6QMKMuHVOyTECigo6qnooTBs8qASDYL43Ym6AToRKX13Adb28lZWfGTkwX?=
 =?us-ascii?Q?QCkMRyzI3ZRgMraPLmcUrrcQFu6+TqUzHSaqkxlZ5HAgtzhIOqXCesP+iShQ?=
 =?us-ascii?Q?MuVmJo8rcgNQVLR05uNz6Q6dKiYfu3OLTDNlCcNBjSmiKU27iCHk48eZRw9Y?=
 =?us-ascii?Q?5+Atww4oAW2dtsYIsDLAI2WONiRBO+RTbUHPelmMUYej+lJI+xJNnpFTGVHZ?=
 =?us-ascii?Q?GJ+xHdOAG8GVPUb7YErVeF7tq5pOUUs4HBLk2AZ5V+Qj3AGj0vdDTefu2wTc?=
 =?us-ascii?Q?/Y2Tf81bHZkXvLCwkUviQF8Iv/yqyU1o8iiUb1LEqnfUrXGTqXUa24jrmISj?=
 =?us-ascii?Q?UduGKfbiJfFnLD5Yrwd/DYEah0VgdImg+vimxuBnx08knkXsbLuph2PVxlE7?=
 =?us-ascii?Q?Lh6lO4nZ1d5cSF67rTz7mCRQTSMLZptpuLr+/RZeOYHzrxc9+JR78xdLKK8u?=
 =?us-ascii?Q?5DUGXAkHzEnBZLYZy3nzMmXORCG2eiOpaN0VQMbi/+eASdrj0HchDXp0ahFm?=
 =?us-ascii?Q?hNMTAFVZs6YF9Xad0Brk869qQ4b6BKrVmJHfjxlmQ4i1WNjCSZhz2xaHRZHG?=
 =?us-ascii?Q?SN5h8SCGuPas1wGj/9TSmli6P8lufM5QG3G/Z6begEyyxlvgzKwwf8BaC11Q?=
 =?us-ascii?Q?B2OjSee+O4Rtu1SpRHlX/oDVKgmDNNY0ICGxVNWHmUdtIv23nQc8i+NypG21?=
 =?us-ascii?Q?QRnoKVq3PBDaxzWp68O7nzM9HkdTBlC8vtYvPR+z?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39df35b-635a-42e9-0273-08dc3f81eb9f
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:10:41.7644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39eODOqzbqnDRdSqUPbR/L9VjGm+g21ifJo070S1yMvXKiJUBUzwExXlWiiwFV4XUkMnKl4q28HqmbHnUoWnfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2564
X-Proofpoint-GUID: yC9NNv4CopOat13Yqu4h3JAIKd--upK0
X-Proofpoint-ORIG-GUID: yC9NNv4CopOat13Yqu4h3JAIKd--upK0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403080122

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add new interrupt handler for generating WoM event from int status
register bits. Launch from interrupt the trigger poll function for
data buffer.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 11 ---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 72 +++++++++++++++++--
 3 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 19adccf388cf..e97a63ad2c31 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -184,6 +184,7 @@ struct inv_mpu6050_hw {
  *  @magn_orient:       magnetometer sensor chip orientation if available.
  *  @suspended_sensors:	sensors mask of sensors turned off for suspend
  *  @data:		read buffer used for bulk reads.
+ *  @it_timestamp:	interrupt timestamp.
  */
 struct inv_mpu6050_state {
 	struct mutex lock;
@@ -209,6 +210,7 @@ struct inv_mpu6050_state {
 	unsigned int suspended_sensors;
 	bool level_shifter;
 	u8 *data;
+	s64 it_timestamp;
 };
 
 /*register and associated bit definition*/
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 13da6f523ca2..e282378ee2ca 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -51,21 +51,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u32 fifo_period;
 	s64 timestamp;
 	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
-	int int_status;
 	size_t i, nb;
 
 	mutex_lock(&st->lock);
 
-	/* ack interrupt and check status */
-	result = regmap_read(st->map, st->reg->int_status, &int_status);
-	if (result) {
-		dev_err(regmap_get_device(st->map),
-			"failed to ack interrupt\n");
-		goto flush_fifo;
-	}
-	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))
-		goto end_session;
-
 	if (!(st->chip_config.accl_fifo_enable |
 		st->chip_config.gyro_fifo_enable |
 		st->chip_config.magn_fifo_enable))
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index ec2398a87f45..585e5112f7a5 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -6,6 +6,7 @@
 #include <linux/pm_runtime.h>
 
 #include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/events.h>
 
 #include "inv_mpu_iio.h"
 
@@ -223,6 +224,68 @@ static const struct iio_trigger_ops inv_mpu_trigger_ops = {
 	.set_trigger_state = &inv_mpu_data_rdy_trigger_set_state,
 };
 
+static irqreturn_t inv_mpu6050_interrupt_timestamp(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+
+	st->it_timestamp = iio_get_time_ns(indio_dev);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	unsigned int int_status, wom_bits;
+	int result;
+
+	switch (st->chip_type) {
+	case INV_MPU6050:
+	case INV_MPU6500:
+	case INV_MPU6515:
+	case INV_MPU6880:
+	case INV_MPU6000:
+	case INV_MPU9150:
+	case INV_MPU9250:
+	case INV_MPU9255:
+		wom_bits = INV_MPU6500_BIT_WOM_INT;
+		break;
+	default:
+		wom_bits = INV_ICM20608_BIT_WOM_INT;
+		break;
+	}
+
+	mutex_lock(&st->lock);
+
+	/* ack interrupt and check status */
+	result = regmap_read(st->map, st->reg->int_status, &int_status);
+	if (result) {
+		dev_err(regmap_get_device(st->map), "failed to ack interrupt\n");
+		int_status = 0;
+		goto exit_unlock;
+	}
+
+	/* handle WoM event */
+	if (st->chip_config.wom_en && (int_status & wom_bits))
+		iio_push_event(indio_dev,
+				IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
+						   IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING),
+				st->it_timestamp);
+
+exit_unlock:
+	mutex_unlock(&st->lock);
+
+	/* handle raw data interrupt */
+	if (int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT) {
+		indio_dev->pollfunc->timestamp = st->it_timestamp;
+		iio_trigger_poll_nested(st->trig);
+	}
+
+	return IRQ_HANDLED;
+}
+
 int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
 {
 	int ret;
@@ -235,11 +298,10 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
 	if (!st->trig)
 		return -ENOMEM;
 
-	ret = devm_request_irq(&indio_dev->dev, st->irq,
-			       &iio_trigger_generic_data_rdy_poll,
-			       irq_type,
-			       "inv_mpu",
-			       st->trig);
+	ret = devm_request_threaded_irq(&indio_dev->dev, st->irq,
+					&inv_mpu6050_interrupt_timestamp,
+					&inv_mpu6050_interrupt_handle,
+					irq_type, "inv_mpu", indio_dev);
 	if (ret)
 		return ret;
 
-- 
2.34.1


