Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491D6142797
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 10:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgATJrj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 04:47:39 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:32814 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgATJrj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 04:47:39 -0500
X-Greylist: delayed 642 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jan 2020 04:47:37 EST
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K9RdO7025311;
        Mon, 20 Jan 2020 01:36:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=GE62sdKSX3LGUqRw6XwcVtitfaMeR56KCsErcKwEREY=;
 b=UV1ZhKZGL/GAXMgVBb3Pbda4wthczgg+zBQfscwXQw9hQ5yL5atPGNdGFgkOEHpVBG1f
 HXOLHeSt1K1Zw8e5PNSCXzo8dwhCTlYFK1SHzFb+Xr0TQCltLIVeio8sbIcD9s1OToe8
 AxvJpKqBjt85FmTvO3wTfQAT1UerSesxk00PnGY5MzH6k28XRdb1UIE6IgpT9KQMHaGg
 f9vZk5k4S4CiukdT41saCZ5Q3E1JGCOdsZbz7NEzsQ/0Wx7pqoH51vKsh+Fqtkw21xhy
 TOC1URSS0fGaVdZXewXBgDyeuIcDw/R8JMtjlRMj/616GJRXoN4OOhA69gYc4j9Z0bFh 9g== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2053.outbound.protection.outlook.com [104.47.46.53])
        by mx0b-00328301.pphosted.com with ESMTP id 2xkxuu0mxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 01:36:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fke8yOs8eo9n1tXQPOOm6mGOn8geLKBPckh0lrwalwpcSPZU1bF7SzG9TR1iD3F36F1zW58TZE55C/k6fJhmEVI/ye4sWWwfkbMRBwD7DNI1wkeSMw0iqIG+g+NHzO7FeT0chiIBeOdmwbZjRMTCFSSk/msnOib5wUuVaI6JNAqz7ZGo8NOjElw28KeL0zTB1fxw/W9ihS5STO6H30pmwUokDgJI/VDZUhe6r36wsFTXvXavSgOcDruiBD4cJiYmpsouc5/kt+zlqN7JPPPh8nw6dXhj2kX6PiWR2RpkgH1SgFx3xQAcp8akrILU8cArbQiLL4innCkg7fEGkm0fjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GE62sdKSX3LGUqRw6XwcVtitfaMeR56KCsErcKwEREY=;
 b=aEFdko3gQxxs5+kOeApKvx65Q6tKMhmkO7XTh5PKbtt0UaGevp7JVAhWdVC3zq++x2aLCoiRW+6YOeCUba3X206yMEzZXWRQcDUL83I24G0/YgSdDehtnwHt0mrykvJXuGknlDhi/hc9lXGWuNCsCiOGrvqxLBistfH76lVOcPG41cVtnrmuerkywyH1YB7moq7cVZuWRBQxFKD3V0sEBQjl/05AtDFbsVHkP4h9xv7ws/DUzJ4YvOJTCMOz3Uv3Ypr5k4OvHFEuDXJfAwA2gEZiHuBRARAm0f7UtWqRT9a5bGK+TZ2jw00pC2IhsOSd8XmiTfKrI7hIT2MHyeLLiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GE62sdKSX3LGUqRw6XwcVtitfaMeR56KCsErcKwEREY=;
 b=NtTIjF/20zhNYGqkjjce1K9yK5UXkhCw2ejmHFNK06u/5Z7ZFV07TeW08cOUwcO8XpRgID/gVMeGzhWVurom6OuMtw9zOT5nU7xk9Rut5n0gXvyCLPewHEyCzRL8PIr4QzTscYvStysyPHiFHH6s8HujHDwM3a/wWLrxS5NE1K0=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3183.namprd12.prod.outlook.com (20.179.82.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 09:36:52 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa%6]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 09:36:52 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 3/9] iio: imu: inv_mpu6050: add support of ICM20609 & ICM20689
Date:   Mon, 20 Jan 2020 10:36:14 +0100
Message-Id: <20200120093620.9681-4-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120093620.9681-1-jmaneyrol@invensense.com>
References: <20200120093620.9681-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 09:36:50 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93f34402-ca0f-4b9f-6556-08d79d8c47cb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB318308078C5F9F3515BB720CC4320@MN2PR12MB3183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39840400004)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(7696005)(52116002)(6666004)(8936002)(478600001)(186003)(16526019)(8676002)(86362001)(2906002)(26005)(316002)(81156014)(81166006)(54906003)(956004)(107886003)(2616005)(6486002)(1076003)(66946007)(36756003)(5660300002)(66556008)(4326008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3183;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrZ22wBTl02MWlpL1e8ThClCnIAqYTmZ/tYM1gFsPYy331j+4855aPoOrS5ItnGY3R1h1nuiaWZubiz4CBLyfiizFAJ9rXS44qgx2IDj8u/hAc5JqfGiKgndRxzZiFoUkzSmQPQeA3csowh2y2bW1KmUQMe3jENFIYpFkr3KFMN58wTTByJDCeWlHDe4trg5/mg1MswButruPLPtuNvTUy51MQNPNLN1keRGzO/nuQNZqm+e7LvvIF5PrKFlXyyal161qkHYbQVOr3fCb5UFZultrscX3B+zq8hu2tgMRz6E1pppr06CKUsMGWkq092QMBfx8HQDbczl7+QNxdME2GvUaHf6xR9RkT4Cf23Bt2XF3vCzxSTzZ1MTiCd5ukd7x1LrznN5iRyZzox7Rte1z1ql3ScU2NZ6uz8+SqMlVQTyRmxXGSKTNiQ3v4JAQ1Zl
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f34402-ca0f-4b9f-6556-08d79d8c47cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 09:36:52.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99bOXE45RY0P1GylR7z/Ew+oRSQY5OvPsqn+Gxqp3vXVyjXghHOxVkadEWy8Gbj+Ai7dsJzVqpPdIXAPRXtdz9zYFQ6xXKCD3tqOsc4O9UM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3183
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_01:2020-01-16,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

They are similar to ICM20608 chip.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Kconfig        |  8 +++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 26 ++++++++++++++++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 12 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  5 +++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 10 +++++++++
 5 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index 003134734646..e933db3a5a89 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -16,8 +16,8 @@ config INV_MPU6050_I2C
 	select REGMAP_I2C
 	help
 	  This driver supports the Invensense MPU6050/9150,
-	  MPU6500/6515/9250/9255, ICM20608 and ICM20602 motion tracking devices
-	  over I2C.
+	  MPU6500/6515/9250/9255, ICM20608/20609/20689 and ICM20602
+	  motion tracking devices over I2C.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-i2c.
 
@@ -28,7 +28,7 @@ config INV_MPU6050_SPI
 	select REGMAP_SPI
 	help
 	  This driver supports the Invensense MPU6000,
-	  MPU6500/6515/9250/9255, ICM20608 and ICM20602 motion tracking devices
-	  over SPI.
+	  MPU6500/6515/9250/9255, ICM20608/20609/20689 and ICM20602
+	  motion tracking devices over SPI.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-spi.
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 5096fc49012d..5fd57a1bee90 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -176,6 +176,22 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.fifo_size = 512,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
 	},
+	{
+		.whoami = INV_ICM20609_WHOAMI_VALUE,
+		.name = "ICM20609",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6050,
+		.fifo_size = 4 * 1024,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+	},
+	{
+		.whoami = INV_ICM20689_WHOAMI_VALUE,
+		.name = "ICM20689",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6050,
+		.fifo_size = 4 * 1024,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+	},
 	{
 		.whoami = INV_ICM20602_WHOAMI_VALUE,
 		.name = "ICM20602",
@@ -286,20 +302,22 @@ static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
 	if (result)
 		return result;
 
+	/* set accel lpf */
 	switch (st->chip_type) {
 	case INV_MPU6050:
 	case INV_MPU6000:
 	case INV_MPU9150:
 		/* old chips, nothing to do */
-		result = 0;
+		return 0;
+	case INV_ICM20689:
+		/* set FIFO size to maximum value */
+		val |= INV_ICM20689_BITS_FIFO_SIZE_MAX;
 		break;
 	default:
-		/* set accel lpf */
-		result = regmap_write(st->map, st->reg->accel_lpf, val);
 		break;
 	}
 
-	return result;
+	return regmap_write(st->map, st->reg->accel_lpf, val);
 }
 
 /**
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index f47a28b4be23..c2b5621edadb 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -74,6 +74,8 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
 
 	switch (st->chip_type) {
 	case INV_ICM20608:
+	case INV_ICM20609:
+	case INV_ICM20689:
 	case INV_ICM20602:
 		/* no i2c auxiliary bus on the chip */
 		return false;
@@ -218,6 +220,8 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"mpu9250", INV_MPU9250},
 	{"mpu9255", INV_MPU9255},
 	{"icm20608", INV_ICM20608},
+	{"icm20609", INV_ICM20609},
+	{"icm20689", INV_ICM20689},
 	{"icm20602", INV_ICM20602},
 	{}
 };
@@ -253,6 +257,14 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,icm20608",
 		.data = (void *)INV_ICM20608
 	},
+	{
+		.compatible = "invensense,icm20609",
+		.data = (void *)INV_ICM20609
+	},
+	{
+		.compatible = "invensense,icm20689",
+		.data = (void *)INV_ICM20689
+	},
 	{
 		.compatible = "invensense,icm20602",
 		.data = (void *)INV_ICM20602
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 6158fca7f70e..75b8903450eb 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -75,6 +75,8 @@ enum inv_devices {
 	INV_MPU9250,
 	INV_MPU9255,
 	INV_ICM20608,
+	INV_ICM20609,
+	INV_ICM20689,
 	INV_ICM20602,
 	INV_NUM_PARTS
 };
@@ -276,6 +278,7 @@ struct inv_mpu6050_state {
 
 /* mpu6500 registers */
 #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
+#define INV_ICM20689_BITS_FIFO_SIZE_MAX     0xC0
 #define INV_MPU6500_REG_ACCEL_OFFSET        0x77
 
 /* delay time in milliseconds */
@@ -340,6 +343,8 @@ struct inv_mpu6050_state {
 #define INV_MPU9255_WHOAMI_VALUE		0x73
 #define INV_MPU6515_WHOAMI_VALUE		0x74
 #define INV_ICM20608_WHOAMI_VALUE		0xAF
+#define INV_ICM20609_WHOAMI_VALUE		0xA6
+#define INV_ICM20689_WHOAMI_VALUE		0x98
 #define INV_ICM20602_WHOAMI_VALUE		0x12
 
 /* scan element definition for generic MPU6xxx devices */
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index f7276f9d83fc..189df8bae7b4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -78,6 +78,8 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"mpu9250", INV_MPU9250},
 	{"mpu9255", INV_MPU9255},
 	{"icm20608", INV_ICM20608},
+	{"icm20609", INV_ICM20609},
+	{"icm20689", INV_ICM20689},
 	{"icm20602", INV_ICM20602},
 	{}
 };
@@ -109,6 +111,14 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,icm20608",
 		.data = (void *)INV_ICM20608
 	},
+	{
+		.compatible = "invensense,icm20609",
+		.data = (void *)INV_ICM20609
+	},
+	{
+		.compatible = "invensense,icm20689",
+		.data = (void *)INV_ICM20689
+	},
 	{
 		.compatible = "invensense,icm20602",
 		.data = (void *)INV_ICM20602
-- 
2.17.1

