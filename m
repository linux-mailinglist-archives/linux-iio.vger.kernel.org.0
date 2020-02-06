Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C65D154244
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgBFKqD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:46:03 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:11980 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727795AbgBFKqD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 05:46:03 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016AWAJ6004840;
        Thu, 6 Feb 2020 02:32:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=fMujg3wtOusTzDXf8SvP5S50c2HsD7aK60QJvPr4Tjk=;
 b=mS+75NEFwIZT8pmKYwYTkkj1/dRQCBc1HXLLx9t9gbX1jqZGbxA2y4cLHxHk5YMCRw68
 zoOMrPFjt3Qt9SkEy963JMAura0G3nZ3LqBReBxUx+XCahtib6kssSWEdkXaDZzWgI+k
 VsA5jCTfJzj++Z+nIzpH3+cE7J1VSNhdhJNwJLMf9jl18Gu4FING5hGxQVIRSiQBzcI/
 UH0nF/qVQnzm29kJfjsVItdl+XDsOTMMLCrtG4Zqtv7+vEhjNoGgCw03hq4R8btaM/+L
 imzWhErLm6qrnpZ3jw2rVvPmFGqLswNOoavtHpWAkI8NwtM0eOd4sdVfwm5TFHNtRIPT LQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0b-00328301.pphosted.com with ESMTP id 2y0e4sg2cj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 02:32:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4+xj1JcWV7WNYZ3DLtW2jLrHgCtM9gox2OB4B5cUbqQg3W/XWP0aHlznJZIpNtRckQBgreZvEs3L+ztEI0g6qN5+fPcAb+CKJQVdT3eK/NcIHBN++dgfnE/xzLy58R7zVUSRqMQq7DKcRLLIMIt0xOmXLh+mkdUdaOmDcIaQ5PjzVSz4WPG6fO2X7d5TWnKn8B1Nwau7/Z4wp4iI0GWTSXskh6iz6MNYhn1TTTlZwCkKyd0b48aBs4DdEUvMIzQMQ4eiSyy0Lm8/vt/68Ie+hjJF96fO6ffnXeYDowO0antf2X0PepLAfgLIFQbrvrWjpFoHW5599MwEHH2AMt7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMujg3wtOusTzDXf8SvP5S50c2HsD7aK60QJvPr4Tjk=;
 b=Aa8RVLs6k7sGT6BBZieBorfnjatxdF7IQ39DhHqv78sDG6rED2vW56xNPbKNZUdYvMJ0ApqtDIQVnAJBhtCg4+82793DZITDfdJShD+RkvyAwT48bc0Kv5PzIo8OZBuE7sr82Z7g6gJRqqi/UTo4r16+0CItims8oqWJ/K5pA1UBAEbZG6UKTziE5CEbyOSRn/dX4Pj48HaHAT4CvWspk9bK84vxfRsOXcGJx+LkVswL31WegQgnul7UIcXaSX7azaOtvvt6TW38gcoODnyp2DwXM8AGg0Obi5lhq6k9UNmT3rUGbQydZx/6kDxJp58Q0RIPYNE5ehOPK4nKg6cKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMujg3wtOusTzDXf8SvP5S50c2HsD7aK60QJvPr4Tjk=;
 b=fkQfqfqTmGHWsnHqZewXNDNWY25NHQYVMrwM33mL/3PFYunoHEV8V898yVpH88YM6/LBEyIKUdDGISOKI2abtWlHByGVrE++hzlsphNKCEkhmnNuqV738CfNONHea2w74gsEuKOFK5EV5pkHPjcq6kHb9Jui81McJPxOpR0PW6I=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4085.namprd12.prod.outlook.com (20.180.16.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 10:32:10 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 10:32:10 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 2/6] iio: imu: inv_mpu6050: add support of ICM20609 & ICM20689
Date:   Thu,  6 Feb 2020 11:31:01 +0100
Message-Id: <20200206103105.23666-3-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206103105.23666-1-jmaneyrol@invensense.com>
References: <20200206103105.23666-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::34) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 10:32:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29ab2fc4-0922-4b00-c147-08d7aaefd28a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4085D1BCCF034A9BAD9E4C08C41D0@CH2PR12MB4085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(366004)(136003)(376002)(199004)(189003)(478600001)(2616005)(956004)(86362001)(2906002)(26005)(5660300002)(186003)(16526019)(107886003)(6666004)(6486002)(1076003)(81156014)(8676002)(81166006)(4326008)(8936002)(36756003)(54906003)(52116002)(66476007)(316002)(66946007)(66556008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4085;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGLMcjwuNb1CG7HTVjr9eXvDEwDb0i4aXnPAwGH7lqGzj22OpKNfRH6yIZjg+D8MxjAEJG4ex13Cx2DCgHCRLXF3zguB/qrTvj9/Y1PcwsesX/XKVZQOy0zgcTKC6gfTZlf9FpIezeRDA3iPDwb+aW7N0VHmNamgkNMVNiwzxAQpBJghdOCYrtT8+O3uKZH8hN8vdCtMZtt2cf8Sk7mO3P5KGIzw1NPPVSivfzdTAUzr0zIIjKmjWapu75EdpyaZ93oQRB5fQEKRt5q+QH07G2rdigias0GWmfa+t1Jq7gcN1lUraEeLwja2ISbgAYohdSRU/h/3w3LeiQxId12YSV70SQWkdHgFXBVtyg76dH2BgVwPRXSHfYJdSMvZnDlriuWX3amEZWg2N53/mR+HR397zy/yQUodqE9PLIEJrmielpccA1OD5pDiF3QuGkjm
X-MS-Exchange-AntiSpam-MessageData: p46MDQ6hlbe7U3hIewk8qDmivf2Nl/kPzuN54mRmHsEwG0XG3yR26A5TBdsT0KWyZV/PHNXIsbyOmfTY2rjFdF/rUvc8X50SF/Ug2orp5SBBziCYlxaF+rFkOuiYSQlP7j2QuIkVxhBDMXdICXBKDg==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ab2fc4-0922-4b00-c147-08d7aaefd28a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 10:32:10.4032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjZ6D7K4YZbK38dEszx2l3ueyR2rjxit76ciDzX3iaY1bSqFzaaM+hIV+1+JGM7OecVePYZ+pgo6+Elz6iiBQHZcvGwFk49uyWksooCHl3E=
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
index 49e9aa777ba4..dd054e21216a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -61,6 +61,8 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
 
 	switch (st->chip_type) {
 	case INV_ICM20608:
+	case INV_ICM20609:
+	case INV_ICM20689:
 	case INV_ICM20602:
 		/* no i2c auxiliary bus on the chip */
 		return false;
@@ -202,6 +204,8 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"mpu9250", INV_MPU9250},
 	{"mpu9255", INV_MPU9255},
 	{"icm20608", INV_ICM20608},
+	{"icm20609", INV_ICM20609},
+	{"icm20689", INV_ICM20689},
 	{"icm20602", INV_ICM20602},
 	{}
 };
@@ -237,6 +241,14 @@ static const struct of_device_id inv_of_match[] = {
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
index 834bfa8e8684..3803c40e7b24 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -81,6 +81,8 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"mpu9250", INV_MPU9250},
 	{"mpu9255", INV_MPU9255},
 	{"icm20608", INV_ICM20608},
+	{"icm20609", INV_ICM20609},
+	{"icm20689", INV_ICM20689},
 	{"icm20602", INV_ICM20602},
 	{}
 };
@@ -112,6 +114,14 @@ static const struct of_device_id inv_of_match[] = {
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

