Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D722514275D
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 10:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgATJhF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 04:37:05 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:14180 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbgATJhE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 04:37:04 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K9Tq6T007127;
        Mon, 20 Jan 2020 01:37:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=q/wWUx6BfE9XfiWkGIu56PHDOTmVjW++RZg/ACURu1w=;
 b=hHTR+aWp91HioMFv/lBUj1nmRNM9wtjkL8vIMX0Bhk1l8OnEiljD3qyM6wi5APiy58wP
 7WI7nGpRAngKbVpzhX9uK/3Q+5o84b77pcYca2DUIpAFMmDNGlWF93in3v9Ivfp/r5ew
 48QoWHZxm5YNkeuCYg3pRGlOz+OcHGa2Op3E2b+3bng500vRIaYx7D7tK48xfNzkdYXf
 Pw/GQeK4+5FKKVwudquk/q28sfDw6vcgc0m+rlbNUXZLXpC1vd4uErcndh8D0hBiHvsL
 4IbGVisUJtsA50JPYxpWChrLDm1f9xguWGEaWq61QPjFOhlCG/rykJKHMFYa21g0nSx5 bg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00328301.pphosted.com with ESMTP id 2xm1gqrmt6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 01:37:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BORfg/oyjDzxOZ8eoPVjMBes1H1J94Yvcvmuc4S3L7BQYHhzJOXaADVspKMLoAkTHl6fYoBroXER02jpzUMUTAqTo5ZcnuDrbdz7z87Nsn2d7Efk2aKNQE2rRYAfh2tyqoLrBowsYKhP8BAesSBFVQS5WcIRH+SUZCIEbbj39j3ZHqv8/dgEpdmLG/zfc+1/dss50rsemsXKmDA+xi9BBjMmNPY4be3lVGsgH6jz7aW0saa58ZrJbd+Zu4rGE2K5xad/N/tBoDzc82GoAp0rwwjBqBSpzXq0XhdMu9L6ZYWOdyF4FwRhVVsp9PRrgIhQ9QS3Rl6NOs6KI8/BPR2sxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/wWUx6BfE9XfiWkGIu56PHDOTmVjW++RZg/ACURu1w=;
 b=SOU8ca6CJMOUtEk9+VAAPRrOvKFKMTmKTSgGmHSk3iBK3e5p9fm3HqJk3VMgpgrGMMU6DYfbE1jRCWQPRTNyWKT3jaQsgUdwnbeI+qoHkqbRKH46YqNORIbcWgwQ8mUuBpEgEszxskxff6Q3Em6VO6X6ErN3/y8rzEcH743AUKhbBZL1YuP3kUlQSjJWLp++zr7TqTKLSUgryt+qptbjrDyZ/sElZHx1HTDEPVvnRUHKvw/6W7yFwYlgObLLKKTSNM0FNrsPq5qrdVT3wH6Fry+BSTZy6+8GmSpcTkvNk26mJlQv0wyOZxinuZjkWy+RQR7pcy00251lTot312woOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/wWUx6BfE9XfiWkGIu56PHDOTmVjW++RZg/ACURu1w=;
 b=QjIUtftPZTIN6i3fpNWwRiLxLT0ZbUB0hc2nvmR1yZ0KOwOKuvh9HLXZB09flnO8FlrEBzDqxDuBXh4DQSTFYmyjqs+TdTlVkqAU0pucev0erY091aYf6G1wVYMUlKnmD+VGrYJ3v5WyVk2muQnfATvaDas/j8Jh4Qk0DGSQl8U=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB4048.namprd12.prod.outlook.com (52.135.49.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 09:36:58 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa%6]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 09:36:58 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 5/9] iio: imu: inv_mpu6050: add support of IAM20680
Date:   Mon, 20 Jan 2020 10:36:16 +0100
Message-Id: <20200120093620.9681-6-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120093620.9681-1-jmaneyrol@invensense.com>
References: <20200120093620.9681-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 09:36:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8e2a1be-b6ff-4ebf-6325-08d79d8c4b0a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB404852B1C51999CAF54FFF49C4320@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39840400004)(376002)(136003)(366004)(189003)(199004)(66946007)(66476007)(66556008)(7696005)(52116002)(86362001)(36756003)(107886003)(5660300002)(6666004)(2906002)(8676002)(81166006)(186003)(81156014)(54906003)(1076003)(8936002)(478600001)(4326008)(16526019)(316002)(956004)(2616005)(26005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4048;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkMpoJnPSvEeQnxfjFcEZiB6rBVv6UudwZzDBIyKOauqHlaKu+MJAPJFx+X8ABnj5f4XZU8vzvM2D2Z41sT+0wDbqnzVqli+elOr1JJVUR8/GicLtsvVCek/J0yHO+49ddI3ntTPEDxt6Rdc34amAIaDg7AhMeMi/ri3Nz5KsuS4XqroQbrub4Y48df6JfGhSTwa8BgPm0C4LcbnRZ2OOAT1FPlwuu3w/mBNnk1mCSLGfWOFc6dCNoe5B9m75An93rXiGh13Ro62faE4uIK8TlzuRAwcrtDwtiTUPoZ1yEoi1TlKoFhtilGY8UNzkCjeMRUtriCzQFYKoh9tRNkci8GvSM3obMxuUpM8raoMXyAUUybZCorj/ahlEoAr9gC9zZPMNKMC465fFfIGN1U7dnR9ZuH3Y8bG6H6tFwtBLWP/XMpgby2jJ6+jkxCqSuq6
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e2a1be-b6ff-4ebf-6325-08d79d8c4b0a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 09:36:58.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JnphokRMc3FK23cP05evDu2n7QJY9wgv3gm+OOPHN1PbJjMnnwIWNptjUKvm19p2r+A1hSk3h2Bs93jk3jNvRhOsAPFr5XKbQdqLf8EF0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_01:2020-01-16,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200083
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
index c2b5621edadb..66193786386c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -77,6 +77,7 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
 	case INV_ICM20609:
 	case INV_ICM20689:
 	case INV_ICM20602:
+	case INV_IAM20680:
 		/* no i2c auxiliary bus on the chip */
 		return false;
 	case INV_MPU9150:
@@ -223,6 +224,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"icm20609", INV_ICM20609},
 	{"icm20689", INV_ICM20689},
 	{"icm20602", INV_ICM20602},
+	{"iam20680", INV_IAM20680},
 	{}
 };
 
@@ -269,6 +271,10 @@ static const struct of_device_id inv_of_match[] = {
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
index 189df8bae7b4..e911e13edb86 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -81,6 +81,7 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"icm20609", INV_ICM20609},
 	{"icm20689", INV_ICM20689},
 	{"icm20602", INV_ICM20602},
+	{"iam20680", INV_IAM20680},
 	{}
 };
 
@@ -123,6 +124,10 @@ static const struct of_device_id inv_of_match[] = {
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

