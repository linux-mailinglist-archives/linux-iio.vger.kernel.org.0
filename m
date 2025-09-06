Return-Path: <linux-iio+bounces-23824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4481B46A34
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 10:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5CF5C22C2
	for <lists+linux-iio@lfdr.de>; Sat,  6 Sep 2025 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7136B2C11F8;
	Sat,  6 Sep 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZlEcnhG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F102882C8;
	Sat,  6 Sep 2025 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757147898; cv=none; b=GS8xMZmHPWcuvnlLqYKDGvFQuIXz+A7G2tLqd3UasBUP5WLNdScjJX8Uy39pYIXSzrXfye3pfIE7qc3SvSebpSru8PfvDpYyntIcl2C+0138knCsQ66ie7itxkEbawoRdAAAP4tt+fmAHwAPxO2uCnw9b8+f0DLtKhlSGnijCqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757147898; c=relaxed/simple;
	bh=ezhqZEsjaI9Q47+7zwLxJgsjFYD8hPvewuch1nsoUZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b4LKlZIBGnD3O/P1cBhI3z7Jst6fl54SFUkthLlE0G8l4reP9DuyNY1G9JWkTL6CwKzcivUifvpowFJ3HwxLZbp6BNoamrJBzpR3ybSYRJ5SXYKZkKop3s4jwCjlQXydYE2wGWibeGpEDTXPP1ZEvDyj7OXfLhqt4/WDHh5GzxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZlEcnhG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24eb713b2dfso9678415ad.0;
        Sat, 06 Sep 2025 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757147893; x=1757752693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUiUUP5qr7LBZsXYf+VbkMR7173VDaprJZn7A6xWLdY=;
        b=NZlEcnhGidmpxViG2qWpcaMDf4ab3nIcN+UbJNbzEWZlzUBTVAi4m7/MsEBr0IRcgm
         V9Pkh4hg1/g/Z+uDlmGVcntMPH/XoYFU+bttxyAxqkfbBPA16OPTtcdjD8otgxGN/glq
         sgwlbWQfjbl9dQ8jYhUNC3cJJDmmbtr5QD6yddjhX1m9FojAHUxV/YFER9ibPufk27wk
         xxtA5CZnv7LB9dON/02t6NcYM3oDyjr+gKNgrdA2nEltRhQYpmCKmemwXmlNFI3tB5LN
         K6Vz5uwSRu7VTOTIIO21ilrELUvU9Qos6aT4qgv1vTECzBoRt7JMwga3KK3yuvMtKr5n
         O3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757147893; x=1757752693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUiUUP5qr7LBZsXYf+VbkMR7173VDaprJZn7A6xWLdY=;
        b=bzOlyztJBcKlhOzLlBdOY9LmdQqhSolyFsIrti0MlwNznPEBinVNzby8kju1XHCUe3
         80zLB33VaYPuzh7U7Y7Z8b3b6eFYK80Yb2RTafaxsr3QZVjDkoRY1/jE3LzrTAulEy6W
         7Weu8d80JERiqnB60xpdzV5hcCQWDQgkKH060/KD2Fhp1x+QbaWeDgEYV6oXXebU/P+N
         qlW1r1BACwrOO8Q4Ej6FNOBLvmQdPs8Jhqs+IYiFuh3izG/nNTscuJlKHjib7IBRChCJ
         c48xB4TNpDcm0XQ6TnE5PPpxXFHvwuGJZhA0PuQs0y7nVAjnRuwcW1lgRPNo5z0bE2SU
         tOIg==
X-Forwarded-Encrypted: i=1; AJvYcCU+IybPAiTT+oSC8PwZZjRon/XtDLudl2m6q7al5bwl5ZOjiKxhWVCBeSF5Vu5v5ME91SiRVso3ZFJO@vger.kernel.org, AJvYcCWHAqSfz4UVye0ltRgCKMh9u3h2LIXlwgJFOhsyDbV3gpfWMB8GVzBkJPZyhkhY2ZTVhf1B7M6MBH8x@vger.kernel.org
X-Gm-Message-State: AOJu0YyMshXfIMbUUKctaefXizYb8flRwZ0LD496ac7Bc2U3HKF2ZNMn
	9Moacok9A/yiu4PGOh3OK1lIqhgiB8LhGU+l/RDgpLOTevAoBFH4SFW8
X-Gm-Gg: ASbGncvEiyIXIl1eExfGzWF7vNpZHyiYqHl3YadXw1WVLtrwgSV58X5Kb5mcaj3iOIH
	XfgqgKhJ/xv+YGDfhVlz0TTEXxGxQXXvhRYXTnOBGAUT+zAGWPTvLoHcL5zl16/DzEPQc8h9640
	qtwfbeLVtxmLkc3sSsnO7IOP1Tl+uwZZEE0QE7w8kxEST4pNp8PRHEq7+SufteXrchgz9tsDGiN
	nTFYMeTP6GhW5MLP3ixqKG8bJ/8k9uxzyho12LQCJ32OAxY2fF5nza8F25pPO5BMplWQ+KJV5tR
	sULcGbfJRole6QIOErPecRMpXjvkzjiqZHX26cqS4SJGNOi5TuKzNgzTEZhfLK93xVhdJDm/Qr1
	2qbXjK5n8Glj8oZg/6VbfoCjq1rFauc0=
X-Google-Smtp-Source: AGHT+IEbAmBvEN/tzWZs8obuRl153zAy8tde6N3Xrxq0jBQPSlF9xKn6wKDD2n+Y8mELwipE2ac+9Q==
X-Received: by 2002:a17:902:ea09:b0:246:7a43:3f84 with SMTP id d9443c01a7336-2516d33d4ebmr22183485ad.5.1757147893204;
        Sat, 06 Sep 2025 01:38:13 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c44:6dc9:9ee4:9664:de3c:82ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1589e480sm116577765ad.130.2025.09.06.01.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 01:38:12 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Sat, 06 Sep 2025 14:07:57 +0530
Subject: [PATCH v6 2/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250906-tlv493d-sensor-v6_16-rc5-v6-2-b1a62d968353@gmail.com>
References: <20250906-tlv493d-sensor-v6_16-rc5-v6-0-b1a62d968353@gmail.com>
In-Reply-To: <20250906-tlv493d-sensor-v6_16-rc5-v6-0-b1a62d968353@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757147878; l=19238;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=ezhqZEsjaI9Q47+7zwLxJgsjFYD8hPvewuch1nsoUZI=;
 b=p2JbllAo7cFoF1zxgznEpGkk88R4CeF8s5/pNY1y6rpJ2H71V4luQqU9134+sir6Z9AzDUXin
 3PijWZT8yG0AyiSp8ThBXPd2kMCmeeWK3niZlxMeLeBWnbF2cUSt+lj
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
 MAINTAINERS                        |   1 +
 drivers/iio/magnetometer/Kconfig   |  13 +
 drivers/iio/magnetometer/Makefile  |   2 +
 drivers/iio/magnetometer/tlv493d.c | 531 +++++++++++++++++++++++++++++++++++++
 4 files changed, 547 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35990c2701f6..cf0a00f5c4d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11849,6 +11849,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	https://www.infineon.com/part/TLV493D-A1B6
 F:	Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
+F:	drivers/iio/magnetometer/tlv493d.c
 
 INFINIBAND SUBSYSTEM
 M:	Jason Gunthorpe <jgg@nvidia.com>
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 3debf1320ad1..714128df944d 100644
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
+	  Power 3D Magnetic Sensor.
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
index 000000000000..6b9012889148
--- /dev/null
+++ b/drivers/iio/magnetometer/tlv493d.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the Infineon TLV493D Low-Power 3D Magnetic Sensor
+ *
+ * Copyright (C) 2025 Dixit Parmar <dixitparmar19@gmail.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/i2c.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm.h>
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
+
+#define TLV493D_WR_REG_MODE1	0x01
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
+	TLV493D_AXIS_X,
+	TLV493D_AXIS_Y,
+	TLV493D_AXIS_Z,
+	TLV493D_TEMPERATURE,
+};
+
+enum tlv493d_op_mode {
+	TLV493D_OP_MODE_POWERDOWN,
+	TLV493D_OP_MODE_FAST,
+	TLV493D_OP_MODE_LOWPOWER,
+	TLV493D_OP_MODE_ULTRA_LOWPOWER,
+	TLV493D_OP_MODE_MASTERCONTROLLED,
+};
+
+struct tlv493d_data {
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
+static const u32 tlv493d_sample_rate_us[] = {
+	[TLV493D_OP_MODE_POWERDOWN] = 0,
+	[TLV493D_OP_MODE_FAST] = 305,
+	[TLV493D_OP_MODE_LOWPOWER] = 10 * USEC_PER_MSEC,
+	[TLV493D_OP_MODE_ULTRA_LOWPOWER] = 100 * USEC_PER_MSEC,
+	[TLV493D_OP_MODE_MASTERCONTROLLED] = 305,
+};
+
+static int tlv493d_write_all_regs(struct tlv493d_data *data)
+{
+	int ret;
+	struct device *dev = &data->client->dev;
+
+	ret = i2c_master_send(data->client, data->wr_regs, ARRAY_SIZE(data->wr_regs));
+	if (ret < 0) {
+		dev_err(dev, "i2c write registers failed, error: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tlv493d_set_operating_mode(struct tlv493d_data *data, enum tlv493d_op_mode mode)
+{
+	u8 *mode1_cfg = &data->wr_regs[TLV493D_WR_REG_MODE1];
+	u8 *mode2_cfg = &data->wr_regs[TLV493D_WR_REG_MODE2];
+
+	switch (mode) {
+	case TLV493D_OP_MODE_POWERDOWN:
+		FIELD_MODIFY(TLV493D_MODE1_MOD_LOWFAST, mode1_cfg, 0);
+		FIELD_MODIFY(TLV493D_MODE2_LP_PERIOD, mode2_cfg, 0);
+		break;
+
+	case TLV493D_OP_MODE_FAST:
+		FIELD_MODIFY(TLV493D_MODE1_MOD_LOWFAST, mode1_cfg, 1);
+		FIELD_MODIFY(TLV493D_MODE2_LP_PERIOD, mode2_cfg, 0);
+		break;
+
+	case TLV493D_OP_MODE_LOWPOWER:
+		FIELD_MODIFY(TLV493D_MODE1_MOD_LOWFAST, mode1_cfg, 2);
+		FIELD_MODIFY(TLV493D_MODE2_LP_PERIOD, mode2_cfg, 1);
+		break;
+
+	case TLV493D_OP_MODE_ULTRA_LOWPOWER:
+		FIELD_MODIFY(TLV493D_MODE1_MOD_LOWFAST, mode1_cfg, 2);
+		FIELD_MODIFY(TLV493D_MODE2_LP_PERIOD, mode2_cfg, 0);
+		break;
+
+	case TLV493D_OP_MODE_MASTERCONTROLLED:
+		FIELD_MODIFY(TLV493D_MODE1_MOD_LOWFAST, mode1_cfg, 3);
+		FIELD_MODIFY(TLV493D_MODE2_LP_PERIOD, mode2_cfg, 0);
+		break;
+	}
+
+	return tlv493d_write_all_regs(data);
+}
+
+static s16 tlv493d_get_channel_data(u8 *b, enum tlv493d_channels ch)
+{
+	u16 val;
+
+	switch (ch) {
+	case TLV493D_AXIS_X:
+		val = FIELD_GET(TLV493D_BX_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX]) << 4 |
+		      FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4;
+		break;
+	case TLV493D_AXIS_Y:
+		val = FIELD_GET(TLV493D_BY_MAG_Y_AXIS_MSB, b[TLV493D_RD_REG_BY]) << 4 |
+		      FIELD_GET(TLV493D_BX2_MAG_Y_AXIS_LSB, b[TLV493D_RD_REG_BX2]);
+		break;
+	case TLV493D_AXIS_Z:
+		val = FIELD_GET(TLV493D_BZ_MAG_Z_AXIS_MSB, b[TLV493D_RD_REG_BZ]) << 4 |
+		      FIELD_GET(TLV493D_BZ2_MAG_Z_AXIS_LSB, b[TLV493D_RD_REG_BZ2]);
+		break;
+	case TLV493D_TEMPERATURE:
+		val = FIELD_GET(TLV493D_TEMP_TEMP_MSB, b[TLV493D_RD_REG_TEMP]) << 8 |
+		      FIELD_GET(TLV493D_TEMP2_TEMP_LSB, b[TLV493D_RD_REG_TEMP2]);
+		break;
+	}
+
+	return sign_extend32(val, 11);
+}
+
+static int tlv493d_get_measurements(struct tlv493d_data *data, s16 *x, s16 *y,
+				    s16 *z, s16 *t)
+{
+	u8 buff[7] = {};
+	int err, ret;
+	struct device *dev = &data->client->dev;
+	u32 sleep_us = tlv493d_sample_rate_us[data->mode];
+
+	guard(mutex)(&data->lock);
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Poll until data is valid.
+	 * For a valid data TLV493D_TEMP_CHANNEL bit of TLV493D_RD_REG_TEMP
+	 * should be set to 0. The sampling time depends on the sensor mode.
+	 * Poll 3x the time of the sampling time.
+	 */
+	ret = read_poll_timeout(i2c_master_recv, err,
+			err || !FIELD_GET(TLV493D_TEMP_CHANNEL, buff[TLV493D_RD_REG_TEMP]),
+			sleep_us, 3 * sleep_us, false, data->client, buff,
+			ARRAY_SIZE(buff));
+	if (ret) {
+		dev_err(dev, "i2c read poll timeout, error:%d\n", ret);
+		goto out_put_autosuspend;
+	}
+	if (err < 0) {
+		dev_err(dev, "i2c read data failed, error:%d\n", err);
+		ret = err;
+		goto out_put_autosuspend;
+	}
+
+	*x = tlv493d_get_channel_data(buff, TLV493D_AXIS_X);
+	*y = tlv493d_get_channel_data(buff, TLV493D_AXIS_Y);
+	*z = tlv493d_get_channel_data(buff, TLV493D_AXIS_Z);
+	*t = tlv493d_get_channel_data(buff, TLV493D_TEMPERATURE);
+
+out_put_autosuspend:
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static int tlv493d_init(struct tlv493d_data *data)
+{
+	int ret;
+	u8 buff[TLV493D_RD_REG_MAX];
+	struct device *dev = &data->client->dev;
+
+	/*
+	 * The sensor initialization requires below steps to be followed,
+	 * 1. Power-up sensor.
+	 * 2. Read and store read-registers map (0x0-0x9).
+	 * 3. Copy values from read reserved registers to write reserved fields
+	 *    (0x0-0x3).
+	 * 4. Set operating mode.
+	 * 5. Write to all registers.
+	 */
+	ret = i2c_master_recv(data->client, buff, ARRAY_SIZE(buff));
+	if (ret < 0) {
+		dev_err(dev, "i2c read failed, error %d\n", ret);
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
+		dev_err(dev, "failed to set operating mode\n");
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
+	int ret;
+	s16 x, y, z, t;
+	struct iio_poll_func *pf = ptr;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct tlv493d_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+	struct {
+		s16 channels[3];
+		s16 temperature;
+		aligned_s64 timestamp;
+	} scan;
+
+	ret = tlv493d_get_measurements(data, &x, &y, &z, &t);
+	if (ret) {
+		dev_err(dev, "failed to read sensor data\n");
+		goto out_trigger_notify;
+	}
+
+	scan.channels[0] = x;
+	scan.channels[1] = y;
+	scan.channels[2] = z;
+	scan.temperature = t;
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
+
+out_trigger_notify:
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
+					      iio_pollfunc_store_time,
+					      tlv493d_trigger_handler,
+					      NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");
+
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_autosuspend_delay(dev, 500);
+	pm_runtime_use_autosuspend(dev);
+
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
+				 tlv493d_runtime_resume, NULL);
+
+static const struct i2c_device_id tlv493d_id[] = {
+	{ "tlv493d" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tlv493d_id);
+
+static const struct of_device_id tlv493d_of_match[] = {
+	{ .compatible = "infineon,tlv493d-a1b6" },
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
+module_i2c_driver(tlv493d_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Infineon TLV493D Low-Power 3D Magnetic Sensor");
+MODULE_AUTHOR("Dixit Parmar <dixitparmar19@gmail.com>");

-- 
2.43.0


