Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC384154241
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBFKqD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:46:03 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:11982 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727778AbgBFKqC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 05:46:02 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016AWDf8004857;
        Thu, 6 Feb 2020 02:32:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=xUCE5HVGNWcVChFybGfE6IedWcElePYitXKepV1nsm0=;
 b=n1ZY73rsQx2YMaY4NZd9kSFpOtMVuD6Y5ONHxLiVEex4zu5s+qXTsXOkneVBmXM01QVv
 t2cNg9xlScQ1daxboPfkZ00tYPZiFVrmgEUMYT+ZOHCUTmkD2UMS5uRFGDfa1X38+v3R
 weaW8tPQxsfuyNXu/xBw7tKI8R0Kti82oODdgn7Fsh4i/6K2Ud4EDuiVIpeuK/1gs6dF
 Y/2EoVOopPcF53RoDtVtPvkNVKnMW4rgquIHwYnGLqUWY79YT3HDYcx6Ooe6s8YjWw/+
 nd/h5WTxawocW4KG0JWgETzeUb8Z16nlhEAmce3PnUsLFkt21oCVixyhtxtAFTA+xYQD lw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0b-00328301.pphosted.com with ESMTP id 2y0e4sg2cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 02:32:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDe/clUYeppdbbn59ISCcYuTejvJMdlT8uEhBgZLwPGT71QandbbcDqVo2iPOErvLPBOvCGZnd5Z7M3+2/XbDBaH7He+Ymf7ys9mnV6o76mjLAsJJvgSVeETxCuLp0UPMzxglSEaxPr3m4sH6Na4yIUY7MTNB5Vz70YTdtXhUS+yTNMWnvYPR+6VTVHO7BAy+Whcb1Jj+ypq++r4UY1oExoM0I7KbhDgrip8sWkQSCFQuymaAZdZWjYXMB+ZZZKC8PgPqDtHsUHW6nZ7K4xQbNECrHIwBH5IJ34FQkj8dYa8/Kx03Dw7StO/ZasK4ZGIfjZMHdEvVW/JQ1j2iT+fng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUCE5HVGNWcVChFybGfE6IedWcElePYitXKepV1nsm0=;
 b=Js9cY4rnblj5NnvLmx93Rq4kAtV3Ad5UX/6u6AW54WrcKPOpPdYOICn3A+m1/bJTFwOtWCj0wDfcyKC3MJqpFzyUa/CoLZ5Uu9HPnO4bBltKY+4xO+4GvtKkxL5NnI4ubKtkPqSv6rEvhGmbIja6/LypFaonB3mO1aZkOAIymBT8uIai8zOSUqyqhVxlFJu0f2kx6LbYR3a2dsrCCPUhXfR9TFbnG0hu0PjcRBJTMw02FUHmvu783d5AfWikEPR+U09Cn2FIESOSKKkuXFZ4jqUAaxGcpvI/1o2xYjNA6kTdi9cF0K8B8Re0rBhgnl7FRgWwiTRX/qNv4AMdwTDM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUCE5HVGNWcVChFybGfE6IedWcElePYitXKepV1nsm0=;
 b=ZcQTvKdNjgyfGU8XFfY4EDq31DpxwN6DoGJUa9mjN0PxDYDoRrpiephhKkvXHlRNU4IwmdRsvnSHPidB0FT+QhmT/zVC1vPeJm8E0L9jVvDYjj1dJqzNqSBeixdz+FrEsuauyIsG/dYKumB0YogJLEUy8U79Mn3seXdnFuJwPxw=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4085.namprd12.prod.outlook.com (20.180.16.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 10:32:13 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 10:32:13 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 4/6] iio: imu: inv_mpu6050: add support of ICM20690
Date:   Thu,  6 Feb 2020 11:31:03 +0100
Message-Id: <20200206103105.23666-5-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206103105.23666-1-jmaneyrol@invensense.com>
References: <20200206103105.23666-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::34) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 10:32:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 230e20cf-a977-4f4a-364e-08d7aaefd437
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4085C2375B109B6CF302B3CCC41D0@CH2PR12MB4085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(366004)(136003)(376002)(199004)(189003)(478600001)(2616005)(956004)(86362001)(2906002)(26005)(5660300002)(186003)(16526019)(107886003)(6666004)(6486002)(1076003)(81156014)(8676002)(81166006)(4326008)(8936002)(36756003)(54906003)(52116002)(66476007)(316002)(66946007)(66556008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4085;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lu+FuACfW/CB3uyrzeiC6HwPbY8hRMYg1fsP+UwXhnDyJQ36uIIuzqPUZ3yd0oSNPPqCEoM+SLGh0WQyyDg2vt/GUJjbRr39Ef5xi6/uU8iaSK01Lb+KNfsQumWBHbi78KIl5PKeDApOTLbAQ8JxSC90Glq1e0QLUiTg6x/j7CelCiHFcmPLnzajVbbjRa547TpWJsCuDv+mrqSdxjdJipgLkqTJyTkp1Vp00+e6LZ3+3ujCVZhHVMuuYBsBtPvPYR9ZFUnXpo/bOWH16meCxBmESZIvu3l/vtv5VK4iufqR3d7k5kjW5jBkoA3jiPfqKcG14vVRiShYKJrLOUU5O3koCgy1n8BVOmi4pGoN17Q/r7ZA5pv/cJotqKo+wrK3Oxxq6Whyqe+JZ+BCVz71UMbsv/vPQqiETim5Wy5eH+Z2y8Tw6Y3lb/DeKxE5/3Dp
X-MS-Exchange-AntiSpam-MessageData: x9RfXJaXtQ6RyXwMqJlv4gixf4Cek8xYBxfwLT1ONuJl5M6GfmZW8Az+poWWELs5nTd/3aVuxMlIQBp56US3XN7G7qxfIXmZ394eawtTg5DR2Dyn9OTch9Fh6PlO4qvk9iKMsL0jZWoF+b6Kbbw7OA==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230e20cf-a977-4f4a-364e-08d7aaefd437
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 10:32:13.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KoOkCkYUel1ia7kmOhphOluntehvQfu/VwXnR7ATDSxuWrY9d/bWM6WOEj7scmyoQEkDJrpD3BW85KENwIQJeIZQsek5IkPBXzeFU3P4zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_01:2020-02-06,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060081
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Same generation as ICM20602 but different registers.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Kconfig        |  8 ++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 36 +++++++++++++++++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  5 +++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  3 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  5 +++
 5 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index e65474a64675..7137ea6f25db 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -16,8 +16,8 @@ config INV_MPU6050_I2C
 	select REGMAP_I2C
 	help
 	  This driver supports the Invensense MPU6050/9150,
-	  MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM20602 and IAM20680
-	  motion tracking devices over I2C.
+	  MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM20602/ICM20690 and
+	  IAM20680 motion tracking devices over I2C.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-i2c.
 
@@ -28,7 +28,7 @@ config INV_MPU6050_SPI
 	select REGMAP_SPI
 	help
 	  This driver supports the Invensense MPU6000,
-	  MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM20602 and IAM20680
-	  motion tracking devices over SPI.
+	  MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM20602/ICM20690 and
+	  IAM20680 motion tracking devices over SPI.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-spi.
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index e8e6beef3f04..9ecc667debbe 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -200,6 +200,14 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.fifo_size = 1008,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
 	},
+	{
+		.whoami = INV_ICM20690_WHOAMI_VALUE,
+		.name = "ICM20690",
+		.reg = &reg_set_icm20602,
+		.config = &chip_config_6050,
+		.fifo_size = 1024,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+	},
 	{
 		.whoami = INV_IAM20680_WHOAMI_VALUE,
 		.name = "IAM20680",
@@ -295,6 +303,25 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
 }
 EXPORT_SYMBOL_GPL(inv_mpu6050_set_power_itg);
 
+static int inv_mpu6050_set_gyro_fsr(struct inv_mpu6050_state *st,
+				    enum inv_mpu6050_fsr_e val)
+{
+	unsigned int gyro_shift;
+	u8 data;
+
+	switch (st->chip_type) {
+	case INV_ICM20690:
+		gyro_shift = INV_ICM20690_GYRO_CONFIG_FSR_SHIFT;
+		break;
+	default:
+		gyro_shift = INV_MPU6050_GYRO_CONFIG_FSR_SHIFT;
+		break;
+	}
+
+	data = val << gyro_shift;
+	return regmap_write(st->map, st->reg->gyro_config, data);
+}
+
 /**
  *  inv_mpu6050_set_lpf_regs() - set low pass filter registers, chip dependent
  *
@@ -318,6 +345,7 @@ static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
 		/* old chips, nothing to do */
 		return 0;
 	case INV_ICM20689:
+	case INV_ICM20690:
 		/* set FIFO size to maximum value */
 		val |= INV_ICM20689_BITS_FIFO_SIZE_MAX;
 		break;
@@ -346,8 +374,8 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 	result = inv_mpu6050_set_power_itg(st, true);
 	if (result)
 		return result;
-	d = (INV_MPU6050_FSR_2000DPS << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
-	result = regmap_write(st->map, st->reg->gyro_config, d);
+
+	result = inv_mpu6050_set_gyro_fsr(st, INV_MPU6050_FSR_2000DPS);
 	if (result)
 		goto error_power_off;
 
@@ -559,12 +587,10 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val)
 {
 	int result, i;
-	u8 d;
 
 	for (i = 0; i < ARRAY_SIZE(gyro_scale_6050); ++i) {
 		if (gyro_scale_6050[i] == val) {
-			d = (i << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
-			result = regmap_write(st->map, st->reg->gyro_config, d);
+			result = inv_mpu6050_set_gyro_fsr(st, i);
 			if (result)
 				return result;
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index cd0eeb5dc7f6..1363d3776523 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -208,6 +208,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"icm20609", INV_ICM20609},
 	{"icm20689", INV_ICM20689},
 	{"icm20602", INV_ICM20602},
+	{"icm20690", INV_ICM20690},
 	{"iam20680", INV_IAM20680},
 	{}
 };
@@ -255,6 +256,10 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,icm20602",
 		.data = (void *)INV_ICM20602
 	},
+	{
+		.compatible = "invensense,icm20690",
+		.data = (void *)INV_ICM20690
+	},
 	{
 		.compatible = "invensense,iam20680",
 		.data = (void *)INV_IAM20680
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 404c289f8c84..7ae614052210 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -78,6 +78,7 @@ enum inv_devices {
 	INV_ICM20609,
 	INV_ICM20689,
 	INV_ICM20602,
+	INV_ICM20690,
 	INV_IAM20680,
 	INV_NUM_PARTS
 };
@@ -297,6 +298,7 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_MAX_ACCL_FS_PARAM        3
 #define INV_MPU6050_THREE_AXIS               3
 #define INV_MPU6050_GYRO_CONFIG_FSR_SHIFT    3
+#define INV_ICM20690_GYRO_CONFIG_FSR_SHIFT   2
 #define INV_MPU6050_ACCL_CONFIG_FSR_SHIFT    3
 
 #define INV_MPU6500_TEMP_OFFSET              7011
@@ -347,6 +349,7 @@ struct inv_mpu6050_state {
 #define INV_ICM20609_WHOAMI_VALUE		0xA6
 #define INV_ICM20689_WHOAMI_VALUE		0x98
 #define INV_ICM20602_WHOAMI_VALUE		0x12
+#define INV_ICM20690_WHOAMI_VALUE		0x20
 #define INV_IAM20680_WHOAMI_VALUE		0xA9
 
 /* scan element definition for generic MPU6xxx devices */
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 393cec555be6..bc351dd58c53 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -84,6 +84,7 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"icm20609", INV_ICM20609},
 	{"icm20689", INV_ICM20689},
 	{"icm20602", INV_ICM20602},
+	{"icm20690", INV_ICM20690},
 	{"iam20680", INV_IAM20680},
 	{}
 };
@@ -127,6 +128,10 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,icm20602",
 		.data = (void *)INV_ICM20602
 	},
+	{
+		.compatible = "invensense,icm20690",
+		.data = (void *)INV_ICM20690
+	},
 	{
 		.compatible = "invensense,iam20680",
 		.data = (void *)INV_IAM20680
-- 
2.17.1

