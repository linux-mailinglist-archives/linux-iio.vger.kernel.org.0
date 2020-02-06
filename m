Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB76615424A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgBFKqE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:46:04 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:11966 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727806AbgBFKqD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 05:46:03 -0500
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016AWDf7004857;
        Thu, 6 Feb 2020 02:32:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=x0dtKWMKOs0kliJ5jJrcKtZrPyTzlkl2yeAs7Yxhwrc=;
 b=FFUxGfu1otRIUnhHW5xRfEQenozbO6wxExDwMt1bvb7GHA0xlUkWGl6W6WnWXz2KIDH0
 g8zhv/nnuB8XpeQ/kLqgL1qNlZGs/P/7+xCManHsKRiNngULdOeKmRbxxQ10p65qDPkQ
 tEF9A657BdOTbNTV9+8bE0FIf1jQGLLqCoIpxK7akdH5BEwzU8akf0IGMr0+q6183+QX
 xfF7acxfAA4x+cJESy3+2ylUlDe4lo+yMxs6+MvwMQlTw8MHH4cP1VDqplP5s/8e8Dp1
 tlJjXv9xeIVRvmi6zVrDzyiKlxkLd/VKw7MrvuV4zIVrQCNW30M8sneiq3MbsfbvUIq9 5Q== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0b-00328301.pphosted.com with ESMTP id 2y0e4sg2ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 02:32:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8oj4t7pxtadPQGKEq0qu+rEC8tB8G/jmexZcdYVEXBAjDUO6t14KT/bAA2JbJ8COP6TouMQEubPi2X8zrGZOg+K/IZr2U58iiFuxnHJUB7Fn+Vy1trKxvg+vjHme6B2DZkDl/l4SsWyTqAttVEcLzPCxxKEjKGoGCvsNza+QWirS/O8BTLnbKAtQhS2DljdYn3jiJSzm2jdodSefvhlrF6eypCQGMVYe/R3WPz5N/TzF3lAWrx5H49kDWzKe3EXFEZWT1EEgmnEoLRTrTwumPVEYOifBQ43VWCpzHtrs0Fg/P4GfdpB+eInp0vYbIisFZTUwKPcZZhc60RSY6ybFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0dtKWMKOs0kliJ5jJrcKtZrPyTzlkl2yeAs7Yxhwrc=;
 b=ZW+WdZ/mMdjZHlkYdZipNPcbCSJSgp6ljnlh6M3DHR1guG6bjAkDCQ+42+aPAZCa1qisauh0bISSsc4uA20ZEA+K9sIgd53zagWe92pg1L6C1kob2Ta39Hr3xZw0oEQCZvjvaxRDdn2DKmXyswIqfiqtG9mhjFgZyO6mYTYAda8F7ip+YQzraRqbMWqqH7ZeDHuCAyl+FPvH6MNXYiIQVntJEa+DaGbIqLCgeTBOMhh2Onr+mmlEkw/YyXfler26z7otWmzT6XZwQYwWsMO/aEbSwdOnwXPJMTapx9oCylqMWNA/QehIBpqapNmSw2lOxT4+ng3ENQNoh793MaKW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0dtKWMKOs0kliJ5jJrcKtZrPyTzlkl2yeAs7Yxhwrc=;
 b=SzqdV6JSaV8hXv6rYVfFvNdZxEtTKrtLVW5P8EgCNTuHx7iHkIe+fWrUqcV5YnaH0tnt/DhSwNpK2Z9O+m9LPwpEEBSbJlQ+N4+R6oVIab1OjkUSpEHR559AA4qGDMN70+hX2EKCUsRD4PhLfwsCxaBMzfHpAVo8CuESErVg+c4=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4085.namprd12.prod.outlook.com (20.180.16.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 10:32:11 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 10:32:11 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 3/6] iio: imu: inv_mpu6050: add support of IAM20680
Date:   Thu,  6 Feb 2020 11:31:02 +0100
Message-Id: <20200206103105.23666-4-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206103105.23666-1-jmaneyrol@invensense.com>
References: <20200206103105.23666-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::34) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 10:32:10 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7cf045b-9eb5-4f68-b469-08d7aaefd35e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40859AC93536FB07CF29A7FAC41D0@CH2PR12MB4085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(366004)(136003)(376002)(199004)(189003)(478600001)(2616005)(956004)(86362001)(2906002)(26005)(5660300002)(186003)(16526019)(107886003)(6666004)(6486002)(1076003)(81156014)(8676002)(81166006)(4326008)(8936002)(36756003)(54906003)(52116002)(66476007)(316002)(66946007)(66556008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4085;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uysBejAcXcFwreW/6h5JtrIonoe4DOrsAHmIZ3mgf0Cz3gOPQv91ItujUoVF26qDKlnMd7egH1Rht+/QZYLcKFTRa1u7VqXHNFQj87olkYgRINHmD4Gz0YuIZcy5eBbjq7CUPrtgrPlBFB+w2n2HUP331FNYwsfOGMT7yIMHqJjiwyG+omov2bAlI57qxgp/MG0W7X3hA4m+b9vX930fp8pNVZGj/D3HB7eCgSyjcC2MC6VP0YrMu0o34AWYq9UJSIYQFeQGsmiDT0/JT/KHBYCgExO3D64Petg0qhgkjB+fQthlVdGReOJychV6huYL2AGAERrMqXKYuIWbsSSNapEI3c7xRNOyutlaK1B8JFX/yQ6mrWyLuJSxj4L0xTKi8J0qrushWXNgzRosbwJP6+Hmjfl8WctrE3wN2jez5r466Po8rKZ1Y1yN1uOWdsKS
X-MS-Exchange-AntiSpam-MessageData: Mr6Aj2W8pv8Ko0VU/3YoxWhfLmFUwkD2EBOcZuW3V4A34SmpNpObrwb4rTmH7d3AcqIl2AfYyyoJ0Mfzij/pO950PtJ7CvDbwbW5+0aq1inS+P7huftm/GIIT3NSfUTWE4qr3GjaT7lT+9AsEbz5bw==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cf045b-9eb5-4f68-b469-08d7aaefd35e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 10:32:11.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syjBr5t/FFM1DatJ5I3FcghbsLoBXA40fd7o5RLYI2UvmhmzhAp3DEOLcBDLIi0DUVVrICkCe5dTS6iXBqkj8311nsTKaJGTifH4NVgjOWQ=
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

Automotive certified IMU, similar to ICM20608.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Kconfig        | 4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 8 ++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 6 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 5 +++++
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index e933db3a5a89..e65474a64675 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -16,7 +16,7 @@ config INV_MPU6050_I2C
 	select REGMAP_I2C
 	help
 	  This driver supports the Invensense MPU6050/9150,
-	  MPU6500/6515/9250/9255, ICM20608/20609/20689 and ICM20602
+	  MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM20602 and IAM20680
 	  motion tracking devices over I2C.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-i2c.
@@ -28,7 +28,7 @@ config INV_MPU6050_SPI
 	select REGMAP_SPI
 	help
 	  This driver supports the Invensense MPU6000,
-	  MPU6500/6515/9250/9255, ICM20608/20609/20689 and ICM20602
+	  MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM20602 and IAM20680
 	  motion tracking devices over SPI.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-spi.
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 5fd57a1bee90..e8e6beef3f04 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -200,6 +200,14 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.fifo_size = 1008,
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
 	},
+	{
+		.whoami = INV_IAM20680_WHOAMI_VALUE,
+		.name = "IAM20680",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6050,
+		.fifo_size = 512,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+	},
 };
 
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index dd054e21216a..cd0eeb5dc7f6 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -64,6 +64,7 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
 	case INV_ICM20609:
 	case INV_ICM20689:
 	case INV_ICM20602:
+	case INV_IAM20680:
 		/* no i2c auxiliary bus on the chip */
 		return false;
 	case INV_MPU9150:
@@ -207,6 +208,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"icm20609", INV_ICM20609},
 	{"icm20689", INV_ICM20689},
 	{"icm20602", INV_ICM20602},
+	{"iam20680", INV_IAM20680},
 	{}
 };
 
@@ -253,6 +255,10 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,icm20602",
 		.data = (void *)INV_ICM20602
 	},
+	{
+		.compatible = "invensense,iam20680",
+		.data = (void *)INV_IAM20680
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, inv_of_match);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 75b8903450eb..404c289f8c84 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -78,6 +78,7 @@ enum inv_devices {
 	INV_ICM20609,
 	INV_ICM20689,
 	INV_ICM20602,
+	INV_IAM20680,
 	INV_NUM_PARTS
 };
 
@@ -346,6 +347,7 @@ struct inv_mpu6050_state {
 #define INV_ICM20609_WHOAMI_VALUE		0xA6
 #define INV_ICM20689_WHOAMI_VALUE		0x98
 #define INV_ICM20602_WHOAMI_VALUE		0x12
+#define INV_IAM20680_WHOAMI_VALUE		0xA9
 
 /* scan element definition for generic MPU6xxx devices */
 enum inv_mpu6050_scan {
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 3803c40e7b24..393cec555be6 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -84,6 +84,7 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"icm20609", INV_ICM20609},
 	{"icm20689", INV_ICM20689},
 	{"icm20602", INV_ICM20602},
+	{"iam20680", INV_IAM20680},
 	{}
 };
 
@@ -126,6 +127,10 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,icm20602",
 		.data = (void *)INV_ICM20602
 	},
+	{
+		.compatible = "invensense,iam20680",
+		.data = (void *)INV_IAM20680
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, inv_of_match);
-- 
2.17.1

