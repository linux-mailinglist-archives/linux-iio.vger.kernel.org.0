Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D71203B2D
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 17:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgFVPiI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 11:38:08 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:29754 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729494AbgFVPiG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2020 11:38:06 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MFWDw5004965;
        Mon, 22 Jun 2020 08:37:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=LY5NdeeP3Ldra1mgDwQdeSQtqJcmWkNwZWxEd8R3JOQ=;
 b=a3Ra+4OmuzvopwITbxIHpKGvHfAoHAAbftNEY1CZczYJF7LMSz2nJc5jTExz5ZBRb/sW
 AHkSI4Exv/gBUCErV7DJGGtZMvmSdUH1E0lCuAYDgOMJZeq43pvqsoHoLUSbY/+EVmmY
 mQ2D+8Ot6gAAjN8u8cuiImjvtkSFqxEUYJF0x7uedUFBNabp/rxiUxgPoGkIsP7Zs93f
 ChfKu836PINcrdhE40eyL9CbUR300JB+0zWIcK4kO5ROefYgBjP4pK/aB5twU+8XgKBz
 okkaPAy3RS2XlMGh3O61ql+ZrsKz77L0Qjzx/v6sCkrX1rkQPDyrVNZ8O4R2nTHUmu4Z 4Q== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0b-00328301.pphosted.com with ESMTP id 31sedp0ukd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 08:37:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vf9qcz5ael6pl8kd2MczLTZXrbUrzAY6/vuWpTkY+TOUAUthumaKdlUZHLzgBaW3TkhjOiZy74/cy9TSmiWKra5mf08Eq9FW//9kJQ2agvXuDx72zH3vRlNeijZDcbclzAQ9dDy3dt9EXsLhMAr17P+UtOgzF1/PTA9mSCJOYcz4e0X21/VqWWXo7Hn9ZOAelW5SAKhkK8Wjsu5gel2MzhT2pQvXxFPBOxCgpONFj6I7S5CHYNy8Qczmv98uuF4fj/Zy+FIc9rQQtZ/nGWLkrrn5XkV3QZqLIaQGdbc3HC9O7OpR7v5DMK0Fjf1zjBkpUgOul/D+8BnYfl4O2XD+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY5NdeeP3Ldra1mgDwQdeSQtqJcmWkNwZWxEd8R3JOQ=;
 b=aIitEY1tLGZOvrKV70mSP2XkYZzWlWRRnROJUtsAvSixxZROFK4qj6KVQ6hPGQP6fn6UUmb/vpoZultgT+FS83Za7n/w/IVsqVVdXbdcETIGZVX9FJp6OUV2VfxQyqcdU70eyXI2zco36DBHJxXx+6Y4rR81u/oKswQXmV7R7J+d4zI1yXL9xS6PD6MJ2IPHiWfPhJ8gubNkLwjtyMT2agpdD9lZWh1QGnuY+/3HP7sDvAtpTd0zywZEV97AsNYb/7OoDUtDB0ucpmpUbOs1gI7sU34zA1aETHlTdVBXHAoYj11dMb8UyAc87ZsfHdK7yXpaZdvesoeYJB3UzNfBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY5NdeeP3Ldra1mgDwQdeSQtqJcmWkNwZWxEd8R3JOQ=;
 b=GeIfnSh9orBPSUcJywT3GhJReidvi3seL9W0i1ONl/G8xsP7CbWyixQILZkY8pGdBttGSufY0SS5M9Xhxwoec96YFBfa9uzOwNahxOy8PdNt5IrFSlBeCUxga5Ww/fRApkwGwEAAHXNGyn2d/PrELvf4MGKdFkCd7uMMLtTjXBY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 15:37:55 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:37:55 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v4 01/13] iio: imu: inv_icm42600: add core of new inv_icm42600 driver
Date:   Mon, 22 Jun 2020 17:37:17 +0200
Message-Id: <20200622153729.12702-2-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622153729.12702-1-jmaneyrol@invensense.com>
References: <20200622153729.12702-1-jmaneyrol@invensense.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::18) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 15:37:54 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 283b5e5a-a0eb-43ea-0c48-08d816c23bcf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4501824606B4BEFD68E3778EC4970@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:211;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wHeyz9Hu1F+UGo9PS04ndQufJOcV3ST67fYvDTj32NB0n6QspKNgboXeUk/i9/B7YYRouE52j+erESEY8rIs7fD/3yyqpYVk4Ap7AfVxxLAbR24393RKBahngEciHWLoF68mVrTY3LDDEjZvZ2rOasZq+495S8YT3ayuriK6Z2ifmHmILPXbbBJXhgGhSKDi4QaFM0MTqID9mnyP+EL1W3IORnO+8OqbPayOfe2wQ8TrrcQIfN+g744QNy5P5tg34vz0VIp7kYha9zBh1W1iGbOuk9XSNCEFH1gZBXI7dourCDHvD0Bu6iKK/bBIzI/tbCW39aZSpDKHgOGBTBiNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39850400004)(136003)(366004)(396003)(4326008)(66946007)(7696005)(52116002)(8676002)(66476007)(66556008)(956004)(2616005)(1076003)(83380400001)(107886003)(86362001)(36756003)(30864003)(478600001)(6486002)(6666004)(26005)(316002)(8936002)(16526019)(5660300002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Z/XW4Xh+CBLtV2KPSukrs+g1o+h5ot7GRVoz9Z2oeYrytRf/0AaB67Muwsj6UQwoavDJxADFGbpiMT/Gg5k3tSWbngHp79ohNJOUcCZ3Rwa0c9cHXS2Ux994+Dq6UQcEZuU4md1VkJE3wl/O8wIhZlUd5NcWsW+U/zDAHiNHe4+hHoSp8GkOxgzqouhX/4hPAInsFT7tU3A/xOkmblbejbYU7ZJtEXpKiXZtmFO3/WmailhFc1gl6yT/e7mCaQfIrD2DozlV1WQtORshhyYnHP6xMg/+oDFTmqTTc9xBNE9zob3fIQpggRylGF8X4n7GiT29gLbrv8FMF12nuDVQIQ33TWpOrzlpo4/YB4zquQFn0eu3p0Vg9xQ3+H+oJwuoP6Gm3StaK3CuTLabzwO+gSsGDN9b0/hPB4KCatkCRss4FWMSyHYd16ZpMfm2c4uVTKcLQkfAOs7nREq1PaTmYpWC25RUy4fMZ3BymoLY+u0=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283b5e5a-a0eb-43ea-0c48-08d816c23bcf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 15:37:55.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfPmEo6PMgtJk28mbmU+CZsj3Hf2hKR7oqYvfq/d4o24zUjdhtZMBgJpFBjMUF53WvSSicd5rMyLBvJyoykizFYoU/Cte0gLJ4EMA5SvtbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_09:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 cotscore=-2147483648
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220116
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
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   | 372 ++++++++++
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 634 ++++++++++++++++++
 2 files changed, 1006 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600.h
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
new file mode 100644
index 000000000000..14c8ef152418
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
+/**
+ *  struct inv_icm42600_state - driver state variables
+ *  @lock:		lock for serializing multiple registers access.
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
+				unsigned int *sleep_ms);
+
+int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
+			       struct inv_icm42600_sensor_conf *conf,
+			       unsigned int *sleep_ms);
+
+int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
+			       unsigned int *sleep_ms);
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
index 000000000000..2eb25c5f77f8
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -0,0 +1,634 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
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
+static const struct inv_icm42600_hw inv_icm42600_hw[INV_CHIP_NB] = {
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
+	const struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
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
+				      bool temp, unsigned int *sleep_ms)
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
+	if (sleep_ms)
+		*sleep_ms = sleepval;
+	else if (sleepval)
+		msleep(sleepval);
+
+	return 0;
+}
+
+int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
+				struct inv_icm42600_sensor_conf *conf,
+				unsigned int *sleep_ms)
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
+		ret = regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->filter = conf->filter;
+	}
+
+	/* set PWR_MGMT0 register (accel sensor mode) */
+	return inv_icm42600_set_pwr_mgmt0(st, st->conf.gyro.mode, conf->mode,
+					  st->conf.temp_en, sleep_ms);
+}
+
+int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
+			       struct inv_icm42600_sensor_conf *conf,
+			       unsigned int *sleep_ms)
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
+		ret = regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->filter = conf->filter;
+	}
+
+	/* set PWR_MGMT0 register (gyro sensor mode) */
+	return inv_icm42600_set_pwr_mgmt0(st, conf->mode, st->conf.accel.mode,
+					  st->conf.temp_en, sleep_ms);
+
+	return 0;
+}
+
+int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
+			       unsigned int *sleep_ms)
+{
+	return inv_icm42600_set_pwr_mgmt0(st, st->conf.gyro.mode,
+					  st->conf.accel.mode, enable,
+					  sleep_ms);
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
+ *  inv_icm42600_setup() - check and setup chip
+ *  @st:	driver internal state
+ *  @bus_setup:	callback for setting up bus specific registers
+ *
+ *  Returns 0 on success, a negative error code otherwise.
+ */
+static int inv_icm42600_setup(struct inv_icm42600_state *st,
+			      inv_icm42600_bus_setup bus_setup)
+{
+	const struct inv_icm42600_hw *hw = &inv_icm42600_hw[st->chip];
+	const struct device *dev = regmap_get_device(st->map);
+	unsigned int val;
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
+	st->name = hw->name;
+
+	/* reset to make sure previous state are not there */
+	ret = regmap_write(st->map, INV_ICM42600_REG_DEVICE_CONFIG,
+			   INV_ICM42600_DEVICE_CONFIG_SOFT_RESET);
+	if (ret)
+		return ret;
+	msleep(INV_ICM42600_RESET_TIME_MS);
+
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
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG0,
+				 INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN,
+				 INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN);
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
+static void inv_icm42600_disable_vdd_reg(void *_data)
+{
+	struct inv_icm42600_state *st = _data;
+	const struct device *dev = regmap_get_device(st->map);
+	int ret;
+
+	ret = regulator_disable(st->vdd_supply);
+	if (ret)
+		dev_err(dev, "failed to disable vdd error %d\n", ret);
+}
+
+static void inv_icm42600_disable_vddio_reg(void *_data)
+{
+	struct inv_icm42600_state *st = _data;
+	const struct device *dev = regmap_get_device(st->map);
+	int ret;
+
+	ret = regulator_disable(st->vddio_supply);
+	if (ret)
+		dev_err(dev, "failed to disable vddio error %d\n", ret);
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
+	if (chip < 0 || chip >= INV_CHIP_NB) {
+		dev_err(dev, "invalid chip = %d\n", chip);
+		return -ENODEV;
+	}
+
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
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
+	ret = devm_add_action_or_reset(dev, inv_icm42600_disable_vdd_reg, st);
+	if (ret)
+		return ret;
+
+	ret = inv_icm42600_enable_regulator_vddio(st);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, inv_icm42600_disable_vddio_reg, st);
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
+/*
+ * Suspend saves sensors state and turns everything off.
+ * Check first if runtime suspend has not already done the job.
+ */
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
+/*
+ * System resume gets the system back on and restores the sensors state.
+ * Manually put runtime power management in system active state.
+ */
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
+/* Runtime suspend will turn off sensors that are enabled by iio devices. */
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
+/* Sensors are enabled by iio devices, no need to turn them back on here. */
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

