Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBE7A43D4
	for <lists+linux-iio@lfdr.de>; Mon, 18 Sep 2023 10:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjIRIEU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Sep 2023 04:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbjIRIED (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2023 04:04:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E1C1A3;
        Mon, 18 Sep 2023 01:03:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c3d6d88231so32762225ad.0;
        Mon, 18 Sep 2023 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695024207; x=1695629007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7CgDBVjrfVKlRZenIT5IAWMhaz+PJGm8bhGAH5rUzA=;
        b=haDMrxw3SZ2tD8Lj1E1BhahQKAjxihboFCaXDuGRXOIV/Tmu/XAqru6X1Tw0CMF4pa
         AUwaj+29iEIWuD4eVhjRKN3zIIFFHrhe4ElgVBsqlG8zWoHrgPqanb+mumvWOlhwYMJH
         m563vHoiQV/djsHRqM8nV8lNRhuONkV5uomEPG7jcNOQXQVPxvWSuP8A0yqgnnHoV2dw
         eIIeTDwlOY1VwwS42FoIoO9MYL6g7Ryn+JbXcrI4ZmnEF0/LAg+naKmRbdMqvXU7hXLJ
         CSZfQKi231JL3HgnC0W1wF91igQ4tQ4z0zMi3LtLiMGx244ERmpJeaHLjVFcthEn951F
         cN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695024207; x=1695629007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7CgDBVjrfVKlRZenIT5IAWMhaz+PJGm8bhGAH5rUzA=;
        b=srK8wKGiPjiuvkluO0p160TzFH7fifbSwACsI/PtwwVchQbT0njAkz1Y3AkdSJRTdg
         7q7Ar+N1j67gHkYOf1Xow4VDVhqZwobarV2RIQkCV0y3D/mrBz24m0DjYakqj+mrhBGZ
         8qaP2XnlUmHQ2Ji69SNCpqRNIhws2le8fGcZoQnuODDtVDc2Hc4M1L/0XnP05qgxf1F4
         zB+okDpMTxlf/i8CN3AGo414QuF5p1gC4yRzi76FJF2sDDA8ZQWv7JI9HBfYMO/gXnW6
         WMNydyA9FJarDV/u47dU5aiJZfs5TqH3U7ZD0/d8Biql10KqjxQlQln97Mwxavo/eb+A
         RNBA==
X-Gm-Message-State: AOJu0Yy2yO1EExLYAdOoLNEWUyzzS9aMqcF1cVBvDNeupySKpDrW/wjE
        gOmfvP2rGzCMnMNgeiNiqcw=
X-Google-Smtp-Source: AGHT+IHarO0xoz8By0MhB9/bePSWvMmYkOICJCXXTvSjHDKKfcWWKNRtv+8fiJiP3ymhtf10UN6Hqw==
X-Received: by 2002:a17:903:22d0:b0:1c4:5e9e:7865 with SMTP id y16-20020a17090322d000b001c45e9e7865mr4339075plg.0.1695024206290;
        Mon, 18 Sep 2023 01:03:26 -0700 (PDT)
Received: from localhost.localdomain ([115.96.179.37])
        by smtp.gmail.com with ESMTPSA id w18-20020a1709029a9200b001bde877a7casm7716161plp.264.2023.09.18.01.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 01:03:25 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andriy.shevchenko@linux.intel.com,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
Date:   Mon, 18 Sep 2023 13:33:14 +0530
Message-Id: <20230918080314.11959-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230918080314.11959-1-jagathjog1996@gmail.com>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Bosch BMI323 is a 6-axis low-power IMU that provide measurements for
acceleration, angular rate, and temperature. This sensor includes
motion-triggered interrupt features, such as a step counter, tap detection,
and activity/inactivity interrupt capabilities.

The driver supports various functionalities, including data ready, FIFO
data handling, and events such as tap detection, step counting, and
activity interrupts

Datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi323-ds000.pdf
Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 MAINTAINERS                          |    7 +
 drivers/iio/imu/Kconfig              |    1 +
 drivers/iio/imu/Makefile             |    1 +
 drivers/iio/imu/bmi323/Kconfig       |   33 +
 drivers/iio/imu/bmi323/Makefile      |    7 +
 drivers/iio/imu/bmi323/bmi323.h      |  198 +++
 drivers/iio/imu/bmi323/bmi323_core.c | 2260 ++++++++++++++++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c  |  115 ++
 drivers/iio/imu/bmi323/bmi323_spi.c  |  106 ++
 9 files changed, 2728 insertions(+)
 create mode 100644 drivers/iio/imu/bmi323/Kconfig
 create mode 100644 drivers/iio/imu/bmi323/Makefile
 create mode 100644 drivers/iio/imu/bmi323/bmi323.h
 create mode 100644 drivers/iio/imu/bmi323/bmi323_core.c
 create mode 100644 drivers/iio/imu/bmi323/bmi323_i2c.c
 create mode 100644 drivers/iio/imu/bmi323/bmi323_spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fe86f4ec383..7479e187270a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3605,6 +3605,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
 F:	drivers/iio/accel/bma400*
 
+BOSCH SENSORTEC BMI323 IMU IIO DRIVER
+M:	Jagath Jog J <jagathjog1996@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/imu/bosch,bma400.yaml
+F:	drivers/iio/imu/bmi323/
+
 BPF JIT for ARM
 M:	Shubham Bansal <illusionist.neo@gmail.com>
 L:	bpf@vger.kernel.org
diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index c2f97629e9cd..6c9a85294bc1 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -54,6 +54,7 @@ config ADIS16480
 
 source "drivers/iio/imu/bmi160/Kconfig"
 source "drivers/iio/imu/bno055/Kconfig"
+source "drivers/iio/imu/bmi323/Kconfig"
 
 config FXOS8700
 	tristate
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index 6eb612034722..627406476357 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_IIO_ADIS_LIB) += adis_lib.o
 
 obj-y += bmi160/
 obj-y += bno055/
+obj-y += bmi323/
 
 obj-$(CONFIG_FXOS8700) += fxos8700_core.o
 obj-$(CONFIG_FXOS8700_I2C) += fxos8700_i2c.o
diff --git a/drivers/iio/imu/bmi323/Kconfig b/drivers/iio/imu/bmi323/Kconfig
new file mode 100644
index 000000000000..ab37b285393c
--- /dev/null
+++ b/drivers/iio/imu/bmi323/Kconfig
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# BMI323 IMU driver
+#
+
+config BMI323
+	tristate
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+
+config BMI323_I2C
+	tristate "Bosch BMI323 I2C driver"
+	depends on I2C
+	select BMI323
+	select REGMAP_I2C
+	help
+	  Enable support for the Bosch BMI323 6-Axis IMU connected to I2C
+	  interface.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called bmi323_i2c.
+
+config BMI323_SPI
+	tristate "Bosch BMI323 SPI driver"
+	depends on SPI
+	select BMI323
+	select REGMAP_SPI
+	help
+	  Enable support for the Bosch BMI323 6-Axis IMU connected to SPI
+	  interface.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called bmi323_spi.
diff --git a/drivers/iio/imu/bmi323/Makefile b/drivers/iio/imu/bmi323/Makefile
new file mode 100644
index 000000000000..a6a6dc0207c9
--- /dev/null
+++ b/drivers/iio/imu/bmi323/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Bosch BMI323 IMU
+#
+obj-$(CONFIG_BMI323) += bmi323_core.o
+obj-$(CONFIG_BMI323_I2C) += bmi323_i2c.o
+obj-$(CONFIG_BMI323_SPI) += bmi323_spi.o
diff --git a/drivers/iio/imu/bmi323/bmi323.h b/drivers/iio/imu/bmi323/bmi323.h
new file mode 100644
index 000000000000..bb04894761ee
--- /dev/null
+++ b/drivers/iio/imu/bmi323/bmi323.h
@@ -0,0 +1,198 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * IIO driver for Bosch BMI323 6-Axis IMU
+ *
+ * Copyright (C) 2023, Jagath Jog J <jagathjog1996@gmail.com>
+ */
+
+#ifndef _BMI323_H_
+#define _BMI323_H_
+
+#include <linux/regmap.h>
+#include <linux/bits.h>
+
+#define BMI323_I2C_DUMMY			2
+#define BMI323_SPI_DUMMY			1
+
+/* Register map */
+
+#define BMI323_CHIP_ID_REG			0x00
+#define BMI323_CHIP_ID_VAL			0x0043
+#define BMI323_ERR_REG				0x01
+#define BMI323_STATUS_REG			0x02
+
+/* Accelero/Gyro/Temp data registers */
+#define BMI323_ACCEL_X_REG			0x03
+#define BMI323_GYRO_X_REG			0x06
+#define BMI323_TEMP_REG				0x09
+
+/* Status registers */
+#define BMI323_STATUS_INT1_REG			0x0D
+#define BMI323_STATUS_INT2_REG			0x0E
+#define BMI323_STATUS_NOMOTION_MSK		BIT(0)
+#define BMI323_STATUS_MOTION_MSK		BIT(1)
+#define BMI323_STATUS_STP_WTR_MSK		BIT(5)
+#define BMI323_STATUS_TAP_MSK			BIT(8)
+#define BMI323_STATUS_ERROR_MSK			BIT(10)
+#define BMI323_STATUS_TMP_DRDY_MSK		BIT(11)
+#define BMI323_STATUS_GYR_DRDY_MSK		BIT(12)
+#define BMI323_STATUS_ACC_DRDY_MSK		BIT(13)
+#define BMI323_STATUS_ACC_GYR_DRDY_MSK		GENMASK(13, 12)
+#define BMI323_STATUS_FIFO_WTRMRK_MSK		BIT(14)
+#define BMI323_STATUS_FIFO_FULL_MSK		BIT(15)
+
+/* Feature registers */
+#define BMI323_FEAT_IO0_REG			0x10
+#define BMI323_FEAT_IO0_XYZ_NOMOTION_MSK	GENMASK(2, 0)
+#define BMI323_FEAT_IO0_XYZ_MOTION_MSK		GENMASK(5, 3)
+#define BMI323_FEAT_IO0_STP_CNT_MSK		BIT(9)
+#define BMI323_FEAT_IO0_S_TAP_MSK		BIT(12)
+#define BMI323_FEAT_IO0_D_TAP_MSK		BIT(13)
+#define BMI323_FEAT_IO1_REG			0x11
+#define BMI323_FEAT_IO2_REG			0x12
+#define BMI323_FEAT_IO_STATUS_REG		0x14
+#define BMI323_FEAT_IO_STATUS_MSK		BIT(0)
+
+/* FIFO registers */
+#define BMI323_FIFO_FILL_LEVEL_REG		0x15
+#define BMI323_FIFO_DATA_REG			0x16
+
+/* Accelero/Gyro config registers */
+#define BMI323_ACC_CONF_REG			0x20
+#define BMI323_GYRO_CONF_REG			0x21
+#define BMI323_ACC_GYRO_CONF_MODE_MSK		GENMASK(14, 12)
+#define BMI323_ACC_GYRO_CONF_ODR_MSK		GENMASK(3, 0)
+#define BMI323_ACC_GYRO_CONF_SCL_MSK		GENMASK(6, 4)
+#define BMI323_ACC_GYRO_CONF_BW_MSK		BIT(7)
+#define BMI323_ACC_GYRO_CONF_AVG_MSK		GENMASK(10, 8)
+
+/* FIFO registers */
+#define BMI323_FIFO_WTRMRK_REG			0x35
+#define BMI323_FIFO_CONF_REG			0x36
+#define BMI323_FIFO_CONF_STP_FUL_MSK		BIT(0)
+#define BMI323_FIFO_CONF_ACC_GYR_EN_MSK		GENMASK(10, 9)
+#define BMI323_FIFO_CTRL_REG			0x37
+#define BMI323_FIFO_FLUSH_MSK			BIT(0)
+
+/* Interrupt pin config registers */
+#define BMI323_IO_INT_CTR_REG			0x38
+#define BMI323_IO_INT1_LVL_MSK			BIT(0)
+#define BMI323_IO_INT1_OD_MSK			BIT(1)
+#define BMI323_IO_INT1_OP_EN_MSK		BIT(2)
+#define BMI323_IO_INT1_LVL_OD_OP_MSK		GENMASK(2, 0)
+#define BMI323_IO_INT2_LVL_MSK			BIT(8)
+#define BMI323_IO_INT2_OD_MSK			BIT(9)
+#define BMI323_IO_INT2_OP_EN_MSK		BIT(10)
+#define BMI323_IO_INT2_LVL_OD_OP_MSK		GENMASK(10, 8)
+#define BMI323_IO_INT_CONF_REG			0x39
+#define BMI323_IO_INT_LTCH_MSK			BIT(0)
+#define BMI323_INT_MAP1_REG			0x3A
+#define BMI323_INT_MAP2_REG			0x3B
+#define BMI323_NOMOTION_MSK			GENMASK(1, 0)
+#define BMI323_MOTION_MSK			GENMASK(3, 2)
+#define BMI323_STEP_CNT_MSK			GENMASK(11, 10)
+#define BMI323_TAP_MSK				GENMASK(1, 0)
+#define BMI323_TMP_DRDY_MSK			GENMASK(7, 6)
+#define BMI323_GYR_DRDY_MSK			GENMASK(9, 8)
+#define BMI323_ACC_DRDY_MSK			GENMASK(11, 10)
+#define BMI323_FIFO_WTRMRK_MSK			GENMASK(13, 12)
+#define BMI323_FIFO_FULL_MSK			GENMASK(15, 14)
+
+/* Feature registers */
+#define BMI323_FEAT_CTRL_REG			0x40
+#define BMI323_FEAT_ENG_EN_MSK			BIT(0)
+#define BMI323_FEAT_DATA_ADDR			0x41
+#define BMI323_FEAT_DATA_TX			0x42
+#define BMI323_FEAT_DATA_STATUS			0x43
+#define BMI323_FEAT_DATA_TX_RDY_MSK		BIT(1)
+#define BMI323_FEAT_EVNT_EXT_REG		0x47
+#define BMI323_FEAT_EVNT_EXT_S_MSK		BIT(3)
+#define BMI323_FEAT_EVNT_EXT_D_MSK		BIT(4)
+
+#define BMI323_CMD_REG				0x7E
+#define BMI323_RST_VAL				0xDEAF
+#define BMI323_CFG_RES_REG			0x7F
+
+/* Extended registers */
+#define BMI323_GEN_SET1_REG			0x02
+#define BMI323_GEN_SET1_MODE_MSK		BIT(0)
+#define BMI323_GEN_HOLD_DUR_MSK			GENMASK(4, 1)
+
+/* Any Motion/No Motion config registers */
+#define BMI323_ANYMO1_REG			0x05
+#define BMI323_NOMO1_REG			0x08
+#define BMI323_MO2_OFFSET			0x01
+#define BMI323_MO3_OFFSET			0x02
+#define BMI323_MO1_REF_UP_MSK			BIT(12)
+#define BMI323_MO1_SLOPE_TH_MSK			GENMASK(11, 0)
+#define BMI323_MO2_HYSTR_MSK			GENMASK(9, 0)
+#define BMI323_MO3_DURA_MSK			GENMASK(12, 0)
+
+/* Step counter config registers */
+#define BMI323_STEP_SC1_REG			0x10
+#define BMI323_STEP_SC1_WTRMRK_MSK		GENMASK(9, 0)
+#define BMI323_STEP_SC1_RST_CNT_MSK		BIT(10)
+#define BMI323_STEP_SC1_REG			0x10
+
+/* Tap gesture config registers */
+#define BMI323_TAP1_REG				0x1E
+#define BMI323_TAP1_AXIS_SEL_MSK		GENMASK(1, 0)
+#define BMI323_TAP1_TIMOUT_MSK			BIT(2)
+#define BMI323_TAP1_MAX_PEAKS_MSK		GENMASK(5, 3)
+#define BMI323_TAP1_MODE_MSK			GENMASK(7, 6)
+#define BMI323_TAP2_REG				0x1F
+#define BMI323_TAP2_THRES_MSK			GENMASK(9, 0)
+#define BMI323_TAP2_MAX_DUR_MSK			GENMASK(15, 10)
+#define BMI323_TAP3_REG				0x20
+#define BMI323_TAP3_QUIET_TIM_MSK		GENMASK(15, 12)
+#define BMI323_TAP3_QT_BW_TAP_MSK		GENMASK(11, 8)
+#define BMI323_TAP3_QT_AFT_GES_MSK		GENMASK(15, 12)
+
+#define BMI323_MOTION_THRES_SCALE		512
+#define BMI323_MOTION_HYSTR_SCALE		512
+#define BMI323_MOTION_DURAT_SCALE		50
+#define BMI323_TAP_THRES_SCALE			512
+#define BMI323_DUR_BW_TAP_SCALE			200
+#define BMI323_QUITE_TIM_GES_SCALE		25
+#define BMI323_MAX_GES_DUR_SCALE		25
+
+/*
+ * The formula to calculate temperature in C.
+ * See datasheet section 6.1.1, Register Map Overview
+ *
+ * T_C = (temp_raw / 512) + 23
+ */
+#define BMI323_TEMP_OFFSET			11776
+#define BMI323_TEMP_SCALE			1953125
+
+/*
+ * The BMI323 features a FIFO with a capacity of 2048 bytes. Each frame
+ * consists of accelerometer (X, Y, Z) data and gyroscope (X, Y, Z) data,
+ * totaling 6 words or 12 bytes. The FIFO buffer can hold a total of
+ * 170 frames.
+ *
+ * If a watermark interrupt is configured for 170 frames, the interrupt will
+ * trigger when the FIFO reaches 169 frames, so limit the maximum watermark
+ * level to 169 frames. In terms of data, 169 frames would equal 1014 bytes,
+ * which is approximately 2 frames before the FIFO reaches its full capacity.
+ * See datasheet section 5.7.3 FIFO Buffer Interrupts
+ */
+#define BMI323_BYTES_PER_SAMPLE			2
+#define BMI323_FIFO_LENGTH_IN_BYTES		2048
+#define BMI323_FIFO_FRAME_LENGTH		6
+#define BMI323_FIFO_FULL_IN_FRAMES		\
+	((BMI323_FIFO_LENGTH_IN_BYTES /		\
+	(BMI323_BYTES_PER_SAMPLE * BMI323_FIFO_FRAME_LENGTH)) - 1)
+#define BMI323_FIFO_FULL_IN_WORDS		\
+	(BMI323_FIFO_FULL_IN_FRAMES * BMI323_FIFO_FRAME_LENGTH)
+
+#define BMI323_INT_MICRO_TO_RAW(val, val2, scale) (((val) * (scale)) + \
+						  (((val2) * (scale)) / MEGA))
+
+#define BMI323_RAW_TO_MICRO(raw, scale) ((((raw) % (scale)) * MEGA) / scale)
+
+struct device;
+int bmi323_core_probe(struct device *dev);
+extern const struct regmap_config bmi323_regmap_config;
+
+#endif
diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
new file mode 100644
index 000000000000..adbcfbc6b97d
--- /dev/null
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -0,0 +1,2260 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IIO core driver for Bosch BMI323 6-Axis IMU.
+ *
+ * Copyright (C) 2023, Jagath Jog J <jagathjog1996@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/units.h>
+
+#include <asm/unaligned.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include "bmi323.h"
+
+enum bmi323_sensor_type {
+	BMI323_ACCEL,
+	BMI323_GYRO,
+};
+
+enum bmi323_opr_mode {
+	ACC_GYRO_MODE_DISABLE = 0x00,
+	GYRO_DRIVE_MODE_ENABLED = 0x01,
+	ACC_GYRO_MODE_DUTYCYCLE = 0x03,
+	ACC_GYRO_MODE_CONTINOUS = 0x04,
+	ACC_GYRO_MODE_HIGH_PERF = 0x07,
+};
+
+enum bmi323_state {
+	BMI323_IDLE,
+	BMI323_BUFFER_DRDY_TRIGGERED,
+	BMI323_BUFFER_FIFO,
+};
+
+enum bmi323_irq_pin {
+	BMI323_IRQ_DISABLED,
+	BMI323_IRQ_INT1,
+	BMI323_IRQ_INT2,
+};
+
+enum bmi323_3db_bw {
+	BMI323_BW_ODR_BY_2,
+	BMI323_BW_ODR_BY_4,
+};
+
+enum bmi323_scan {
+	BMI323_ACCEL_X,
+	BMI323_ACCEL_Y,
+	BMI323_ACCEL_Z,
+	BMI323_GYRO_X,
+	BMI323_GYRO_Y,
+	BMI323_GYRO_Z,
+	BMI323_CHAN_MAX
+};
+
+struct bmi323_hw {
+	u8 data;
+	u8 config;
+	const int (*scale_table)[2];
+	int scale_table_len;
+};
+
+/*
+ * The accelerometer supports +-2G/4G/8G/16G ranges, and the resolution of
+ * each sample is 16 bits, signed.
+ * At +-8G the scale can calculated by
+ * ((8 + 8) * 9.80665 / (2^16 - 1)) * 10^6 = 2394.23819 scale in micro
+ *
+ */
+static const int bmi323_accel_scale[][2] = {
+	{ 0, 598 },
+	{ 0, 1197 },
+	{ 0, 2394 },
+	{ 0, 4788 },
+};
+
+static const int bmi323_gyro_scale[][2] = {
+	{ 0, 66 },
+	{ 0, 133 },
+	{ 0, 266 },
+	{ 0, 532 },
+	{ 0, 1065 },
+};
+
+static const int bmi323_accel_gyro_avrg[] = {0, 2, 4, 8, 16, 32, 64};
+
+static const struct bmi323_hw bmi323_hw[2] = {
+	[BMI323_ACCEL] = {
+		.data = BMI323_ACCEL_X_REG,
+		.config = BMI323_ACC_CONF_REG,
+		.scale_table = bmi323_accel_scale,
+		.scale_table_len = ARRAY_SIZE(bmi323_accel_scale),
+	},
+	[BMI323_GYRO] = {
+		.data = BMI323_GYRO_X_REG,
+		.config = BMI323_GYRO_CONF_REG,
+		.scale_table = bmi323_gyro_scale,
+		.scale_table_len = ARRAY_SIZE(bmi323_gyro_scale),
+	},
+};
+
+struct bmi323_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct iio_mount_matrix orientation;
+	enum bmi323_irq_pin irq_pin;
+	struct iio_trigger *trig;
+	bool drdy_trigger_enabled;
+	enum bmi323_state state;
+	s64 fifo_tstamp, old_fifo_tstamp;
+	u32 odrns[2];
+	u32 odrhz[2];
+	unsigned int feature_events;
+
+	/*
+	 * Lock to protect the members of device's private data from concurrent
+	 * access and also to serialize the access of extended registers.
+	 * See bmi323_write_ext_reg(..) for more info.
+	 */
+	struct mutex mutex;
+	int watermark;
+	__le16 fifo_buff[BMI323_FIFO_FULL_IN_WORDS] __aligned(IIO_DMA_MINALIGN);
+	struct {
+		__le16 channels[6];
+		s64 ts __aligned(8);
+	} buffer;
+	__le16 steps_count[2];
+};
+
+const struct regmap_config bmi323_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = BMI323_CFG_RES_REG,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+EXPORT_SYMBOL_NS_GPL(bmi323_regmap_config, IIO_BMI323);
+
+static const struct iio_mount_matrix *
+bmi323_get_mount_matrix(const struct iio_dev *idev,
+			const struct iio_chan_spec *chan)
+{
+	struct bmi323_data *data = iio_priv(idev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info bmi323_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, bmi323_get_mount_matrix),
+	{ }
+};
+
+static const struct iio_event_spec bmi323_step_wtrmrk_event = {
+	.type = IIO_EV_TYPE_CHANGE,
+	.dir = IIO_EV_DIR_NONE,
+	.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+			       BIT(IIO_EV_INFO_VALUE),
+};
+
+static const struct iio_event_spec bmi323_accel_event[] = {
+	{
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD) |
+				       BIT(IIO_EV_INFO_HYSTERESIS) |
+				       BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD) |
+				       BIT(IIO_EV_INFO_HYSTERESIS) |
+				       BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_SINGLETAP,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+				       BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_RESET_TIMEOUT),
+	},
+	{
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_DOUBLETAP,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+				       BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_RESET_TIMEOUT) |
+				       BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
+	},
+};
+
+#define BMI323_ACCEL_CHANNEL(_type, _axis, _index) {			\
+	.type = _type,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+				    BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type_available =				\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+				    BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = _index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+	},								\
+	.ext_info = bmi323_ext_info,					\
+	.event_spec = bmi323_accel_event,				\
+	.num_event_specs = ARRAY_SIZE(bmi323_accel_event),		\
+}
+
+#define BMI323_GYRO_CHANNEL(_type, _axis, _index) {			\
+	.type = _type,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+				    BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type_available =				\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+				    BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = _index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+	},								\
+	.ext_info = bmi323_ext_info,					\
+}
+
+static const struct iio_chan_spec bmi323_channels[] = {
+	BMI323_ACCEL_CHANNEL(IIO_ACCEL, X, BMI323_ACCEL_X),
+	BMI323_ACCEL_CHANNEL(IIO_ACCEL, Y, BMI323_ACCEL_Y),
+	BMI323_ACCEL_CHANNEL(IIO_ACCEL, Z, BMI323_ACCEL_Z),
+	BMI323_GYRO_CHANNEL(IIO_ANGL_VEL, X, BMI323_GYRO_X),
+	BMI323_GYRO_CHANNEL(IIO_ANGL_VEL, Y, BMI323_GYRO_Y),
+	BMI323_GYRO_CHANNEL(IIO_ANGL_VEL, Z, BMI323_GYRO_Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_OFFSET) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = -1,
+	},
+	{
+		.type = IIO_STEPS,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_ENABLE),
+		.scan_index = -1,
+		.event_spec = &bmi323_step_wtrmrk_event,
+		.num_event_specs = 1,
+
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(BMI323_CHAN_MAX),
+};
+
+static const int bmi323_acc_gyro_odr[][2] = {
+	{ 0, 781250 },
+	{ 1, 562500 },
+	{ 3, 125000 },
+	{ 6, 250000 },
+	{ 12, 500000 },
+	{ 25, 0 },
+	{ 50, 0 },
+	{ 100, 0 },
+	{ 200, 0 },
+	{ 400, 0 },
+	{ 800, 0 },
+};
+
+static const int bmi323_acc_gyro_odrns[] = {
+	1280 * MEGA,
+	640 * MEGA,
+	320 * MEGA,
+	160 * MEGA,
+	80 * MEGA,
+	40 * MEGA,
+	20 * MEGA,
+	10 * MEGA,
+	5 * MEGA,
+	2500000,
+	1250000,
+};
+
+static enum bmi323_sensor_type bmi323_iio_to_sensor(enum iio_chan_type iio_type)
+{
+	switch (iio_type) {
+	case IIO_ACCEL:
+		return BMI323_ACCEL;
+	case IIO_ANGL_VEL:
+		return BMI323_GYRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi323_set_mode(struct bmi323_data *data,
+			   enum bmi323_sensor_type sensor,
+			   enum bmi323_opr_mode mode)
+{
+	return regmap_update_bits(data->regmap, bmi323_hw[sensor].config,
+				  BMI323_ACC_GYRO_CONF_MODE_MSK,
+				  FIELD_PREP(BMI323_ACC_GYRO_CONF_MODE_MSK,
+					     mode));
+}
+
+/*
+ * When writing data to extended register there must be no communication to
+ * any other register before write transaction is complete.
+ * See datasheet section 6.2 Extended Register Map Description.
+ */
+static int bmi323_write_ext_reg(struct bmi323_data *data, unsigned int ext_addr,
+				unsigned int ext_data)
+{
+	int ret, feature_status;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_read(data->regmap, BMI323_FEAT_DATA_STATUS,
+			  &feature_status);
+	if (ret)
+		goto unlock_out;
+
+	if (!FIELD_GET(BMI323_FEAT_DATA_TX_RDY_MSK, feature_status)) {
+		ret = -EBUSY;
+		goto unlock_out;
+	}
+
+	ret = regmap_write(data->regmap, BMI323_FEAT_DATA_ADDR, ext_addr);
+	if (ret)
+		goto unlock_out;
+
+	ret = regmap_write(data->regmap, BMI323_FEAT_DATA_TX, ext_data);
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+/*
+ * When reading data from extended register there must be no communication to
+ * any other register before read transaction is complete.
+ * See datasheet section 6.2 Extended Register Map Description.
+ */
+static int bmi323_read_ext_reg(struct bmi323_data *data, unsigned int ext_addr,
+			       unsigned int *ext_data)
+{
+	int ret, feature_status;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_read(data->regmap, BMI323_FEAT_DATA_STATUS,
+			  &feature_status);
+	if (ret)
+		goto unlock_out;
+
+	if (!FIELD_GET(BMI323_FEAT_DATA_TX_RDY_MSK, feature_status)) {
+		ret = -EBUSY;
+		goto unlock_out;
+	}
+
+	ret = regmap_write(data->regmap, BMI323_FEAT_DATA_ADDR, ext_addr);
+	if (ret)
+		goto unlock_out;
+
+	ret = regmap_read(data->regmap, BMI323_FEAT_DATA_TX, ext_data);
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static int bmi323_update_ext_reg(struct bmi323_data *data,
+				 unsigned int ext_addr,
+				 unsigned int mask, unsigned int ext_data)
+{
+	unsigned int value;
+	int ret;
+
+	ret = bmi323_read_ext_reg(data, ext_addr, &value);
+	if (ret)
+		return ret;
+
+	set_mask_bits(&value, mask, ext_data);
+
+	ret = bmi323_write_ext_reg(data, ext_addr, value);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int bmi323_get_error_status(struct bmi323_data *data)
+{
+	int error, ret;
+
+	ret = regmap_read(data->regmap, BMI323_ERR_REG, &error);
+	if (ret)
+		return ret;
+
+	if (error)
+		dev_err(data->dev, "Sensor error 0x%x\n", error);
+
+	return error;
+}
+
+static int bmi323_feature_engine_events(struct bmi323_data *data,
+					const unsigned int event_mask,
+					bool state)
+{
+	unsigned int value;
+	int ret;
+
+	ret = regmap_read(data->regmap, BMI323_FEAT_IO0_REG, &value);
+	if (ret)
+		return ret;
+
+	/* Register must be cleared before changing an active config */
+	ret = regmap_write(data->regmap, BMI323_FEAT_IO0_REG, 0);
+	if (ret)
+		return ret;
+
+	if (state)
+		value |= event_mask;
+	else
+		value &= ~event_mask;
+
+	ret = regmap_write(data->regmap, BMI323_FEAT_IO0_REG, value);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->regmap, BMI323_FEAT_IO_STATUS_REG,
+			    BMI323_FEAT_IO_STATUS_MSK);
+}
+
+static int bmi323_step_wtrmrk_en(struct bmi323_data *data, int state)
+{
+	enum bmi323_irq_pin step_irq;
+	int ret;
+
+	mutex_lock(&data->mutex);
+	if (!FIELD_GET(BMI323_FEAT_IO0_STP_CNT_MSK, data->feature_events)) {
+		mutex_unlock(&data->mutex);
+		return -EINVAL;
+	}
+	mutex_unlock(&data->mutex);
+
+	if (state)
+		step_irq = data->irq_pin;
+	else
+		step_irq = BMI323_IRQ_DISABLED;
+
+	ret = bmi323_update_ext_reg(data, BMI323_STEP_SC1_REG,
+				    BMI323_STEP_SC1_WTRMRK_MSK,
+				    FIELD_PREP(BMI323_STEP_SC1_WTRMRK_MSK,
+					       state ? 1 : 0));
+	if (ret)
+		return ret;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, BMI323_INT_MAP1_REG,
+				 BMI323_STEP_CNT_MSK,
+				 FIELD_PREP(BMI323_STEP_CNT_MSK, step_irq));
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int bmi323_motion_config_reg(enum iio_event_direction dir)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return BMI323_ANYMO1_REG;
+	case IIO_EV_DIR_FALLING:
+		return BMI323_NOMO1_REG;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi323_motion_event_en(struct bmi323_data *data,
+				  enum iio_event_direction dir, int state)
+{
+	int config, ret, msk, raw, field_value = 0;
+	enum bmi323_irq_pin motion_irq;
+	int irq_msk, irq_field_val;
+
+	if (state)
+		motion_irq = data->irq_pin;
+	else
+		motion_irq = BMI323_IRQ_DISABLED;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		msk = BMI323_FEAT_IO0_XYZ_MOTION_MSK;
+		raw = 512;
+		config = BMI323_ANYMO1_REG;
+		irq_msk = BMI323_MOTION_MSK;
+		set_mask_bits(&irq_field_val, BMI323_MOTION_MSK,
+			      FIELD_PREP(BMI323_MOTION_MSK, motion_irq));
+		set_mask_bits(&field_value, BMI323_FEAT_IO0_XYZ_MOTION_MSK,
+			      FIELD_PREP(BMI323_FEAT_IO0_XYZ_MOTION_MSK,
+					 state ? 7 : 0));
+		break;
+	case IIO_EV_DIR_FALLING:
+		msk = BMI323_FEAT_IO0_XYZ_NOMOTION_MSK;
+		raw = 0;
+		config = BMI323_NOMO1_REG;
+		irq_msk = BMI323_NOMOTION_MSK;
+		set_mask_bits(&irq_field_val, BMI323_NOMOTION_MSK,
+			      FIELD_PREP(BMI323_NOMOTION_MSK, motion_irq));
+		set_mask_bits(&field_value, BMI323_FEAT_IO0_XYZ_NOMOTION_MSK,
+			      FIELD_PREP(BMI323_FEAT_IO0_XYZ_NOMOTION_MSK,
+					 state ? 7 : 0));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&data->mutex);
+	ret = bmi323_feature_engine_events(data, msk, state);
+	mutex_unlock(&data->mutex);
+	if (ret)
+		return ret;
+
+	ret = bmi323_update_ext_reg(data, config,
+				    BMI323_MO1_REF_UP_MSK,
+				    FIELD_PREP(BMI323_MO1_REF_UP_MSK, 0));
+	if (ret)
+		return ret;
+
+	/* Set initial value to avoid interrupts while enabling*/
+	ret = bmi323_update_ext_reg(data, config,
+				    BMI323_MO1_SLOPE_TH_MSK,
+				    FIELD_PREP(BMI323_MO1_SLOPE_TH_MSK, raw));
+	if (ret)
+		return ret;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, BMI323_INT_MAP1_REG, irq_msk,
+				 irq_field_val);
+	if (ret)
+		goto unlock_out;
+
+	set_mask_bits(&data->feature_events, msk, field_value);
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static int bmi323_tap_event_en(struct bmi323_data *data,
+			       enum iio_event_direction dir, int state)
+{
+	enum bmi323_irq_pin tap_irq;
+	int ret, tap_enabled;
+
+	mutex_lock(&data->mutex);
+	if (data->odrhz[BMI323_ACCEL] < 200) {
+		dev_err(data->dev, "Invalid accelrometer parameter\n");
+		ret = -EINVAL;
+		goto unlock_out;
+	}
+
+	switch (dir) {
+	case IIO_EV_DIR_SINGLETAP:
+		ret = bmi323_feature_engine_events(data,
+						   BMI323_FEAT_IO0_S_TAP_MSK,
+						   state);
+		if (ret)
+			goto unlock_out;
+
+		set_mask_bits(&data->feature_events, BMI323_FEAT_IO0_S_TAP_MSK,
+			      FIELD_PREP(BMI323_FEAT_IO0_S_TAP_MSK, state));
+		break;
+	case IIO_EV_DIR_DOUBLETAP:
+		ret = bmi323_feature_engine_events(data,
+						   BMI323_FEAT_IO0_D_TAP_MSK,
+						   state);
+		if (ret)
+			goto unlock_out;
+
+		set_mask_bits(&data->feature_events, BMI323_FEAT_IO0_D_TAP_MSK,
+			      FIELD_PREP(BMI323_FEAT_IO0_D_TAP_MSK, state));
+		break;
+	default:
+		ret = -EINVAL;
+		goto unlock_out;
+	}
+
+	tap_enabled = FIELD_GET(BMI323_FEAT_IO0_S_TAP_MSK |
+				BMI323_FEAT_IO0_D_TAP_MSK,
+				data->feature_events);
+
+	if (tap_enabled)
+		tap_irq = data->irq_pin;
+	else
+		tap_irq = BMI323_IRQ_DISABLED;
+
+	ret = regmap_update_bits(data->regmap, BMI323_INT_MAP2_REG,
+				 BMI323_TAP_MSK,
+				 FIELD_PREP(BMI323_TAP_MSK, tap_irq));
+	if (ret)
+		goto unlock_out;
+
+	mutex_unlock(&data->mutex);
+
+	if (state) {
+		ret = bmi323_update_ext_reg(data, BMI323_TAP1_REG,
+					    BMI323_TAP1_MAX_PEAKS_MSK,
+					    FIELD_PREP(BMI323_TAP1_MAX_PEAKS_MSK,
+						       0x04));
+		if (ret)
+			return ret;
+
+		ret = bmi323_update_ext_reg(data, BMI323_TAP1_REG,
+					    BMI323_TAP1_AXIS_SEL_MSK,
+					    FIELD_PREP(BMI323_TAP1_AXIS_SEL_MSK,
+						       0x03));
+		if (ret)
+			return ret;
+
+		return bmi323_update_ext_reg(data, BMI323_TAP1_REG,
+					     BMI323_TAP1_TIMOUT_MSK,
+					     FIELD_PREP(BMI323_TAP1_TIMOUT_MSK,
+							0));
+	}
+
+	return ret;
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static ssize_t in_accel_gesture_tap_max_dur_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bmi323_data *data = iio_priv(indio_dev);
+	unsigned int reg_value, raw;
+	int ret, val[2];
+
+	ret = bmi323_read_ext_reg(data, BMI323_TAP2_REG, &reg_value);
+	if (ret)
+		return ret;
+
+	raw = FIELD_GET(BMI323_TAP2_MAX_DUR_MSK, reg_value);
+	val[0] = raw / BMI323_MAX_GES_DUR_SCALE;
+	val[1] = BMI323_RAW_TO_MICRO(raw, BMI323_MAX_GES_DUR_SCALE);
+
+	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, val);
+}
+
+static ssize_t in_accel_gesture_tap_max_dur_store(struct device *dev,
+						  struct device_attribute *attr,
+						  const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bmi323_data *data = iio_priv(indio_dev);
+	int ret, val_int, val_fract, raw;
+
+	ret = iio_str_to_fixpoint(buf, 100000, &val_int, &val_fract);
+	if (ret)
+		return ret;
+
+	raw = BMI323_INT_MICRO_TO_RAW(val_int, val_fract,
+				      BMI323_MAX_GES_DUR_SCALE);
+	if (raw < 0 || raw > 63)
+		return -EINVAL;
+
+	ret = bmi323_update_ext_reg(data, BMI323_TAP2_REG,
+				    BMI323_TAP2_MAX_DUR_MSK,
+				    FIELD_PREP(BMI323_TAP2_MAX_DUR_MSK, raw));
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+/*
+ * Maximum duration from first tap within the second tap is expected to happen.
+ * This timeout is applicable only if gesture_tap_timeout is enabled.
+ */
+static IIO_DEVICE_ATTR_RW(in_accel_gesture_tap_max_dur, 0);
+
+static ssize_t in_accel_gesture_tap_timeout_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bmi323_data *data = iio_priv(indio_dev);
+	unsigned int reg_value, raw;
+	int ret;
+
+	ret = bmi323_read_ext_reg(data, BMI323_TAP1_REG, &reg_value);
+	if (ret)
+		return ret;
+
+	raw = FIELD_GET(BMI323_TAP1_TIMOUT_MSK, reg_value);
+
+	return iio_format_value(buf, IIO_VAL_INT, 1, &raw);
+}
+
+static ssize_t in_accel_gesture_tap_timeout_store(struct device *dev,
+						  struct device_attribute *attr,
+						  const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bmi323_data *data = iio_priv(indio_dev);
+	int ret, val;
+
+	if (kstrtoint(buf, 10, &val))
+		return -EINVAL;
+
+	if (!(val == 0 || val == 1))
+		return -EINVAL;
+
+	ret = bmi323_update_ext_reg(data, BMI323_TAP1_REG,
+				    BMI323_TAP1_TIMOUT_MSK,
+				    FIELD_PREP(BMI323_TAP1_TIMOUT_MSK, val));
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+/* Enable/disable gesture confirmation with wait time */
+static IIO_DEVICE_ATTR_RW(in_accel_gesture_tap_timeout, 0);
+
+static IIO_CONST_ATTR(in_accel_gesture_tap_max_dur_available,
+		      "[0.0 0.04 2.52]");
+
+static IIO_CONST_ATTR(in_accel_gesture_doubletap_tap2_min_delay_available,
+		      "[0.005 0.005 0.075]");
+
+static IIO_CONST_ATTR(in_accel_gesture_tap_reset_timeout_available,
+		      "[0.04 0.04 0.6]");
+
+static IIO_CONST_ATTR(in_accel_gesture_tap_value_available, "[0.0 0.002 1.99]");
+
+static IIO_CONST_ATTR(in_accel_mag_value_available, "[0.0 0.002 7.99]");
+
+static IIO_CONST_ATTR(in_accel_mag_period_available, "[0.0 0.02 162.0]");
+
+static IIO_CONST_ATTR(in_accel_mag_hysteresis_available, "[0.0 0.002 1.99]");
+
+static struct attribute *bmi323_event_attributes[] = {
+	&iio_const_attr_in_accel_gesture_tap_value_available.dev_attr.attr,
+	&iio_const_attr_in_accel_gesture_tap_reset_timeout_available.dev_attr.attr,
+	&iio_const_attr_in_accel_gesture_doubletap_tap2_min_delay_available.dev_attr.attr,
+	&iio_const_attr_in_accel_gesture_tap_max_dur_available.dev_attr.attr,
+	&iio_dev_attr_in_accel_gesture_tap_timeout.dev_attr.attr,
+	&iio_dev_attr_in_accel_gesture_tap_max_dur.dev_attr.attr,
+	&iio_const_attr_in_accel_mag_value_available.dev_attr.attr,
+	&iio_const_attr_in_accel_mag_period_available.dev_attr.attr,
+	&iio_const_attr_in_accel_mag_hysteresis_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group bmi323_event_attribute_group = {
+	.attrs = bmi323_event_attributes,
+};
+
+static int bmi323_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir, int state)
+{
+	struct bmi323_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		ret = bmi323_motion_event_en(data, dir, state);
+		return ret;
+	case IIO_EV_TYPE_GESTURE:
+		return bmi323_tap_event_en(data, dir, state);
+	case IIO_EV_TYPE_CHANGE:
+		ret = bmi323_step_wtrmrk_en(data, state);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi323_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct bmi323_data *data = iio_priv(indio_dev);
+	int ret, value, reg_val;
+
+	switch (chan->type) {
+	case IIO_ACCEL:
+		mutex_lock(&data->mutex);
+		switch (dir) {
+		case IIO_EV_DIR_SINGLETAP:
+			ret = FIELD_GET(BMI323_FEAT_IO0_S_TAP_MSK,
+					data->feature_events);
+			break;
+		case IIO_EV_DIR_DOUBLETAP:
+			ret = FIELD_GET(BMI323_FEAT_IO0_D_TAP_MSK,
+					data->feature_events);
+			break;
+		case IIO_EV_DIR_RISING:
+			value = FIELD_GET(BMI323_FEAT_IO0_XYZ_MOTION_MSK,
+					  data->feature_events);
+			ret = value ? 1 : 0;
+			break;
+		case IIO_EV_DIR_FALLING:
+			value = FIELD_GET(BMI323_FEAT_IO0_XYZ_NOMOTION_MSK,
+					  data->feature_events);
+			ret = value ? 1 : 0;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		mutex_unlock(&data->mutex);
+		return ret;
+	case IIO_STEPS:
+		mutex_lock(&data->mutex);
+		ret = regmap_read(data->regmap, BMI323_INT_MAP1_REG, &reg_val);
+		mutex_unlock(&data->mutex);
+		if (ret)
+			return ret;
+
+		return FIELD_GET(BMI323_STEP_CNT_MSK, reg_val) ? 1 : 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi323_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int val, int val2)
+{
+	struct bmi323_data *data = iio_priv(indio_dev);
+	unsigned int raw;
+	int reg;
+
+	switch (type) {
+	case IIO_EV_TYPE_GESTURE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			if (!(val == 0 || val == 1))
+				return -EINVAL;
+
+			raw = BMI323_INT_MICRO_TO_RAW(val, val2,
+						      BMI323_TAP_THRES_SCALE);
+
+			return bmi323_update_ext_reg(data, BMI323_TAP2_REG,
+						     BMI323_TAP2_THRES_MSK,
+						     FIELD_PREP(BMI323_TAP2_THRES_MSK,
+								raw));
+		case IIO_EV_INFO_RESET_TIMEOUT:
+			if (val != 0 || val2 < 40000 || val2 > 600000)
+				return -EINVAL;
+
+			raw = BMI323_INT_MICRO_TO_RAW(val, val2,
+						      BMI323_QUITE_TIM_GES_SCALE);
+
+			return bmi323_update_ext_reg(data, BMI323_TAP3_REG,
+						     BMI323_TAP3_QT_AFT_GES_MSK,
+						     FIELD_PREP(BMI323_TAP3_QT_AFT_GES_MSK,
+								raw));
+		case IIO_EV_INFO_TAP2_MIN_DELAY:
+			if (val != 0 || val2 < 5000 || val2 > 75000)
+				return -EINVAL;
+
+			raw = BMI323_INT_MICRO_TO_RAW(val, val2,
+						      BMI323_DUR_BW_TAP_SCALE);
+
+			return bmi323_update_ext_reg(data, BMI323_TAP3_REG,
+						     BMI323_TAP3_QT_BW_TAP_MSK,
+						     FIELD_PREP(BMI323_TAP3_QT_BW_TAP_MSK,
+								raw));
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_TYPE_MAG:
+		reg = bmi323_motion_config_reg(dir);
+		if (reg < 0)
+			return -EINVAL;
+
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			if (val < 0 || val > 7)
+				return -EINVAL;
+
+			raw = BMI323_INT_MICRO_TO_RAW(val, val2,
+						      BMI323_MOTION_THRES_SCALE);
+
+			return bmi323_update_ext_reg(data, reg,
+						     BMI323_MO1_SLOPE_TH_MSK,
+						     FIELD_PREP(BMI323_MO1_SLOPE_TH_MSK,
+								raw));
+		case IIO_EV_INFO_PERIOD:
+			if (val < 0 || val > 162)
+				return -EINVAL;
+
+			raw = BMI323_INT_MICRO_TO_RAW(val, val2,
+						      BMI323_MOTION_DURAT_SCALE);
+
+			return bmi323_update_ext_reg(data,
+						     reg + BMI323_MO3_OFFSET,
+						     BMI323_MO3_DURA_MSK,
+						     FIELD_PREP(BMI323_MO3_DURA_MSK,
+								raw));
+		case IIO_EV_INFO_HYSTERESIS:
+			if (!(val == 0 || val == 1))
+				return -EINVAL;
+
+			raw = BMI323_INT_MICRO_TO_RAW(val, val2,
+						      BMI323_MOTION_HYSTR_SCALE);
+
+			return bmi323_update_ext_reg(data,
+						     reg + BMI323_MO2_OFFSET,
+						     BMI323_MO2_HYSTR_MSK,
+						     FIELD_PREP(BMI323_MO2_HYSTR_MSK,
+								raw));
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_TYPE_CHANGE:
+		if (val < 0 || val > 20460)
+			return -EINVAL;
+
+		raw = val / 20;
+		return bmi323_update_ext_reg(data, BMI323_STEP_SC1_REG,
+					     BMI323_STEP_SC1_WTRMRK_MSK,
+					     FIELD_PREP(BMI323_STEP_SC1_WTRMRK_MSK,
+							raw));
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi323_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int *val, int *val2)
+{
+	struct bmi323_data *data = iio_priv(indio_dev);
+	unsigned int raw, reg_value;
+	int ret, reg;
+
+	switch (type) {
+	case IIO_EV_TYPE_GESTURE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = bmi323_read_ext_reg(data, BMI323_TAP2_REG,
+						  &reg_value);
+			if (ret)
+				return ret;
+
+			raw = FIELD_GET(BMI323_TAP2_THRES_MSK, reg_value);
+			*val = raw / BMI323_TAP_THRES_SCALE;
+			*val2 = BMI323_RAW_TO_MICRO(raw, BMI323_TAP_THRES_SCALE);
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_EV_INFO_RESET_TIMEOUT:
+			ret = bmi323_read_ext_reg(data, BMI323_TAP3_REG,
+						  &reg_value);
+			if (ret)
+				return ret;
+
+			raw = FIELD_GET(BMI323_TAP3_QT_AFT_GES_MSK, reg_value);
+			*val = 0;
+			*val2 = BMI323_RAW_TO_MICRO(raw,
+						    BMI323_QUITE_TIM_GES_SCALE);
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_EV_INFO_TAP2_MIN_DELAY:
+			ret = bmi323_read_ext_reg(data, BMI323_TAP3_REG,
+						  &reg_value);
+			if (ret)
+				return ret;
+
+			raw = FIELD_GET(BMI323_TAP3_QT_BW_TAP_MSK, reg_value);
+			*val = 0;
+			*val2 = BMI323_RAW_TO_MICRO(raw,
+						    BMI323_DUR_BW_TAP_SCALE);
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_TYPE_MAG:
+		reg = bmi323_motion_config_reg(dir);
+		if (reg < 0)
+			return -EINVAL;
+
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = bmi323_read_ext_reg(data, reg, &reg_value);
+			if (ret)
+				return ret;
+
+			raw = FIELD_GET(BMI323_MO1_SLOPE_TH_MSK, reg_value);
+			*val = raw / BMI323_MOTION_THRES_SCALE;
+			*val2 = BMI323_RAW_TO_MICRO(raw,
+						    BMI323_MOTION_THRES_SCALE);
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_EV_INFO_PERIOD:
+			ret = bmi323_read_ext_reg(data,
+						  reg + BMI323_MO3_OFFSET,
+						  &reg_value);
+			if (ret)
+				return ret;
+
+			raw = FIELD_GET(BMI323_MO3_DURA_MSK, reg_value);
+			*val = raw / BMI323_MOTION_DURAT_SCALE;
+			*val2 = BMI323_RAW_TO_MICRO(raw,
+						    BMI323_MOTION_DURAT_SCALE);
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_EV_INFO_HYSTERESIS:
+			ret = bmi323_read_ext_reg(data,
+						  reg + BMI323_MO2_OFFSET,
+						  &reg_value);
+			if (ret)
+				return ret;
+
+			raw = FIELD_GET(BMI323_MO2_HYSTR_MSK, reg_value);
+			*val = raw / BMI323_MOTION_HYSTR_SCALE;
+			*val2 = BMI323_RAW_TO_MICRO(raw,
+						    BMI323_MOTION_HYSTR_SCALE);
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_TYPE_CHANGE:
+		ret = bmi323_read_ext_reg(data, BMI323_STEP_SC1_REG,
+					  &reg_value);
+		if (ret)
+			return ret;
+
+		raw = FIELD_GET(BMI323_STEP_SC1_WTRMRK_MSK, reg_value);
+		*val = raw * 20;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int __bmi323_fifo_flush(struct iio_dev *indio_dev)
+{
+	struct bmi323_data *data = iio_priv(indio_dev);
+	int i, ret, fifo_lvl, frame_count, bit;
+	__le16 *frame, *channels;
+	u64 sample_period;
+	s64 tstamp;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_read(data->regmap, BMI323_FIFO_FILL_LEVEL_REG, &fifo_lvl);
+	if (ret)
+		goto unlock_out;
+
+	if (fifo_lvl > BMI323_FIFO_FULL_IN_WORDS)
+		fifo_lvl = BMI323_FIFO_FULL_IN_WORDS;
+
+	frame_count = fifo_lvl / BMI323_FIFO_FRAME_LENGTH;
+	if (!frame_count) {
+		ret = -EINVAL;
+		goto unlock_out;
+	}
+
+	if (fifo_lvl % BMI323_FIFO_FRAME_LENGTH)
+		dev_warn(data->dev, "Bad FIFO alignment\n");
+
+	/*
+	 * Approximate timestamps for each of the sample based on the sampling
+	 * frequency, timestamp for last sample and number of samples.
+	 */
+	if (data->old_fifo_tstamp) {
+		sample_period = data->fifo_tstamp - data->old_fifo_tstamp;
+		do_div(sample_period, frame_count);
+	} else {
+		sample_period = data->odrns[BMI323_ACCEL];
+	}
+
+	tstamp = data->fifo_tstamp - (frame_count - 1) * sample_period;
+
+	ret = regmap_noinc_read(data->regmap, BMI323_FIFO_DATA_REG,
+				&data->fifo_buff[0],
+				fifo_lvl * BMI323_BYTES_PER_SAMPLE);
+	if (ret)
+		goto unlock_out;
+
+	for (i = 0; i < frame_count; i++) {
+		frame = &data->fifo_buff[i * BMI323_FIFO_FRAME_LENGTH];
+		channels = &data->buffer.channels[0];
+
+		for_each_set_bit(bit, indio_dev->active_scan_mask,
+				 BMI323_CHAN_MAX) {
+			channels[bit] = frame[bit];
+		}
+
+		iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
+						   tstamp);
+
+		tstamp += sample_period;
+	}
+
+	ret = frame_count;
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static int bmi323_set_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct bmi323_data *data = iio_priv(indio_dev);
+
+	if (val > BMI323_FIFO_FULL_IN_FRAMES)
+		val = BMI323_FIFO_FULL_IN_FRAMES;
+
+	mutex_lock(&data->mutex);
+	data->watermark = val;
+	mutex_unlock(&data->mutex);
+
+	return 0;
+}
+
+static int bmi323_fifo_disable(struct bmi323_data *data)
+{
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_write(data->regmap, BMI323_FIFO_CONF_REG, 0);
+	if (ret)
+		goto unlock_out;
+
+	ret = regmap_update_bits(data->regmap, BMI323_INT_MAP2_REG,
+				 BMI323_FIFO_WTRMRK_MSK,
+				 FIELD_PREP(BMI323_FIFO_WTRMRK_MSK, 0));
+	if (ret)
+		goto unlock_out;
+
+	data->fifo_tstamp = 0;
+	data->state = BMI323_IDLE;
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static int bmi323_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct bmi323_data *data = iio_priv(indio_dev);
+
+	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
+		return 0;
+
+	return bmi323_fifo_disable(data);
+}
+
+static int bmi323_update_watermark(struct bmi323_data *data)
+{
+	int wtrmrk;
+
+	wtrmrk = data->watermark * BMI323_FIFO_FRAME_LENGTH;
+
+	return regmap_write(data->regmap, BMI323_FIFO_WTRMRK_REG, wtrmrk);
+}
+
+static int bmi323_fifo_enable(struct bmi323_data *data)
+{
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, BMI323_FIFO_CONF_REG,
+				 BMI323_FIFO_CONF_ACC_GYR_EN_MSK,
+				 FIELD_PREP(BMI323_FIFO_CONF_ACC_GYR_EN_MSK,
+					    3));
+	if (ret)
+		goto unlock_out;
+
+	ret = regmap_update_bits(data->regmap, BMI323_INT_MAP2_REG,
+				 BMI323_FIFO_WTRMRK_MSK,
+				 FIELD_PREP(BMI323_FIFO_WTRMRK_MSK,
+					    data->irq_pin));
+	if (ret)
+		goto unlock_out;
+
+	ret = bmi323_update_watermark(data);
+	if (ret)
+		goto unlock_out;
+
+	ret = regmap_write(data->regmap, BMI323_FIFO_CTRL_REG,
+			   BMI323_FIFO_FLUSH_MSK);
+	if (ret)
+		goto unlock_out;
+
+	data->state = BMI323_BUFFER_FIFO;
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static int bmi323_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct bmi323_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	mutex_lock(&data->mutex);
+	/*
+	 * When the ODR of the accelerometer and gyroscope do not match, the
+	 * maximum ODR value between the accelerometer and gyroscope is used
+	 * for FIFO and the signal with lower ODR will insert dummy frame.
+	 * So allow buffer read only when ODR's of accelero and gyro are equal.
+	 * See datasheet section 5.7 "FIFO Data Buffering".
+	 */
+	if (data->odrns[BMI323_ACCEL] != data->odrns[BMI323_GYRO]) {
+		dev_err(data->dev, "Accelero and Gyro ODR doesn't match\n");
+		ret = -EINVAL;
+	}
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int bmi323_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct bmi323_data *data = iio_priv(indio_dev);
+
+	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
+		return 0;
+
+	return bmi323_fifo_enable(data);
+}
+
+static ssize_t hwfifo_watermark_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bmi323_data *data = iio_priv(indio_dev);
+	int wm;
+
+	mutex_lock(&data->mutex);
+	wm = data->watermark;
+	mutex_unlock(&data->mutex);
+
+	return sysfs_emit(buf, "%d\n", wm);
+}
+
+static ssize_t hwfifo_enabled_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bmi323_data *data = iio_priv(indio_dev);
+	bool state;
+
+	mutex_lock(&data->mutex);
+	state = data->state == BMI323_BUFFER_FIFO ? true : false;
+	mutex_unlock(&data->mutex);
+
+	return sysfs_emit(buf, "%d\n", state);
+}
+
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark, 0);
+static IIO_DEVICE_ATTR_RO(hwfifo_enabled, 0);
+
+static const struct iio_dev_attr *bmi323_fifo_attributes[] = {
+	&iio_dev_attr_hwfifo_watermark,
+	&iio_dev_attr_hwfifo_enabled,
+	NULL
+};
+
+static const struct iio_buffer_setup_ops bmi323_buffer_ops = {
+	.preenable = bmi323_buffer_preenable,
+	.postenable = bmi323_buffer_postenable,
+	.predisable = bmi323_buffer_predisable,
+};
+
+static irqreturn_t bmi323_irq_thread_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct bmi323_data *data = iio_priv(indio_dev);
+	unsigned int status_addr, status, feature_event;
+	s64 timestamp = iio_get_time_ns(indio_dev);
+	int ret;
+
+	if (data->irq_pin == BMI323_IRQ_INT1)
+		status_addr = BMI323_STATUS_INT1_REG;
+	else
+		status_addr = BMI323_STATUS_INT2_REG;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_read(data->regmap, status_addr, &status);
+	mutex_unlock(&data->mutex);
+	if (ret)
+		return IRQ_NONE;
+
+	if (!status || FIELD_GET(BMI323_STATUS_ERROR_MSK, status)) {
+		dev_err(data->dev, "status error = 0x%x\n", status);
+		return IRQ_NONE;
+	}
+
+	if (FIELD_GET(BMI323_STATUS_FIFO_WTRMRK_MSK, status)) {
+		data->old_fifo_tstamp = data->fifo_tstamp;
+		data->fifo_tstamp = iio_get_time_ns(indio_dev);
+		ret = __bmi323_fifo_flush(indio_dev);
+		if (ret < 0)
+			return IRQ_NONE;
+	}
+
+	if (FIELD_GET(BMI323_STATUS_ACC_GYR_DRDY_MSK, status))
+		iio_trigger_poll_nested(data->trig);
+
+	if (FIELD_GET(BMI323_STATUS_MOTION_MSK, status))
+		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							     IIO_MOD_X_OR_Y_OR_Z,
+							     IIO_EV_TYPE_MAG,
+							     IIO_EV_DIR_RISING),
+			       timestamp);
+
+	if (FIELD_GET(BMI323_STATUS_NOMOTION_MSK, status))
+		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							     IIO_MOD_X_OR_Y_OR_Z,
+							     IIO_EV_TYPE_MAG,
+							     IIO_EV_DIR_FALLING),
+			       timestamp);
+
+	if (FIELD_GET(BMI323_STATUS_STP_WTR_MSK, status))
+		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_STEPS, 0,
+							     IIO_NO_MOD,
+							     IIO_EV_TYPE_CHANGE,
+							     IIO_EV_DIR_NONE),
+			       timestamp);
+
+	if (FIELD_GET(BMI323_STATUS_TAP_MSK, status)) {
+		mutex_lock(&data->mutex);
+		ret = regmap_read(data->regmap, BMI323_FEAT_EVNT_EXT_REG,
+				  &feature_event);
+		mutex_unlock(&data->mutex);
+		if (ret)
+			return IRQ_NONE;
+
+		if (FIELD_GET(BMI323_FEAT_EVNT_EXT_S_MSK, feature_event)) {
+			iio_push_event(indio_dev,
+				       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							  IIO_MOD_X_OR_Y_OR_Z,
+							  IIO_EV_TYPE_GESTURE,
+							  IIO_EV_DIR_SINGLETAP),
+				       timestamp);
+		}
+
+		if (FIELD_GET(BMI323_FEAT_EVNT_EXT_D_MSK, feature_event))
+			iio_push_event(indio_dev,
+				       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							  IIO_MOD_X_OR_Y_OR_Z,
+							  IIO_EV_TYPE_GESTURE,
+							  IIO_EV_DIR_DOUBLETAP),
+				       timestamp);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int bmi323_set_drdy_irq(struct bmi323_data *data,
+			       enum bmi323_irq_pin irq_pin)
+{
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, BMI323_INT_MAP2_REG,
+				 BMI323_GYR_DRDY_MSK,
+				 FIELD_PREP(BMI323_GYR_DRDY_MSK, irq_pin));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap, BMI323_INT_MAP2_REG,
+				  BMI323_ACC_DRDY_MSK,
+				  FIELD_PREP(BMI323_ACC_DRDY_MSK, irq_pin));
+}
+
+static int bmi323_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					     bool state)
+{
+	struct bmi323_data *data = iio_trigger_get_drvdata(trig);
+	enum bmi323_irq_pin irq_pin;
+	int ret;
+
+	mutex_lock(&data->mutex);
+
+	if (data->state == BMI323_BUFFER_FIFO) {
+		dev_warn(data->dev, "Can't set trigger when FIFO enabled\n");
+		ret = -EBUSY;
+		goto unlock_out;
+	}
+
+	if (state) {
+		data->state = BMI323_BUFFER_DRDY_TRIGGERED;
+		irq_pin = data->irq_pin;
+	} else {
+		data->state = BMI323_IDLE;
+		irq_pin = BMI323_IRQ_DISABLED;
+	}
+
+	ret = bmi323_set_drdy_irq(data, irq_pin);
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static const struct iio_trigger_ops bmi323_trigger_ops = {
+	.set_trigger_state = &bmi323_data_rdy_trigger_set_state,
+};
+
+static irqreturn_t bmi323_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmi323_data *data = iio_priv(indio_dev);
+	int ret;
+
+	/* Lock to protect the data->buffer */
+	mutex_lock(&data->mutex);
+	ret = regmap_bulk_read(data->regmap, BMI323_ACCEL_X_REG,
+			       &data->buffer.channels,
+			       ARRAY_SIZE(data->buffer.channels));
+	if (ret)
+		goto unlock_out;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
+					   iio_get_time_ns(indio_dev));
+	mutex_unlock(&data->mutex);
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+
+unlock_out:
+	mutex_unlock(&data->mutex);
+	return IRQ_NONE;
+}
+
+static int bmi323_set_average(struct bmi323_data *data,
+			      enum bmi323_sensor_type sensor, int avg)
+{
+	int ret, raw;
+
+	for (raw = 0; raw < ARRAY_SIZE(bmi323_accel_gyro_avrg); raw++)
+		if (avg == bmi323_accel_gyro_avrg[raw])
+			break;
+
+	if (raw >= ARRAY_SIZE(bmi323_accel_gyro_avrg))
+		return -EINVAL;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, bmi323_hw[sensor].config,
+				 BMI323_ACC_GYRO_CONF_AVG_MSK,
+				 FIELD_PREP(BMI323_ACC_GYRO_CONF_AVG_MSK,
+					    raw));
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int bmi323_get_average(struct bmi323_data *data,
+			      enum bmi323_sensor_type sensor, int *avg)
+{
+	int ret, value, raw;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_read(data->regmap, bmi323_hw[sensor].config, &value);
+	mutex_unlock(&data->mutex);
+	if (ret)
+		return ret;
+
+	raw = FIELD_GET(BMI323_ACC_GYRO_CONF_AVG_MSK, value);
+	*avg = bmi323_accel_gyro_avrg[raw];
+
+	return ret;
+}
+
+static ssize_t in_accel_gyro_averaging_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bmi323_data *data = iio_priv(indio_dev);
+	int ret, avg;
+
+	ret = bmi323_get_average(data, BMI323_ACCEL, &avg);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", avg);
+}
+
+static ssize_t in_accel_gyro_averaging_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bmi323_data *data = iio_priv(indio_dev);
+	int ret, avg;
+
+	ret = kstrtoint(buf, 0, &avg);
+	if (ret)
+		return ret;
+
+	ret = bmi323_set_average(data, BMI323_ACCEL, avg);
+	if (ret)
+		return ret;
+
+	ret = bmi323_set_average(data, BMI323_GYRO, avg);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_RW(in_accel_gyro_averaging, 0);
+static IIO_CONST_ATTR(in_accel_gyro_averaging_available, "2 4 8 16 32 64");
+
+static struct attribute *bmi323_attributes[] = {
+	&iio_dev_attr_in_accel_gyro_averaging.dev_attr.attr,
+	&iio_const_attr_in_accel_gyro_averaging_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group bmi323_attrs_group = {
+	.attrs = bmi323_attributes,
+};
+
+static int bmi323_enable_steps(struct bmi323_data *data, int val)
+{
+	int ret;
+
+	if (data->odrhz[BMI323_ACCEL] < 200) {
+		dev_err(data->dev, "Invalid accelrometer parameter\n");
+		return -EINVAL;
+	}
+
+	ret = bmi323_feature_engine_events(data, BMI323_FEAT_IO0_STP_CNT_MSK,
+					   val ? 1 : 0);
+	if (ret)
+		return ret;
+
+	set_mask_bits(&data->feature_events, BMI323_FEAT_IO0_STP_CNT_MSK,
+		      FIELD_PREP(BMI323_FEAT_IO0_STP_CNT_MSK, val ? 1 : 0));
+
+	return ret;
+}
+
+static int bmi323_read_steps(struct bmi323_data *data, int *val)
+{
+	int ret;
+
+	if (!FIELD_GET(BMI323_FEAT_IO0_STP_CNT_MSK, data->feature_events))
+		return -EINVAL;
+
+	ret = regmap_bulk_read(data->regmap, BMI323_FEAT_IO2_REG,
+			       data->steps_count,
+			       ARRAY_SIZE(data->steps_count));
+	if (ret)
+		return ret;
+
+	*val = get_unaligned_le32(data->steps_count);
+
+	return IIO_VAL_INT;
+}
+
+static int bmi323_read_axis(struct bmi323_data *data,
+			    struct iio_chan_spec const *chan, int *val)
+{
+	enum bmi323_sensor_type sensor;
+	unsigned int value;
+	u8 addr;
+	int ret;
+
+	ret = bmi323_get_error_status(data);
+	if (ret)
+		return -EINVAL;
+
+	sensor = bmi323_iio_to_sensor(chan->type);
+	addr = bmi323_hw[sensor].data + (chan->channel2 - IIO_MOD_X);
+
+	ret = regmap_read(data->regmap, addr, &value);
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(le16_to_cpup((const __le16 *)&value),
+			     chan->scan_type.realbits - 1);
+
+	return IIO_VAL_INT;
+}
+
+static int bmi323_get_temp_data(struct bmi323_data *data, int *val)
+{
+	unsigned int value;
+	int ret;
+
+	ret = bmi323_get_error_status(data);
+	if (ret)
+		return -EINVAL;
+
+	ret = regmap_read(data->regmap, BMI323_TEMP_REG, &value);
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(le16_to_cpup((const __le16 *)&value), 15);
+
+	return IIO_VAL_INT;
+}
+
+static int bmi323_get_odr(struct bmi323_data *data, enum iio_chan_type type,
+			  int *odr, int *uodr)
+{
+	enum bmi323_sensor_type sensor;
+	int ret, value, odr_raw;
+
+	sensor = bmi323_iio_to_sensor(type);
+
+	ret = regmap_read(data->regmap, bmi323_hw[sensor].config, &value);
+	if (ret)
+		return ret;
+
+	odr_raw = FIELD_GET(BMI323_ACC_GYRO_CONF_ODR_MSK, value);
+	*odr = bmi323_acc_gyro_odr[odr_raw - 1][0];
+	*uodr = bmi323_acc_gyro_odr[odr_raw - 1][1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int bmi323_configure_power_mode(struct bmi323_data *data,
+				       enum bmi323_sensor_type sensor,
+				       int odr_index)
+{
+	enum bmi323_opr_mode mode;
+
+	if (bmi323_acc_gyro_odr[odr_index][0] <= 25)
+		mode = ACC_GYRO_MODE_DUTYCYCLE;
+	else
+		mode = ACC_GYRO_MODE_CONTINOUS;
+
+	return bmi323_set_mode(data, sensor, mode);
+}
+
+static int bmi323_set_odr(struct bmi323_data *data,
+			  enum bmi323_sensor_type sensor, int odr, int uodr)
+{
+	int odr_raw, ret;
+
+	odr_raw = ARRAY_SIZE(bmi323_acc_gyro_odr);
+
+	while (odr_raw--)
+		if (odr == bmi323_acc_gyro_odr[odr_raw][0] &&
+		    uodr == bmi323_acc_gyro_odr[odr_raw][1])
+			break;
+	if (odr_raw < 0)
+		return -EINVAL;
+
+	ret = bmi323_configure_power_mode(data, sensor, odr_raw);
+	if (ret)
+		return -EINVAL;
+
+	data->odrhz[sensor] = bmi323_acc_gyro_odr[odr_raw][0];
+	data->odrns[sensor] = bmi323_acc_gyro_odrns[odr_raw];
+
+	odr_raw++;
+
+	return regmap_update_bits(data->regmap, bmi323_hw[sensor].config,
+				  BMI323_ACC_GYRO_CONF_ODR_MSK,
+				  FIELD_PREP(BMI323_ACC_GYRO_CONF_ODR_MSK,
+					     odr_raw));
+}
+
+static int bmi323_get_scale(struct bmi323_data *data, enum iio_chan_type type,
+			    int *val2)
+{
+	enum bmi323_sensor_type sensor;
+	int ret, value, scale_raw;
+
+	sensor = bmi323_iio_to_sensor(type);
+
+	ret = regmap_read(data->regmap, bmi323_hw[sensor].config, &value);
+	if (ret)
+		return ret;
+
+	scale_raw = FIELD_GET(BMI323_ACC_GYRO_CONF_SCL_MSK, value);
+	*val2 = bmi323_hw[sensor].scale_table[scale_raw][1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int bmi323_set_scale(struct bmi323_data *data,
+			    enum bmi323_sensor_type sensor, int val, int val2)
+{
+	int scale_raw;
+
+	if (data->state != BMI323_IDLE)
+		return -EBUSY;
+
+	scale_raw = bmi323_hw[sensor].scale_table_len;
+
+	while (scale_raw--)
+		if (val == bmi323_hw[sensor].scale_table[scale_raw][0] &&
+		    val2 == bmi323_hw[sensor].scale_table[scale_raw][1])
+			break;
+	if (scale_raw < 0)
+		return -EINVAL;
+
+	return regmap_update_bits(data->regmap, bmi323_hw[sensor].config,
+				  BMI323_ACC_GYRO_CONF_SCL_MSK,
+				  FIELD_PREP(BMI323_ACC_GYRO_CONF_SCL_MSK,
+					     scale_raw));
+}
+
+static int bmi323_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	enum bmi323_sensor_type sensor;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*vals = (const int *)bmi323_acc_gyro_odr;
+		*length = ARRAY_SIZE(bmi323_acc_gyro_odr) * 2;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		sensor = bmi323_iio_to_sensor(chan->type);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*vals = (const int *)bmi323_hw[sensor].scale_table;
+		*length = bmi323_hw[sensor].scale_table_len * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi323_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val,
+			    int val2, long mask)
+{
+	struct bmi323_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		mutex_lock(&data->mutex);
+		ret = bmi323_set_odr(data, bmi323_iio_to_sensor(chan->type),
+				     val, val2);
+		mutex_unlock(&data->mutex);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SCALE:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		mutex_lock(&data->mutex);
+		ret = bmi323_set_scale(data, bmi323_iio_to_sensor(chan->type),
+				       val, val2);
+		mutex_unlock(&data->mutex);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_ENABLE:
+		mutex_lock(&data->mutex);
+		ret = bmi323_enable_steps(data, val);
+		mutex_unlock(&data->mutex);
+		return ret;
+	case IIO_CHAN_INFO_PROCESSED:
+		if (val || !FIELD_GET(BMI323_FEAT_IO0_STP_CNT_MSK,
+				      data->feature_events))
+			return -EINVAL;
+
+		/* Clear step counter value */
+		return bmi323_update_ext_reg(data, BMI323_STEP_SC1_REG,
+					     BMI323_STEP_SC1_RST_CNT_MSK,
+					     FIELD_PREP(BMI323_STEP_SC1_RST_CNT_MSK,
+							1));
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bmi323_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	struct bmi323_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		mutex_lock(&data->mutex);
+		ret = bmi323_read_steps(data, val);
+		mutex_unlock(&data->mutex);
+		return ret;
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_ACCEL:
+		case IIO_ANGL_VEL:
+			ret = iio_device_claim_direct_mode(indio_dev);
+			if (ret)
+				return ret;
+
+			mutex_lock(&data->mutex);
+			ret = bmi323_read_axis(data, chan, val);
+			mutex_unlock(&data->mutex);
+
+			iio_device_release_direct_mode(indio_dev);
+			return ret;
+		case IIO_TEMP:
+			mutex_lock(&data->mutex);
+			ret = bmi323_get_temp_data(data, val);
+			mutex_unlock(&data->mutex);
+			return ret;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(&data->mutex);
+		ret = bmi323_get_odr(data, chan->type, val, val2);
+		mutex_unlock(&data->mutex);
+		return ret;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ACCEL:
+		case IIO_ANGL_VEL:
+			*val = 0;
+			mutex_lock(&data->mutex);
+			ret = bmi323_get_scale(data, chan->type, val2);
+			mutex_unlock(&data->mutex);
+			return ret;
+		case IIO_TEMP:
+			*val = BMI323_TEMP_SCALE / MEGA;
+			*val2 = BMI323_TEMP_SCALE % MEGA;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = BMI323_TEMP_OFFSET;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_ENABLE:
+		mutex_lock(&data->mutex);
+		*val = FIELD_GET(BMI323_FEAT_IO0_STP_CNT_MSK,
+				 data->feature_events);
+		mutex_unlock(&data->mutex);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info bmi323_info = {
+	.read_raw = bmi323_read_raw,
+	.write_raw = bmi323_write_raw,
+	.read_avail = bmi323_read_avail,
+	.attrs = &bmi323_attrs_group,
+	.hwfifo_set_watermark = bmi323_set_watermark,
+	.write_event_config = bmi323_write_event_config,
+	.read_event_config = bmi323_read_event_config,
+	.write_event_value = bmi323_write_event_value,
+	.read_event_value = bmi323_read_event_value,
+	.event_attrs = &bmi323_event_attribute_group,
+};
+
+#define BMI323_SCAN_MASK_ACCEL_3AXIS		\
+	(BIT(BMI323_ACCEL_X) | BIT(BMI323_ACCEL_Y) | BIT(BMI323_ACCEL_Z))
+
+#define BMI323_SCAN_MASK_GYRO_3AXIS		\
+	(BIT(BMI323_GYRO_X) | BIT(BMI323_GYRO_Y) | BIT(BMI323_GYRO_Z))
+
+static const unsigned long bmi323_avail_scan_masks[] = {
+	/* 3-axis accel + 3-axis gyro */
+	BMI323_SCAN_MASK_ACCEL_3AXIS | BMI323_SCAN_MASK_GYRO_3AXIS,
+	/* 3-axis accel */
+	BMI323_SCAN_MASK_ACCEL_3AXIS,
+	/* 3-axis gyro */
+	BMI323_SCAN_MASK_GYRO_3AXIS,
+	0
+};
+
+static int bmi323_int_pin_config(struct bmi323_data *data,
+				 enum bmi323_irq_pin irq_pin,
+				 bool active_high, bool open_drain, bool latch)
+{
+	unsigned int mask, field_value = 0;
+	int ret;
+
+	switch (irq_pin) {
+	case BMI323_IRQ_INT1:
+		mask = BMI323_IO_INT1_LVL_OD_OP_MSK;
+
+		set_mask_bits(&field_value, BMI323_IO_INT1_LVL_MSK,
+			      FIELD_PREP(BMI323_IO_INT1_LVL_MSK, active_high));
+
+		set_mask_bits(&field_value, BMI323_IO_INT1_OD_MSK,
+			      FIELD_PREP(BMI323_IO_INT1_OD_MSK, open_drain));
+
+		set_mask_bits(&field_value, BMI323_IO_INT1_OP_EN_MSK,
+			      FIELD_PREP(BMI323_IO_INT1_OP_EN_MSK, 1));
+		break;
+	case BMI323_IRQ_INT2:
+		mask = BMI323_IO_INT2_LVL_OD_OP_MSK;
+
+		set_mask_bits(&field_value, BMI323_IO_INT2_LVL_MSK,
+			      FIELD_PREP(BMI323_IO_INT2_LVL_MSK, active_high));
+
+		set_mask_bits(&field_value, BMI323_IO_INT2_OD_MSK,
+			      FIELD_PREP(BMI323_IO_INT2_OD_MSK, open_drain));
+
+		set_mask_bits(&field_value, BMI323_IO_INT2_OP_EN_MSK,
+			      FIELD_PREP(BMI323_IO_INT2_OP_EN_MSK, 1));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(data->regmap, BMI323_IO_INT_CONF_REG,
+				 BMI323_IO_INT_LTCH_MSK,
+				 FIELD_PREP(BMI323_IO_INT_LTCH_MSK, latch));
+	if (ret)
+		return ret;
+
+	ret = bmi323_update_ext_reg(data, BMI323_GEN_SET1_REG,
+				    BMI323_GEN_HOLD_DUR_MSK,
+				    FIELD_PREP(BMI323_GEN_HOLD_DUR_MSK, 0));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap, BMI323_IO_INT_CTR_REG, mask,
+				  field_value);
+}
+
+static int bmi323_trigger_probe(struct bmi323_data *data,
+				struct iio_dev *indio_dev)
+{
+	bool open_drain, active_high, latch;
+	struct fwnode_handle *fwnode;
+	enum bmi323_irq_pin irq_pin;
+	int ret, irq, irq_type;
+	struct irq_data *desc;
+
+	fwnode = dev_fwnode(data->dev);
+	if (!fwnode)
+		return -ENODEV;
+
+	irq = fwnode_irq_get_byname(fwnode, "INT1");
+	if (irq > 0) {
+		irq_pin = BMI323_IRQ_INT1;
+	} else {
+		irq = fwnode_irq_get_byname(fwnode, "INT2");
+		if (irq <= 0)
+			return 0;
+
+		irq_pin = BMI323_IRQ_INT2;
+	}
+
+	desc = irq_get_irq_data(irq);
+	if (!desc) {
+		dev_err(data->dev, "Could not find IRQ %d\n", irq);
+		return -EINVAL;
+	}
+
+	irq_type = irqd_get_trigger_type(desc);
+
+	switch (irq_type) {
+	case IRQF_TRIGGER_RISING:
+		latch = false;
+		active_high = true;
+		break;
+	case IRQF_TRIGGER_HIGH:
+		latch = true;
+		active_high = true;
+		break;
+	case IRQF_TRIGGER_FALLING:
+		latch = false;
+		active_high = false;
+		break;
+	case IRQF_TRIGGER_LOW:
+		latch = true;
+		active_high = false;
+		break;
+	default:
+		dev_err(data->dev, "Invalid interrupt type 0x%x specified\n",
+			irq_type);
+		return -EINVAL;
+	}
+
+	open_drain = fwnode_property_read_bool(fwnode, "drive-open-drain");
+
+	ret = bmi323_int_pin_config(data, irq_pin, active_high, open_drain,
+				    latch);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Failed to configure irq line\n");
+
+	data->trig = devm_iio_trigger_alloc(data->dev, "%s-trig-%d",
+					    indio_dev->name, irq_pin);
+	if (!data->trig)
+		return -ENOMEM;
+
+	data->trig->ops = &bmi323_trigger_ops;
+	iio_trigger_set_drvdata(data->trig, data);
+
+	ret = devm_request_threaded_irq(data->dev, irq, NULL,
+					bmi323_irq_thread_handler,
+					irq_type | IRQF_ONESHOT,
+					"bmi323-int", indio_dev);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Failed to request IRQ\n");
+
+	ret = devm_iio_trigger_register(data->dev, data->trig);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Trigger registration failed\n");
+
+	data->irq_pin = irq_pin;
+
+	return ret;
+}
+
+static int bmi323_feature_engine_enable(struct bmi323_data *data, bool en)
+{
+	unsigned int feature_status;
+	int ret, i;
+
+	if (en) {
+		ret = regmap_write(data->regmap, BMI323_FEAT_IO2_REG,
+				   0x012c);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(data->regmap, BMI323_FEAT_IO_STATUS_REG,
+				   BMI323_FEAT_IO_STATUS_MSK);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(data->regmap, BMI323_FEAT_CTRL_REG,
+				   BMI323_FEAT_ENG_EN_MSK);
+		if (ret)
+			return ret;
+
+		i = 5;
+		do {
+			ret = regmap_read(data->regmap, BMI323_FEAT_IO1_REG,
+					  &feature_status);
+			if (ret)
+				return ret;
+
+			i--;
+			mdelay(2);
+		} while (feature_status != 0x01 && i);
+
+		if (feature_status != 0x01) {
+			dev_err(data->dev, "Failed to enable feature engine\n");
+			return -EINVAL;
+		}
+
+		return ret;
+	} else {
+		return regmap_write(data->regmap, BMI323_FEAT_CTRL_REG, 0);
+	}
+}
+
+static void bmi323_disable(void *data_ptr)
+{
+	struct bmi323_data *data = data_ptr;
+
+	bmi323_set_mode(data, BMI323_ACCEL, ACC_GYRO_MODE_DISABLE);
+	bmi323_set_mode(data, BMI323_GYRO, ACC_GYRO_MODE_DISABLE);
+}
+
+static int bmi323_set_bw(struct bmi323_data *data,
+			 enum bmi323_sensor_type sensor, enum bmi323_3db_bw bw)
+{
+	return regmap_update_bits(data->regmap, bmi323_hw[sensor].config,
+				  BMI323_ACC_GYRO_CONF_BW_MSK,
+				  FIELD_PREP(BMI323_ACC_GYRO_CONF_BW_MSK, bw));
+}
+
+static int bmi323_init(struct bmi323_data *data)
+{
+	int ret, val;
+
+	/*
+	 * Perform soft reset to make sure the device is in a known state after
+	 * start up. A delay of 1.5 ms is required after reset.
+	 * See datasheet section 5.17 "Soft Reset".
+	 */
+	ret = regmap_write(data->regmap, BMI323_CMD_REG, BMI323_RST_VAL);
+	if (ret)
+		return ret;
+
+	usleep_range(1500, 2000);
+
+	/*
+	 * Dummy read is required to enable SPI interface after reset.
+	 * See datasheet section 7.2.1 "Protocol Selection".
+	 */
+	regmap_read(data->regmap, BMI323_CHIP_ID_REG, &val);
+
+	ret = regmap_read(data->regmap, BMI323_CHIP_ID_REG, &val);
+	if (ret)
+		return ret;
+
+	if ((val & 0xFF) != BMI323_CHIP_ID_VAL) {
+		dev_err(data->dev, "Chip ID mismatch\n");
+		return -EINVAL;
+	}
+
+	ret = bmi323_feature_engine_enable(data, true);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, BMI323_ERR_REG, &val);
+	if (ret)
+		return ret;
+
+	if (val) {
+		dev_err(data->dev, "Sensor power error = 0x%x\n", val);
+		return -EINVAL;
+	}
+
+	ret = regmap_read(data->regmap, BMI323_STATUS_REG, &val);
+	if (ret)
+		return ret;
+
+	if (val != 0x01) {
+		dev_err(data->dev, "Sensor initialization error = 0x%x\n", val);
+		return -EINVAL;
+	}
+
+	/*
+	 * Set the Bandwidth coefficient which defines the 3 dB cutoff
+	 * frequency in relation to the ODR.
+	 */
+	ret = bmi323_set_bw(data, BMI323_ACCEL, BMI323_BW_ODR_BY_2);
+	if (ret)
+		return -EINVAL;
+
+	ret = bmi323_set_bw(data, BMI323_GYRO, BMI323_BW_ODR_BY_2);
+	if (ret)
+		return -EINVAL;
+
+	ret = bmi323_set_odr(data, BMI323_ACCEL, 25, 0);
+	if (ret)
+		return -EINVAL;
+
+	ret = bmi323_set_odr(data, BMI323_GYRO, 25, 0);
+	if (ret)
+		return -EINVAL;
+
+	ret = devm_add_action_or_reset(data->dev, bmi323_disable, data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int bmi323_core_probe(struct device *dev)
+{
+	static const char * const regulator_names[] = { "vdd", "vddio" };
+	struct iio_dev *indio_dev;
+	struct bmi323_data *data;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = dev_get_regmap(dev, NULL);
+	if (!regmap) {
+		dev_err(dev, "No regmap\n");
+		return -EINVAL;
+	}
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
+					     regulator_names);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
+
+	data = iio_priv(indio_dev);
+	data->dev = dev;
+	data->regmap = regmap;
+	mutex_init(&data->mutex);
+
+	ret = bmi323_init(data);
+	if (ret)
+		return -EINVAL;
+
+	ret = iio_read_mount_matrix(dev, &data->orientation);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "bmi323-imu";
+	indio_dev->info = &bmi323_info;
+	indio_dev->channels = bmi323_channels;
+	indio_dev->num_channels = ARRAY_SIZE(bmi323_channels);
+	indio_dev->available_scan_masks = bmi323_avail_scan_masks;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	dev_set_drvdata(data->dev, indio_dev);
+
+	ret = bmi323_trigger_probe(data, indio_dev);
+	if (ret)
+		return -EINVAL;
+
+	ret = devm_iio_triggered_buffer_setup_ext(data->dev, indio_dev,
+						  &iio_pollfunc_store_time,
+						  bmi323_trigger_handler,
+						  IIO_BUFFER_DIRECTION_IN,
+						  &bmi323_buffer_ops,
+						  bmi323_fifo_attributes);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Failed to setup trigger buffer\n");
+
+	ret = devm_iio_device_register(data->dev, indio_dev);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "Unable to register iio device\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
+
+MODULE_DESCRIPTION("Bosch BMI323 IMU driver");
+MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
new file mode 100644
index 000000000000..afbaa3d3c638
--- /dev/null
+++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * I2C driver for Bosch BMI323 6-Axis IMU.
+ *
+ * Copyright (C) 2023, Jagath Jog J <jagathjog1996@gmail.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "bmi323.h"
+
+/*
+ * From BMI323 datasheet section 4: Notes on the Serial Interface Support.
+ * Each I2C register read operation requires to read two dummy bytes before
+ * the actual payload.
+ */
+static int bmi323_regmap_i2c_read(void *context, const void *reg_buf,
+				  size_t reg_size, void *val_buf,
+				  size_t val_size)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct i2c_msg msgs[2];
+	u8 *buff = NULL;
+	int ret;
+
+	buff = kmalloc(val_size + BMI323_I2C_DUMMY, GFP_KERNEL);
+	if (!buff)
+		return -ENOMEM;
+
+	msgs[0].addr = i2c->addr;
+	msgs[0].flags = i2c->flags;
+	msgs[0].len = reg_size;
+	msgs[0].buf = (u8 *)reg_buf;
+
+	msgs[1].addr = i2c->addr;
+	msgs[1].len = val_size + BMI323_I2C_DUMMY;
+	msgs[1].buf = (u8 *)buff;
+	msgs[1].flags = i2c->flags | I2C_M_RD;
+
+	ret = i2c_transfer(i2c->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret < 0) {
+		kfree(buff);
+		return -EIO;
+	}
+
+	memcpy(val_buf, buff + BMI323_I2C_DUMMY, val_size);
+	kfree(buff);
+
+	return 0;
+}
+
+static int bmi323_regmap_i2c_write(void *context, const void *data,
+				   size_t count)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	int ret;
+	u8 reg;
+
+	reg = *(u8 *)data;
+	ret = i2c_smbus_write_i2c_block_data(i2c, reg, count - 1,
+					     data + sizeof(u8));
+
+	return ret;
+}
+
+static struct regmap_bus bmi323_regmap_bus = {
+	.read = bmi323_regmap_i2c_read,
+	.write = bmi323_regmap_i2c_write,
+};
+
+static int bmi323_i2c_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init(dev, &bmi323_regmap_bus, dev,
+				  &bmi323_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialize I2C Regmap\n");
+
+	return bmi323_core_probe(dev);
+}
+
+static const struct i2c_device_id bmi323_i2c_ids[] = {
+	{ "bmi323", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, bmi323_i2c_ids);
+
+static const struct of_device_id bmi323_of_i2c_match[] = {
+	{ .compatible = "bosch,bmi323" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bmi323_of_i2c_match);
+
+static struct i2c_driver bmi323_i2c_driver = {
+	.driver = {
+		.name = "bmi323",
+		.of_match_table = bmi323_of_i2c_match,
+	},
+	.probe_new = bmi323_i2c_probe,
+	.id_table = bmi323_i2c_ids,
+};
+module_i2c_driver(bmi323_i2c_driver);
+
+MODULE_DESCRIPTION("Bosch BMI323 IMU driver");
+MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_BMI323);
diff --git a/drivers/iio/imu/bmi323/bmi323_spi.c b/drivers/iio/imu/bmi323/bmi323_spi.c
new file mode 100644
index 000000000000..2b802a0c6d9d
--- /dev/null
+++ b/drivers/iio/imu/bmi323/bmi323_spi.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SPI driver for Bosch BMI323 6-Axis IMU.
+ *
+ * Copyright (C) 2023, Jagath Jog J <jagathjog1996@gmail.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "bmi323.h"
+
+/*
+ * From BMI323 datasheet section 4: Notes on the Serial Interface Support.
+ * Each SPI register read operation requires to read one dummy byte before
+ * the actual payload.
+ */
+static int bmi323_regmap_spi_read(void *context, const void *reg_buf,
+				  size_t reg_size, void *val_buf,
+				  size_t val_size)
+{
+	struct spi_device *spi = context;
+	u8 reg, *buff = NULL;
+	int ret;
+
+	buff = kmalloc(val_size + BMI323_SPI_DUMMY, GFP_KERNEL);
+	if (!buff)
+		return -ENOMEM;
+
+	reg = *(u8 *)reg_buf | 0x80;
+	ret = spi_write_then_read(spi, &reg, sizeof(reg), buff,
+				  val_size + BMI323_SPI_DUMMY);
+	if (ret) {
+		kfree(buff);
+		return ret;
+	}
+
+	memcpy(val_buf, buff + BMI323_SPI_DUMMY, val_size);
+	kfree(buff);
+
+	return ret;
+}
+
+static int bmi323_regmap_spi_write(void *context, const void *data,
+				   size_t count)
+{
+	struct spi_device *spi = context;
+
+	return spi_write(spi, data, count);
+}
+
+static struct regmap_bus bmi323_regmap_bus = {
+	.read = bmi323_regmap_spi_read,
+	.write = bmi323_regmap_spi_write,
+};
+
+static int bmi323_spi_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct regmap *regmap;
+	int dummy;
+
+	regmap = devm_regmap_init(dev, &bmi323_regmap_bus, dev,
+				  &bmi323_regmap_config);
+
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialize SPI Regmap\n");
+
+	/*
+	 * Dummy read is required to enable SPI interface after POR.
+	 * See datasheet section 7.2.1 "Protocol Selection".
+	 */
+	regmap_read(regmap, BMI323_CHIP_ID_REG, &dummy);
+
+	return bmi323_core_probe(dev);
+}
+
+static const struct spi_device_id bmi323_spi_ids[] = {
+	{ "bmi323", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, bmi323_spi_ids);
+
+static const struct of_device_id bmi323_of_spi_match[] = {
+	{ .compatible = "bosch,bmi323" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bmi323_of_spi_match);
+
+static struct spi_driver bmi323_spi_driver = {
+	.driver = {
+		.name = "bmi323",
+		.of_match_table = bmi323_of_spi_match,
+	},
+	.probe = bmi323_spi_probe,
+	.id_table = bmi323_spi_ids,
+};
+module_spi_driver(bmi323_spi_driver);
+
+MODULE_DESCRIPTION("Bosch BMI323 IMU driver");
+MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_BMI323);
-- 
2.20.1

