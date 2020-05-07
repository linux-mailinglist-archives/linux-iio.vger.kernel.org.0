Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BACE1C9068
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgEGOnW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 10:43:22 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:22320 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbgEGOnV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2020 10:43:21 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047EbhbW006057;
        Thu, 7 May 2020 07:43:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=UgS9409OZ7jcsrOpUf1U/Wt1Y50MnDXXPDLeOEz14qE=;
 b=WZSpN8vSamnu76c6jvcyil5daJQibX+MeQkv3z8kV3am0tZ3Lf91P9VA8ObwaBiMEQv8
 t/A0YcTK/oSHWI+rDdFZamZe/KIC92NErqs//8QylC4wgb2gsvwXDLzaLZKZp2jzeS+N
 gWFLi1+7JYW+5qcjUTrngKwx5b8s0vl85j27YqtLiDPjMbAR2/F94i/GtbZhIkHMZ8ao
 +ZJZYwLwL/CHHr0PxqWzqLFhF6C0/nS1KfaBJB7ksiLPOL/RJrraWxs4Id9Rr/st8Sz6
 1UzaJ2dScSRBh3tmhfVZtW9d/zML3XKkz1yGKdVarWzljY0rRaVTzLeYTeom+t9GNuOW Pw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0b-00328301.pphosted.com with ESMTP id 30s4tnatwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 07:43:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5GOEEv8EHPBF/oGbRFPkgs7MjVBtwSiR+azfOfRTvp6nbLfBswym3MVgKohvBxwmOLhbwM8etBMmFVBU0vRL6tuQkgUvi4BpxTIgsUEks4aMKlcP2e7h3JjMQCq1gGTutCw+QURTk6NgG9o0ZAg+upSkCsnnU8OY9vUM7lFognKe379BnyFSCSpQYLiR6d7nNcbgmdWjnezwtp/3MGpm7HwZeh6DRUnoKZW0a7DpER+SXfmXSeM6mXq6E+ARg2fDMDMvxp6WQSF4cQklxRdwHznkj+QspQYKAap4y0CfoLYBuPWRf8vtlkiw9NUzXDgrHHOCD271zfhrWlUQS9o3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgS9409OZ7jcsrOpUf1U/Wt1Y50MnDXXPDLeOEz14qE=;
 b=bYh+1EGIEH61SJPoma/OK+Uy21hU3FZSjVSePPavGay/4mCz5ziq0Azq5eo+Cjvp1qmKU+KkKKDhDXUsg0EQufyodeQZcKtjSkWoMCxMuPpaW77DpgM4JTbj7CMnY+zc6GX8Y3SLFaMhWa/px4JQK5ouM8J1qlSvjBwx+LxbkkICNIQ0i24Oej9f7yrgyYgpJn7jFjrA1vihK4WsCOOxFthnSkt8xEfuZm8M2zRIoRfAp+ooeoMGpX8xe0RaIUS6MCyl5VycnWfSfV/G5sNW0CZ/Zc/YxI8dSf9crtPlscIZags1t1L/20P32bGFYSNYIgK9Zi6rhtkta7oQFT8nvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgS9409OZ7jcsrOpUf1U/Wt1Y50MnDXXPDLeOEz14qE=;
 b=EZjefep+9ltCeQr4LMON9ItqkhCUxZvTu9qd5UwvViRqFDPROsjUroTORCR7kNSjcBjmw6CKd5Nq8+c/be592PvzG6pUKeT1UFqelj6ZJGXvKJQQD7vOLjYDsvpg0N3kTbUG7D9DMljbxVXZbigkKB/JWoTZCi/WbkzCKpNkW6w=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 14:43:07 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 14:43:07 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 01/12] iio: imu: inv_icm42600: add core of new inv_icm42600 driver
Date:   Thu,  7 May 2020 16:42:11 +0200
Message-Id: <20200507144222.20989-2-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507144222.20989-1-jmaneyrol@invensense.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 14:43:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c9c07fa-7c95-46b3-e710-08d7f294f4b1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42695F1B48D46F0CCE115679C4A50@MN2PR12MB4269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjOwBsOnNhwIv1/j44yYpcqKCgHFs7Cbsox1VNJVPUuqpaw6XwdWTvX63nV4E0i10kSLHtbTQkJm4P+QxRpP1dEqzGbezDZELU4mGQfFLXz7XSJ+Yhf1yPtDv9HHqqWPPO1+14N0Wb/jAgUQfw6B46BN6BZARxl4FLnREwX50Pgfd1YS2sRdz36Dsn5QVPR0OUrldTy0u48t4dueXV2OtHGwNzlqZUb6wKK/bSY05zB45VBBC6DvlAh6oXaw0yTiz/o9ozDszBJgjc7Btqs/HwItxSINc9D8Nh8XgAWyXAk0TnTyj8/dPbBn4o+zVkwBUkWdsXZJt8YTnOCj0lktP1Ql7Ef9eUVu8GI1qlKwxciwmeQv3r9/W0EbqL4F0tpAO6nTfkZvUZgjqIV+3P2HPEP89JBGZvUWlv8UnLAskb/VaLGYj4BQGgTPRf/Zf2JwQrnBZcjmToVLoFttL74+HwKU48MEP1xuE8MPBERMMJz7z9VWya5fnFbgDGYsMLlFpNnrylgQm3K+SmUt1q34dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(136003)(366004)(39850400004)(376002)(33430700001)(186003)(6486002)(478600001)(16526019)(5660300002)(4326008)(33440700001)(30864003)(66556008)(8676002)(1076003)(36756003)(316002)(66946007)(66476007)(6666004)(52116002)(8936002)(86362001)(2616005)(83280400001)(956004)(83320400001)(83290400001)(83310400001)(26005)(2906002)(7696005)(83300400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ujYys01TYH18auPkkP6wsgT0ptgw99vTBsnHwnYEKYMKFAv70X7A8A/U0zc/xxy7dbi/9keiMxpuLmyUn8kNg/y+iLp0N6N7qI9PPk0AD1Dagf23QSxJ8YN/yLzAPi6ejRievtB9z3CmIvWwGI9OoVm18ooXO/YXZHc/MyaEhNJyTw3bTybpMOjk6N2cYq6ed5dhQyN7K9I3MZTUbEtKOSmxgBQjfWEnkhF9EL8kdgcmbn4dXt6FQBxiG6gISYWSexO21PjPbnoqTfAf5ys1tTIiO7d6yW5svkjwSUtAQRPKR2n9pGRwQ0MiVWb4GmC9IERMmg+Or4egjCLZN7VwwrCKCawkuu3AivThNK7oG8VEw6zcmY9PMGLIxNFh/PR/JfuAuYoUgOSWRLvKfE7VbhMVHy3vZ1GBClmf39pnDY991fIEKW49RPNn9U45JqsdU/dpSsMeLJNJHZr6+3SZelroxRxp1Qe0t9YrpuiGJ0uoflhAZXt6teYdyMaOkEzz0ey4Mn22WksI8ay2rlz1YPauk1r0Vmdq6B67LFZ+w4XWdoInv6blfEW69IxE+l9Ia2prCLF2qUEuIblS0aEHh39vIlx8H9+IU4JI8OuiDFbeuQZ7+KnZJyYkYdodLGw+ngFXnb1RrsXKjrw4EAV/rJSYXHNs+Z9vAZIeMbRaFsMVe4jidc6HP9f8nxbIqs7xHn8pZ3DAEY0pWic1Y3FxT1iSjSSHO/G0r1RgieQjb7k2H1BQ5TvxXB5i5+rnUOk2s1zPoUcXGlkv+lGHdgIF9vIbf1ylWRS7xahLmVMD8+I=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9c07fa-7c95-46b3-e710-08d7f294f4b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 14:43:07.5583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00xaBwL4GtppzIAcCT64jsxp2Y48gvpgEOSoYF7MDtmQOnmD3M0JRI92EEr1nccI2b8aQbvsp7eEz/6+3FdTqa9PIeGkhAQ2UvSiUYkT1+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_09:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Core component of a new driver for InvenSense ICM-426xx devices.
It includes registers definition, main probe/setup, and device
utility functions.

ICM-426xx devices are latest generation of 6-axis IMU,
gyroscope+accelerometer and temperature sensor. This device
includes a 2K FIFO, supports I2C/I3C/SPI, and provides
intelligent motion features like pedometer, tilt detection,
and tap detection.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   | 372 +++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 618 ++++++++++++++++++
 2 files changed, 990 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600.h
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
new file mode 100644
index 000000000000..8da4c8249aed
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -0,0 +1,372 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#ifndef INV_ICM42600_H_
+#define INV_ICM42600_H_
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/regmap.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pm.h>
+#include <linux/iio/iio.h>
+
+enum inv_icm42600_chip {
+	INV_CHIP_ICM42600,
+	INV_CHIP_ICM42602,
+	INV_CHIP_ICM42605,
+	INV_CHIP_ICM42622,
+	INV_CHIP_NB,
+};
+
+/* serial bus slew rates */
+enum inv_icm42600_slew_rate {
+	INV_ICM42600_SLEW_RATE_20_60NS,
+	INV_ICM42600_SLEW_RATE_12_36NS,
+	INV_ICM42600_SLEW_RATE_6_18NS,
+	INV_ICM42600_SLEW_RATE_4_12NS,
+	INV_ICM42600_SLEW_RATE_2_6NS,
+	INV_ICM42600_SLEW_RATE_INF_2NS,
+};
+
+enum inv_icm42600_sensor_mode {
+	INV_ICM42600_SENSOR_MODE_OFF,
+	INV_ICM42600_SENSOR_MODE_STANDBY,
+	INV_ICM42600_SENSOR_MODE_LOW_POWER,
+	INV_ICM42600_SENSOR_MODE_LOW_NOISE,
+	INV_ICM42600_SENSOR_MODE_NB,
+};
+
+/* gyroscope fullscale values */
+enum inv_icm42600_gyro_fs {
+	INV_ICM42600_GYRO_FS_2000DPS,
+	INV_ICM42600_GYRO_FS_1000DPS,
+	INV_ICM42600_GYRO_FS_500DPS,
+	INV_ICM42600_GYRO_FS_250DPS,
+	INV_ICM42600_GYRO_FS_125DPS,
+	INV_ICM42600_GYRO_FS_62_5DPS,
+	INV_ICM42600_GYRO_FS_31_25DPS,
+	INV_ICM42600_GYRO_FS_15_625DPS,
+	INV_ICM42600_GYRO_FS_NB,
+};
+
+/* accelerometer fullscale values */
+enum inv_icm42600_accel_fs {
+	INV_ICM42600_ACCEL_FS_16G,
+	INV_ICM42600_ACCEL_FS_8G,
+	INV_ICM42600_ACCEL_FS_4G,
+	INV_ICM42600_ACCEL_FS_2G,
+	INV_ICM42600_ACCEL_FS_NB,
+};
+
+/* ODR suffixed by LN or LP are Low-Noise or Low-Power mode only */
+enum inv_icm42600_odr {
+	INV_ICM42600_ODR_8KHZ_LN = 3,
+	INV_ICM42600_ODR_4KHZ_LN,
+	INV_ICM42600_ODR_2KHZ_LN,
+	INV_ICM42600_ODR_1KHZ_LN,
+	INV_ICM42600_ODR_200HZ,
+	INV_ICM42600_ODR_100HZ,
+	INV_ICM42600_ODR_50HZ,
+	INV_ICM42600_ODR_25HZ,
+	INV_ICM42600_ODR_12_5HZ,
+	INV_ICM42600_ODR_6_25HZ_LP,
+	INV_ICM42600_ODR_3_125HZ_LP,
+	INV_ICM42600_ODR_1_5625HZ_LP,
+	INV_ICM42600_ODR_500HZ,
+	INV_ICM42600_ODR_NB,
+};
+
+enum inv_icm42600_filter {
+	/* Low-Noise mode sensor data filter (3rd order filter by default) */
+	INV_ICM42600_FILTER_BW_ODR_DIV_2,
+
+	/* Low-Power mode sensor data filter (averaging) */
+	INV_ICM42600_FILTER_AVG_1X = 1,
+	INV_ICM42600_FILTER_AVG_16X = 6,
+};
+
+struct inv_icm42600_sensor_conf {
+	int mode;
+	int fs;
+	int odr;
+	int filter;
+};
+#define INV_ICM42600_SENSOR_CONF_INIT		{-1, -1, -1, -1}
+
+struct inv_icm42600_conf {
+	struct inv_icm42600_sensor_conf gyro;
+	struct inv_icm42600_sensor_conf accel;
+	bool temp_en;
+};
+
+struct inv_icm42600_suspended {
+	enum inv_icm42600_sensor_mode gyro;
+	enum inv_icm42600_sensor_mode accel;
+	bool temp;
+};
+
+/*
+ *  struct inv_icm42600_state - driver state variables
+ *  @lock:		chip access lock.
+ *  @chip:		chip identifier.
+ *  @name:		chip name.
+ *  @map:		regmap pointer.
+ *  @vdd_supply:	VDD voltage regulator for the chip.
+ *  @vddio_supply:	I/O voltage regulator for the chip.
+ *  @orientation:	sensor chip orientation relative to main hardware.
+ *  @conf:		chip sensors configurations.
+ *  @suspended:		suspended sensors configuration.
+ */
+struct inv_icm42600_state {
+	struct mutex lock;
+	enum inv_icm42600_chip chip;
+	const char *name;
+	struct regmap *map;
+	struct regulator *vdd_supply;
+	struct regulator *vddio_supply;
+	struct iio_mount_matrix orientation;
+	struct inv_icm42600_conf conf;
+	struct inv_icm42600_suspended suspended;
+};
+
+/* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
+
+/* Bank selection register, available in all banks */
+#define INV_ICM42600_REG_BANK_SEL			0x76
+#define INV_ICM42600_BANK_SEL_MASK			GENMASK(2, 0)
+
+/* User bank 0 (MSB 0x00) */
+#define INV_ICM42600_REG_DEVICE_CONFIG			0x0011
+#define INV_ICM42600_DEVICE_CONFIG_SOFT_RESET		BIT(0)
+
+#define INV_ICM42600_REG_DRIVE_CONFIG			0x0013
+#define INV_ICM42600_DRIVE_CONFIG_I2C_MASK		GENMASK(5, 3)
+#define INV_ICM42600_DRIVE_CONFIG_I2C(_rate)		\
+		FIELD_PREP(INV_ICM42600_DRIVE_CONFIG_I2C_MASK, (_rate))
+#define INV_ICM42600_DRIVE_CONFIG_SPI_MASK		GENMASK(2, 0)
+#define INV_ICM42600_DRIVE_CONFIG_SPI(_rate)		\
+		FIELD_PREP(INV_ICM42600_DRIVE_CONFIG_SPI_MASK, (_rate))
+
+#define INV_ICM42600_REG_INT_CONFIG			0x0014
+#define INV_ICM42600_INT_CONFIG_INT2_LATCHED		BIT(5)
+#define INV_ICM42600_INT_CONFIG_INT2_PUSH_PULL		BIT(4)
+#define INV_ICM42600_INT_CONFIG_INT2_ACTIVE_HIGH	BIT(3)
+#define INV_ICM42600_INT_CONFIG_INT2_ACTIVE_LOW		0x00
+#define INV_ICM42600_INT_CONFIG_INT1_LATCHED		BIT(2)
+#define INV_ICM42600_INT_CONFIG_INT1_PUSH_PULL		BIT(1)
+#define INV_ICM42600_INT_CONFIG_INT1_ACTIVE_HIGH	BIT(0)
+#define INV_ICM42600_INT_CONFIG_INT1_ACTIVE_LOW		0x00
+
+#define INV_ICM42600_REG_FIFO_CONFIG			0x0016
+#define INV_ICM42600_FIFO_CONFIG_MASK			GENMASK(7, 6)
+#define INV_ICM42600_FIFO_CONFIG_BYPASS			\
+		FIELD_PREP(INV_ICM42600_FIFO_CONFIG_MASK, 0)
+#define INV_ICM42600_FIFO_CONFIG_STREAM			\
+		FIELD_PREP(INV_ICM42600_FIFO_CONFIG_MASK, 1)
+#define INV_ICM42600_FIFO_CONFIG_STOP_ON_FULL		\
+		FIELD_PREP(INV_ICM42600_FIFO_CONFIG_MASK, 2)
+
+/* all sensor data are 16 bits (2 registers wide) in big-endian */
+#define INV_ICM42600_REG_TEMP_DATA			0x001D
+#define INV_ICM42600_REG_ACCEL_DATA_X			0x001F
+#define INV_ICM42600_REG_ACCEL_DATA_Y			0x0021
+#define INV_ICM42600_REG_ACCEL_DATA_Z			0x0023
+#define INV_ICM42600_REG_GYRO_DATA_X			0x0025
+#define INV_ICM42600_REG_GYRO_DATA_Y			0x0027
+#define INV_ICM42600_REG_GYRO_DATA_Z			0x0029
+#define INV_ICM42600_DATA_INVALID			-32768
+
+#define INV_ICM42600_REG_INT_STATUS			0x002D
+#define INV_ICM42600_INT_STATUS_UI_FSYNC		BIT(6)
+#define INV_ICM42600_INT_STATUS_PLL_RDY			BIT(5)
+#define INV_ICM42600_INT_STATUS_RESET_DONE		BIT(4)
+#define INV_ICM42600_INT_STATUS_DATA_RDY		BIT(3)
+#define INV_ICM42600_INT_STATUS_FIFO_THS		BIT(2)
+#define INV_ICM42600_INT_STATUS_FIFO_FULL		BIT(1)
+#define INV_ICM42600_INT_STATUS_AGC_RDY			BIT(0)
+
+/*
+ * FIFO access registers
+ * FIFO count is 16 bits (2 registers) big-endian
+ * FIFO data is a continuous read register to read FIFO content
+ */
+#define INV_ICM42600_REG_FIFO_COUNT			0x002E
+#define INV_ICM42600_REG_FIFO_DATA			0x0030
+
+#define INV_ICM42600_REG_SIGNAL_PATH_RESET		0x004B
+#define INV_ICM42600_SIGNAL_PATH_RESET_DMP_INIT_EN	BIT(6)
+#define INV_ICM42600_SIGNAL_PATH_RESET_DMP_MEM_RESET	BIT(5)
+#define INV_ICM42600_SIGNAL_PATH_RESET_RESET		BIT(3)
+#define INV_ICM42600_SIGNAL_PATH_RESET_TMST_STROBE	BIT(2)
+#define INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH	BIT(1)
+
+/* default configuration: all data big-endian and fifo count in bytes */
+#define INV_ICM42600_REG_INTF_CONFIG0			0x004C
+#define INV_ICM42600_INTF_CONFIG0_FIFO_HOLD_LAST_DATA	BIT(7)
+#define INV_ICM42600_INTF_CONFIG0_FIFO_COUNT_REC	BIT(6)
+#define INV_ICM42600_INTF_CONFIG0_FIFO_COUNT_ENDIAN	BIT(5)
+#define INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN	BIT(4)
+#define INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_MASK	GENMASK(1, 0)
+#define INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS	\
+		FIELD_PREP(INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_MASK, 2)
+#define INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS	\
+		FIELD_PREP(INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_MASK, 3)
+
+#define INV_ICM42600_REG_INTF_CONFIG1			0x004D
+#define INV_ICM42600_INTF_CONFIG1_ACCEL_LP_CLK_RC	BIT(3)
+
+#define INV_ICM42600_REG_PWR_MGMT0			0x004E
+#define INV_ICM42600_PWR_MGMT0_TEMP_DIS			BIT(5)
+#define INV_ICM42600_PWR_MGMT0_IDLE			BIT(4)
+#define INV_ICM42600_PWR_MGMT0_GYRO(_mode)		\
+		FIELD_PREP(GENMASK(3, 2), (_mode))
+#define INV_ICM42600_PWR_MGMT0_ACCEL(_mode)		\
+		FIELD_PREP(GENMASK(1, 0), (_mode))
+
+#define INV_ICM42600_REG_GYRO_CONFIG0			0x004F
+#define INV_ICM42600_GYRO_CONFIG0_FS(_fs)		\
+		FIELD_PREP(GENMASK(7, 5), (_fs))
+#define INV_ICM42600_GYRO_CONFIG0_ODR(_odr)		\
+		FIELD_PREP(GENMASK(3, 0), (_odr))
+
+#define INV_ICM42600_REG_ACCEL_CONFIG0			0x0050
+#define INV_ICM42600_ACCEL_CONFIG0_FS(_fs)		\
+		FIELD_PREP(GENMASK(7, 5), (_fs))
+#define INV_ICM42600_ACCEL_CONFIG0_ODR(_odr)		\
+		FIELD_PREP(GENMASK(3, 0), (_odr))
+
+#define INV_ICM42600_REG_GYRO_ACCEL_CONFIG0		0x0052
+#define INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(_f)	\
+		FIELD_PREP(GENMASK(7, 4), (_f))
+#define INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(_f)	\
+		FIELD_PREP(GENMASK(3, 0), (_f))
+
+#define INV_ICM42600_REG_TMST_CONFIG			0x0054
+#define INV_ICM42600_TMST_CONFIG_MASK			GENMASK(4, 0)
+#define INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN	BIT(4)
+#define INV_ICM42600_TMST_CONFIG_TMST_RES_16US		BIT(3)
+#define INV_ICM42600_TMST_CONFIG_TMST_DELTA_EN		BIT(2)
+#define INV_ICM42600_TMST_CONFIG_TMST_FSYNC_EN		BIT(1)
+#define INV_ICM42600_TMST_CONFIG_TMST_EN		BIT(0)
+
+#define INV_ICM42600_REG_FIFO_CONFIG1			0x005F
+#define INV_ICM42600_FIFO_CONFIG1_RESUME_PARTIAL_RD	BIT(6)
+#define INV_ICM42600_FIFO_CONFIG1_WM_GT_TH		BIT(5)
+#define INV_ICM42600_FIFO_CONFIG1_TMST_FSYNC_EN		BIT(3)
+#define INV_ICM42600_FIFO_CONFIG1_TEMP_EN		BIT(2)
+#define INV_ICM42600_FIFO_CONFIG1_GYRO_EN		BIT(1)
+#define INV_ICM42600_FIFO_CONFIG1_ACCEL_EN		BIT(0)
+
+/* FIFO watermark is 16 bits (2 registers wide) in little-endian */
+#define INV_ICM42600_REG_FIFO_WATERMARK			0x0060
+#define INV_ICM42600_FIFO_WATERMARK_VAL(_wm)		\
+		cpu_to_le16((_wm) & GENMASK(11, 0))
+/* FIFO is 2048 bytes, let 12 samples for reading latency */
+#define INV_ICM42600_FIFO_WATERMARK_MAX			(2048 - 12 * 16)
+
+#define INV_ICM42600_REG_INT_CONFIG1			0x0064
+#define INV_ICM42600_INT_CONFIG1_TPULSE_DURATION	BIT(6)
+#define INV_ICM42600_INT_CONFIG1_TDEASSERT_DISABLE	BIT(5)
+#define INV_ICM42600_INT_CONFIG1_ASYNC_RESET		BIT(4)
+
+#define INV_ICM42600_REG_INT_SOURCE0			0x0065
+#define INV_ICM42600_INT_SOURCE0_UI_FSYNC_INT1_EN	BIT(6)
+#define INV_ICM42600_INT_SOURCE0_PLL_RDY_INT1_EN	BIT(5)
+#define INV_ICM42600_INT_SOURCE0_RESET_DONE_INT1_EN	BIT(4)
+#define INV_ICM42600_INT_SOURCE0_UI_DRDY_INT1_EN	BIT(3)
+#define INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN	BIT(2)
+#define INV_ICM42600_INT_SOURCE0_FIFO_FULL_INT1_EN	BIT(1)
+#define INV_ICM42600_INT_SOURCE0_UI_AGC_RDY_INT1_EN	BIT(0)
+
+#define INV_ICM42600_REG_WHOAMI				0x0075
+#define INV_ICM42600_WHOAMI_ICM42600			0x40
+#define INV_ICM42600_WHOAMI_ICM42602			0x41
+#define INV_ICM42600_WHOAMI_ICM42605			0x42
+#define INV_ICM42600_WHOAMI_ICM42622			0x46
+
+/* User bank 1 (MSB 0x10) */
+#define INV_ICM42600_REG_SENSOR_CONFIG0			0x1003
+#define INV_ICM42600_SENSOR_CONFIG0_ZG_DISABLE		BIT(5)
+#define INV_ICM42600_SENSOR_CONFIG0_YG_DISABLE		BIT(4)
+#define INV_ICM42600_SENSOR_CONFIG0_XG_DISABLE		BIT(3)
+#define INV_ICM42600_SENSOR_CONFIG0_ZA_DISABLE		BIT(2)
+#define INV_ICM42600_SENSOR_CONFIG0_YA_DISABLE		BIT(1)
+#define INV_ICM42600_SENSOR_CONFIG0_XA_DISABLE		BIT(0)
+
+/* Timestamp value is 20 bits (3 registers) in little-endian */
+#define INV_ICM42600_REG_TMSTVAL			0x1062
+#define INV_ICM42600_TMSTVAL_MASK			GENMASK(19, 0)
+
+#define INV_ICM42600_REG_INTF_CONFIG4			0x107A
+#define INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY		BIT(6)
+#define INV_ICM42600_INTF_CONFIG4_SPI_AP_4WIRE		BIT(1)
+
+#define INV_ICM42600_REG_INTF_CONFIG6			0x107C
+#define INV_ICM42600_INTF_CONFIG6_MASK			GENMASK(4, 0)
+#define INV_ICM42600_INTF_CONFIG6_I3C_EN		BIT(4)
+#define INV_ICM42600_INTF_CONFIG6_I3C_IBI_BYTE_EN	BIT(3)
+#define INV_ICM42600_INTF_CONFIG6_I3C_IBI_EN		BIT(2)
+#define INV_ICM42600_INTF_CONFIG6_I3C_DDR_EN		BIT(1)
+#define INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN		BIT(0)
+
+/* User bank 4 (MSB 0x40) */
+#define INV_ICM42600_REG_INT_SOURCE8			0x404F
+#define INV_ICM42600_INT_SOURCE8_FSYNC_IBI_EN		BIT(5)
+#define INV_ICM42600_INT_SOURCE8_PLL_RDY_IBI_EN		BIT(4)
+#define INV_ICM42600_INT_SOURCE8_UI_DRDY_IBI_EN		BIT(3)
+#define INV_ICM42600_INT_SOURCE8_FIFO_THS_IBI_EN	BIT(2)
+#define INV_ICM42600_INT_SOURCE8_FIFO_FULL_IBI_EN	BIT(1)
+#define INV_ICM42600_INT_SOURCE8_AGC_RDY_IBI_EN		BIT(0)
+
+#define INV_ICM42600_REG_OFFSET_USER0			0x4077
+#define INV_ICM42600_REG_OFFSET_USER1			0x4078
+#define INV_ICM42600_REG_OFFSET_USER2			0x4079
+#define INV_ICM42600_REG_OFFSET_USER3			0x407A
+#define INV_ICM42600_REG_OFFSET_USER4			0x407B
+#define INV_ICM42600_REG_OFFSET_USER5			0x407C
+#define INV_ICM42600_REG_OFFSET_USER6			0x407D
+#define INV_ICM42600_REG_OFFSET_USER7			0x407E
+#define INV_ICM42600_REG_OFFSET_USER8			0x407F
+
+/* Sleep times required by the driver */
+#define INV_ICM42600_POWER_UP_TIME_MS		100
+#define INV_ICM42600_RESET_TIME_MS		1
+#define INV_ICM42600_ACCEL_STARTUP_TIME_MS	20
+#define INV_ICM42600_GYRO_STARTUP_TIME_MS	60
+#define INV_ICM42600_GYRO_STOP_TIME_MS		150
+#define INV_ICM42600_TEMP_STARTUP_TIME_MS	14
+#define INV_ICM42600_SUSPEND_DELAY_MS		2000
+
+typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
+
+extern const struct regmap_config inv_icm42600_regmap_config;
+extern const struct dev_pm_ops inv_icm42600_pm_ops;
+
+const struct iio_mount_matrix *
+inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan);
+
+uint32_t inv_icm42600_odr_to_period(enum inv_icm42600_odr odr);
+
+int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
+				struct inv_icm42600_sensor_conf *conf,
+				unsigned int *sleep);
+
+int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
+			       struct inv_icm42600_sensor_conf *conf,
+			       unsigned int *sleep);
+
+int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
+			       unsigned int *sleep);
+
+int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval);
+
+int inv_icm42600_core_probe(struct regmap *regmap, int chip,
+			    inv_icm42600_bus_setup bus_setup);
+
+#endif
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
new file mode 100644
index 000000000000..35bdf4f9d31e
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -0,0 +1,618 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/iio/iio.h>
+
+#include "inv_icm42600.h"
+
+static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] = {
+	{
+		.name = "user banks",
+		.range_min = 0x0000,
+		.range_max = 0x4FFF,
+		.selector_reg = INV_ICM42600_REG_BANK_SEL,
+		.selector_mask = INV_ICM42600_BANK_SEL_MASK,
+		.selector_shift = 0,
+		.window_start = 0,
+		.window_len = 0x1000,
+	},
+};
+
+const struct regmap_config inv_icm42600_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x4FFF,
+	.ranges = inv_icm42600_regmap_ranges,
+	.num_ranges = ARRAY_SIZE(inv_icm42600_regmap_ranges),
+};
+EXPORT_SYMBOL_GPL(inv_icm42600_regmap_config);
+
+struct inv_icm42600_hw {
+	uint8_t whoami;
+	const char *name;
+	const struct inv_icm42600_conf *conf;
+};
+
+/* chip initial default configuration */
+static const struct inv_icm42600_conf inv_icm42600_default_conf = {
+	.gyro = {
+		.mode = INV_ICM42600_SENSOR_MODE_OFF,
+		.fs = INV_ICM42600_GYRO_FS_2000DPS,
+		.odr = INV_ICM42600_ODR_50HZ,
+		.filter = INV_ICM42600_FILTER_BW_ODR_DIV_2,
+	},
+	.accel = {
+		.mode = INV_ICM42600_SENSOR_MODE_OFF,
+		.fs = INV_ICM42600_ACCEL_FS_16G,
+		.odr = INV_ICM42600_ODR_50HZ,
+		.filter = INV_ICM42600_FILTER_BW_ODR_DIV_2,
+	},
+	.temp_en = false,
+};
+
+static const struct inv_icm42600_hw inv_icm42600_hw[] = {
+	[INV_CHIP_ICM42600] = {
+		.whoami = INV_ICM42600_WHOAMI_ICM42600,
+		.name = "icm42600",
+		.conf = &inv_icm42600_default_conf,
+	},
+	[INV_CHIP_ICM42602] = {
+		.whoami = INV_ICM42600_WHOAMI_ICM42602,
+		.name = "icm42602",
+		.conf = &inv_icm42600_default_conf,
+	},
+	[INV_CHIP_ICM42605] = {
+		.whoami = INV_ICM42600_WHOAMI_ICM42605,
+		.name = "icm42605",
+		.conf = &inv_icm42600_default_conf,
+	},
+	[INV_CHIP_ICM42622] = {
+		.whoami = INV_ICM42600_WHOAMI_ICM42622,
+		.name = "icm42622",
+		.conf = &inv_icm42600_default_conf,
+	},
+};
+
+const struct iio_mount_matrix *
+inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan)
+{
+	const struct inv_icm42600_state *st =
+			iio_device_get_drvdata((struct iio_dev *)indio_dev);
+
+	return &st->orientation;
+}
+
+uint32_t inv_icm42600_odr_to_period(enum inv_icm42600_odr odr)
+{
+	static uint32_t odr_periods[INV_ICM42600_ODR_NB] = {
+		/* reserved values */
+		0, 0, 0,
+		/* 8kHz */
+		125000,
+		/* 4kHz */
+		250000,
+		/* 2kHz */
+		500000,
+		/* 1kHz */
+		1000000,
+		/* 200Hz */
+		5000000,
+		/* 100Hz */
+		10000000,
+		/* 50Hz */
+		20000000,
+		/* 25Hz */
+		40000000,
+		/* 12.5Hz */
+		80000000,
+		/* 6.25Hz */
+		160000000,
+		/* 3.125Hz */
+		320000000,
+		/* 1.5625Hz */
+		640000000,
+		/* 500Hz */
+		2000000,
+	};
+
+	return odr_periods[odr];
+}
+
+static int inv_icm42600_set_pwr_mgmt0(struct inv_icm42600_state *st,
+				      enum inv_icm42600_sensor_mode gyro,
+				      enum inv_icm42600_sensor_mode accel,
+				      bool temp, unsigned int *sleep)
+{
+	enum inv_icm42600_sensor_mode oldgyro = st->conf.gyro.mode;
+	enum inv_icm42600_sensor_mode oldaccel = st->conf.accel.mode;
+	bool oldtemp = st->conf.temp_en;
+	unsigned int sleepval;
+	unsigned int val;
+	int ret;
+
+	/* if nothing changed, exit */
+	if (gyro == oldgyro && accel == oldaccel && temp == oldtemp)
+		return 0;
+
+	val = INV_ICM42600_PWR_MGMT0_GYRO(gyro) |
+	      INV_ICM42600_PWR_MGMT0_ACCEL(accel);
+	if (!temp)
+		val |= INV_ICM42600_PWR_MGMT0_TEMP_DIS;
+	dev_dbg(regmap_get_device(st->map), "pwr_mgmt0: %#02x\n", val);
+	ret = regmap_write(st->map, INV_ICM42600_REG_PWR_MGMT0, val);
+	if (ret)
+		return ret;
+
+	st->conf.gyro.mode = gyro;
+	st->conf.accel.mode = accel;
+	st->conf.temp_en = temp;
+
+	/* compute required wait time for sensors to stabilize */
+	sleepval = 0;
+	/* temperature stabilization time */
+	if (temp && !oldtemp) {
+		if (sleepval < INV_ICM42600_TEMP_STARTUP_TIME_MS)
+			sleepval = INV_ICM42600_TEMP_STARTUP_TIME_MS;
+	}
+	/* accel startup time */
+	if (accel != oldaccel && oldaccel == INV_ICM42600_SENSOR_MODE_OFF) {
+		/* block any register write for at least 200 µs */
+		usleep_range(200, 300);
+		if (sleepval < INV_ICM42600_ACCEL_STARTUP_TIME_MS)
+			sleepval = INV_ICM42600_ACCEL_STARTUP_TIME_MS;
+	}
+	if (gyro != oldgyro) {
+		/* gyro startup time */
+		if (oldgyro == INV_ICM42600_SENSOR_MODE_OFF) {
+			/* block any register write for at least 200 µs */
+			usleep_range(200, 300);
+			if (sleepval < INV_ICM42600_GYRO_STARTUP_TIME_MS)
+				sleepval = INV_ICM42600_GYRO_STARTUP_TIME_MS;
+		/* gyro stop time */
+		} else if (gyro == INV_ICM42600_SENSOR_MODE_OFF) {
+			if (sleepval < INV_ICM42600_GYRO_STOP_TIME_MS)
+				sleepval =  INV_ICM42600_GYRO_STOP_TIME_MS;
+		}
+	}
+
+	/* deferred sleep value if sleep pointer is provided or direct sleep */
+	if (sleep)
+		*sleep = sleepval;
+	else if (sleepval)
+		msleep(sleepval);
+
+	return 0;
+}
+
+int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
+				struct inv_icm42600_sensor_conf *conf,
+				unsigned int *sleep)
+{
+	struct inv_icm42600_sensor_conf *oldconf = &st->conf.accel;
+	unsigned int val;
+	int ret;
+
+	/* Sanitize missing values with current values */
+	if (conf->mode < 0)
+		conf->mode = oldconf->mode;
+	if (conf->fs < 0)
+		conf->fs = oldconf->fs;
+	if (conf->odr < 0)
+		conf->odr = oldconf->odr;
+	if (conf->filter < 0)
+		conf->filter = oldconf->filter;
+
+	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
+	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
+		val = INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) |
+		      INV_ICM42600_ACCEL_CONFIG0_ODR(conf->odr);
+		dev_dbg(regmap_get_device(st->map), "accel_config0: %#02x\n", val);
+		ret = regmap_write(st->map, INV_ICM42600_REG_ACCEL_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->fs = conf->fs;
+		oldconf->odr = conf->odr;
+	}
+
+	/* set GYRO_ACCEL_CONFIG0 register (accel filter) */
+	if (conf->filter != oldconf->filter) {
+		val = INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(conf->filter) |
+		      INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(st->conf.gyro.filter);
+		dev_dbg(regmap_get_device(st->map), "gyro_accel_config0: %#02x\n", val);
+		ret = regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->filter = conf->filter;
+	}
+
+	/* set PWR_MGMT0 register (accel sensor mode) */
+	return inv_icm42600_set_pwr_mgmt0(st, st->conf.gyro.mode, conf->mode,
+					  st->conf.temp_en, sleep);
+}
+
+int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
+			       struct inv_icm42600_sensor_conf *conf,
+			       unsigned int *sleep)
+{
+	struct inv_icm42600_sensor_conf *oldconf = &st->conf.gyro;
+	unsigned int val;
+	int ret;
+
+	/* sanitize missing values with current values */
+	if (conf->mode < 0)
+		conf->mode = oldconf->mode;
+	if (conf->fs < 0)
+		conf->fs = oldconf->fs;
+	if (conf->odr < 0)
+		conf->odr = oldconf->odr;
+	if (conf->filter < 0)
+		conf->filter = oldconf->filter;
+
+	/* set GYRO_CONFIG0 register (gyro fullscale & odr) */
+	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
+		val = INV_ICM42600_GYRO_CONFIG0_FS(conf->fs) |
+		      INV_ICM42600_GYRO_CONFIG0_ODR(conf->odr);
+		dev_dbg(regmap_get_device(st->map), "gyro_config0: %#02x\n", val);
+		ret = regmap_write(st->map, INV_ICM42600_REG_GYRO_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->fs = conf->fs;
+		oldconf->odr = conf->odr;
+	}
+
+	/* set GYRO_ACCEL_CONFIG0 register (gyro filter) */
+	if (conf->filter != oldconf->filter) {
+		val = INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(st->conf.accel.filter) |
+		      INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(conf->filter);
+		dev_dbg(regmap_get_device(st->map), "gyro_accel_config0: %#02x\n", val);
+		ret = regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->filter = conf->filter;
+	}
+
+	/* set PWR_MGMT0 register (gyro sensor mode) */
+	return inv_icm42600_set_pwr_mgmt0(st, conf->mode, st->conf.accel.mode,
+					  st->conf.temp_en, sleep);
+
+	return 0;
+}
+
+int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
+			       unsigned int *sleep)
+{
+	return inv_icm42600_set_pwr_mgmt0(st, st->conf.gyro.mode,
+					  st->conf.accel.mode, enable,
+					  sleep);
+}
+
+int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	if (readval)
+		ret = regmap_read(st->map, reg, readval);
+	else
+		ret = regmap_write(st->map, reg, writeval);
+
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int inv_icm42600_set_conf(struct inv_icm42600_state *st,
+				 const struct inv_icm42600_conf *conf)
+{
+	unsigned int val;
+	int ret;
+
+	/* set PWR_MGMT0 register (gyro & accel sensor mode, temp enabled) */
+	val = INV_ICM42600_PWR_MGMT0_GYRO(conf->gyro.mode) |
+	      INV_ICM42600_PWR_MGMT0_ACCEL(conf->accel.mode);
+	if (!conf->temp_en)
+		val |= INV_ICM42600_PWR_MGMT0_TEMP_DIS;
+	ret = regmap_write(st->map, INV_ICM42600_REG_PWR_MGMT0, val);
+	if (ret)
+		return ret;
+
+	/* set GYRO_CONFIG0 register (gyro fullscale & odr) */
+	val = INV_ICM42600_GYRO_CONFIG0_FS(conf->gyro.fs) |
+	      INV_ICM42600_GYRO_CONFIG0_ODR(conf->gyro.odr);
+	ret = regmap_write(st->map, INV_ICM42600_REG_GYRO_CONFIG0, val);
+	if (ret)
+		return ret;
+
+	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
+	val = INV_ICM42600_ACCEL_CONFIG0_FS(conf->accel.fs) |
+	      INV_ICM42600_ACCEL_CONFIG0_ODR(conf->accel.odr);
+	ret = regmap_write(st->map, INV_ICM42600_REG_ACCEL_CONFIG0, val);
+	if (ret)
+		return ret;
+
+	/* set GYRO_ACCEL_CONFIG0 register (gyro & accel filters) */
+	val = INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(conf->accel.filter) |
+	      INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(conf->gyro.filter);
+	ret = regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL_CONFIG0, val);
+	if (ret)
+		return ret;
+
+	/* update internal conf */
+	st->conf = *conf;
+
+	return 0;
+}
+
+/**
+ *  inv_icm42600_setup() - check and setup chip.
+ */
+static int inv_icm42600_setup(struct inv_icm42600_state *st,
+			      inv_icm42600_bus_setup bus_setup)
+{
+	const struct inv_icm42600_hw *hw = &inv_icm42600_hw[st->chip];
+	const struct device *dev = regmap_get_device(st->map);
+	unsigned int mask, val;
+	int ret;
+
+	/* check chip self-identification value */
+	ret = regmap_read(st->map, INV_ICM42600_REG_WHOAMI, &val);
+	if (ret)
+		return ret;
+	if (val != hw->whoami) {
+		dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n",
+			val, hw->whoami, hw->name);
+		return -ENODEV;
+	}
+	dev_info(dev, "found %s (%#02x)\n", hw->name, hw->whoami);
+	st->name = hw->name;
+
+	/* reset to make sure previous state are not there */
+	ret = regmap_write(st->map, INV_ICM42600_REG_DEVICE_CONFIG,
+			   INV_ICM42600_DEVICE_CONFIG_SOFT_RESET);
+	if (ret)
+		return ret;
+	msleep(INV_ICM42600_RESET_TIME_MS);
+	ret = regmap_read(st->map, INV_ICM42600_REG_INT_STATUS, &val);
+	if (ret)
+		return ret;
+	if (!(val & INV_ICM42600_INT_STATUS_RESET_DONE)) {
+		dev_err(dev, "reset error, reset done bit not set\n");
+		return -ENODEV;
+	}
+
+	/* set chip bus configuration */
+	ret = bus_setup(st);
+	if (ret)
+		return ret;
+
+	/* sensor data in big-endian (default) */
+	mask = INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN;
+	val = INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN;
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG0,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	return inv_icm42600_set_conf(st, hw->conf);
+}
+
+static int inv_icm42600_enable_regulator_vddio(struct inv_icm42600_state *st)
+{
+	int ret;
+
+	ret = regulator_enable(st->vddio_supply);
+	if (ret)
+		return ret;
+
+	/* wait a little for supply ramp */
+	usleep_range(3000, 4000);
+
+	return 0;
+}
+
+static void inv_icm42600_disable_regulators(void *_data)
+{
+	struct inv_icm42600_state *st = _data;
+	const struct device *dev = regmap_get_device(st->map);
+	int ret;
+
+	ret = regulator_disable(st->vddio_supply);
+	if (ret)
+		dev_err(dev, "failed to disable vddio error %d\n", ret);
+
+	ret = regulator_disable(st->vdd_supply);
+	if (ret)
+		dev_err(dev, "failed to disable vdd error %d\n", ret);
+}
+
+static void inv_icm42600_disable_pm(void *_data)
+{
+	struct device *dev = _data;
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+}
+
+int inv_icm42600_core_probe(struct regmap *regmap, int chip,
+			    inv_icm42600_bus_setup bus_setup)
+{
+	struct device *dev = regmap_get_device(regmap);
+	struct inv_icm42600_state *st;
+	int ret;
+
+	BUILD_BUG_ON(ARRAY_SIZE(inv_icm42600_hw) != INV_CHIP_NB);
+	if (chip < 0 || chip >= INV_CHIP_NB) {
+		dev_err(dev, "invalid chip = %d\n", chip);
+		return -ENODEV;
+	}
+
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+	dev_set_drvdata(dev, st);
+	mutex_init(&st->lock);
+	st->chip = chip;
+	st->map = regmap;
+
+	ret = iio_read_mount_matrix(dev, "mount-matrix", &st->orientation);
+	if (ret) {
+		dev_err(dev, "failed to retrieve mounting matrix %d\n", ret);
+		return ret;
+	}
+
+	st->vdd_supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(st->vdd_supply))
+		return PTR_ERR(st->vdd_supply);
+
+	st->vddio_supply = devm_regulator_get(dev, "vddio");
+	if (IS_ERR(st->vddio_supply))
+		return PTR_ERR(st->vddio_supply);
+
+	ret = regulator_enable(st->vdd_supply);
+	if (ret)
+		return ret;
+	msleep(INV_ICM42600_POWER_UP_TIME_MS);
+
+	ret = inv_icm42600_enable_regulator_vddio(st);
+	if (ret) {
+		regulator_disable(st->vdd_supply);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, inv_icm42600_disable_regulators,
+				       st);
+	if (ret)
+		return ret;
+
+	/* setup chip registers */
+	ret = inv_icm42600_setup(st, bus_setup);
+	if (ret)
+		return ret;
+
+	/* setup runtime power management */
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		return ret;
+	pm_runtime_get_noresume(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, INV_ICM42600_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_put(dev);
+
+	return devm_add_action_or_reset(dev, inv_icm42600_disable_pm, dev);
+}
+EXPORT_SYMBOL_GPL(inv_icm42600_core_probe);
+
+static int __maybe_unused inv_icm42600_suspend(struct device *dev)
+{
+	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	st->suspended.gyro = st->conf.gyro.mode;
+	st->suspended.accel = st->conf.accel.mode;
+	st->suspended.temp = st->conf.temp_en;
+	if (pm_runtime_suspended(dev)) {
+		ret = 0;
+		goto out_unlock;
+	}
+
+	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
+					 INV_ICM42600_SENSOR_MODE_OFF, false,
+					 NULL);
+	if (ret)
+		goto out_unlock;
+
+	regulator_disable(st->vddio_supply);
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int __maybe_unused inv_icm42600_resume(struct device *dev)
+{
+	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = inv_icm42600_enable_regulator_vddio(st);
+	if (ret)
+		goto out_unlock;
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	/* restore sensors state */
+	ret = inv_icm42600_set_pwr_mgmt0(st, st->suspended.gyro,
+					 st->suspended.accel,
+					 st->suspended.temp, NULL);
+	if (ret)
+		goto out_unlock;
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int __maybe_unused inv_icm42600_runtime_suspend(struct device *dev)
+{
+	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	/* disable all sensors */
+	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
+					 INV_ICM42600_SENSOR_MODE_OFF, false,
+					 NULL);
+	if (ret)
+		goto error_unlock;
+
+	regulator_disable(st->vddio_supply);
+
+error_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int __maybe_unused inv_icm42600_runtime_resume(struct device *dev)
+{
+	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = inv_icm42600_enable_regulator_vddio(st);
+
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+const struct dev_pm_ops inv_icm42600_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(inv_icm42600_suspend, inv_icm42600_resume)
+	SET_RUNTIME_PM_OPS(inv_icm42600_runtime_suspend,
+			   inv_icm42600_runtime_resume, NULL)
+};
+EXPORT_SYMBOL_GPL(inv_icm42600_pm_ops);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-426xx device driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

