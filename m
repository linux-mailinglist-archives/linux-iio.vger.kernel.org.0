Return-Path: <linux-iio+bounces-22368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABC7B1D10D
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 04:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9333B43BE
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 02:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795CE1C7015;
	Thu,  7 Aug 2025 02:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEbe3TsF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E171CBA02;
	Thu,  7 Aug 2025 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754535426; cv=none; b=UeO5EISG3Z8HTUq3SwzWvN9HMW3HoETm7Y24+z7gRZQINMpsJgmnNmc3P67YM/fpvVxVuRG+SXJ67W8uTOCH+CG5/lDT+hqgxFzgtlO2np4mhzeSKppYMAU6KnBq2DazshitFMV97XpSmQSMc9GPhzxftxZzj7BPqtm+con5MfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754535426; c=relaxed/simple;
	bh=LzZrfd0lRJKMFN35lijHLHju1OrBPHXOEPpTIrYbtoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hg2OihEm1TqY4FHxYf6dS3i4KlLnsafrHiaihz94GnUgaOyae6dYPgD5zq6jSqjyb+iRRw9Ia7o71lk9KcjPg1uZJHBKakk0/f6Qx6Kcw1EfGG1Zx4KItQDUMfxUVDvVYN0tCKAqjWKhhIudmD2ZSdz+XWVRl9cgWXn2GENVNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEbe3TsF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313a001d781so526836a91.3;
        Wed, 06 Aug 2025 19:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754535423; x=1755140223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSxyk91XX4UPw0QE20sRbXDudbYTAvhAYDelQr8Nuck=;
        b=PEbe3TsFxy50plS7lXESCt1+6zMeHDqc48jV2NSr9NhlqHy5qS6o+HNTf7WW3DJwBx
         0TBpYBJWnqhS1H1LOZUL+vgUeuCnJKPGmisYrG9TNt6+K/p98+WxMrS0Pu6VWOVrRykz
         cAWL3fZqLTFAITKlmJXRoJAaNTwESZwMl3RTC0uvHAAR1oddq3IlDXXVVqRWevhjRULj
         Lz6CruyIywQR+nYSBH/xhtYPh1xlw+jnCsgEKdCK23Wc/uFXaPXMKjg3AJ95goAysgNJ
         HI4vjLxqrusu3Qbjp0uoyrqxVAse69LOfxVaWmeYPUdAiMWS6w3y+5YT40hOD6Vf+U4Y
         oXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754535423; x=1755140223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSxyk91XX4UPw0QE20sRbXDudbYTAvhAYDelQr8Nuck=;
        b=fi/ofFsQ+cQErdGxhADE9/SUl3MpWY3UMVx+0FaIqHjCjN5+KXJexui1djV1UV6FCl
         lfErDrVrSVpwd10CpdvCXMWAv1/myBlM/YrW3JV8zKbOW5EmxdsAfX63P0Tq6fL7u6ax
         P9XhzjhwFRSGSmgRyT58HPY31lrwRFYkou0g7fmOE70u00BodVocMZlNmt25MQXDRWEc
         P97A8g9a/iQqwota4G3AZt7e+KjBc4vIwSwERPTz/7ej6v9IUKtH6SV6WW1mHNJESCpi
         II8yV5x6rMchmAY5KLudGZhpwmViTdMVNOG0uf2cKMuEti91uq9DPGekFEALtXIpU9WV
         qxXA==
X-Forwarded-Encrypted: i=1; AJvYcCV4G2ISMjyDtutrSCN6W6KNihkfys6rEeWFxr3mg5UIFd9kDAqtGO2q3znknr7Glt3wUOE45FBF/b3o@vger.kernel.org, AJvYcCXvC6kFu1h0F/DwHdgrngsy+dJkuTXLd2ZSDGKS4xMKy6KArjQst6HOiCok3YnESDmHmFUXRuxonJ3z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz856sXMjpYU9H4fSt/hT20DoS4B6FYjNUQZR3l7z5jT36Dgr0s
	q/UdDf/WNFzkObvAu2x1IYzPyp0j4nqFAQiMqpC20K6I9UNPb/SI/mUdoRcTtEPc
X-Gm-Gg: ASbGncvAKXKTW482AUu7PWfGlNpViQo4oMDkr/Lga2JKp2hlPLF6TISxXn9SORjWe3K
	wHMMHp2h0AGxqtZXy5hKsmRqo9Grnr9yZ7fAIw/HjyT9+2DKuCISXofVcSk7t/TcAbCsxYqcz7i
	O4zQcOAl1Vgo/xnVvkUs1TNua4vLXf1X0rJ6FRDAWd7xzpqHEP+2ERd1HJzGR9OkCZvxfNR/x1P
	j3788Z53GL3WQwjJfGzbV/gsvpSHasBCUbRhbnMuaPdqmVDcFdQldYuEnLg1vCrl4XOJQcz8vaM
	KaxKb9ENDPrdgAeEwSXAabDNo3+vswZjo8dvXG5HD67OsKWHwbOPWvYU7PopOLGebm5vVInX22n
	No83NpnOqVJjiW5vm6Pm3CsZU9EldZCs=
X-Google-Smtp-Source: AGHT+IHIS3fF+/m2kGqOBPA1cOg8RIPoUyoPij1uob2p7w+BMu9pD6KmksDNCKKNi5D249P9ZgdCKQ==
X-Received: by 2002:a17:90b:1850:b0:321:27d5:eaf1 with SMTP id 98e67ed59e1d1-32166cc8bc2mr6492474a91.25.1754535423054;
        Wed, 06 Aug 2025 19:57:03 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c44:c940:e6ba:2cae:4deb:130b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0bb79sm20885560a91.31.2025.08.06.19.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 19:57:02 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Thu, 07 Aug 2025 08:26:35 +0530
Subject: [PATCH v3 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250807-tlv493d-sensor-v6_16-rc5-v3-1-b80d2cb41232@gmail.com>
References: <20250807-tlv493d-sensor-v6_16-rc5-v3-0-b80d2cb41232@gmail.com>
In-Reply-To: <20250807-tlv493d-sensor-v6_16-rc5-v3-0-b80d2cb41232@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754535409; l=18400;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=LzZrfd0lRJKMFN35lijHLHju1OrBPHXOEPpTIrYbtoo=;
 b=CTVnAfFp9B8kJn0+d+PgLo46xl2aeFucwkIFmzC+q7+t74+RSm5ZWy04mOAje8xys3BLgB9CL
 iYaVRdCJwEmD2AoX9u0ufJlxw0VPoss7IGbBW+LrUCPi3m8NzNPY5ne
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

While the sensor has an interrupt pin multiplexed with an I2C SCL pin.
But for bus configurations interrupt(INT) is not recommended, unless timing
constraints between I2C data transfers and interrupt pulses are monitored
and aligned.

The Sensor's I2C register map and mode information is described in product
User Manual [1].

Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf [1]
Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 drivers/iio/magnetometer/Kconfig   |  13 +
 drivers/iio/magnetometer/Makefile  |   2 +
 drivers/iio/magnetometer/tlv493d.c | 524 +++++++++++++++++++++++++++++++++++++
 3 files changed, 539 insertions(+)

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
index 000000000000..8611664f0237
--- /dev/null
+++ b/drivers/iio/magnetometer/tlv493d.c
@@ -0,0 +1,524 @@
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
+/*
+ * TLV493D sensor I2C communication note:
+ *
+ * The sensor supports only direct byte-stream write starting from the
+ * register address 0x0. So for any modification to be made to any write
+ * registers, it must be written starting from the register address  0x0.
+ * I2C write operation should not contain the register address in the I2C
+ * frame, it should contain only raw byte stream for the write registers.
+ * I2C Frame: |S|SlaveAddr Wr|Ack|Byte[0]|Ack|Byte[1]|Ack|.....|Sp|
+ *
+ * Same as the write operation, reading from the sensor registers is also
+ * performed starting from the register address 0x0 for as many bytes as
+ * need to be read.
+ * I2C read operation should not contain the register address in the I2C frame.
+ * I2C Frame: |S|SlaveAddr Rd|Ack|Byte[0]|Ack|Byte[1]|Ack|.....|Sp|
+ */
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
+	TLV493D_OP_MODE_MASTERCONTROLLED
+};
+
+struct tlv493d_data {
+	struct device *dev;
+	struct i2c_client *client;
+	/* protects from simultaneous sensor access and register readings */
+	struct mutex lock;
+	enum tlv493d_op_mode mode;
+	u8 wr_regs[TLV493D_WR_REG_MAX];
+};
+
+/*
+ * Different mode has different measurement sampling time, this time is
+ * used in deriving the sleep and timeout while reading the data from
+ * sensor in polling.
+ * Power-down mode: No measurement.
+ * Fast mode: Freq:3.3 KHz. Measurement time:305 usec.
+ * Low-power mode: Freq:100 Hz. Measurement time:10 msec.
+ * Ultra low-power mode: Freq:10 Hz. Measurement time:100 msec.
+ * Master controlled mode: Freq:3.3 Khz. Measurement time:305 usec.
+ */
+static u32 tlv493d_sample_rate_us[] = { 0, 305, 10000, 100000, 305 };
+
+static int tlv493d_write_all_regs(struct tlv493d_data *data)
+{
+	int ret;
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
+static int tlv493d_set_operating_mode(struct tlv493d_data *data, enum tlv493d_op_mode mode)
+{
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
+	}
+
+	data->wr_regs[TLV493D_WR_REG_MODE1] |= mode1_cfg;
+	data->wr_regs[TLV493D_WR_REG_MODE2] |= mode2_cfg;
+
+	return tlv493d_write_all_regs(data);
+}
+
+static s16 tlv493d_get_channel_data(u8 *b, enum tlv493d_channels ch)
+{
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
+	u32 sleep_us = tlv493d_sample_rate_us[data->mode];
+
+	guard(mutex)(&data->lock);
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Poll until data is valid,
+	 * For a valid data TLV493D_TEMP_CHANNEL bit of TLV493D_RD_REG_TEMP should be set to 0.
+	 * The sampling time depends on the sensor mode. poll 3x the time of the sampling time.
+	 */
+	ret = read_poll_timeout(i2c_master_recv, err, err ||
+			FIELD_GET(TLV493D_TEMP_CHANNEL, buff[TLV493D_RD_REG_TEMP]) == 0,
+			sleep_us, (3 * sleep_us), false, data->client, buff,
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
+	pm_runtime_put_autosuspend(data->dev);
+	return ret;
+}
+
+static int tlv493d_init(struct tlv493d_data *data)
+{
+	int ret;
+	u8 buff[TLV493D_RD_REG_MAX];
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
+			 * Magnetic field in Gauss: mT * 10 = 0.098.
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
+	 * Setting Sensor default operating mode to Master-Controlled mode since
+	 * it performs measurement cycle only on-request and stays in Power-Down
+	 * state until next cycle is initiated.
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
+				iio_pollfunc_store_time,
+				tlv493d_trigger_handler,
+				NULL);
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
+	struct tlv493d_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return tlv493d_set_operating_mode(data, TLV493D_OP_MODE_POWERDOWN);
+}
+
+static int tlv493d_runtime_resume(struct device *dev)
+{
+	struct tlv493d_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return tlv493d_set_operating_mode(data, data->mode);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops, tlv493d_runtime_suspend,
+			tlv493d_runtime_resume, NULL);
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


