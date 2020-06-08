Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B12A1F20EE
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 22:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgFHUoM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 16:44:12 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:14402 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgFHUoG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 16:44:06 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KdBDL019703;
        Mon, 8 Jun 2020 13:44:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=QBf2HMHj1/eKnonntrdhRRALP8UmjKyNHNknL468b6U=;
 b=QWIArn4+F/ax+zVVDfGbrm3wqfXTLp4Ey9H3Lr3kf74cTB7uGmUiW5MxPW828z6UAh7u
 heavhAu1prAtrfEPtybB7ZghaEAqpjFSwJIbHu5tFlb6A4bCVuG0B3m50FfMfyAER6LC
 qRoaFhSTvykUX2KvmywGZ0qBpqMWHL7yh3KGOT9tZGmxPPj0qHyUPa6l4bgTdrsT+PPQ
 X3wxgV48w9mQNFBfwZczybcVk1j9Djmd9pYl8eJQL1ZIF44H2c5Oi8abbla/kaRNeTv+
 +aWtJdWAX0N3KnL7Wymen4PxWTSSUexUCkmXkF61LDg/Z9+A1eCNz5kYhxZSmFE1HA/b uQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-00328301.pphosted.com with ESMTP id 31g8cf0xvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 13:44:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex+uCl6Nk5xks7YZdkeUbHVn0+0O/tId1TDtKd6iu2BFiPDe1MxcE7vf/xu43bkeLjEhoz9dyBLnwWky91IZeVsRNS4gWAEKD0w5Ipm1F2BVvq7a20GcYHc5UJvOZ9JzzB2AJ+onVISyqvhw+iUGLWrZ7b9yzGM9tSko7YwgkgGFTCKr1AqBjSn+jgCxMYLBzd0FroWgIPLhN0tsRQ2QsJ1KR18Bd/rJxg38Jzl38A8AKfG1Yr0gQcy5+cduISnlCgcKQSLer/RxbBrZQ+7VxyPm+ud1H3zx2ADhGSGuaMNWcbJcYh5qnb4IndfhVTXA+1xe12Cel1MTW/BhNsuNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBf2HMHj1/eKnonntrdhRRALP8UmjKyNHNknL468b6U=;
 b=jtDcvc9EgbOmnyn/0wIImrRFSxtUbKgykHT4+ktI78tOkHQeS/eRcro8TrYeXMZSXeHtnHr/JE8sQxLBRHuZWoYsi29X6Inw56ZV4MimB2j3/8u0pRKSkIUsRRudg6JByd2ktFFiIzIZZBbTcMCmn2jfsGfsJKg5LtVfGK73xge5ABZmJhaPqLcYhSeVGqECq2OQHDtyEX5w7q8rswIfYLBmgH4UTCZ/SjLRP9LfGwNdphOiEhhjQOJ+hL+H4LKeGVq3aHj+KA5/4wXpUJ1kjMck/6LxZCwKeFvv7mO5A7wees1Wwi8WJam87kQTjbRc+AOaZYT5Kj7CQjQTqlOXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBf2HMHj1/eKnonntrdhRRALP8UmjKyNHNknL468b6U=;
 b=UDO/mHMzn0SL3AWKvuuoGpHGWSVXzwIW2SvyIy1XziQPYEqYb2pSgn9D3+FgkQNStJ01D3NnSmHdT8SB8GEooDjSAnlqbnr/UYAHRipFP1FG+gmX3xE66tj+LBRQOsWvT/BuSDfHOydNe7+rw8LKyD5xJEXopho9gS2IECNro7o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 20:44:00 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:44:00 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 07/13] iio: imu: add Kconfig and Makefile for inv_icm42600 driver
Date:   Mon,  8 Jun 2020 22:42:44 +0200
Message-Id: <20200608204250.3291-8-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608204250.3291-1-jmaneyrol@invensense.com>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 20:43:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7234ed2-1b0a-419e-3468-08d80becac07
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB395134161E2B292F0D74CF2FC4850@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: laheXfOWDvF5TJhDVWi6GXgNkXxb3AHMQIYNxjY/91Ccf56xGq7m3J8kb+E+Vbcae1yhhQHn5gT7ii/GQGVl6yEdQ+XAETx7sBqE75fVOGNQm7eCQvAk7hZ2Pk6PORYFvc3RBixns/YQUn6OC3l/8Gp2peAAAcpKDMquL1NZCO1mfQXMQ0gluJgFIbY+tFyGllunvcO7fuJBPil07DqQVcJ/1NNLgBWuRiUbxeDEBOwGwHMf0x7DFYyTa+yV0mv/uUfHca5Y/d4xsh3mP0fcNjcGIhYMXkpkVWIWaF7duDiX2HjZlbl1N3Q78zHdQNeY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(346002)(396003)(136003)(366004)(66556008)(66476007)(66946007)(6666004)(36756003)(86362001)(5660300002)(1076003)(6486002)(4326008)(956004)(2616005)(8936002)(2906002)(107886003)(8676002)(7696005)(16526019)(186003)(478600001)(52116002)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ieqOuyacSKTYgby3JS/SsIKc2SPsj41ki9NXrHlWGFsw0Dun5R3YTHRZj9LbaShrZ1+3FMDMSv6O+36PeRBj0V1tnoAvGqxY6gfp8mBxn3Dn1tPrOzT9kBcLqYZIeX+UFCuX/P7E6Cr6zLejIYq5W+8fOHLivtwVAx1wHqAZlVpKy2o6ynQQHuWSXNx+q5nm02UOjlIXsO4IgA8DZKlTE1kpZhDwgAh+pMeqgiTKBth6aayiUXSDPhxK46IX7d2IWk2rze6zkiuDNHDPKBtk1jfk1X04bZ/FU+QMqBo6j4xLmh1mazstg+fE+mjdYhYPLx/OMLRMwtTy4jBVnd0RjISk5U/5WRivLi9cXhvw9ti5uHnW58bpxjbHJ5ih1bY1krX9/8fkk53qy0xmuBoRxahvLqXxEFuPB02ZuE9W7CA4WGlVzwz9o7wa6xb46i/zOkdSkoYRKm/2QppBYzKmne/Vqd8Ffz37FVq/2KAdlKI=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7234ed2-1b0a-419e-3468-08d80becac07
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:44:00.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUgNtNAZkDo2lJt0kXSp3INbKWrrssmgBdy4u5e0L2wVNfAZRILjGnsMg+2pTNauFHYabt0NrynrVDSQDtxE78jFXA87rYn5XDLZF49U0KU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 cotscore=-2147483648 mlxlogscore=893
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080144
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add 3 modules: inv-icm42600, inv-icm42600-i2c, inv-icm42600-spi.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/Kconfig               |  1 +
 drivers/iio/imu/Makefile              |  1 +
 drivers/iio/imu/inv_icm42600/Kconfig  | 28 +++++++++++++++++++++++++++
 drivers/iio/imu/inv_icm42600/Makefile | 13 +++++++++++++
 4 files changed, 43 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42600/Kconfig
 create mode 100644 drivers/iio/imu/inv_icm42600/Makefile

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index fc4123d518bc..f02883b08480 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -91,6 +91,7 @@ config KMX61
 	  To compile this driver as module, choose M here: the module will
 	  be called kmx61.
 
+source "drivers/iio/imu/inv_icm42600/Kconfig"
 source "drivers/iio/imu/inv_mpu6050/Kconfig"
 source "drivers/iio/imu/st_lsm6dsx/Kconfig"
 
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index 88b2c4555230..13e9ff442b11 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_FXOS8700) += fxos8700_core.o
 obj-$(CONFIG_FXOS8700_I2C) += fxos8700_i2c.o
 obj-$(CONFIG_FXOS8700_SPI) += fxos8700_spi.o
 
+obj-y += inv_icm42600/
 obj-y += inv_mpu6050/
 
 obj-$(CONFIG_KMX61) += kmx61.o
diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv_icm42600/Kconfig
new file mode 100644
index 000000000000..22390a72f0a3
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config INV_ICM42600
+	tristate
+
+config INV_ICM42600_I2C
+	tristate "InvenSense ICM-426xx I2C driver"
+	depends on I2C
+	select INV_ICM42600
+	select REGMAP_I2C
+	help
+	  This driver supports the InvenSense ICM-426xx motion tracking
+	  devices over I2C.
+
+	  This driver can be built as a module. The module will be called
+	  inv-icm42600-i2c.
+
+config INV_ICM42600_SPI
+	tristate "InvenSense ICM-426xx SPI driver"
+	depends on SPI_MASTER
+	select INV_ICM42600
+	select REGMAP_SPI
+	help
+	  This driver supports the InvenSense ICM-426xx motion tracking
+	  devices over SPI.
+
+	  This driver can be built as a module. The module will be called
+	  inv-icm42600-spi.
diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_icm42600/Makefile
new file mode 100644
index 000000000000..48965824f00c
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-$(CONFIG_INV_ICM42600) += inv-icm42600.o
+inv-icm42600-y += inv_icm42600_core.o
+inv-icm42600-y += inv_icm42600_gyro.o
+inv-icm42600-y += inv_icm42600_accel.o
+inv-icm42600-y += inv_icm42600_temp.o
+
+obj-$(CONFIG_INV_ICM42600_I2C) += inv-icm42600-i2c.o
+inv-icm42600-i2c-y += inv_icm42600_i2c.o
+
+obj-$(CONFIG_INV_ICM42600_SPI) += inv-icm42600-spi.o
+inv-icm42600-spi-y += inv_icm42600_spi.o
-- 
2.17.1

