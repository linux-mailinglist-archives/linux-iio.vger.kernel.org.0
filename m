Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39AFFDF9F
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 15:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfKOOGq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 09:06:46 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:3600 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727571AbfKOOGq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 09:06:46 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFDu4Di010259;
        Fri, 15 Nov 2019 06:06:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=GAX3uUaY3a39bOO5q91jzeVNeYLdM7fgvb9wYKt8urI=;
 b=uBKlIF69YNfrzRO5LbVDO5oTBmXKXjAjjPkaLte06irljD7CgdRr99EqZkLMq/YHSNTb
 +WxRZoAfLfUH3F9gQczpIIrn3K2AN4JL02kZlcW1h55154wij+7uZUG8WboJ7flQ2db3
 w4GTUNOp65qxI8dYdEVEq/n/QPFbclzM27aBNe//91pJPZjO8Cuq3DPwmoEjW0vKfnWJ
 pKqtNgK5/f9KmXnkYNJ28Ej3mRabg6U0JzDV+ykVIlOoZhz1awwVZuC8CHz48Uo9rRTV
 15pmWSyDxvHTjyckFb7AeJVMzDX1S0LPHnWmyakwlmwoyKgV43D0inRQKuvZ9RmglMBR Qg== 
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2053.outbound.protection.outlook.com [104.47.49.53])
        by mx0a-00328301.pphosted.com with ESMTP id 2w8x598wae-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 06:06:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZB+DcO+R99jwZwtw5QWOH0xN/jyDn7h6Q0RebXHXtHEmW+pRAB0iR1ody7XU5CIbX/SlS8OdZw2Sv9AFFasZ532E76AXD75W94qjgf7VU3CNv/JfP/sEnY3rk5pfXkG0kxNVmNrPDJUIJb1rKvayywShyJRWJNT0Fz4j4F0Oy6pG7yDpvJh0Aa562HhI8E5RoA065iLiWYQcf3ZWN7MZ1xP9MoBKnb146GJ2MAAIQYZxNHOC6TmRw1P7KY01dyrZQEZZO6XDK40fHvIoehSr8ZBOS79G6vrOkreNeXiWh/vapEQCUmblHJSHLyeg0EwZ9aaHVc5QJ1zrKu8xfBzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAX3uUaY3a39bOO5q91jzeVNeYLdM7fgvb9wYKt8urI=;
 b=XKLwYUfX1S17fbDRSRzuY00swggtKk/NWGic4malvLPZdmyG+wcltjZFHe6u37s2TezR6VrZRjX3aNrTSDcU/yzTbzA+8L0AdFIZAwjjY8GyZgB67yUa7JnZG/723vf5n2HpIJGu+QEB4POf+NCDlICRnoxFKmnXy7wtZuzYJOobX31PwP1CDvN38cjrvbhKzK+EO+uD9a3UtDXTNMlaGV5Fsq88b2QcPw3b74lUZtIcmi4JZvOEsXsse8o1JiFYxlfhXJQit3yO6kjhyD01ZErI0qC9fz2W3EIvIqaoaOEzkAXY/rVqtu9dfrk6f+xvjJrOg2a194IAXqW/JX+n5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAX3uUaY3a39bOO5q91jzeVNeYLdM7fgvb9wYKt8urI=;
 b=RV722azJ6J2NgBYfTTrK1RfIDBAcBSFJMMl6FBjjZpHtyUFAONzmsDfnc+Sw7nHZk6hsWh1saEJJGXiS0y9PQI4/62V/cVUnkAwQFfDFczw7S/gjbRmPNmFi1GN3pyQ80eiQk/AqigvINGpO2hBxQO6H3Bla/kDqmqepzeiV9gw=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB4126.namprd12.prod.outlook.com (10.255.125.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 14:06:42 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3%3]) with mapi id 15.20.2451.029; Fri, 15 Nov 2019
 14:06:42 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 1/2] iio: imu: inv_mpu6050: delete not existing MPU9150 spi support
Date:   Fri, 15 Nov 2019 15:06:21 +0100
Message-Id: <20191115140622.6429-2-jmaneyrol@invensense.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7b7f4daf-d51b-40d8-e359-08d769d50a4c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4126F1D58CD76E5B6E106441C4700@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39850400004)(376002)(366004)(189003)(199004)(8936002)(6916009)(186003)(99286004)(7736002)(6506007)(478600001)(486006)(16586007)(25786009)(11346002)(36756003)(386003)(2616005)(476003)(14454004)(26005)(6436002)(80792005)(48376002)(305945005)(4326008)(50466002)(2351001)(14444005)(47776003)(66066001)(2361001)(2906002)(66556008)(50226002)(66476007)(66946007)(86362001)(81156014)(107886003)(81166006)(6666004)(5660300002)(6486002)(8676002)(446003)(52116002)(51416003)(316002)(76176011)(6116002)(3846002)(1076003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4126;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6IxluiYOukJ0Kdz7jekFfpKPFUij9XhrgJgXR2suK25yIx0D0zRtr8l+qQFrekNG2lNc/JWw3r6eUR3xvvNtSqQAGrSHz2eQxnOhc2XuC52YR8Iec4NdWifWCaMEKbYs18Oj1aLEBF5E85bDUG5ZUMXN6N0Exvxi859fZrxd4FiQA+zDUngNFSgoVKnign4ZIrq6rp0ImODFts/VCQ/C6sg5TtfndH0cL598PD4Qv/lMEmqsOIBDGKVvR+cEMATjp+aaJuJOrb5fn5hQ+ACeDecE0UlfSkXvugM5aI+ya7aPbA/VTyywY55FxBWIviS/J0Kcu9H/8sRFlqm2u7+WrM53MrQaTnOEV3LcsfS8aucrAS8N3qQH7TPIkmYmdA2nJSZ9vID08z8Kxm0XvZlOF9wvBjfN0WLeYNlpu+Tv/1EGyF2HWYQBObP+BBHrZQT
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7f4daf-d51b-40d8-e359-08d769d50a4c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 14:06:42.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FqvJ/M+qnyEUOcDjRIZZzV48MjnqesN6w+GLYHYalntBjLt5A4qHr2hJ9rhtFlFDXt9LO1TPbUg+L3XemunIySsemPgX8bp8iXvmTdzUY0=
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

MPU9150 is i2c only.
Update Kconfig to delete in description chips that are i2c or
spi only.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Kconfig       | 6 +++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index e4c4c12236a7..963a0cafe0cb 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -14,7 +14,7 @@ config INV_MPU6050_I2C
 	select INV_MPU6050_IIO
 	select REGMAP_I2C
 	help
-	  This driver supports the Invensense MPU6000/6050/6500/6515,
+	  This driver supports the Invensense MPU6050/6500/6515,
 	  MPU9150/9250/9255 and ICM20608/20602 motion tracking devices
 	  over I2C.
 	  This driver can be built as a module. The module will be called
@@ -26,8 +26,8 @@ config INV_MPU6050_SPI
 	select INV_MPU6050_IIO
 	select REGMAP_SPI
 	help
-	  This driver supports the Invensense MPU6000/6050/6500/6515,
-	  MPU9150/9250/9255 and ICM20608/20602 motion tracking devices
+	  This driver supports the Invensense MPU6000/6500/6515,
+	  MPU9250/9255 and ICM20608/20602 motion tracking devices
 	  over SPI.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-spi.
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 142692fc0758..ec102d5a5c77 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -74,7 +74,6 @@ static int inv_mpu_probe(struct spi_device *spi)
 static const struct spi_device_id inv_mpu_id[] = {
 	{"mpu6000", INV_MPU6000},
 	{"mpu6500", INV_MPU6500},
-	{"mpu9150", INV_MPU9150},
 	{"mpu9250", INV_MPU9250},
 	{"mpu9255", INV_MPU9255},
 	{"icm20608", INV_ICM20608},
-- 
2.17.1

