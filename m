Return-Path: <linux-iio+bounces-22180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA864B18AE8
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 08:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8D66276D9
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 06:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0051F1302;
	Sat,  2 Aug 2025 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWqwoo9+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E019D081;
	Sat,  2 Aug 2025 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754117086; cv=none; b=RNwCtc6HrYXQFWJghmSWI65Z+BWXbymlhTkVN2jAyJsULROxpk7PcGTiukCiRSu6lrqfBL77+/XOikCTZSDyWAqPBYX60ELGn3UpgWNijqaq2+/e3XsgttXOVhoBuemXtvNeRrRlTSY1YBSnMqyege9ipfrVgCrdeF0XLUW1SKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754117086; c=relaxed/simple;
	bh=5pvtlNJu2PeADuNGG+jQKjnAveAb+p+UUgX2fjDmv18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fi5bxCGlwnTd1Sdqzy/jveAts4Q6Jd5xGtP5/zYNGyee65fqsCR8sPGBEkejYkgUElt3AXRVhBlXH5AcUwQUHHzIrBlmf96tjAKhx1pM6He9RURl+qOS7jUhzxJYuPyXw9MjckWfckNo4H2mGsdTgKcSei7zq2wEF10y9CU+8hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWqwoo9+; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4209a0d426so3102973a12.1;
        Fri, 01 Aug 2025 23:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754117084; x=1754721884; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Erv4Md3UAlk0MxKuDkmck1s2JwW4FGvKvWAwXAm6LBI=;
        b=lWqwoo9+dXDzXuvFzydj8vKUju4bF/BHjt6P6hSvdjRzpsUPmRr/fas0NEGZp5RPoN
         FF+xLEYcC05GI1tMej0RnBW18FKJcjnGMZxcHuwj3J5SXA/WHEarvTJXia4etjpJCbnW
         x6aa61kt9ntVXBAEDybWshONlaHoIQZkAs//hngl7McIQyNKWX0jZbn+JOOCU/APJjJE
         l4EnuI0BP8S0beMG6QoOUG4K0JNkGXrRtKjCg7pYp1+oxOgQy6OMkvt2/1Z5svAUg+zG
         21WTrk8fkPbw5HsZwDCzkKFQ0p1lS2AMgGMxEk0HWF06UX6PEJfbFha9/G2eaFXru9uc
         BPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754117084; x=1754721884;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Erv4Md3UAlk0MxKuDkmck1s2JwW4FGvKvWAwXAm6LBI=;
        b=DaOm9OqM9qnb14VCihyxRo/RFTM4XE3jxioPv8NcWGQe1u64N6emhjctrVMzOfGOLP
         6UjuLF/ZCF35Z4j72USM0n+VUb9iTZjKh66Ap14+OQAPHzp4qDRaEqVa33iHO68CJg1i
         8wmt9KhrwfvF2HMF4XdfPgN46zrIcp+CJppOIeEKO1PR2RVE/i2fe9ekzldEgZxXmqpW
         kfZuVhSqEaxHBcFqKduf84UN8GzmR50hvPEQBXMlHn1U/iqJeaBlcAjblGNbjVOgXIUM
         uuaC6D/in1iQsEk45pzoi5jhggVRi2+Q/Jn1MvpWPSMBFCYYEzbiTliw4cIzCBPy76IQ
         dCWg==
X-Forwarded-Encrypted: i=1; AJvYcCUrRToFsONuU0fRGjBUFdWfJGpYCmZ7Gtlhl/nrsq7IM0mPcLap0S6BKcTKNqpJLaH3+i3lXpeeb4Yh@vger.kernel.org, AJvYcCXWcS2wXJultuK5VDTavWBqoSR3xw1E3M0pWO7nfMZO9EC9EdkbIP69T8KqFqNvUePmvdN4vHQU7jxN@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9RLBTz5YEIv3K11lYG/1nHr34lYPdzEpt+SAi2Xcn02AFquf
	gRHu9k/+scatxGfVqY9hj7kbwI2m/LkG8gmIVKi/useS0xni29t0keXsX2CzFpy7Kf0=
X-Gm-Gg: ASbGncuL41irXPO8LZUkARNPfrWAqK8wtNAd6L3xU8QSaJrt3JE7gjFnB7aZDpMPgYZ
	7zB3MVEXI19oEVuVqC/JDk1p2zpUgVE8o/FUAzotiPVSmzyB1hTIu5DwmNKXOY+jFSxidDEfj0h
	6vPIVcDqCoygQFL/UNLiDsT8UjYfuYHy+XvBZtfGyI4kr23NiEMOCijxY7+5Wc43bVvNGtmc8E8
	zy2tSRoBGEvRmpMd9fjYC5pq7rVVcnm+k3iFSbshFolrw4x+wt090VXJdqY3F0ISd2uacmxGrRr
	4upJ2N2ff6q7WO4RHgKypY8hHACEgQur5cAv8RkuuDo7MCvJfrIvG0iBl1iGq2jGokDMk59T3vE
	3VxAk7WWI/8fvBl2SQa/tTxKmNJEPoPw=
X-Google-Smtp-Source: AGHT+IGPFnD9TzOJuXWU2ABsEKWuNAcJ0uA7OBT2IYA31zcCFjBTM5L6YQ+4FufasLqT4IWDt+iw3w==
X-Received: by 2002:a05:6a20:3d12:b0:232:b849:b906 with SMTP id adf61e73a8af0-23df8fa4e55mr3813183637.11.1754117083418;
        Fri, 01 Aug 2025 23:44:43 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c43:2e47:cb90:ffcc:76af:a5b9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe9003sm5639676b3a.125.2025.08.01.23.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 23:44:43 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Sat, 02 Aug 2025 12:14:27 +0530
Subject: [PATCH v2 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250802-tlv493d-sensor-v6_16-rc5-v2-1-e867df86ad93@gmail.com>
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
In-Reply-To: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754117073; l=18938;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=5pvtlNJu2PeADuNGG+jQKjnAveAb+p+UUgX2fjDmv18=;
 b=4nvSNW5rSBFqecnNrY4BlzrTdcLuAFBqRf7esm3xAAtBbdAkKsfTc35MQVd6zwALHzREUFGs5
 1tCMvbJAZM/Ci72BoJf8uErCTQ9t4cuUMagjKjXLPGpMVxpZcgCQFc3
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
applications includes joysticks, control elements (white goods,
multifunction knops), or electric meters (anti tampering) and any
other application that requires accurate angular measurements at
low power consumptions.

The Sensor is configured over I2C, and as part of Sensor measurement
data it provides 3-Axis magnetic fields and temperature core measurement.

The driver supports raw value read and buffered input via external trigger
to allow streaming values with the same sensing timestamp.

While sensor has interrupt pin multiplexed with I2C SCL pin. But for bus
configurations interrupt(INT) is not recommended, unless timing constraints
between I2C data transfers and interrupt pulses are monitored and aligned.

The Sensor's I2C register map and mode information is described in product
User Manual[Link].

Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf
Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 drivers/iio/magnetometer/Kconfig   |  13 +
 drivers/iio/magnetometer/Makefile  |   2 +
 drivers/iio/magnetometer/tlv493d.c | 556 +++++++++++++++++++++++++++++++++++++
 3 files changed, 571 insertions(+)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 3debf1320ad1..e073ebe11810 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -173,6 +173,19 @@ config IIO_ST_MAGN_SPI_3AXIS
 	  To compile this driver as a module, choose M here. The module
 	  will be called st_magn_spi.
 
+config INFINEON_TLV493D
+	tristate "Infineon TLV493D Low-Power 3D Magnetic Sensor"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here to add support for the Infineon TLV493D-A1B6 Low-
+	  Power 3D Megnetic Sensor.
+
+	  This driver can also be compiled as a module.
+	  To compile this driver as a module, choose M here: the module
+	  will be called tlv493d.
+
 config SENSORS_HMC5843
 	tristate
 	select IIO_BUFFER
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index 9297723a97d8..dfe970fcacb8 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -23,6 +23,8 @@ st_magn-$(CONFIG_IIO_BUFFER) += st_magn_buffer.o
 obj-$(CONFIG_IIO_ST_MAGN_I2C_3AXIS) += st_magn_i2c.o
 obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) += st_magn_spi.o
 
+obj-$(CONFIG_INFINEON_TLV493D)		+= tlv493d.o
+
 obj-$(CONFIG_SENSORS_HMC5843)		+= hmc5843_core.o
 obj-$(CONFIG_SENSORS_HMC5843_I2C)	+= hmc5843_i2c.o
 obj-$(CONFIG_SENSORS_HMC5843_SPI)	+= hmc5843_spi.o
diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetometer/tlv493d.c
new file mode 100644
index 000000000000..da1569ae97bf
--- /dev/null
+++ b/drivers/iio/magnetometer/tlv493d.c
@@ -0,0 +1,556 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * Driver for the Infineon TLV493D Low-Power 3D Magnetic Sensor
+ *
+ * Copyright (C) 2025 Dixit Parmar <dixitparmar19@gmail.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define TLV493D_RD_REG_BX	0x00
+#define TLV493D_RD_REG_BY	0x01
+#define TLV493D_RD_REG_BZ	0x02
+#define TLV493D_RD_REG_TEMP	0x03
+#define TLV493D_RD_REG_BX2	0x04
+#define TLV493D_RD_REG_BZ2	0x05
+#define TLV493D_RD_REG_TEMP2	0x06
+#define TLV493D_RD_REG_RES1	0x07
+#define TLV493D_RD_REG_RES2	0x08
+#define TLV493D_RD_REG_RES3	0x09
+#define TLV493D_RD_REG_MAX	0x0a
+#define TLV493D_WR_REG_RES	0x00
+#define TLV493D_WR_REG_MODE1	0x01
+#define TLV493D_WR_REG_RES2	0x02
+#define TLV493D_WR_REG_MODE2	0x03
+#define TLV493D_WR_REG_MAX	0x04
+
+#define TLV493D_BX_MAG_X_AXIS_MSB	GENMASK(7, 0)
+#define TLV493D_BX2_MAG_X_AXIS_LSB	GENMASK(7, 4)
+#define TLV493D_BY_MAG_Y_AXIS_MSB	GENMASK(7, 0)
+#define TLV493D_BX2_MAG_Y_AXIS_LSB	GENMASK(3, 0)
+#define TLV493D_BZ_MAG_Z_AXIS_MSB	GENMASK(7, 0)
+#define TLV493D_BZ2_MAG_Z_AXIS_LSB	GENMASK(3, 0)
+#define TLV493D_TEMP_TEMP_MSB		GENMASK(7, 4)
+#define TLV493D_TEMP2_TEMP_LSB		GENMASK(7, 0)
+#define TLV493D_TEMP_CHANNEL		GENMASK(1, 0)
+#define TLV493D_MODE1_MOD_LOWFAST	GENMASK(1, 0)
+#define TLV493D_MODE2_LP_PERIOD	BIT(6)
+#define TLV493D_RD_REG_RES1_WR_MASK	GENMASK(4, 3)
+#define TLV493D_RD_REG_RES2_WR_MASK	GENMASK(7, 0)
+#define TLV493D_RD_REG_RES3_WR_MASK	GENMASK(4, 0)
+
+enum tlv493d_channels {
+	TLV493D_AXIS_X = 0,
+	TLV493D_AXIS_Y,
+	TLV493D_AXIS_Z,
+	TLV493D_TEMPERATURE
+};
+
+enum tlv493d_op_mode {
+	TLV493D_OP_MODE_POWERDOWN = 0,
+	TLV493D_OP_MODE_FAST,
+	TLV493D_OP_MODE_LOWPOWER,
+	TLV493D_OP_MODE_ULTRA_LOWPOWER,
+	TLV493D_OP_MODE_MASTERCONTROLLED,
+	TLV493D_OP_MODE_MAX
+};
+
+struct tlv493d_mode {
+	u8 m;
+	u32 sleep_us;
+};
+
+struct tlv493d_data {
+	struct device *dev;
+	struct i2c_client *client;
+	/* protects from simultaneous sensor access and register readings */
+	struct mutex lock;
+	u8 mode;
+	u8 wr_regs[TLV493D_WR_REG_MAX];
+};
+
+/*
+ * Different mode has different measurement cycle time, this time is
+ * used in deriving the sleep and timemout while reading the data from
+ * sensor in polling.
+ * Power-down mode: No measurement.
+ * Fast mode: Freq:3.3 KHz. Measurement time:305 usec.
+ * Low-power mode: Freq:100 Hz. Measurement time:10 msec.
+ * Ultra low-power mode: Freq:10 Hz. Measurement time:100 msec.
+ * Master controlled mode: Freq:3.3 Khz. Measurement time:305 usec.
+ */
+static struct tlv493d_mode tlv493d_mode_info[TLV493D_OP_MODE_MAX] = {
+	{ .m = TLV493D_OP_MODE_POWERDOWN, .sleep_us = 0 },
+	{ .m = TLV493D_OP_MODE_FAST, .sleep_us = 305 },
+	{ .m = TLV493D_OP_MODE_LOWPOWER, .sleep_us = 10 * USEC_PER_MSEC	},
+	{ .m = TLV493D_OP_MODE_ULTRA_LOWPOWER, .sleep_us = 100 * USEC_PER_MSEC },
+	{ .m = TLV493D_OP_MODE_MASTERCONTROLLED, .sleep_us = 305 }
+};
+
+/*
+ * The datasheet mentions the sensor supports only direct byte-stream write
+ * starting from register address 0x0. So for any modification to be made to
+ * any write registers, it must be written starting from the register address
+ * 0x0. I2C write operation should not contain register address in the I2C
+ * frame, it should contains only raw byte stream for the write registers.
+ * I2C Frame: |S|SlaveAddr Wr|Ack|Byte[0]|Ack|Byte[1]|Ack|.....|Sp|
+ */
+static int tlv493d_write_all_regs(struct tlv493d_data *data)
+{
+	int ret;
+
+	if (!data || !data->client)
+		return -EINVAL;
+
+	ret = i2c_master_send(data->client, data->wr_regs, ARRAY_SIZE(data->wr_regs));
+	if (ret < 0) {
+		dev_err(data->dev, "i2c write registers failed, error: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tlv493d_set_operating_mode(struct tlv493d_data *data, u8 mode)
+{
+	if (!data)
+		return -EINVAL;
+
+	u8 mode1_cfg, mode2_cfg;
+
+	switch (mode) {
+	case TLV493D_OP_MODE_POWERDOWN:
+		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 0);
+		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
+		break;
+
+	case TLV493D_OP_MODE_FAST:
+		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 1);
+		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
+		break;
+
+	case TLV493D_OP_MODE_LOWPOWER:
+		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 2);
+		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 1);
+		break;
+
+	case TLV493D_OP_MODE_ULTRA_LOWPOWER:
+		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 2);
+		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
+		break;
+
+	case TLV493D_OP_MODE_MASTERCONTROLLED:
+		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 3);
+		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
+		break;
+
+	default:
+		dev_err(data->dev, "invalid mode configuration\n");
+		return -EINVAL;
+	}
+
+	data->wr_regs[TLV493D_WR_REG_MODE1] |= mode1_cfg;
+	data->wr_regs[TLV493D_WR_REG_MODE2] |= mode2_cfg;
+
+	return tlv493d_write_all_regs(data);
+}
+
+static s16 tlv493d_get_channel_data(u8 *b, u8 ch)
+{
+	if (!b)
+		return -EINVAL;
+
+	u16 val = 0;
+
+	switch (ch) {
+	case TLV493D_AXIS_X:
+		val = FIELD_GET(TLV493D_BX_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX]) << 4 |
+			FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4;
+		break;
+	case TLV493D_AXIS_Y:
+		val = FIELD_GET(TLV493D_BY_MAG_Y_AXIS_MSB, b[TLV493D_RD_REG_BY]) << 4 |
+			FIELD_GET(TLV493D_BX2_MAG_Y_AXIS_LSB, b[TLV493D_RD_REG_BX2]);
+		break;
+	case TLV493D_AXIS_Z:
+		val = FIELD_GET(TLV493D_BZ_MAG_Z_AXIS_MSB, b[TLV493D_RD_REG_BZ]) << 4 |
+			FIELD_GET(TLV493D_BZ2_MAG_Z_AXIS_LSB, b[TLV493D_RD_REG_BZ2]);
+		break;
+	case TLV493D_TEMPERATURE:
+		val = FIELD_GET(TLV493D_TEMP_TEMP_MSB, b[TLV493D_RD_REG_TEMP]) << 8 |
+			FIELD_GET(TLV493D_TEMP2_TEMP_LSB, b[TLV493D_RD_REG_TEMP2]);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sign_extend32(val, 11);
+}
+
+static int tlv493d_get_measurements(struct tlv493d_data *data, s16 *x, s16 *y,
+				s16 *z, s16 *t)
+{
+	u8 buff[7] = {};
+	int err, ret;
+	struct tlv493d_mode *mode;
+
+	if (!data)
+		return -EINVAL;
+
+	guard(mutex)(&data->lock);
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
+	mode = &tlv493d_mode_info[data->mode];
+
+	/*
+	 * Poll until data is valid,
+	 * For a valid data TLV493D_TEMP_CHANNEL bit of TLV493D_RD_REG_TEMP should be set to 0.
+	 * The sampling time depends on the sensor mode. poll 3x the time of the sampling time.
+	 */
+	ret = read_poll_timeout(i2c_master_recv, err, err ||
+			FIELD_GET(TLV493D_TEMP_CHANNEL, buff[TLV493D_RD_REG_TEMP]) == 0,
+			mode->sleep_us, (3 * mode->sleep_us), false, data->client, buff,
+			ARRAY_SIZE(buff));
+	if (ret) {
+		dev_err(data->dev, "i2c read poll timeout, error:%d\n", ret);
+		goto out;
+	}
+	if (err < 0) {
+		dev_err(data->dev, "i2c read data failed, error:%d\n", err);
+		ret = err;
+		goto out;
+	}
+
+	*x = tlv493d_get_channel_data(buff, TLV493D_AXIS_X);
+	*y = tlv493d_get_channel_data(buff, TLV493D_AXIS_Y);
+	*z = tlv493d_get_channel_data(buff, TLV493D_AXIS_Z);
+	*t = tlv493d_get_channel_data(buff, TLV493D_TEMPERATURE);
+
+out:
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+	return ret;
+}
+
+static int tlv493d_init(struct tlv493d_data *data)
+{
+	int ret;
+	u8 buff[TLV493D_RD_REG_MAX];
+
+	if (!data)
+		return -EINVAL;
+
+	/*
+	 * The sensor initialization requires below steps to be followed,
+	 * 1. Power-up sensor.
+	 * 2. Read and store read-registers map (0x0-0x9).
+	 * 3. Copy values from read reserved registers to write reserved fields (0x0-0x3).
+	 * 4. Set operating mode.
+	 * 5. Write to all registers.
+	 */
+	ret = i2c_master_recv(data->client, buff, ARRAY_SIZE(buff));
+	if (ret < 0) {
+		dev_err(data->dev, "i2c read failed, error %d\n", ret);
+		return ret;
+	}
+
+	/* Write register 0x0 is reserved. Does not require to be updated.*/
+	data->wr_regs[0] = 0;
+	data->wr_regs[1] = buff[TLV493D_RD_REG_RES1] & TLV493D_RD_REG_RES1_WR_MASK;
+	data->wr_regs[2] = buff[TLV493D_RD_REG_RES2] & TLV493D_RD_REG_RES2_WR_MASK;
+	data->wr_regs[3] = buff[TLV493D_RD_REG_RES3] & TLV493D_RD_REG_RES3_WR_MASK;
+
+	ret = tlv493d_set_operating_mode(data, data->mode);
+	if (ret < 0) {
+		dev_err(data->dev, "failed to set operating mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tlv493d_read_raw(struct iio_dev *indio_dev,
+			const struct iio_chan_spec *chan, int *val,
+			int *val2, long mask)
+{
+	struct tlv493d_data *data = iio_priv(indio_dev);
+	s16 x, y, z, t;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = tlv493d_get_measurements(data, &x, &y, &z, &t);
+		if (ret)
+			return ret;
+
+		/* Return raw values for requested channel */
+		switch (chan->address) {
+		case TLV493D_AXIS_X:
+			*val = x;
+			return IIO_VAL_INT;
+		case TLV493D_AXIS_Y:
+			*val = y;
+			return IIO_VAL_INT;
+		case TLV493D_AXIS_Z:
+			*val = z;
+			return IIO_VAL_INT;
+		case TLV493D_TEMPERATURE:
+			*val = t;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_MAGN:
+			/*
+			 * Magnetic field scale: 0.0098 mTesla (i.e. 9.8 µT)
+			 * Magnetic filed in Guass: mT * 10 = 0.098.
+			 */
+			*val = 98;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_TEMP:
+			/*
+			 * Temperature scale: 1.1 °C per LSB, expressed as 1100 m°C
+			 * Returned as integer for IIO core to apply:
+			 * temp = (raw + offset) * scale
+			 */
+			*val = 1100;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_TEMP:
+			/*
+			 * Temperature offset includes sensor-specific raw offset
+			 * plus compensation for +25°C bias in formula.
+			 * offset = -raw_offset + (25000 / 1100)
+			 * -340 + 22.72 = -317.28
+			 */
+			*val = -31728;
+			*val2 = 100;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static irqreturn_t tlv493d_trigger_handler(int irq, void *ptr)
+{
+	struct iio_poll_func *pf = ptr;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct tlv493d_data *data = iio_priv(indio_dev);
+
+	struct {
+		s16 channels[3];
+		s16 temperature;
+		aligned_s64 timestamp;
+	} scan;
+
+	s16 x, y, z, t;
+	int ret;
+
+	ret = tlv493d_get_measurements(data, &x, &y, &z, &t);
+	if (ret) {
+		dev_err(data->dev, "failed to read sensor data\n");
+		goto trig_out;
+	}
+
+	scan.channels[0] = x;
+	scan.channels[1] = y;
+	scan.channels[2] = z;
+	scan.temperature = t;
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				pf->timestamp);
+trig_out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+#define TLV493D_AXIS_CHANNEL(axis, index)			\
+	{							\
+		.type = IIO_MAGN,				\
+		.modified = 1,					\
+		.channel2 = IIO_MOD_##axis,			\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+				BIT(IIO_CHAN_INFO_SCALE),	\
+		.address = index,				\
+		.scan_index = index,				\
+		.scan_type = {					\
+			.sign = 's',				\
+			.realbits = 12,				\
+			.storagebits = 16,			\
+			.endianness = IIO_CPU,			\
+		},						\
+	}
+
+static const struct iio_chan_spec tlv493d_channels[] = {
+	TLV493D_AXIS_CHANNEL(X, TLV493D_AXIS_X),
+	TLV493D_AXIS_CHANNEL(Y, TLV493D_AXIS_Y),
+	TLV493D_AXIS_CHANNEL(Z, TLV493D_AXIS_Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_SCALE) |
+				BIT(IIO_CHAN_INFO_OFFSET),
+		.address = TLV493D_TEMPERATURE,
+		.scan_index = TLV493D_TEMPERATURE,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 12,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+static const struct iio_info tlv493d_info = {
+	.read_raw = tlv493d_read_raw,
+};
+
+static const struct iio_buffer_setup_ops tlv493d_setup_ops = { NULL };
+
+static const unsigned long tlv493d_scan_masks[] = { GENMASK(3, 0), 0 };
+
+static int tlv493d_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct tlv493d_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->dev = dev;
+	data->client = client;
+	i2c_set_clientdata(client, indio_dev);
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable regulator\n");
+
+	/*
+	 * Setting Sensor default operating mode as Master Controlled mode as
+	 * it performs measurement cycle on-request only and stays in Power-Down
+	 * mode until next cycle is initiated.
+	 */
+	data->mode = TLV493D_OP_MODE_MASTERCONTROLLED;
+	ret = tlv493d_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize\n");
+
+	indio_dev->info = &tlv493d_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = client->name;
+	indio_dev->channels = tlv493d_channels;
+	indio_dev->num_channels = ARRAY_SIZE(tlv493d_channels);
+	indio_dev->available_scan_masks = tlv493d_scan_masks;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+			iio_pollfunc_store_time, tlv493d_trigger_handler,
+			&tlv493d_setup_ops);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");
+
+	ret = pm_runtime_set_active(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret < 0)
+		return ret;
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_autosuspend_delay(dev, 500);
+	pm_runtime_use_autosuspend(dev);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "iio device register failed\n");
+
+	return 0;
+}
+
+static int tlv493d_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tlv493d_data *data = iio_priv(indio_dev);
+
+	return tlv493d_set_operating_mode(data, TLV493D_OP_MODE_POWERDOWN);
+}
+
+static int tlv493d_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tlv493d_data *data = iio_priv(indio_dev);
+
+	return tlv493d_set_operating_mode(data, data->mode);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops,
+			tlv493d_runtime_suspend, tlv493d_runtime_resume, NULL);
+
+static const struct i2c_device_id tlv493d_id[] = {
+	{ "tlv493d" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tlv493d_id);
+
+static const struct of_device_id tlv493d_of_match[] = {
+	{ .compatible = "infineon,tlv493d-a1b6", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tlv493d_of_match);
+
+static struct i2c_driver tlv493d_driver = {
+	.driver = {
+		.name = "tlv493d",
+		.of_match_table = tlv493d_of_match,
+		.pm = pm_ptr(&tlv493d_pm_ops),
+	},
+	.probe = tlv493d_probe,
+	.id_table = tlv493d_id,
+};
+
+module_i2c_driver(tlv493d_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Infineon TLV493D Low-Power 3D Magnetic Sensor");
+MODULE_AUTHOR("Dixit Parmar <dixitparmar19@gmail.com>");

-- 
2.43.0


