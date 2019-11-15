Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 520F6FDFA0
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 15:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfKOOGr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 09:06:47 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:3596 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727380AbfKOOGr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 09:06:47 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFDu4Dj010259;
        Fri, 15 Nov 2019 06:06:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=0gN5HF1vwAWIqKDAXcriXX2lAiXJ8zgMTdT4Qv1jOk4=;
 b=fhGXUdOMTEEbfqCjf8faD0c4CcdpieyyhW9j9EnSCEQP/eArfPY5rBamVxIr224sLRqH
 NW828xQ8C3s+X/NdajTl4rR09JT4x0gu7U0rpfgfonGSoqcC1rWXpc0zxigIcSbDteke
 eCpB/um3taYasEXrHjuMSzhqbrWiqotepGDehV/u5DKqSFlygFeOXlr+Mru1plG3xqjC
 bEXmKQySJ4gBIi2pJDiKNvW3XHrxX7ywndigEKI3SN4Y5kIGLz/npNx23bC5UkH1yCEk
 NgS98GVV9/q/YvKRN24XYjpzeWIm+SWe4U9T6UR2g069Qx2tcfOZ6dxjZ2AMIVJH0qrs IA== 
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2053.outbound.protection.outlook.com [104.47.49.53])
        by mx0a-00328301.pphosted.com with ESMTP id 2w8x598wae-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 06:06:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pxbbyx+Ud1kogcrfVgfjFleQCRzKnqbf+N/zVF2jGZ0dfSVZS7j21OZgNinQfeXiDQLk1iY5pRZICtI2SFe5ZVuD7JHImDo8f+ZJKXhjQwTm/AIE3E6UkJPC10kRwr84alxwJsjLAg+vpjU0rZhW0hR3/aQSGz+SusRoCqw3dGw/HTzUYGEOQdoUyQMEMMr76QbwKiRnr6IWk7FnBix1M9+yylLXoiqtkCdd10FfKtXiIWhlI1+CwkvsOLU/7Cfi/QF98hFpcar5WtsPPnPqJmkSzDrXhZ6ZsWatkh1AQA3QWuLTN+cEhFCKAJGrht7s7g5HtQk7Fyv+yxCgvQA43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gN5HF1vwAWIqKDAXcriXX2lAiXJ8zgMTdT4Qv1jOk4=;
 b=fkT+eLlwda5OU1+rwhhEfEq+lFJ30BLLgTX2VmTY+tHpdm5gEroBbk94x4sqk+NiO//bPYvXvAioVYEEwnqSuLdwP5G3skP1ESYYRFHtG/xprQQDC2vN/hfsAiMijcxn6v18HWDLei7dYuxOLkKuRZ0+kk9E6eVdKFhUOhxHPRc2T9u6hu42Fh5JcLFDH2qvpZNdQ5WOHSMt4CofkZSzQlnwG7YnmpUbAYXvCNTCVNe51zuvJvTgKFY03YVXzb2n46wWn4q4qBj3xdIzqxS6th+5HjE8T3Thfn8BEWAGfPZFFfFloOHZvh3SirjzGPdXDiXfB+Ma7Se1OZp8fo5/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gN5HF1vwAWIqKDAXcriXX2lAiXJ8zgMTdT4Qv1jOk4=;
 b=ke7pIuvgmmOlkkoNDOz0j9WVFps+MuxAod4XWq8oJWL8ez+u+u/eAAwB6h6en7gVPW1aDmmY+TlhDBjr3U+5KLs4ARzTGDYs6v8RJvKVAExxiAM6RyG16Ybx7IBZPInaKCukc/ODeZqRpM4+6N5Ff/V+zqzo6T/njNQGgdZepCA=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB4126.namprd12.prod.outlook.com (10.255.125.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 14:06:43 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3%3]) with mapi id 15.20.2451.029; Fri, 15 Nov 2019
 14:06:43 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 2/2] iio: imu: inv_mpu6050: add support of MPU9150 magnetometer
Date:   Fri, 15 Nov 2019 15:06:22 +0100
Message-Id: <20191115140622.6429-3-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115140622.6429-1-jmaneyrol@invensense.com>
References: <20191115140622.6429-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::28) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5addba2b-fcb6-4ecf-a059-08d769d50b21
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4126063D6E16681AAD92FAE9C4700@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39850400004)(376002)(366004)(189003)(199004)(8936002)(6916009)(186003)(99286004)(7736002)(6506007)(478600001)(486006)(16586007)(25786009)(11346002)(36756003)(386003)(2616005)(476003)(14454004)(26005)(6436002)(80792005)(48376002)(305945005)(4326008)(50466002)(2351001)(14444005)(47776003)(66066001)(2361001)(2906002)(66556008)(50226002)(66476007)(66946007)(86362001)(81156014)(107886003)(81166006)(6666004)(5660300002)(6486002)(8676002)(446003)(52116002)(51416003)(316002)(76176011)(6116002)(3846002)(1076003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4126;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKO6CxmsuZHqfK8F/IPq6VXaSR3HU54gmj16qwRv160f9eJq7So4MHvxQ+LT9vIHhUc1sKcfRVGT19l7A0Cn8gjtW80Vd2s5OYOHxPQnjoDpGCjuLdqTvopkAbMIqmc57swZQOwQF/tCkkXC5yk0KoVRsppax2TUjmpyqL+JxARj3CS4CeURdeYAYM+sATWX5iAAr5EBe0llxIzVZA6d+PCAm5OS99FvHgE+z+QqjJri5MiaxPQya4nuntE7a2k6ztvfa2ZFO9RTuD3D6nNkMEEWrJoZPTquOBq2xBP0mT8GsxUpx6sMaZKFgNhio91X9GJJEyKSuRIoykDEcn3ynvXCIxKSAeNS0Nhvni9W0zmH+pijOxP3mu43Xqlp14Y3YcXUO8edqUazcBZnRHSfPzyRChBnPvQYLlZpXOd04OnBHgcBUdQ6/FB+7cyZo69d
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5addba2b-fcb6-4ecf-a059-08d769d50b21
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 14:06:43.5616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/EsmP4gxPazpwtQTy1EZKZth3qQ1bSZaY7kbAah09wevfdiLNGBIu4w2JyYCrIK5PBrev+0+N2F2cPTvcbW/Go6teR00tXmGPRMPIFZSbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=1
 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911150126
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for driving MPU9150 magnetometer (AK8975) from mpu.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 57 ++++++++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c    | 80 +++++++++++++------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  1 +
 4 files changed, 104 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 45e77b308238..23c0557891a0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -914,6 +914,33 @@ static const unsigned long inv_mpu_scan_masks[] = {
 		.ext_info = inv_ext_info,				\
 	}
 
+static const struct iio_chan_spec inv_mpu9150_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU9X50_SCAN_TIMESTAMP),
+	/*
+	 * Note that temperature should only be via polled reading only,
+	 * not the final scan elements output.
+	 */
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
+				| BIT(IIO_CHAN_INFO_OFFSET)
+				| BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = -1,
+	},
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
+
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU6050_SCAN_ACCL_X),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU6050_SCAN_ACCL_Y),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
+
+	/* Magnetometer resolution is 13 bits */
+	INV_MPU9X50_MAGN_CHAN(IIO_MOD_X, 13, INV_MPU9X50_SCAN_MAGN_X),
+	INV_MPU9X50_MAGN_CHAN(IIO_MOD_Y, 13, INV_MPU9X50_SCAN_MAGN_Y),
+	INV_MPU9X50_MAGN_CHAN(IIO_MOD_Z, 13, INV_MPU9X50_SCAN_MAGN_Z),
+};
+
 static const struct iio_chan_spec inv_mpu9250_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU9X50_SCAN_TIMESTAMP),
 	/*
@@ -1323,21 +1350,16 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		inv_mpu_bus_setup(indio_dev);
 
 	switch (chip_type) {
+	case INV_MPU9150:
+		indio_dev->channels = inv_mpu9150_channels;
+		indio_dev->num_channels = ARRAY_SIZE(inv_mpu9150_channels);
+		indio_dev->available_scan_masks = inv_mpu9x50_scan_masks;
+		break;
 	case INV_MPU9250:
 	case INV_MPU9255:
-		/*
-		 * Use magnetometer inside the chip only if there is no i2c
-		 * auxiliary device in use.
-		 */
-		if (!st->magn_disabled) {
-			indio_dev->channels = inv_mpu9250_channels;
-			indio_dev->num_channels = ARRAY_SIZE(inv_mpu9250_channels);
-			indio_dev->available_scan_masks = inv_mpu9x50_scan_masks;
-		} else {
-			indio_dev->channels = inv_mpu_channels;
-			indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
-			indio_dev->available_scan_masks = inv_mpu_scan_masks;
-		}
+		indio_dev->channels = inv_mpu9250_channels;
+		indio_dev->num_channels = ARRAY_SIZE(inv_mpu9250_channels);
+		indio_dev->available_scan_masks = inv_mpu9x50_scan_masks;
 		break;
 	case INV_ICM20602:
 		indio_dev->channels = inv_icm20602_channels;
@@ -1350,6 +1372,15 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		indio_dev->available_scan_masks = inv_mpu_scan_masks;
 		break;
 	}
+	/*
+	 * Use magnetometer inside the chip only if there is no i2c
+	 * auxiliary device in use. Otherwise Going back to 6-axis only.
+	 */
+	if (st->magn_disabled) {
+		indio_dev->channels = inv_mpu_channels;
+		indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
+		indio_dev->available_scan_masks = inv_mpu_scan_masks;
+	}
 
 	indio_dev->info = &mpu_info;
 	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 389cc8505e0e..f47a28b4be23 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -77,6 +77,7 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
 	case INV_ICM20602:
 		/* no i2c auxiliary bus on the chip */
 		return false;
+	case INV_MPU9150:
 	case INV_MPU9250:
 	case INV_MPU9255:
 		if (st->magn_disabled)
@@ -102,6 +103,7 @@ static int inv_mpu_magn_disable(struct iio_dev *indio_dev)
 	struct device_node *mux_node;
 
 	switch (st->chip_type) {
+	case INV_MPU9150:
 	case INV_MPU9250:
 	case INV_MPU9255:
 		mux_node = of_get_child_by_name(dev->of_node, "i2c-gate");
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
index 02735af152c8..4f192352521e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
@@ -12,7 +12,9 @@
 #include "inv_mpu_magn.h"
 
 /*
- * MPU9250 magnetometer is an AKM AK8963 chip on I2C aux bus
+ * MPU9xxx magnetometer are AKM chips on I2C aux bus
+ * MPU9150 is AK8975
+ * MPU9250 is AK8963
  */
 #define INV_MPU_MAGN_I2C_ADDR		0x0C
 
@@ -33,10 +35,10 @@
 #define INV_MPU_MAGN_BITS_MODE_PWDN	0x00
 #define INV_MPU_MAGN_BITS_MODE_SINGLE	0x01
 #define INV_MPU_MAGN_BITS_MODE_FUSE	0x0F
-#define INV_MPU_MAGN_BIT_OUTPUT_BIT	0x10
+#define INV_MPU9250_MAGN_BIT_OUTPUT_BIT	0x10
 
-#define INV_MPU_MAGN_REG_CNTL2		0x0B
-#define INV_MPU_MAGN_BIT_SRST		0x01
+#define INV_MPU9250_MAGN_REG_CNTL2	0x0B
+#define INV_MPU9250_MAGN_BIT_SRST	0x01
 
 #define INV_MPU_MAGN_REG_ASAX		0x10
 #define INV_MPU_MAGN_REG_ASAY		0x11
@@ -48,6 +50,7 @@
 static bool inv_magn_supported(const struct inv_mpu6050_state *st)
 {
 	switch (st->chip_type) {
+	case INV_MPU9150:
 	case INV_MPU9250:
 	case INV_MPU9255:
 		return true;
@@ -61,6 +64,7 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
 {
 	uint8_t val;
 	uint8_t asa[3];
+	int32_t sensitivity;
 	int ret;
 
 	/* check whoami */
@@ -71,12 +75,19 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
 	if (val != INV_MPU_MAGN_BITS_WIA)
 		return -ENODEV;
 
-	/* reset chip */
-	ret = inv_mpu_aux_write(st, INV_MPU_MAGN_I2C_ADDR,
-				INV_MPU_MAGN_REG_CNTL2,
-				INV_MPU_MAGN_BIT_SRST);
-	if (ret)
-		return ret;
+	/* software reset for MPU925x only */
+	switch (st->chip_type) {
+	case INV_MPU9250:
+	case INV_MPU9255:
+		ret = inv_mpu_aux_write(st, INV_MPU_MAGN_I2C_ADDR,
+					INV_MPU9250_MAGN_REG_CNTL2,
+					INV_MPU9250_MAGN_BIT_SRST);
+		if (ret)
+			return ret;
+		break;
+	default:
+		break;
+	}
 
 	/* read fuse ROM data */
 	ret = inv_mpu_aux_write(st, INV_MPU_MAGN_I2C_ADDR,
@@ -97,6 +108,25 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
 	if (ret)
 		return ret;
 
+	/*
+	 * Sensor sentivity
+	 * 1 uT = 0.01 G and value is in micron (1e6)
+	 * sensitvity = x uT * 0.01 * 1e6
+	 */
+	switch (st->chip_type) {
+	case INV_MPU9150:
+		/* sensor sensitivity is 0.3 uT */
+		sensitivity = 3000;
+		break;
+	case INV_MPU9250:
+	case INV_MPU9255:
+		/* sensor sensitivity in 16 bits mode: 0.15 uT */
+		sensitivity = 1500;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	/*
 	 * Sensitivity adjustement and scale to Gauss
 	 *
@@ -104,16 +134,11 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
 	 * Factor simplification:
 	 * Hadj = H * ((ASA + 128) / 256)
 	 *
-	 * Sensor sentivity
-	 * 0.15 uT in 16 bits mode
-	 * 1 uT = 0.01 G and value is in micron (1e6)
-	 * sensitvity = 0.15 uT * 0.01 * 1e6
-	 *
-	 * raw_to_gauss = Hadj * 1500
+	 * raw_to_gauss = Hadj * sensitivity
 	 */
-	st->magn_raw_to_gauss[0] = (((int32_t)asa[0] + 128) * 1500) / 256;
-	st->magn_raw_to_gauss[1] = (((int32_t)asa[1] + 128) * 1500) / 256;
-	st->magn_raw_to_gauss[2] = (((int32_t)asa[2] + 128) * 1500) / 256;
+	st->magn_raw_to_gauss[0] = (((int32_t)asa[0] + 128) * sensitivity) / 256;
+	st->magn_raw_to_gauss[1] = (((int32_t)asa[1] + 128) * sensitivity) / 256;
+	st->magn_raw_to_gauss[2] = (((int32_t)asa[2] + 128) * sensitivity) / 256;
 
 	return 0;
 }
@@ -129,6 +154,7 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
  */
 int inv_mpu_magn_probe(struct inv_mpu6050_state *st)
 {
+	uint8_t val;
 	int ret;
 
 	/* quit if chip is not supported */
@@ -179,10 +205,17 @@ int inv_mpu_magn_probe(struct inv_mpu6050_state *st)
 	if (ret)
 		return ret;
 
-	/* add 16 bits mode */
-	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_DO(1),
-			   INV_MPU_MAGN_BITS_MODE_SINGLE |
-			   INV_MPU_MAGN_BIT_OUTPUT_BIT);
+	/* add 16 bits mode for MPU925x */
+	val = INV_MPU_MAGN_BITS_MODE_SINGLE;
+	switch (st->chip_type) {
+	case INV_MPU9250:
+	case INV_MPU9255:
+		val |= INV_MPU9250_MAGN_BIT_OUTPUT_BIT;
+		break;
+	default:
+		break;
+	}
+	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_DO(1), val);
 	if (ret)
 		return ret;
 
@@ -237,6 +270,7 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
 
 	/* fill magnetometer orientation */
 	switch (st->chip_type) {
+	case INV_MPU9150:
 	case INV_MPU9250:
 	case INV_MPU9255:
 		/* x <- y */
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index d7d951927a44..a9c75bc62f18 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -50,6 +50,7 @@ static void inv_scan_query(struct iio_dev *indio_dev)
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 
 	switch (st->chip_type) {
+	case INV_MPU9150:
 	case INV_MPU9250:
 	case INV_MPU9255:
 		return inv_scan_query_mpu9x50(indio_dev);
-- 
2.17.1

