Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB3814279B
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 10:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgATJrl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 04:47:41 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:33684 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgATJrk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 04:47:40 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K9SwM6025978;
        Mon, 20 Jan 2020 01:37:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=7OmZlTzr2NeP8b2xAXii26d+pFPKpTZpiadtyKbTsEc=;
 b=QcioyUoy3J6BxcdncEEXYU1mvkQpODWbHBw0DChTULol4BwFaTC8nkUHXXjMj9Mdbvm7
 ZLCNtPDdBLVam1LLZrUzerZ2UCWEK0pkoyKJdsZxwU46S6fhWFNC5ha07B+Bkq4+MCmY
 dGVY+lxZnP/T9uhUJ7C67K4Hiao6r+D0oRC4IpdYjuyfHBBYHMzOW8huLG6ROyQ4Z97z
 v3LNwzkSJLl0x/nXUz7XesFFzWjcJqS/Wc1V5RW3OUKRdRv0yzuqLAW81sVDWJFv8luW
 /XnCSCG4yNW2+Dd//GfdDweXh3NYo3ytMETmPW6oXTaxQHAwv0dEZhXlpyuGcMuVozHj vQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-00328301.pphosted.com with ESMTP id 2xkxuu0mxf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 01:37:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFvPQ0f7DH6WjbfE+7SpwDKwiTd5P9cO6J6B0iKo7qwueDWgHu1ODdwE/EAFIypY3rkmC7rud1oLXyujP3TNi2w3WZVuFDUCOKOCyHvJMhOd6InVFZ6ukt4uXkJ2GvjA1DBAXs96g82Xzk8bLnzKKxf1/MH8MymNOtqaX7piCsHo0kow5hh7jpEAEwfIWOsrlFcKtHuzbXEaUr0HIg1Luc6ILC7Iw71xOH48bwhFvuYJYTCtpURnEo5U4tl17gBXJB0txWw9oIski1InILLB8ezgFEhp4nl2yvQJuZg6MCmx/7+6+woxK+6EB/bI+FTXITZHDDkD3YsL8OQCO/180A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OmZlTzr2NeP8b2xAXii26d+pFPKpTZpiadtyKbTsEc=;
 b=KV1i+fSkfyyeNQc0S8Dfbbt0D7LzYr0thIJXZhvk9adEmWw1Y0J1/djUUh6Td0Os9N8E12gUyCSzguBUOcS1Wbq0BjhXwNOHlvrjYH7KYTbAQvjS1AYt3VUo5pk4msag+rhK0u1W02URwVXhn2qJQrD5IvSv6CMg3WsMmLRJnFVihUQD7ya4I8X7T10A448gwlvxLVwCF7GnuqZa+FCiL82kMJ/qMTta53ca6stbTy0+mEyMDvGRfC1gGhBWN4DBKKjBsMclF4J4oR4Fad8iyDLz6F5GmmfkvgCDf/n4T3foTg2P8dEJBQSUz2ATk+EV76J94nwbC5vfuB/HD3BI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OmZlTzr2NeP8b2xAXii26d+pFPKpTZpiadtyKbTsEc=;
 b=MIgif4lopYko07Q9Fz1ljS5D3hAKFSD8CYfYE5Qwuz4OnA01m1TbQ2bgEsWDc5eoA1ex4Oj6PlDlLaz8pduJ+DB/ohjRKyVzXQsxQacnwQeJfjhOv6hIkhM4waxHG9zFNafcRv1ga8fURemHNgzhm+PYpPpaO4NzsnBtEH+wy/M=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB4048.namprd12.prod.outlook.com (52.135.49.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 09:37:03 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa%6]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 09:37:03 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 7/9] iio: imu: inv_mpu6050: add support of ICM20690
Date:   Mon, 20 Jan 2020 10:36:18 +0100
Message-Id: <20200120093620.9681-8-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120093620.9681-1-jmaneyrol@invensense.com>
References: <20200120093620.9681-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 09:37:01 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e8b423a-2452-434c-bbc3-08d79d8c4e4c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4048771A5A581AAEEAC9B9D3C4320@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39840400004)(376002)(136003)(366004)(189003)(199004)(66946007)(66476007)(66556008)(7696005)(52116002)(86362001)(36756003)(107886003)(5660300002)(6666004)(2906002)(8676002)(81166006)(186003)(81156014)(54906003)(1076003)(8936002)(478600001)(4326008)(16526019)(316002)(956004)(2616005)(26005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4048;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +r/Wcs3suFErYBPsPvpskGLWX+b3rEiGz6I7Bqa4pM7HsuKUF5BOwI/kzZW0hkk872TBlh5coiDBd5K10z/1657Oun/b1Gd3VsAB9grUvcwl/mzYmbbIIUnCjzKRwCx3d9eEj7BEzg4jmUza+9bDBQDYiM+rE5EhxAbOO6WHP+OtW4PPmlSl5taK3bGVzGDjlg0ladV5EoDKC/WAyGGCD34bbgS+gd1IJSArwQbfEcnbmm+DRSJtPWknU7ZtrwNUnIkJyOASJKlGXhDDLZ9SKYllTA89p3xOp2y6C/NQkiV/Qg8hqBnz2YNUwb3XPwEYHwhQJTZH9C3VIoZmy/wZYGY4nWgiM9tV/Fj5YLQTJ6MvklmWPxJfL0/H89xkguqam+ixGuqijoSUjoApEQ2Q+SUkJQ9rV/qCahf9PszhqvKqiVoDNzoZ424oA51RklYp
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8b423a-2452-434c-bbc3-08d79d8c4e4c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 09:37:03.5276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+EvRwufbBjLdZlKwxpLBmVQ5a2NWl+aAHJM/IHRmHi8Noi5lTKVO+3SnmNsDVFtnUxvkyCBD8VOvJ+FmO9uxkoNCIF4YzUDUuAhkPekbX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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
index 66193786386c..f8b1fbca2d9e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -224,6 +224,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"icm20609", INV_ICM20609},
 	{"icm20689", INV_ICM20689},
 	{"icm20602", INV_ICM20602},
+	{"icm20690", INV_ICM20690},
 	{"iam20680", INV_IAM20680},
 	{}
 };
@@ -271,6 +272,10 @@ static const struct of_device_id inv_of_match[] = {
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
index e911e13edb86..2d069e7d468b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -81,6 +81,7 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"icm20609", INV_ICM20609},
 	{"icm20689", INV_ICM20689},
 	{"icm20602", INV_ICM20602},
+	{"icm20690", INV_ICM20690},
 	{"iam20680", INV_IAM20680},
 	{}
 };
@@ -124,6 +125,10 @@ static const struct of_device_id inv_of_match[] = {
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

