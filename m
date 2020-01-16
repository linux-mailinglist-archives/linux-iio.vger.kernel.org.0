Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E0D13EC87
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2020 18:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394087AbgAPR5Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jan 2020 12:57:16 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:2156 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393965AbgAPR5P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jan 2020 12:57:15 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GHtqVD029522;
        Thu, 16 Jan 2020 09:57:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=LxiKo9LWD5YGfBf//GRpsGW6aM+JmsutHmoMzCFhevY=;
 b=plyCT7dBM5k/n4gpuEpAGO0WtPcrtpZBKEdztRYmRZfvZ0yWGD71Ip0NkVHg+S+XY4qc
 cp//67HUIOWGmB9piVPbnYI2fUe2NNpbfhcYqn5oGslokO0IJBtY4WkHaR53YF4h7y3D
 yq+9r1b7ZfQelOTVMLGrkaIOxSeIeSpHydiw/F+EfK4VeLibeaGzCSKrqu9tnnusT7tQ
 9OTyPM2lG6VWeRTYc5YBce2uqACjzYFOzLOGRHRzOT8a/RrIW4lIvf8L9ZCNFVg764lR
 b+wZPdytIXE8+jnGJtG4CdKqeDFOagBQnCc21dR+B0iBpBlLXu7ipkYPLsTYk+sYK/xm eQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-00328301.pphosted.com with ESMTP id 2xggg2a8tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 09:57:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qs/Hk15IqcbrMNJ8AFMmzqzfRMhbRvXDXn8JQSIFuwkzp8SnWLbtnfBLQK/UBcIBLBKpT7BNL4I+jQ3XRHfID0k8PgWO6Xmp+mtqIU5Yq8ug6f5ZeBvsP/r5R3nCM7YRo+GNub6t+OSQXpyN8LUB+DOPcXlrxjJMdDiCbaFlrR5gZsUXc99UaJKmabOz4P34q42/WfGUrhiWROK3L1xmT+WuMjYP/CnnV8ZInD019mcsPH5p7zoauvd2yBeZEelgmI/WqnBpA23+0efq2hzCv1q7ASUlwXn2skJjv0A/+oMzSt+w+QuJcbpSQjb+G5SMvyvUwoSKcp6Xq8iuIMSa4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxiKo9LWD5YGfBf//GRpsGW6aM+JmsutHmoMzCFhevY=;
 b=Itumf9iaPrXe/Q1w6UAcO5ulCkxGvWvL6wMMTIhxI6PmRcc1K/Ghwct4RLednXYSFm25f28FPJI4jiXH0IWpW5LjfDAG5haHOTQXXDUaGApy12ihCCsxpyjgCIm35Rl3unpmtIQn8PMc8GNtQwAl6PwH1MJ2TDeBScm3nqSXN4qBBWKhpiaQhzQOkDR2MSrWH+tgKrufhB2RYXg2BJ3WOOP2/aE3PrA3HMlhuZEqu4F9krIaue1fHiACv26653IzUrB+mepplezrXMX/vIvB/tBUfjK2JytNKqSHCnrKAxMQLrqRXRt9YycyEqR9G92kx1W+01eqHouy/bEjFn4Ziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxiKo9LWD5YGfBf//GRpsGW6aM+JmsutHmoMzCFhevY=;
 b=c5V0AAkBni+aUKSJ2hAorONdfi1TBLkSsGh1Xh9bt4bRHE4+1baUWiUonMjWpmwwGbWebI0T2Naqj5hry9aMw2g2+1xX/Yjjruj89EYqG9n4rpvLHOQ+S5/B0M6MkeMjE71sYv/eJf/6adsyI0P/zvALXl0nU4eV0iGjM4yjJSk=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3151.namprd12.prod.outlook.com (20.178.244.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 17:57:10 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa%6]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 17:57:09 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2] iio: imu: inv_mpu6050: add fifo temperature data support
Date:   Thu, 16 Jan 2020 18:56:45 +0100
Message-Id: <20200116175645.1543-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0267.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::15) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0267.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Thu, 16 Jan 2020 17:57:08 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 348a2410-f4c0-4120-0d1e-08d79aad8188
X-MS-TrafficTypeDiagnostic: MN2PR12MB3151:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB315184ECCCE2F16A29925107C4360@MN2PR12MB3151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02843AA9E0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(396003)(39850400004)(199004)(189003)(478600001)(107886003)(1076003)(66476007)(956004)(66556008)(66946007)(6486002)(30864003)(2616005)(2906002)(8676002)(81166006)(81156014)(86362001)(6666004)(8936002)(7696005)(52116002)(186003)(16526019)(6916009)(4326008)(5660300002)(36756003)(316002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3151;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VoGtVkNsw8nqdxcZ4fVO05+04I6FSVT6X1ZYYWIEmBPX1yYQNubfBT3jTN7c1KaGmMZ43qLDKpHPQaTVwOvNBssOJHfYD3Oh3jQBAWVISiM6Mb4QWICcmreUlIKiayrneOdNCvIu/ceNdcf9GBolh66dM1JHILxIXaI5tfBXVyD3EUKbtq+8Znq6XOwaDGV8FfqZTGbAA75Nrn5NPZ89+mYAz+ICaFst3GbLvh/Mgk+98+fWUcX/5XS3V3r0oLgKM+/LJaZnwR/HXtsWmLzjW5S2DP3hhpjOytODjK8+2ZcIMX3SD/pRgnoFvDakjuuzT/EXulpRYGIqT3FM26pZIsKP/8rhhuN5phEkA3ahzGEuf4ozrdqn+toMnATKKG4nSrJk+nVuSbfhnImT4b0GSOjPFgKIE5fdUYbEQLam7iEUVPNZudZQDEWuBGsU6HI
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348a2410-f4c0-4120-0d1e-08d79aad8188
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 17:57:09.7396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8GjuUYqx5u7hv5h0gyfjPoVHuELuT1s+qYPFcj9CgySIQlU0JY8upjcV2CJdzRAkZt+ZFiOMl0lUGeJDa9HFbvaQ7/eTMZivwCxcJdWb5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3151
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_05:2020-01-16,2020-01-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=1 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160144
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support of temperature data in fifo for all chips.
Enable unification of scan elements for icm20602.
Add macros for generating scan elements.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
Changelog:
- v2: delete temp duplication macro, not compliant with checkpatch
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 200 +++++++-----------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  22 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |   6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   3 +
 4 files changed, 90 insertions(+), 141 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 268240644adf..1eb3c263b528 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -104,6 +104,7 @@ static const struct inv_mpu6050_chip_config chip_config_6050 = {
 	.divider = INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MPU6050_INIT_FIFO_RATE),
 	.gyro_fifo_enable = false,
 	.accl_fifo_enable = false,
+	.temp_fifo_enable = false,
 	.magn_fifo_enable = false,
 	.accl_fs = INV_MPU6050_FS_02G,
 	.user_ctrl = 0,
@@ -856,19 +857,27 @@ static const struct iio_chan_spec_ext_info inv_ext_info[] = {
 		.ext_info = inv_ext_info,                             \
 	}
 
+#define INV_MPU6050_TEMP_CHAN(_index)				\
+	{							\
+		.type = IIO_TEMP,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	\
+				| BIT(IIO_CHAN_INFO_OFFSET)	\
+				| BIT(IIO_CHAN_INFO_SCALE),	\
+		.scan_index = _index,				\
+		.scan_type = {					\
+			.sign = 's',				\
+			.realbits = 16,				\
+			.storagebits = 16,			\
+			.shift = 0,				\
+			.endianness = IIO_BE,			\
+		},						\
+	}
+
 static const struct iio_chan_spec inv_mpu_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),
-	/*
-	 * Note that temperature should only be via polled reading only,
-	 * not the final scan elements output.
-	 */
-	{
-		.type = IIO_TEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
-				| BIT(IIO_CHAN_INFO_OFFSET)
-				| BIT(IIO_CHAN_INFO_SCALE),
-		.scan_index = -1,
-	},
+
+	INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),
+
 	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
 	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
 	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
@@ -878,22 +887,29 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
 	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
 };
 
+#define INV_MPU6050_SCAN_MASK_3AXIS_ACCEL	\
+	(BIT(INV_MPU6050_SCAN_ACCL_X)		\
+	| BIT(INV_MPU6050_SCAN_ACCL_Y)		\
+	| BIT(INV_MPU6050_SCAN_ACCL_Z))
+
+#define INV_MPU6050_SCAN_MASK_3AXIS_GYRO	\
+	(BIT(INV_MPU6050_SCAN_GYRO_X)		\
+	| BIT(INV_MPU6050_SCAN_GYRO_Y)		\
+	| BIT(INV_MPU6050_SCAN_GYRO_Z))
+
+#define INV_MPU6050_SCAN_MASK_TEMP		(BIT(INV_MPU6050_SCAN_TEMP))
+
 static const unsigned long inv_mpu_scan_masks[] = {
 	/* 3-axis accel */
-	BIT(INV_MPU6050_SCAN_ACCL_X)
-		| BIT(INV_MPU6050_SCAN_ACCL_Y)
-		| BIT(INV_MPU6050_SCAN_ACCL_Z),
+	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL,
+	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_TEMP,
 	/* 3-axis gyro */
-	BIT(INV_MPU6050_SCAN_GYRO_X)
-		| BIT(INV_MPU6050_SCAN_GYRO_Y)
-		| BIT(INV_MPU6050_SCAN_GYRO_Z),
+	INV_MPU6050_SCAN_MASK_3AXIS_GYRO,
+	INV_MPU6050_SCAN_MASK_3AXIS_GYRO | INV_MPU6050_SCAN_MASK_TEMP,
 	/* 6-axis accel + gyro */
-	BIT(INV_MPU6050_SCAN_ACCL_X)
-		| BIT(INV_MPU6050_SCAN_ACCL_Y)
-		| BIT(INV_MPU6050_SCAN_ACCL_Z)
-		| BIT(INV_MPU6050_SCAN_GYRO_X)
-		| BIT(INV_MPU6050_SCAN_GYRO_Y)
-		| BIT(INV_MPU6050_SCAN_GYRO_Z),
+	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3AXIS_GYRO,
+	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3AXIS_GYRO
+		| INV_MPU6050_SCAN_MASK_TEMP,
 	0,
 };
 
@@ -917,17 +933,9 @@ static const unsigned long inv_mpu_scan_masks[] = {
 
 static const struct iio_chan_spec inv_mpu9150_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU9X50_SCAN_TIMESTAMP),
-	/*
-	 * Note that temperature should only be via polled reading only,
-	 * not the final scan elements output.
-	 */
-	{
-		.type = IIO_TEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
-				| BIT(IIO_CHAN_INFO_OFFSET)
-				| BIT(IIO_CHAN_INFO_SCALE),
-		.scan_index = -1,
-	},
+
+	INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),
+
 	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
 	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
 	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
@@ -944,17 +952,9 @@ static const struct iio_chan_spec inv_mpu9150_channels[] = {
 
 static const struct iio_chan_spec inv_mpu9250_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU9X50_SCAN_TIMESTAMP),
-	/*
-	 * Note that temperature should only be via polled reading only,
-	 * not the final scan elements output.
-	 */
-	{
-		.type = IIO_TEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
-				| BIT(IIO_CHAN_INFO_OFFSET)
-				| BIT(IIO_CHAN_INFO_SCALE),
-		.scan_index = -1,
-	},
+
+	INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),
+
 	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
 	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
 	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
@@ -969,98 +969,50 @@ static const struct iio_chan_spec inv_mpu9250_channels[] = {
 	INV_MPU9X50_MAGN_CHAN(IIO_MOD_Z, 16, INV_MPU9X50_SCAN_MAGN_Z),
 };
 
+#define INV_MPU9X50_SCAN_MASK_3AXIS_MAGN	\
+	(BIT(INV_MPU9X50_SCAN_MAGN_X)		\
+	| BIT(INV_MPU9X50_SCAN_MAGN_Y)		\
+	| BIT(INV_MPU9X50_SCAN_MAGN_Z))
+
 static const unsigned long inv_mpu9x50_scan_masks[] = {
 	/* 3-axis accel */
-	BIT(INV_MPU6050_SCAN_ACCL_X)
-		| BIT(INV_MPU6050_SCAN_ACCL_Y)
-		| BIT(INV_MPU6050_SCAN_ACCL_Z),
+	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL,
+	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_TEMP,
 	/* 3-axis gyro */
-	BIT(INV_MPU6050_SCAN_GYRO_X)
-		| BIT(INV_MPU6050_SCAN_GYRO_Y)
-		| BIT(INV_MPU6050_SCAN_GYRO_Z),
+	INV_MPU6050_SCAN_MASK_3AXIS_GYRO,
+	INV_MPU6050_SCAN_MASK_3AXIS_GYRO | INV_MPU6050_SCAN_MASK_TEMP,
 	/* 3-axis magn */
-	BIT(INV_MPU9X50_SCAN_MAGN_X)
-		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
-		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	INV_MPU9X50_SCAN_MASK_3AXIS_MAGN,
+	INV_MPU9X50_SCAN_MASK_3AXIS_MAGN | INV_MPU6050_SCAN_MASK_TEMP,
 	/* 6-axis accel + gyro */
-	BIT(INV_MPU6050_SCAN_ACCL_X)
-		| BIT(INV_MPU6050_SCAN_ACCL_Y)
-		| BIT(INV_MPU6050_SCAN_ACCL_Z)
-		| BIT(INV_MPU6050_SCAN_GYRO_X)
-		| BIT(INV_MPU6050_SCAN_GYRO_Y)
-		| BIT(INV_MPU6050_SCAN_GYRO_Z),
+	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3AXIS_GYRO,
+	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3AXIS_GYRO
+		| INV_MPU6050_SCAN_MASK_TEMP,
 	/* 6-axis accel + magn */
-	BIT(INV_MPU6050_SCAN_ACCL_X)
-		| BIT(INV_MPU6050_SCAN_ACCL_Y)
-		| BIT(INV_MPU6050_SCAN_ACCL_Z)
-		| BIT(INV_MPU9X50_SCAN_MAGN_X)
-		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
-		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU9X50_SCAN_MASK_3AXIS_MAGN,
+	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU9X50_SCAN_MASK_3AXIS_MAGN
+		| INV_MPU6050_SCAN_MASK_TEMP,
 	/* 6-axis gyro + magn */
-	BIT(INV_MPU6050_SCAN_GYRO_X)
-		| BIT(INV_MPU6050_SCAN_GYRO_Y)
-		| BIT(INV_MPU6050_SCAN_GYRO_Z)
-		| BIT(INV_MPU9X50_SCAN_MAGN_X)
-		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
-		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	INV_MPU6050_SCAN_MASK_3AXIS_GYRO | INV_MPU9X50_SCAN_MASK_3AXIS_MAGN,
+	INV_MPU6050_SCAN_MASK_3AXIS_GYRO | INV_MPU9X50_SCAN_MASK_3AXIS_MAGN
+		| INV_MPU6050_SCAN_MASK_TEMP,
 	/* 9-axis accel + gyro + magn */
-	BIT(INV_MPU6050_SCAN_ACCL_X)
-		| BIT(INV_MPU6050_SCAN_ACCL_Y)
-		| BIT(INV_MPU6050_SCAN_ACCL_Z)
-		| BIT(INV_MPU6050_SCAN_GYRO_X)
-		| BIT(INV_MPU6050_SCAN_GYRO_Y)
-		| BIT(INV_MPU6050_SCAN_GYRO_Z)
-		| BIT(INV_MPU9X50_SCAN_MAGN_X)
-		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
-		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3AXIS_GYRO
+		| INV_MPU9X50_SCAN_MASK_3AXIS_MAGN,
+	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3AXIS_GYRO
+		| INV_MPU9X50_SCAN_MASK_3AXIS_MAGN
+		| INV_MPU6050_SCAN_MASK_TEMP,
 	0,
 };
 
-static const struct iio_chan_spec inv_icm20602_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIMESTAMP),
-	{
-		.type = IIO_TEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
-				| BIT(IIO_CHAN_INFO_OFFSET)
-				| BIT(IIO_CHAN_INFO_SCALE),
-		.scan_index = INV_ICM20602_SCAN_TEMP,
-		.scan_type = {
-				.sign = 's',
-				.realbits = 16,
-				.storagebits = 16,
-				.shift = 0,
-				.endianness = IIO_BE,
-			     },
-	},
-
-	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_ICM20602_SCAN_GYRO_X),
-	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_ICM20602_SCAN_GYRO_Y),
-	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_ICM20602_SCAN_GYRO_Z),
-
-	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_ICM20602_SCAN_ACCL_Y),
-	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_ICM20602_SCAN_ACCL_X),
-	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_ICM20602_SCAN_ACCL_Z),
-};
-
 static const unsigned long inv_icm20602_scan_masks[] = {
 	/* 3-axis accel + temp (mandatory) */
-	BIT(INV_ICM20602_SCAN_ACCL_X)
-		| BIT(INV_ICM20602_SCAN_ACCL_Y)
-		| BIT(INV_ICM20602_SCAN_ACCL_Z)
-		| BIT(INV_ICM20602_SCAN_TEMP),
+	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_TEMP,
 	/* 3-axis gyro + temp (mandatory) */
-	BIT(INV_ICM20602_SCAN_GYRO_X)
-		| BIT(INV_ICM20602_SCAN_GYRO_Y)
-		| BIT(INV_ICM20602_SCAN_GYRO_Z)
-		| BIT(INV_ICM20602_SCAN_TEMP),
+	INV_MPU6050_SCAN_MASK_3AXIS_GYRO | INV_MPU6050_SCAN_MASK_TEMP,
 	/* 6-axis accel + gyro + temp (mandatory) */
-	BIT(INV_ICM20602_SCAN_ACCL_X)
-		| BIT(INV_ICM20602_SCAN_ACCL_Y)
-		| BIT(INV_ICM20602_SCAN_ACCL_Z)
-		| BIT(INV_ICM20602_SCAN_GYRO_X)
-		| BIT(INV_ICM20602_SCAN_GYRO_Y)
-		| BIT(INV_ICM20602_SCAN_GYRO_Z)
-		| BIT(INV_ICM20602_SCAN_TEMP),
+	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3AXIS_GYRO
+		| INV_MPU6050_SCAN_MASK_TEMP,
 	0,
 };
 
@@ -1363,8 +1315,8 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		indio_dev->available_scan_masks = inv_mpu9x50_scan_masks;
 		break;
 	case INV_ICM20602:
-		indio_dev->channels = inv_icm20602_channels;
-		indio_dev->num_channels = ARRAY_SIZE(inv_icm20602_channels);
+		indio_dev->channels = inv_mpu_channels;
+		indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
 		indio_dev->available_scan_masks = inv_icm20602_scan_masks;
 		break;
 	default:
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index b096e010d4ee..6158fca7f70e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -86,6 +86,7 @@ enum inv_devices {
  *  @accl_fs:		accel full scale range.
  *  @accl_fifo_enable:	enable accel data output
  *  @gyro_fifo_enable:	enable gyro data output
+ *  @temp_fifo_enable:	enable temp data output
  *  @magn_fifo_enable:	enable magn data output
  *  @divider:		chip sample rate divider (sample rate divider - 1)
  */
@@ -95,6 +96,7 @@ struct inv_mpu6050_chip_config {
 	unsigned int accl_fs:2;
 	unsigned int accl_fifo_enable:1;
 	unsigned int gyro_fifo_enable:1;
+	unsigned int temp_fifo_enable:1;
 	unsigned int magn_fifo_enable:1;
 	u8 divider;
 	u8 user_ctrl;
@@ -184,6 +186,7 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_BIT_SLAVE_2             0x04
 #define INV_MPU6050_BIT_ACCEL_OUT           0x08
 #define INV_MPU6050_BITS_GYRO_OUT           0x70
+#define INV_MPU6050_BIT_TEMP_OUT            0x80
 
 #define INV_MPU6050_REG_I2C_MST_CTRL        0x24
 #define INV_MPU6050_BITS_I2C_MST_CLK_400KHZ 0x0D
@@ -268,8 +271,8 @@ struct inv_mpu6050_state {
 /* MPU9X50 9-axis magnetometer */
 #define INV_MPU9X50_BYTES_MAGN               7
 
-/* ICM20602 FIFO samples include temperature readings */
-#define INV_ICM20602_BYTES_PER_TEMP_SENSOR   2
+/* FIFO temperature sample size */
+#define INV_MPU6050_BYTES_PER_TEMP_SENSOR   2
 
 /* mpu6500 registers */
 #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
@@ -298,7 +301,7 @@ struct inv_mpu6050_state {
 #define INV_ICM20608_TEMP_OFFSET	     8170
 #define INV_ICM20608_TEMP_SCALE		     3059976
 
-/* 6 + 6 + 7 (for MPU9x50) = 19 round up to 24 and plus 8 */
+/* 6 + 6 + 2 + 7 (for MPU9x50) = 21 round up to 24 and plus 8 */
 #define INV_MPU6050_OUTPUT_DATA_SIZE         32
 
 #define INV_MPU6050_REG_INT_PIN_CFG	0x37
@@ -344,6 +347,7 @@ enum inv_mpu6050_scan {
 	INV_MPU6050_SCAN_ACCL_X,
 	INV_MPU6050_SCAN_ACCL_Y,
 	INV_MPU6050_SCAN_ACCL_Z,
+	INV_MPU6050_SCAN_TEMP,
 	INV_MPU6050_SCAN_GYRO_X,
 	INV_MPU6050_SCAN_GYRO_Y,
 	INV_MPU6050_SCAN_GYRO_Z,
@@ -355,18 +359,6 @@ enum inv_mpu6050_scan {
 	INV_MPU9X50_SCAN_TIMESTAMP,
 };
 
-/* scan element definition for ICM20602, which includes temperature */
-enum inv_icm20602_scan {
-	INV_ICM20602_SCAN_ACCL_X,
-	INV_ICM20602_SCAN_ACCL_Y,
-	INV_ICM20602_SCAN_ACCL_Z,
-	INV_ICM20602_SCAN_TEMP,
-	INV_ICM20602_SCAN_GYRO_X,
-	INV_ICM20602_SCAN_GYRO_Y,
-	INV_ICM20602_SCAN_GYRO_Z,
-	INV_ICM20602_SCAN_TIMESTAMP,
-};
-
 enum inv_mpu6050_filter_e {
 	INV_MPU6050_FILTER_256HZ_NOLPF2 = 0,
 	INV_MPU6050_FILTER_188HZ,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 10d16ec5104b..3755577dc449 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -142,6 +142,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 		d |= INV_MPU6050_BITS_GYRO_OUT;
 	if (st->chip_config.accl_fifo_enable)
 		d |= INV_MPU6050_BIT_ACCEL_OUT;
+	if (st->chip_config.temp_fifo_enable)
+		d |= INV_MPU6050_BIT_TEMP_OUT;
 	if (st->chip_config.magn_fifo_enable)
 		d |= INV_MPU6050_BIT_SLAVE_0;
 	result = regmap_write(st->map, st->reg->fifo_en, d);
@@ -200,8 +202,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	if (st->chip_config.gyro_fifo_enable)
 		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
 
-	if (st->chip_type == INV_ICM20602)
-		bytes_per_datum += INV_ICM20602_BYTES_PER_TEMP_SENSOR;
+	if (st->chip_config.temp_fifo_enable)
+		bytes_per_datum += INV_MPU6050_BYTES_PER_TEMP_SENSOR;
 
 	if (st->chip_config.magn_fifo_enable)
 		bytes_per_datum += INV_MPU9X50_BYTES_MAGN;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index a9c75bc62f18..5199fe790c30 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -24,6 +24,9 @@ static void inv_scan_query_mpu6050(struct iio_dev *indio_dev)
 			 indio_dev->active_scan_mask) ||
 		test_bit(INV_MPU6050_SCAN_ACCL_Z,
 			 indio_dev->active_scan_mask);
+
+	st->chip_config.temp_fifo_enable =
+		test_bit(INV_MPU6050_SCAN_TEMP, indio_dev->active_scan_mask);
 }
 
 static void inv_scan_query_mpu9x50(struct iio_dev *indio_dev)
-- 
2.17.1

