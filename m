Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2672100273
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2019 11:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfKRKe5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Nov 2019 05:34:57 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:41242 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726460AbfKRKe4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Nov 2019 05:34:56 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAIAYtqt012400;
        Mon, 18 Nov 2019 02:34:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=/w7XTs9jMb+iixzOSu1XRw2LRW0fA8JLVsB9iQiRJbE=;
 b=UtM+Ay0AR2Whgg2FGU97IDhximFNYuBwUG4uR9F1czmWnb18Vflgo/E145Ccft7XfW7s
 psxcN+9knzYrtjiAxgmd66mxM3wGrjrhnWh0ukx5PE3nK5ysDWiy5+xUchbnAcygnvjy
 Zeql52woikOSCGB9WDGhIvXWmZnv8MKDxUTVxvyQj9SbCOm2HTEGoJ4t3OoV5POROzbC
 Q6Nqv/FiPXgLO2pAWIU1MV9tLiPjDaiMXCt0aqyUTNPtyAB7Cq5rDHnrUzMYlUzFphlA
 fJN/wTBcVQKEVen8BLhYpwpM+7TYl8TrRe7Cxo0KokfDloPzNO77bC3Is+YJSf1U4Nts hA== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2056.outbound.protection.outlook.com [104.47.46.56])
        by mx0a-00328301.pphosted.com with ESMTP id 2wadft0qbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 02:34:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pp0enSZlPl9civFshu93gYVC24Ws9+U/UjaNKPZ8VAy0AtJVCVE+iQE8i1CTSGbsSaGariG5DCcVPP8XM/ij9RyGaJ81OuejnufQGucoNOlYkMw2s/OYlj8wqwISX7HfvCsugeHWmbQ9zrTGi9ZRIWZXK6f5LgXMGKxFVOcxC5YI9BGnNJom9fMubyyS4JVTB06xetiJqRb5tQ4wmBzrHLyvQ6gewOqvk+f7uK/HT9Dr/98DWnhVJ+5PkRrXzLGEjWG0Il3dsVo6yI/fkvD+EQ/Z+JfR6WTE23a0EH4frSF5GlGsRxJCq1rkoNDuT1rE3IESeLOvZK7w5oI3snhmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w7XTs9jMb+iixzOSu1XRw2LRW0fA8JLVsB9iQiRJbE=;
 b=TmN8DV18WLOQJdtvGK0MrlxG5HhOubRnS7yO+Iv932GZBqHkqHWi5cYKnJWDGUrwHBVDSRogxZXmEOWziYyd+WRbILP51v3BR6WKApT0QqRjJpzw53fkn/v2ZkbhTU0f0ze3XAM9ued5AwV2KDfzTslAnbuwH1QtsryFs7w8l3ObtxXcDkp02d9/Cb52ielopunXE1sNQnbjQ3MtevvLDnV+MZSvcnHu8PXqR5Q7p6AacQVWym1HVOtTF+5Q0PVeK52c9zqcNCBdSAhfPB7K2g6JmlT6Kpq0NRd5jiay4vFuYodXGHMFOx5Mu3WLPPoJUv7vHK0vw00M30p+gtLlnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w7XTs9jMb+iixzOSu1XRw2LRW0fA8JLVsB9iQiRJbE=;
 b=ASfqcgPF5UgVTg5jPG7Wz07FsDT+6pt9WdrzCv9en5rhT9mV7yG/DoYtWsDdqRvhlkoLgss+7cNo1CfpOYDqiqaBNqSizTPhc0jHvSVOyt6sai6Arv0n70PLW/oTaNqw7WchYkMjnTNdknftgOcwT7x9RqQL68RHsYjkd50kcSI=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3248.namprd12.prod.outlook.com (20.179.80.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Mon, 18 Nov 2019 10:34:48 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3%3]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 10:34:48 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data support
Date:   Mon, 18 Nov 2019 11:34:06 +0100
Message-Id: <20191118103406.9353-2-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118103406.9353-1-jmaneyrol@invensense.com>
References: <20191118103406.9353-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::15) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56c26d98-fa8a-4a1f-5c76-08d76c12ef88
X-MS-TrafficTypeDiagnostic: MN2PR12MB3248:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3248C00AEDD1AF493D65AE3AC44D0@MN2PR12MB3248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39850400004)(136003)(396003)(189003)(199004)(1076003)(2906002)(5660300002)(2361001)(4326008)(476003)(16586007)(107886003)(36756003)(50466002)(6512007)(48376002)(316002)(14454004)(6666004)(7736002)(25786009)(6116002)(305945005)(80792005)(2351001)(486006)(6486002)(76176011)(52116002)(81166006)(51416003)(8676002)(3846002)(99286004)(6436002)(186003)(26005)(30864003)(6916009)(8936002)(478600001)(47776003)(11346002)(446003)(2616005)(86362001)(6506007)(386003)(50226002)(81156014)(66946007)(66066001)(66476007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3248;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UqC8aQJ+GD4kj242ehB/issQOFw904akAwIK5rjNqbZZ9BrbQkw7fmFPx28XtPBtEGihz5rIE04jEBlB/Zzmbj2Vgq0LHbzqVm2e11DQk6+EwEu5sIizKGxJuxFNePM3SdtuuFpCoOYOeM6KALSeZqYQG0X6Rxf0dS2DopL1gwIuTE8oqmeuwpJDIh4b7rDJFyezQ2//ol3Dbh9hb7lF8G/TQq/HrkL1bqbsXiUoFYXB0LXF7oT6KvqDfjnqfz/mzYJaaA8eJSOjCphX1/WDVHTA+xpcC4tGq4kKp4GZNFZ0+cFGysH0jIVzhBQh9JRcg6PG/QSiCNLHaU0Cv+N14l0nc0eWUERCvLj5pNbYlsoECDGtx47TtSaIs6uWCHtvG7HmHSsGhgec+nEpJQB96dUexMVWdmhcFNq+m3TTxGeBoKjdcv+LArSCj/2WRK6C
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c26d98-fa8a-4a1f-5c76-08d76c12ef88
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 10:34:48.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3FJwFI7o9MiqmbE6PgB6xB72DQ+53qpHegfGKQlLEcj6FquCzhUVpJqIGLO+x5U1UdBwQKrBNjMZR+5Lk6XWq6NLbMxnlNBu/qF4fszfNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3248
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 suspectscore=1 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support of temperature data in fifo for all chips.
Enable unification of scan elements for icm20602.
Add macros for generating scan elements with and without temp.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 194 +++++++-----------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  22 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |   6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   3 +
 4 files changed, 84 insertions(+), 141 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 268240644adf..7c2f6951364d 100644
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
@@ -878,22 +887,31 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
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
+/* generate scan mask and a duplicate with temperature enabled */
+#define INV_MPU6050_SCAN_MASK_DUP_TEMP(_mask)	\
+	(_mask),				\
+	(_mask) | INV_MPU6050_SCAN_MASK_TEMP
+
 static const unsigned long inv_mpu_scan_masks[] = {
 	/* 3-axis accel */
-	BIT(INV_MPU6050_SCAN_ACCL_X)
-		| BIT(INV_MPU6050_SCAN_ACCL_Y)
-		| BIT(INV_MPU6050_SCAN_ACCL_Z),
+	INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_ACCEL),
 	/* 3-axis gyro */
-	BIT(INV_MPU6050_SCAN_GYRO_X)
-		| BIT(INV_MPU6050_SCAN_GYRO_Y)
-		| BIT(INV_MPU6050_SCAN_GYRO_Z),
+	INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_GYRO),
 	/* 6-axis accel + gyro */
-	BIT(INV_MPU6050_SCAN_ACCL_X)
-		| BIT(INV_MPU6050_SCAN_ACCL_Y)
-		| BIT(INV_MPU6050_SCAN_ACCL_Z)
-		| BIT(INV_MPU6050_SCAN_GYRO_X)
-		| BIT(INV_MPU6050_SCAN_GYRO_Y)
-		| BIT(INV_MPU6050_SCAN_GYRO_Z),
+	INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_ACCEL
+			| INV_MPU6050_SCAN_MASK_3AXIS_GYRO),
 	0,
 };
 
@@ -917,17 +935,9 @@ static const unsigned long inv_mpu_scan_masks[] = {
 
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
@@ -944,17 +954,9 @@ static const struct iio_chan_spec inv_mpu9150_channels[] = {
 
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
@@ -969,98 +971,42 @@ static const struct iio_chan_spec inv_mpu9250_channels[] = {
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
+	INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_ACCEL),
 	/* 3-axis gyro */
-	BIT(INV_MPU6050_SCAN_GYRO_X)
-		| BIT(INV_MPU6050_SCAN_GYRO_Y)
-		| BIT(INV_MPU6050_SCAN_GYRO_Z),
+	INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_GYRO),
 	/* 3-axis magn */
-	BIT(INV_MPU9X50_SCAN_MAGN_X)
-		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
-		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU9X50_SCAN_MASK_3AXIS_MAGN),
 	/* 6-axis accel + gyro */
-	BIT(INV_MPU6050_SCAN_ACCL_X)
-		| BIT(INV_MPU6050_SCAN_ACCL_Y)
-		| BIT(INV_MPU6050_SCAN_ACCL_Z)
-		| BIT(INV_MPU6050_SCAN_GYRO_X)
-		| BIT(INV_MPU6050_SCAN_GYRO_Y)
-		| BIT(INV_MPU6050_SCAN_GYRO_Z),
+	INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_ACCEL
+			| INV_MPU6050_SCAN_MASK_3AXIS_GYRO),
 	/* 6-axis accel + magn */
-	BIT(INV_MPU6050_SCAN_ACCL_X)
-		| BIT(INV_MPU6050_SCAN_ACCL_Y)
-		| BIT(INV_MPU6050_SCAN_ACCL_Z)
-		| BIT(INV_MPU9X50_SCAN_MAGN_X)
-		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
-		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_ACCEL
+			| INV_MPU9X50_SCAN_MASK_3AXIS_MAGN),
 	/* 6-axis gyro + magn */
-	BIT(INV_MPU6050_SCAN_GYRO_X)
-		| BIT(INV_MPU6050_SCAN_GYRO_Y)
-		| BIT(INV_MPU6050_SCAN_GYRO_Z)
-		| BIT(INV_MPU9X50_SCAN_MAGN_X)
-		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
-		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
+	INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_GYRO
+			| INV_MPU9X50_SCAN_MASK_3AXIS_MAGN),
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
+	INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXIS_ACCEL
+			| INV_MPU6050_SCAN_MASK_3AXIS_GYRO
+			| INV_MPU9X50_SCAN_MASK_3AXIS_MAGN),
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
+			| INV_MPU6050_SCAN_MASK_TEMP,
 	0,
 };
 
@@ -1363,8 +1309,8 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
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

