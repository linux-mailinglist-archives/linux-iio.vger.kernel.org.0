Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F2054DF4C
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jun 2022 12:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376324AbiFPKmf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jun 2022 06:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376293AbiFPKme (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jun 2022 06:42:34 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4CABD9;
        Thu, 16 Jun 2022 03:42:29 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 1F60D5FD0B;
        Thu, 16 Jun 2022 13:42:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1655376148;
        bh=NVecVXtjAAt7DLogVaHfyJnF3wfQkiILgLSvyxY8vho=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=dCUthDph9dm+gylvmoyr8PHnO3uTMJp/iAA1C7Dcjr8Ac8Ddxx3ajvBCstfzHYWjl
         eZSkxz/hRUDSYaorlYbVrcUWrz5+DjQhPvvoyxeCyEBCjmpz5/Hx06FoF7KhWktn3D
         vThhAIhLYmqj4K+KEfjor8x1YIF4d4VEkykhrbDR1ia5pv/2NqI+LPLLnNhyJ0cFil
         YAeZ4p8FRkgENF0Y5RhdYG1xoHMDVVQMDHzLuRvEz12AxqZiQkkS0rf2bQg0gTZAfi
         eSu+I8NfIpk1e3jJ0Gg1sASWhqcjsoCsCxYPB/68uBaFc4IXj7mXk2d8vEhOBdXjoF
         q7WDsUG/IXj5Q==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 16 Jun 2022 13:42:28 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer driver
Thread-Topic: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYgW2+up0uMWdZgUWEAW/5cCPkBg==
Date:   Thu, 16 Jun 2022 10:42:14 +0000
Message-ID: <20220616104211.9257-3-ddrokosov@sberdevices.ru>
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/16 07:44:00 #19785775
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
sensitivity consumer applications. It has dynamical user selectable full
scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
with output data rates from 1Hz to 1000Hz.

Datasheet can be found at following URL:
https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf

This driver supports following MSA311 features:
    - IIO interface
    - Different power modes: NORMAL and SUSPEND (using pm_runtime)
    - ODR (Output Data Rate) selection
    - Scale and samp_freq selection
    - IIO triggered buffer, IIO reg access
    - NEW_DATA interrupt + trigger

Below features to be done:
    - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
    - Low Power mode

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 MAINTAINERS                |    6 +
 drivers/iio/accel/Kconfig  |   13 +
 drivers/iio/accel/Makefile |    2 +
 drivers/iio/accel/msa311.c | 1312 ++++++++++++++++++++++++++++++++++++
 4 files changed, 1333 insertions(+)
 create mode 100644 drivers/iio/accel/msa311.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d9b2f1731ee0..55aeb25c004c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12478,6 +12478,12 @@ F:	drivers/mtd/
 F:	include/linux/mtd/
 F:	include/uapi/mtd/
=20
+MEMSENSING MICROSYSTEMS MSA311 ACCELEROMETER DRIVER
+M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/accel/msa311.c
+
 MEN A21 WATCHDOG DRIVER
 M:	Johannes Thumshirn <morbidrsa@gmail.com>
 L:	linux-watchdog@vger.kernel.org
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 49587c992a6d..88a265b75eed 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -508,6 +508,19 @@ config MMA9553
 	  To compile this driver as a module, choose M here: the module
 	  will be called mma9553.
=20
+config MSA311
+	tristate "MEMSensing Digital 3-Axis Accelerometer Driver"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for the MEMSensing MSA311
+	  accelerometer driver.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called msa311.
+
 config MXC4005
 	tristate "Memsic MXC4005XC 3-Axis Accelerometer Driver"
 	depends on I2C
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index d03e2f6bba08..b1ddcaa811b6 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -55,6 +55,8 @@ obj-$(CONFIG_MMA9551_CORE)	+=3D mma9551_core.o
 obj-$(CONFIG_MMA9551)		+=3D mma9551.o
 obj-$(CONFIG_MMA9553)		+=3D mma9553.o
=20
+obj-$(CONFIG_MSA311)		+=3D msa311.o
+
 obj-$(CONFIG_MXC4005)		+=3D mxc4005.o
 obj-$(CONFIG_MXC6255)		+=3D mxc6255.o
=20
diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
new file mode 100644
index 000000000000..f8a8ed064f21
--- /dev/null
+++ b/drivers/iio/accel/msa311.c
@@ -0,0 +1,1312 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * msa311.c - MEMSensing digital 3-Axis accelerometer
+ *
+ * MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
+ * sensitivity consumer applications. It has dynamical user selectable ful=
l
+ * scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measuremen=
ts
+ * with output data rates from 1Hz to 1000Hz.
+ *
+ * MSA311 is available in an ultra small (2mm x 2mm, height 0.95mm) LGA pa=
ckage
+ * and is guaranteed to operate over -40C to +85C.
+ *
+ * This driver supports following MSA311 features:
+ *     - IIO interface
+ *     - Different power modes: NORMAL, SUSPEND
+ *     - ODR (Output Data Rate) selection
+ *     - Scale selection
+ *     - IIO triggered buffer
+ *     - NEW_DATA interrupt + trigger
+ *
+ * Below features to be done:
+ *     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
+ *     - Low Power mode
+ *
+ * Copyright (c) 2022, SberDevices. All Rights Reserved.
+ *
+ * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
+ */
+
+#include <linux/i2c.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+/* Register map */
+
+#define MSA311_SOFT_RESET_REG     0x00
+#define MSA311_PARTID_REG         0x01
+#define MSA311_ACC_X_REG          0x02
+#define MSA311_ACC_Y_REG          0x04
+#define MSA311_ACC_Z_REG          0x06
+#define MSA311_MOTION_INT_REG     0x09
+#define MSA311_DATA_INT_REG       0x0A
+#define MSA311_TAP_ACTIVE_STS_REG 0x0B
+#define MSA311_ORIENT_STS_REG     0x0C
+#define MSA311_RANGE_REG          0x0F
+#define MSA311_ODR_REG            0x10
+#define MSA311_PWR_MODE_REG       0x11
+#define MSA311_SWAP_POLARITY_REG  0x12
+#define MSA311_INT_SET_0_REG      0x16
+#define MSA311_INT_SET_1_REG      0x17
+#define MSA311_INT_MAP_0_REG      0x19
+#define MSA311_INT_MAP_1_REG      0x1A
+#define MSA311_INT_CONFIG_REG     0x20
+#define MSA311_INT_LATCH_REG      0x21
+#define MSA311_FREEFALL_DUR_REG   0x22
+#define MSA311_FREEFALL_TH_REG    0x23
+#define MSA311_FREEFALL_HY_REG    0x24
+#define MSA311_ACTIVE_DUR_REG     0x27
+#define MSA311_ACTIVE_TH_REG      0x28
+#define MSA311_TAP_DUR_REG        0x2A
+#define MSA311_TAP_TH_REG         0x2B
+#define MSA311_ORIENT_HY_REG      0x2C
+#define MSA311_Z_BLOCK_REG        0x2D
+#define MSA311_OFFSET_X_REG       0x38
+#define MSA311_OFFSET_Y_REG       0x39
+#define MSA311_OFFSET_Z_REG       0x3A
+
+enum msa311_fields {
+	F_SOFT_RESET_I2C, F_SOFT_RESET_SPI,
+
+	F_ORIENT_INT, F_S_TAP_INT, F_D_TAP_INT, F_ACTIVE_INT, F_FREEFALL_INT,
+
+	F_NEW_DATA_INT,
+
+	F_TAP_SIGN, F_TAP_FIRST_X, F_TAP_FIRST_Y, F_TAP_FIRST_Z, F_ACTV_SIGN,
+	F_ACTV_FIRST_X, F_ACTV_FIRST_Y, F_ACTV_FIRST_Z,
+
+	F_ORIENT_Z, F_ORIENT_X_Y,
+
+	F_FS,
+
+	F_X_AXIS_DIS, F_Y_AXIS_DIS, F_Z_AXIS_DIS, F_ODR,
+
+	F_PWR_MODE, F_LOW_POWER_BW,
+
+	F_X_POLARITY, F_Y_POLARITY, F_Z_POLARITY, F_X_Y_SWAP,
+
+	F_ORIENT_INT_EN, F_S_TAP_INT_EN, F_D_TAP_INT_EN, F_ACTIVE_INT_EN_Z,
+	F_ACTIVE_INT_EN_Y, F_ACTIVE_INT_EN_X,
+
+	F_NEW_DATA_INT_EN, F_FREEFALL_INT_EN,
+
+	F_INT1_ORIENT, F_INT1_S_TAP, F_INT1_D_TAP, F_INT1_ACTIVE,
+	F_INT1_FREEFALL,
+
+	F_INT1_NEW_DATA,
+
+	F_INT1_OD, F_INT1_LVL,
+
+	F_RESET_INT, F_LATCH_INT,
+
+	F_FREEFALL_MODE, F_FREEFALL_HY,
+
+	F_ACTIVE_DUR,
+
+	F_TAP_QUIET, F_TAP_SHOCK, F_TAP_DUR,
+
+	F_TAP_TH,
+
+	F_ORIENT_HYST, F_ORIENT_BLOCKING, F_ORIENT_MODE,
+
+	F_Z_BLOCKING,
+
+	F_MAX_FIELDS,
+};
+
+static const struct reg_field msa311_reg_fields[] =3D {
+	[F_SOFT_RESET_I2C] =3D REG_FIELD(MSA311_SOFT_RESET_REG, 2, 2),
+	[F_SOFT_RESET_SPI] =3D REG_FIELD(MSA311_SOFT_RESET_REG, 5, 5),
+
+	[F_ORIENT_INT] =3D REG_FIELD(MSA311_MOTION_INT_REG, 6, 6),
+	[F_S_TAP_INT] =3D REG_FIELD(MSA311_MOTION_INT_REG, 5, 5),
+	[F_D_TAP_INT] =3D REG_FIELD(MSA311_MOTION_INT_REG, 4, 4),
+	[F_ACTIVE_INT] =3D REG_FIELD(MSA311_MOTION_INT_REG, 2, 2),
+	[F_FREEFALL_INT] =3D REG_FIELD(MSA311_MOTION_INT_REG, 0, 0),
+
+	[F_NEW_DATA_INT] =3D REG_FIELD(MSA311_DATA_INT_REG, 0, 0),
+
+	[F_TAP_SIGN] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 7, 7),
+	[F_TAP_FIRST_X] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 6, 6),
+	[F_TAP_FIRST_Y] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 5, 5),
+	[F_TAP_FIRST_Z] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 4, 4),
+	[F_ACTV_SIGN] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 3, 3),
+	[F_ACTV_FIRST_X] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 2, 2),
+	[F_ACTV_FIRST_Y] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 1, 1),
+	[F_ACTV_FIRST_Z] =3D REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 0, 0),
+
+	[F_ORIENT_Z] =3D REG_FIELD(MSA311_ORIENT_STS_REG, 6, 6),
+	[F_ORIENT_X_Y] =3D REG_FIELD(MSA311_ORIENT_STS_REG, 4, 5),
+
+	[F_FS] =3D REG_FIELD(MSA311_RANGE_REG, 0, 1),
+
+	[F_X_AXIS_DIS] =3D REG_FIELD(MSA311_ODR_REG, 7, 7),
+	[F_Y_AXIS_DIS] =3D REG_FIELD(MSA311_ODR_REG, 6, 6),
+	[F_Z_AXIS_DIS] =3D REG_FIELD(MSA311_ODR_REG, 5, 5),
+	[F_ODR] =3D REG_FIELD(MSA311_ODR_REG, 0, 3),
+
+	[F_PWR_MODE] =3D REG_FIELD(MSA311_PWR_MODE_REG, 6, 7),
+	[F_LOW_POWER_BW] =3D REG_FIELD(MSA311_PWR_MODE_REG, 1, 4),
+
+	[F_X_POLARITY] =3D REG_FIELD(MSA311_SWAP_POLARITY_REG, 3, 3),
+	[F_Y_POLARITY] =3D REG_FIELD(MSA311_SWAP_POLARITY_REG, 2, 2),
+	[F_Z_POLARITY] =3D REG_FIELD(MSA311_SWAP_POLARITY_REG, 1, 1),
+	[F_X_Y_SWAP] =3D REG_FIELD(MSA311_SWAP_POLARITY_REG, 0, 0),
+
+	[F_ORIENT_INT_EN] =3D REG_FIELD(MSA311_INT_SET_0_REG, 6, 6),
+	[F_S_TAP_INT_EN] =3D REG_FIELD(MSA311_INT_SET_0_REG, 5, 5),
+	[F_D_TAP_INT_EN] =3D REG_FIELD(MSA311_INT_SET_0_REG, 4, 4),
+	[F_ACTIVE_INT_EN_Z] =3D REG_FIELD(MSA311_INT_SET_0_REG, 2, 2),
+	[F_ACTIVE_INT_EN_Y] =3D REG_FIELD(MSA311_INT_SET_0_REG, 1, 1),
+	[F_ACTIVE_INT_EN_X] =3D REG_FIELD(MSA311_INT_SET_0_REG, 0, 0),
+
+	[F_NEW_DATA_INT_EN] =3D REG_FIELD(MSA311_INT_SET_1_REG, 4, 4),
+	[F_FREEFALL_INT_EN] =3D REG_FIELD(MSA311_INT_SET_1_REG, 3, 3),
+
+	[F_INT1_ORIENT] =3D REG_FIELD(MSA311_INT_MAP_0_REG, 6, 6),
+	[F_INT1_S_TAP] =3D REG_FIELD(MSA311_INT_MAP_0_REG, 5, 5),
+	[F_INT1_D_TAP] =3D REG_FIELD(MSA311_INT_MAP_0_REG, 4, 4),
+	[F_INT1_ACTIVE] =3D REG_FIELD(MSA311_INT_MAP_0_REG, 2, 2),
+	[F_INT1_FREEFALL] =3D REG_FIELD(MSA311_INT_MAP_0_REG, 0, 0),
+
+	[F_INT1_NEW_DATA] =3D REG_FIELD(MSA311_INT_MAP_1_REG, 0, 0),
+
+	[F_INT1_OD] =3D REG_FIELD(MSA311_INT_CONFIG_REG, 1, 1),
+	[F_INT1_LVL] =3D REG_FIELD(MSA311_INT_CONFIG_REG, 0, 0),
+
+	[F_RESET_INT] =3D REG_FIELD(MSA311_INT_LATCH_REG, 7, 7),
+	[F_LATCH_INT] =3D REG_FIELD(MSA311_INT_LATCH_REG, 0, 3),
+
+	[F_FREEFALL_MODE] =3D REG_FIELD(MSA311_FREEFALL_HY_REG, 2, 2),
+	[F_FREEFALL_HY] =3D REG_FIELD(MSA311_FREEFALL_HY_REG, 0, 1),
+
+	[F_ACTIVE_DUR] =3D REG_FIELD(MSA311_ACTIVE_DUR_REG, 0, 1),
+
+	[F_TAP_QUIET] =3D REG_FIELD(MSA311_TAP_DUR_REG, 7, 7),
+	[F_TAP_SHOCK] =3D REG_FIELD(MSA311_TAP_DUR_REG, 6, 6),
+	[F_TAP_DUR] =3D REG_FIELD(MSA311_TAP_DUR_REG, 0, 2),
+
+	[F_TAP_TH] =3D REG_FIELD(MSA311_TAP_TH_REG, 0, 4),
+
+	[F_ORIENT_HYST] =3D REG_FIELD(MSA311_ORIENT_HY_REG, 4, 6),
+	[F_ORIENT_BLOCKING] =3D REG_FIELD(MSA311_ORIENT_HY_REG, 2, 3),
+	[F_ORIENT_MODE] =3D REG_FIELD(MSA311_ORIENT_HY_REG, 0, 1),
+
+	[F_Z_BLOCKING] =3D REG_FIELD(MSA311_Z_BLOCK_REG, 0, 3),
+};
+
+#define MSA311_WHO_AM_I 0x13
+
+/*
+ * Possible Full Scale ranges
+ *
+ * Axis data is 12-bit signed value, so
+ *
+ * fs0 =3D (2 + 2) * 9.81 / (2<<11) =3D 0.009580
+ * fs1 =3D (4 + 4) * 9.81 / (2<<11) =3D 0.019160
+ * fs2 =3D (8 + 8) * 9.81 / (2<<11) =3D 0.038320
+ * fs3 =3D (16 + 16) * 9.81 / (2<<11) =3D 0.076641
+ */
+enum {
+	MSA311_FS_2G,
+	MSA311_FS_4G,
+	MSA311_FS_8G,
+	MSA311_FS_16G,
+};
+
+static const struct {
+	int val;
+	int val2;
+} msa311_fs_table[] =3D {
+	{0, 9580}, {0, 19160}, {0, 38320}, {0, 76641}
+};
+
+/* Possible Output Data Rate values */
+enum {
+	MSA311_ODR_1_HZ,
+	MSA311_ODR_1_95_HZ,
+	MSA311_ODR_3_9_HZ,
+	MSA311_ODR_7_81_HZ,
+	MSA311_ODR_15_63_HZ,
+	MSA311_ODR_31_25_HZ,
+	MSA311_ODR_62_5_HZ,
+	MSA311_ODR_125_HZ,
+	MSA311_ODR_250_HZ,
+	MSA311_ODR_500_HZ,
+	MSA311_ODR_1000_HZ,
+};
+
+static const struct {
+	int val;
+	int val2;
+} msa311_odr_table[] =3D {
+	{1, 0}, {1, 950000}, {3, 900000}, {7, 810000}, {15, 630000},
+	{31, 250000}, {62, 500000}, {125, 0}, {250, 0}, {500, 0}, {1000, 0}
+};
+
+/* All supported power modes */
+#define MSA311_PWR_MODE_NORMAL  0b00
+#define MSA311_PWR_MODE_SUSPEND 0b11
+
+/* Autosuspend delay */
+#define MSA311_PWR_SLEEP_DELAY_MS 2000
+
+/* Possible INT1 types and levels */
+enum {
+	MSA311_INT1_OD_PUSH_PULL,
+	MSA311_INT1_OD_OPEN_DRAIN,
+};
+
+enum {
+	MSA311_INT1_LVL_LOW,
+	MSA311_INT1_LVL_HIGH,
+};
+
+/* Latch INT modes */
+#define MSA311_LATCH_INT_NOT_LATCHED 0b0000
+#define MSA311_LATCH_INT_250MS       0b0001
+#define MSA311_LATCH_INT_500MS       0b0010
+#define MSA311_LATCH_INT_1S          0b0011
+#define MSA311_LATCH_INT_2S          0b0100
+#define MSA311_LATCH_INT_4S          0b0101
+#define MSA311_LATCH_INT_8S          0b0110
+#define MSA311_LATCH_INT_1MS         0b1010
+#define MSA311_LATCH_INT_2MS         0b1011
+#define MSA311_LATCH_INT_25MS        0b1100
+#define MSA311_LATCH_INT_50MS        0b1101
+#define MSA311_LATCH_INT_100MS       0b1110
+#define MSA311_LATCH_INT_LATCHED     0b0111
+
+static const struct regmap_range msa311_readonly_registers[] =3D {
+	regmap_reg_range(MSA311_PARTID_REG, MSA311_ORIENT_STS_REG),
+};
+
+static const struct regmap_access_table msa311_writeable_table =3D {
+	.no_ranges =3D msa311_readonly_registers,
+	.n_no_ranges =3D ARRAY_SIZE(msa311_readonly_registers),
+};
+
+static const struct regmap_range msa311_writeonly_registers[] =3D {
+	regmap_reg_range(MSA311_SOFT_RESET_REG, MSA311_SOFT_RESET_REG),
+};
+
+static const struct regmap_access_table msa311_readable_table =3D {
+	.no_ranges =3D msa311_writeonly_registers,
+	.n_no_ranges =3D ARRAY_SIZE(msa311_writeonly_registers),
+};
+
+static const struct regmap_range msa311_volatile_registers[] =3D {
+	regmap_reg_range(MSA311_ACC_X_REG, MSA311_ORIENT_STS_REG),
+};
+
+static const struct regmap_access_table msa311_volatile_table =3D {
+	.yes_ranges =3D msa311_volatile_registers,
+	.n_yes_ranges =3D ARRAY_SIZE(msa311_volatile_registers),
+};
+
+static const struct regmap_config msa311_regmap_config =3D {
+	.name =3D "msa311",
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.max_register =3D MSA311_OFFSET_Z_REG,
+	.wr_table =3D &msa311_writeable_table,
+	.rd_table =3D &msa311_readable_table,
+	.volatile_table =3D &msa311_volatile_table,
+	.cache_type =3D REGCACHE_RBTREE,
+};
+
+#define MSA311_GENMASK(field) ({                \
+	typeof(field) _field =3D (field);         \
+	GENMASK(msa311_reg_fields[_field].msb,  \
+		msa311_reg_fields[_field].lsb); \
+})
+
+/**
+ * struct msa311_priv - MSA311 internal private state
+ * @i2c: I2C client object
+ * @lock: Protects msa311 device state between setup and data access routi=
nes
+ *        (power transitions, samp_freq/scale tune, retrieving axes data, =
etc)
+ * @new_data_trig: Optional NEW_DATA interrupt driven trigger used
+ *                 to notify external consumers a new sample is ready
+ * @regs: Underlying I2C bus adapter used to abstract slave
+ *        register accesses
+ * @fields: Abstract objects for each registers fields access
+ */
+struct msa311_priv {
+	struct i2c_client *i2c;
+	struct mutex lock; /* state guard */
+
+	struct iio_trigger *new_data_trig;
+
+	struct regmap *regs;
+	struct regmap_field *fields[F_MAX_FIELDS];
+};
+
+/* Channels */
+
+enum msa311_si {
+	MSA311_SI_X,
+	MSA311_SI_Y,
+	MSA311_SI_Z,
+	MSA311_SI_TIMESTAMP,
+};
+
+#define MSA311_ACCEL_CHANNEL(axis) {                                      =
 \
+	.type =3D IIO_ACCEL,                                                 \
+	.modified =3D 1,                                                     \
+	.channel2 =3D IIO_MOD_##axis,                                        \
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),                      \
+	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SCALE) |              \
+				   BIT(IIO_CHAN_INFO_SAMP_FREQ),           \
+	.info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_SCALE) |    \
+					     BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.scan_index =3D MSA311_SI_##axis,                                    \
+	.scan_type =3D {                                                     \
+		.sign =3D 's',                                               \
+		.realbits =3D 12,                                            \
+		.storagebits =3D 16,                                         \
+		.shift =3D 4,                                                \
+		.endianness =3D IIO_LE,                                      \
+	},                                                                 \
+	.datasheet_name =3D "ACC_"#axis                                      \
+}
+
+static const struct iio_chan_spec msa311_channels[] =3D {
+	MSA311_ACCEL_CHANNEL(X),
+	MSA311_ACCEL_CHANNEL(Y),
+	MSA311_ACCEL_CHANNEL(Z),
+	IIO_CHAN_SOFT_TIMESTAMP(MSA311_SI_TIMESTAMP)
+};
+
+/**
+ * msa311_get_odr() - Read Output Data Rate (ODR) value from MSA311 accel
+ * @msa311: MSA311 internal private state
+ * @odr: output ODR value
+ *
+ * This function should be called under msa311->lock.
+ *
+ * Return: 0 on success, -ERRNO in other failures
+ */
+static inline int msa311_get_odr(struct msa311_priv *msa311, unsigned int =
*odr)
+{
+	int err;
+
+	err =3D regmap_field_read(msa311->fields[F_ODR], odr);
+	if (err)
+		return err;
+
+	/*
+	 * Filter the same 1000Hz ODR register values based on datasheet info.
+	 * ODR can be equal to 1010-1111 for 1000Hz, but function returns 1010
+	 * all the time.
+	 */
+	if (*odr > MSA311_ODR_1000_HZ)
+		*odr =3D MSA311_ODR_1000_HZ;
+
+	return 0;
+}
+
+/**
+ * msa311_set_odr() - Setup Output Data Rate (ODR) value for MSA311 accel
+ * @msa311: MSA311 internal private state
+ * @odr: requested ODR value
+ *
+ * This function should be called under msa311->lock. Possible ODR values:
+ *     - 1Hz (not available in normal mode)
+ *     - 1.95Hz (not available in normal mode)
+ *     - 3.9Hz
+ *     - 7.81Hz
+ *     - 15.63Hz
+ *     - 31.25Hz
+ *     - 62.5Hz
+ *     - 125Hz
+ *     - 250Hz
+ *     - 500Hz
+ *     - 1000Hz
+ *
+ * Return: 0 on success, -EINVAL for bad ODR value in the certain power mo=
de,
+ *         -ERRNO in other failures
+ */
+static inline int msa311_set_odr(struct msa311_priv *msa311, unsigned int =
odr)
+{
+	struct device *dev =3D &msa311->i2c->dev;
+	const char *mode =3D NULL;
+	unsigned int pwr_mode;
+	bool good_odr =3D false;
+	int err;
+
+	err =3D regmap_field_read(msa311->fields[F_PWR_MODE], &pwr_mode);
+	if (err)
+		return err;
+
+	/* Filter bad ODR values */
+	switch (pwr_mode) {
+	case MSA311_PWR_MODE_NORMAL:
+		mode =3D "normal";
+		good_odr =3D (odr > MSA311_ODR_1_95_HZ);
+		break;
+	case MSA311_PWR_MODE_SUSPEND:
+		mode =3D "suspend";
+		break;
+	default:
+		mode =3D "unknown";
+		break;
+	}
+
+	if (!good_odr) {
+		dev_err(dev,
+			"failed to set odr %u.%uHz, not available in %s mode\n",
+			msa311_odr_table[odr].val,
+			msa311_odr_table[odr].val2 / 1000, mode);
+		return -EINVAL;
+	}
+
+	return regmap_field_write(msa311->fields[F_ODR], odr);
+}
+
+/**
+ * msa311_wait_for_next_data() - Wait next accel data available after resu=
me
+ * @msa311: MSA311 internal private state
+ *
+ * Return: 0 on success, -EINTR if msleep() was interrupted,
+ *         -ERRNO in other failures
+ */
+static int msa311_wait_for_next_data(struct msa311_priv *msa311)
+{
+	static const int unintr_thresh_ms =3D 20;
+	struct device *dev =3D &msa311->i2c->dev;
+	unsigned int odr;
+	unsigned long wait_ms;
+	unsigned long freq_uhz;
+	int err;
+
+	err =3D msa311_get_odr(msa311, &odr);
+	if (err) {
+		dev_err(dev, "cannot get actual freq (%d)\n", err);
+		return err;
+	}
+
+	/*
+	 * After msa311 resuming is done, we need to wait for data
+	 * to be refreshed by accel logic.
+	 * A certain timeout is calculated based on the current ODR value.
+	 * If requested timeout isn't so long (let's assume 20ms),
+	 * we can wait for next data in uninterruptible sleep.
+	 */
+	freq_uhz =3D msa311_odr_table[odr].val * USEC_PER_SEC +
+		   msa311_odr_table[odr].val2;
+	wait_ms =3D (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;
+
+	if (wait_ms < unintr_thresh_ms)
+		usleep_range(wait_ms * USEC_PER_MSEC,
+			     unintr_thresh_ms * USEC_PER_MSEC);
+	else
+		return msleep_interruptible(wait_ms) ? -EINTR : 0;
+
+	return 0;
+}
+
+/**
+ * msa311_set_pwr_mode() - Install certain MSA311 power mode
+ * @msa311: MSA311 internal private state
+ * @mode: Power mode can be equal to NORMAL or SUSPEND
+ *
+ * This function should be called under msa311->lock.
+ *
+ * Return: 0 on success, -ERRNO on failure
+ */
+static int msa311_set_pwr_mode(struct msa311_priv *msa311, unsigned int mo=
de)
+{
+	struct device *dev =3D &msa311->i2c->dev;
+	unsigned int prev_mode;
+	int err;
+
+	dev_dbg(dev, "transition to %s mode\n",
+		(mode =3D=3D MSA311_PWR_MODE_NORMAL) ? "normal" :
+		(mode =3D=3D MSA311_PWR_MODE_SUSPEND) ? "suspend" :
+		"unknown");
+
+	err =3D regmap_field_read(msa311->fields[F_PWR_MODE], &prev_mode);
+	if (err)
+		return err;
+
+	err =3D regmap_field_write(msa311->fields[F_PWR_MODE], mode);
+	if (err)
+		return err;
+
+	/* Wait actual data if we wakeup */
+	if (prev_mode =3D=3D MSA311_PWR_MODE_SUSPEND &&
+	    mode =3D=3D MSA311_PWR_MODE_NORMAL)
+		return msa311_wait_for_next_data(msa311);
+
+	return 0;
+}
+
+/**
+ * msa311_get_axis() - Read MSA311 accel data for certain IIO channel axis=
 spec
+ * @msa311: MSA311 internal private state
+ * @chan: IIO channel specification
+ * @axis: Output accel axis data for requested IIO channel spec
+ *
+ * This function should be called under msa311->lock.
+ *
+ * Return: 0 on success, -EINVAL for unknown IIO channel specification,
+ *         -ERRNO in other failures
+ */
+static int msa311_get_axis(struct msa311_priv *msa311,
+			   const struct iio_chan_spec * const chan,
+			   __le16 *axis)
+{
+	struct device *dev =3D &msa311->i2c->dev;
+	unsigned int axis_reg;
+
+	if (chan->scan_index < MSA311_SI_X || chan->scan_index > MSA311_SI_Z) {
+		dev_err(dev, "invalid scan_index value [%d]\n",
+			chan->scan_index);
+		return -EINVAL;
+	}
+
+	/* Axes data layout has 2 byte gap for each axis starting from X axis */
+	axis_reg =3D MSA311_ACC_X_REG + (chan->scan_index << 1);
+
+	return regmap_bulk_read(msa311->regs, axis_reg, axis, sizeof(*axis));
+}
+
+static int msa311_read_raw_data(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2)
+{
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	struct device *dev =3D &msa311->i2c->dev;
+	__le16 axis;
+	int err;
+
+	err =3D pm_runtime_resume_and_get(dev);
+	if (err)
+		return err;
+
+	err =3D iio_device_claim_direct_mode(indio_dev);
+	if (err)
+		return err;
+
+	mutex_lock(&msa311->lock);
+	err =3D msa311_get_axis(msa311, chan, &axis);
+	mutex_unlock(&msa311->lock);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	if (err) {
+		dev_err(dev, "cannot get axis %s (%d)\n",
+			chan->datasheet_name, err);
+		return err;
+	}
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	/*
+	 * Axis data format is:
+	 * ACC_X =3D (ACC_X_MSB[7:0] << 4) | ACC_X_LSB[7:4]
+	 */
+	*val =3D sign_extend32(le16_to_cpu(axis) >> chan->scan_type.shift,
+			     chan->scan_type.realbits - 1);
+
+	return IIO_VAL_INT;
+}
+
+static int msa311_read_scale(struct iio_dev *indio_dev, int *val, int *val=
2)
+{
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	struct device *dev =3D &msa311->i2c->dev;
+	unsigned int fs;
+	int err;
+
+	mutex_lock(&msa311->lock);
+	err =3D regmap_field_read(msa311->fields[F_FS], &fs);
+	mutex_unlock(&msa311->lock);
+
+	if (err) {
+		dev_err(dev, "cannot get actual scale (%d)\n", err);
+		return err;
+	}
+
+	*val =3D msa311_fs_table[fs].val;
+	*val2 =3D msa311_fs_table[fs].val2;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int msa311_read_samp_freq(struct iio_dev *indio_dev,
+				 int *val, int *val2)
+{
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	struct device *dev =3D &msa311->i2c->dev;
+	unsigned int odr;
+	int err;
+
+	mutex_lock(&msa311->lock);
+	err =3D msa311_get_odr(msa311, &odr);
+	mutex_unlock(&msa311->lock);
+
+	if (err) {
+		dev_err(dev, "cannot get actual freq (%d)\n", err);
+		return err;
+	}
+
+	*val =3D msa311_odr_table[odr].val;
+	*val2 =3D msa311_odr_table[odr].val2;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int msa311_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return msa311_read_raw_data(indio_dev, chan, val, val2);
+
+	case IIO_CHAN_INFO_SCALE:
+		return msa311_read_scale(indio_dev, val, val2);
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return msa311_read_samp_freq(indio_dev, val, val2);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int msa311_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type,
+			     int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals =3D (int *)msa311_odr_table;
+		*type =3D IIO_VAL_INT_PLUS_MICRO;
+		/* ODR value has 2 ints (integer and fractional parts) */
+		*length =3D ARRAY_SIZE(msa311_odr_table) * 2;
+		return IIO_AVAIL_LIST;
+
+	case IIO_CHAN_INFO_SCALE:
+		*vals =3D (int *)msa311_fs_table;
+		*type =3D IIO_VAL_INT_PLUS_MICRO;
+		/* FS value has 2 ints (integer and fractional parts) */
+		*length =3D ARRAY_SIZE(msa311_fs_table) * 2;
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int msa311_write_scale(struct iio_dev *indio_dev, int val, int val2=
)
+{
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	struct device *dev =3D &msa311->i2c->dev;
+	unsigned int fs;
+	int err;
+
+	/* We do not have fs >=3D 1, so skip such values */
+	if (val !=3D 0)
+		return 0;
+
+	err =3D pm_runtime_resume_and_get(dev);
+	if (err)
+		return err;
+
+	err =3D -EINVAL;
+	mutex_lock(&msa311->lock);
+	for (fs =3D 0; fs < ARRAY_SIZE(msa311_fs_table); ++fs)
+		/* Do not check msa311_fs_table[fs].val, it's always 0 */
+		if (val2 =3D=3D msa311_fs_table[fs].val2) {
+			err =3D regmap_field_write(msa311->fields[F_FS], fs);
+			if (err) {
+				dev_err(dev, "cannot update scale (%d)\n", err);
+				goto failed;
+			}
+
+			break;
+		}
+
+failed:
+	mutex_unlock(&msa311->lock);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return err;
+}
+
+static int msa311_write_samp_freq(struct iio_dev *indio_dev, int val, int =
val2)
+{
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	struct device *dev =3D &msa311->i2c->dev;
+	unsigned int odr;
+	int err;
+
+	err =3D pm_runtime_resume_and_get(dev);
+	if (err)
+		return err;
+
+	/*
+	 * Sampling frequency changing is prohibited when buffer mode is
+	 * enabled, because sometimes MSA311 chip returns outliers during
+	 * frequency values growing up in the read operation moment.
+	 */
+	err =3D iio_device_claim_direct_mode(indio_dev);
+	if (err)
+		return err;
+
+	err =3D -EINVAL;
+	mutex_lock(&msa311->lock);
+	for (odr =3D 0; odr < ARRAY_SIZE(msa311_odr_table); ++odr)
+		if (val =3D=3D msa311_odr_table[odr].val &&
+		    val2 =3D=3D msa311_odr_table[odr].val2) {
+			err =3D msa311_set_odr(msa311, odr);
+			if (err) {
+				dev_err(dev, "cannot update freq (%d)\n", err);
+				goto failed;
+			}
+
+			break;
+		}
+
+failed:
+	mutex_unlock(&msa311->lock);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return err;
+}
+
+static int msa311_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return msa311_write_scale(indio_dev, val, val2);
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return msa311_write_samp_freq(indio_dev, val, val2);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int msa311_debugfs_reg_access(struct iio_dev *indio_dev,
+				     unsigned int reg, unsigned int writeval,
+				     unsigned int *readval)
+{
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	struct device *dev =3D &msa311->i2c->dev;
+	int err;
+
+	if (reg > regmap_get_max_register(msa311->regs))
+		return -EINVAL;
+
+	err =3D pm_runtime_resume_and_get(dev);
+	if (err)
+		return err;
+
+	mutex_lock(&msa311->lock);
+
+	if (!readval)
+		err =3D regmap_write(msa311->regs, reg, writeval);
+	else
+		err =3D regmap_read(msa311->regs, reg, readval);
+
+	mutex_unlock(&msa311->lock);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	if (err)
+		dev_err(dev, "cannot %s register %u from debugfs (%d)\n",
+			(!readval) ? "write" : "read", reg, err);
+
+	return err;
+}
+
+static int msa311_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	struct device *dev =3D &msa311->i2c->dev;
+
+	return pm_runtime_resume_and_get(dev);
+}
+
+static int msa311_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	struct device *dev =3D &msa311->i2c->dev;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static int msa311_set_new_data_trig_state(struct iio_trigger *trig, bool s=
tate)
+{
+	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	struct device *dev =3D &msa311->i2c->dev;
+	int err;
+
+	mutex_lock(&msa311->lock);
+	err =3D regmap_field_write(msa311->fields[F_NEW_DATA_INT_EN], state);
+	mutex_unlock(&msa311->lock);
+
+	if (err)
+		dev_err(dev,
+			"cannot %s buffer due to new_data_int failure (%d)\n",
+			state ? "enable" : "disable", err);
+
+	return err;
+}
+
+static int msa311_validate_device(struct iio_trigger *trig,
+				  struct iio_dev *indio_dev)
+{
+	return (iio_trigger_get_drvdata(trig) !=3D indio_dev) ? -EINVAL : 0;
+}
+
+static irqreturn_t msa311_buffer_thread(int irq, void *p)
+{
+	struct iio_poll_func *pf =3D p;
+	struct iio_dev *indio_dev =3D pf->indio_dev;
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	struct device *dev =3D &msa311->i2c->dev;
+	const struct iio_chan_spec *chan;
+	__le16 axis;
+	int bit =3D 0, err, i =3D 0;
+
+	/* Ensure correct alignment of time stamp when present */
+	struct {
+		__le16 channels[MSA311_SI_Z + 1];
+		s64 ts __aligned(8);
+	} buf;
+
+	memset(&buf, 0, sizeof(buf));
+
+	mutex_lock(&msa311->lock);
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		chan =3D &msa311_channels[bit];
+
+		err =3D msa311_get_axis(msa311, chan, &axis);
+		if (err) {
+			mutex_unlock(&msa311->lock);
+			dev_err(dev, "cannot get axis %s (%d)\n",
+				chan->datasheet_name, err);
+			goto err;
+		}
+
+		buf.channels[i++] =3D axis;
+	}
+
+	mutex_unlock(&msa311->lock);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &buf,
+					   iio_get_time_ns(indio_dev));
+
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t msa311_irq_thread(int irq, void *p)
+{
+	struct msa311_priv *msa311 =3D iio_priv(p);
+	struct device *dev =3D &msa311->i2c->dev;
+	unsigned int new_data_int_enabled;
+	int err;
+
+	mutex_lock(&msa311->lock);
+
+	/*
+	 * We do not check NEW_DATA int status, because of based on
+	 * specification it's cleared automatically after a fixed time.
+	 * So just check that is enabled by driver logic.
+	 */
+	err =3D regmap_field_read(msa311->fields[F_NEW_DATA_INT_EN],
+				&new_data_int_enabled);
+
+	/* TODO: check motion interrupts status */
+
+	mutex_unlock(&msa311->lock);
+
+	if (err) {
+		dev_err(dev, "cannot read new_data int state (%d)\n", err);
+		return IRQ_NONE;
+	}
+
+	if (new_data_int_enabled)
+		iio_trigger_poll_chained(msa311->new_data_trig);
+
+	/* TODO: send motion events if needed */
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_info msa311_info =3D {
+	.read_raw =3D msa311_read_raw,
+	.read_avail =3D msa311_read_avail,
+	.write_raw =3D msa311_write_raw,
+	.debugfs_reg_access =3D msa311_debugfs_reg_access,
+};
+
+static const struct iio_buffer_setup_ops msa311_buffer_setup_ops =3D {
+	.preenable =3D msa311_buffer_preenable,
+	.postdisable =3D msa311_buffer_postdisable,
+};
+
+static const struct iio_trigger_ops msa311_new_data_trig_ops =3D {
+	.set_trigger_state =3D msa311_set_new_data_trig_state,
+	.validate_device =3D msa311_validate_device,
+};
+
+static int msa311_check_partid(struct msa311_priv *msa311)
+{
+	struct device *dev =3D &msa311->i2c->dev;
+	unsigned int partid;
+	int err;
+
+	err =3D regmap_read(msa311->regs, MSA311_PARTID_REG, &partid);
+	if (err) {
+		dev_err(dev, "failed to read partid (%d)\n", err);
+		return err;
+	}
+
+	dev_dbg(dev, "Found MSA311 compatible chip[%#x]\n", partid);
+
+	if (partid !=3D MSA311_WHO_AM_I)
+		dev_warn(dev, "invalid partid (%#x), expected (%#x)\n",
+			 partid, MSA311_WHO_AM_I);
+
+	return 0;
+}
+
+static int msa311_chip_init(struct msa311_priv *msa311)
+{
+	struct device *dev =3D &msa311->i2c->dev;
+	int err;
+
+	err =3D msa311_check_partid(msa311);
+	if (err)
+		return err;
+
+	/* Soft reset */
+	err =3D regmap_write(msa311->regs, MSA311_SOFT_RESET_REG,
+			   MSA311_GENMASK(F_SOFT_RESET_I2C) |
+			   MSA311_GENMASK(F_SOFT_RESET_SPI));
+	if (err)
+		return dev_err_probe(dev, err, "cannot soft reset all logic\n");
+
+	err =3D msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_NORMAL);
+	if (err)
+		return dev_err_probe(dev, err, "bad normal mode transition\n");
+
+	err =3D regmap_write(msa311->regs, MSA311_RANGE_REG, MSA311_FS_16G);
+	if (err)
+		return dev_err_probe(dev, err, "failed to setup accel range\n");
+
+	/* Disable all interrupts by default */
+	err =3D regmap_write(msa311->regs, MSA311_INT_SET_0_REG, 0);
+	if (err)
+		return dev_err_probe(dev, err, "cannot disable set0 intrs\n");
+
+	err =3D regmap_write(msa311->regs, MSA311_INT_SET_1_REG, 0);
+	if (err)
+		return dev_err_probe(dev, err, "cannot disable set1 intrs\n");
+
+	/* Unmap all INT1 interrupts by default */
+	err =3D regmap_write(msa311->regs, MSA311_INT_MAP_0_REG, 0);
+	if (err)
+		return dev_err_probe(dev, err, "failed to unmap map0 intrs\n");
+
+	err =3D regmap_write(msa311->regs, MSA311_INT_MAP_1_REG, 0);
+	if (err)
+		return dev_err_probe(dev, err, "failed to unmap map1 intrs\n");
+
+	/* Disable all axis by default */
+	err =3D regmap_update_bits(msa311->regs, MSA311_ODR_REG,
+				 MSA311_GENMASK(F_X_AXIS_DIS) |
+				 MSA311_GENMASK(F_Y_AXIS_DIS) |
+				 MSA311_GENMASK(F_Z_AXIS_DIS), 0);
+	if (err)
+		return dev_err_probe(dev, err, "cannot enable all axes\n");
+
+	err =3D msa311_set_odr(msa311, MSA311_ODR_125_HZ);
+	if (err)
+		return dev_err_probe(dev, err, "failed to set accel freq\n");
+
+	return 0;
+}
+
+static int msa311_setup_interrupts(struct msa311_priv *msa311)
+{
+	struct iio_trigger *trig;
+	struct i2c_client *i2c =3D msa311->i2c;
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(i2c);
+	struct device *dev =3D &i2c->dev;
+	int err;
+
+	err =3D devm_request_threaded_irq(dev, i2c->irq,
+					NULL, msa311_irq_thread,
+					IRQF_ONESHOT,
+					i2c->name,
+					indio_dev);
+	if (err)
+		return dev_err_probe(dev, err, "failed to request irq\n");
+
+	trig =3D devm_iio_trigger_alloc(dev, "%s-new-data", i2c->name);
+	if (!trig)
+		return dev_err_probe(dev, -ENOMEM,
+				     "cannot allocate newdata trig\n");
+
+	msa311->new_data_trig =3D trig;
+	msa311->new_data_trig->dev.parent =3D dev;
+	msa311->new_data_trig->ops =3D &msa311_new_data_trig_ops;
+	iio_trigger_set_drvdata(msa311->new_data_trig, indio_dev);
+
+	err =3D devm_iio_trigger_register(dev, msa311->new_data_trig);
+	if (err)
+		return dev_err_probe(dev, err, "can't register newdata trig\n");
+
+	err =3D regmap_field_write(msa311->fields[F_INT1_OD],
+				 MSA311_INT1_OD_PUSH_PULL);
+	if (err)
+		return dev_err_probe(dev, err, "cannot enable push-pull int\n");
+
+	err =3D regmap_field_write(msa311->fields[F_INT1_LVL],
+				 MSA311_INT1_LVL_HIGH);
+	if (err)
+		return dev_err_probe(dev, err, "cannot set active int level\n");
+
+	err =3D regmap_field_write(msa311->fields[F_LATCH_INT],
+				 MSA311_LATCH_INT_LATCHED);
+	if (err)
+		return dev_err_probe(dev, err, "cannot latch int\n");
+
+	err =3D regmap_field_write(msa311->fields[F_RESET_INT], 1);
+	if (err)
+		return dev_err_probe(dev, err, "cannot reset int\n");
+
+	err =3D regmap_field_write(msa311->fields[F_INT1_NEW_DATA], 1);
+	if (err)
+		return dev_err_probe(dev, err, "cannot map new data int\n");
+
+	return 0;
+}
+
+static int msa311_regmap_init(struct msa311_priv *msa311)
+{
+	struct regmap_field **fields =3D msa311->fields;
+	struct device *dev =3D &msa311->i2c->dev;
+	struct regmap *regmap;
+	int i;
+
+	regmap =3D devm_regmap_init_i2c(msa311->i2c, &msa311_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "failed to register i2c regmap\n");
+
+	msa311->regs =3D regmap;
+
+	for (i =3D 0; i < F_MAX_FIELDS; ++i) {
+		fields[i] =3D devm_regmap_field_alloc(dev,
+						    msa311->regs,
+						    msa311_reg_fields[i]);
+		if (IS_ERR(msa311->fields[i])) {
+			return dev_err_probe(dev, PTR_ERR(msa311->fields[i]),
+					     "cannot alloc reg field[%d]\n", i);
+		}
+	}
+
+	return 0;
+}
+
+static void msa311_powerdown(void *dev)
+{
+	/* Resume device if any */
+	pm_runtime_get_sync(dev);
+
+	/* Suspend device right now */
+	pm_runtime_put_sync_suspend(dev);
+}
+
+static int msa311_probe(struct i2c_client *i2c)
+{
+	struct msa311_priv *msa311;
+	struct iio_dev *indio_dev;
+	struct device *dev =3D &i2c->dev;
+	int err;
+
+	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*msa311));
+	if (!indio_dev)
+		return dev_err_probe(dev, -ENOMEM,
+				     "iio device allocation failed\n");
+
+	msa311 =3D iio_priv(indio_dev);
+	msa311->i2c =3D i2c;
+	i2c_set_clientdata(i2c, indio_dev);
+
+	err =3D msa311_regmap_init(msa311);
+	if (err)
+		return err;
+
+	mutex_init(&msa311->lock);
+
+	err =3D devm_pm_runtime_enable(dev);
+	if (err)
+		return err;
+
+	/* Resume msa311 logic before any interactions with registers */
+	err =3D pm_runtime_resume_and_get(dev);
+	if (err)
+		return err;
+
+	pm_runtime_set_autosuspend_delay(dev, MSA311_PWR_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	err =3D msa311_chip_init(msa311);
+	if (err)
+		return err;
+
+	indio_dev->modes =3D INDIO_DIRECT_MODE; /* setup buffered mode later */
+	indio_dev->channels =3D msa311_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(msa311_channels);
+	indio_dev->name =3D i2c->name;
+	indio_dev->info =3D &msa311_info;
+
+	err =3D devm_iio_triggered_buffer_setup(dev,
+					      indio_dev,
+					      iio_pollfunc_store_time,
+					      msa311_buffer_thread,
+					      &msa311_buffer_setup_ops);
+	if (err)
+		return dev_err_probe(dev, err, "cannot setup iio trig buf\n");
+
+	if (i2c->irq > 0) {
+		err =3D msa311_setup_interrupts(msa311);
+		if (err)
+			return err;
+	}
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	/*
+	 * Register powerdown deferred callback which suspends the chip
+	 * after module unloaded.
+	 *
+	 * MSA311 should be in SUSPEND mode in the two cases:
+	 * 1) When driver is loaded, but we do not have any data or
+	 *    configuration requests to it (we are solving it using
+	 *    autosuspend feature).
+	 * 2) When driver is unloaded and device is not used (devm action is
+	 *    used in this case).
+	 */
+	err =3D devm_add_action_or_reset(dev, msa311_powerdown, dev);
+	if (err)
+		return dev_err_probe(dev, err, "cannot add powerdown action\n");
+
+	err =3D devm_iio_device_register(dev, indio_dev);
+	if (err)
+		return dev_err_probe(dev, err, "iio device register failed\n");
+
+	return 0;
+}
+
+static int msa311_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	int err;
+
+	dev_dbg(dev, "suspending %s\n", dev->driver->name);
+
+	mutex_lock(&msa311->lock);
+	err =3D msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_SUSPEND);
+	mutex_unlock(&msa311->lock);
+
+	if (err) {
+		dev_err(dev, "failed to power off device (%d)\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int msa311_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+	struct msa311_priv *msa311 =3D iio_priv(indio_dev);
+	int err;
+
+	dev_dbg(dev, "resuming %s\n", dev->driver->name);
+
+	mutex_lock(&msa311->lock);
+	err =3D msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_NORMAL);
+	mutex_unlock(&msa311->lock);
+
+	if (err) {
+		dev_err(dev, "failed to power on device (%d)\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(msa311_pm_ops, msa311_runtime_suspend,
+				 msa311_runtime_resume, NULL);
+
+static const struct i2c_device_id msa311_i2c_id[] =3D {
+	{ .name =3D "msa311" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, msa311_i2c_id);
+
+static const struct of_device_id msa311_of_match[] =3D {
+	{ .compatible =3D "memsensing,msa311" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, msa311_of_match);
+
+static struct i2c_driver msa311_driver =3D {
+	.driver =3D {
+		.name =3D "msa311",
+		.owner =3D THIS_MODULE,
+		.of_match_table =3D msa311_of_match,
+		.pm =3D pm_ptr(&msa311_pm_ops),
+	},
+	.probe_new	=3D msa311_probe,
+	.id_table	=3D msa311_i2c_id,
+};
+
+module_i2c_driver(msa311_driver);
+
+MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@sberdevices.ru>");
+MODULE_DESCRIPTION("MEMSensing MSA311 3-axis accelerometer driver");
+MODULE_LICENSE("GPL v2");
--=20
2.36.0
