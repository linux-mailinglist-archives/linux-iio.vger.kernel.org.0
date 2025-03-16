Return-Path: <linux-iio+bounces-16915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B99A636A5
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 18:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18ED23AC0A8
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 17:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84561ACEDF;
	Sun, 16 Mar 2025 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="mD0hOZDd"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F0D32C8B;
	Sun, 16 Mar 2025 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742145049; cv=none; b=uf4Jpv7Ymnz5owzC00OGFwZ+/lNv+mcuPfhzSp0gElIOGhzUrzNac5KoyqJT9xZg0NxfXI/x9agnMcVSOkVR2zZL5Rxjg9+UV7/ubosTEFQL3djTx7CZXzY+Smf+yRa53Ave1LGjS6iOS68Wxe0Ev7tSjac1lhB78VgkFFi0akE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742145049; c=relaxed/simple;
	bh=jnS+8WvmK+Apj5S3Vla+T1eMCCd/XmF+ey4cYPIW1+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jaA0amwG1wjqSyGBVg/DIzichsOt1XC8QgLmuaWTT80MYZK9M99JIF1pC1SvXOmyBnJ69rBOxGl2CO0YcviMF84Reh48IzbIm/5X/N/PmHVjJLyEST2ZW8rF0d73YuOflXcJ8SvPaIfpy9YgENm9VoUVYws8E0LQS4+pbYuMItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=mD0hOZDd; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=L5xgTmtYQlG2HFzO1mbeKkhTVCQUTZthMl/DtZ08p7Y=; b=mD0hOZDdhyyOUQH7jL2X3Oh0W0
	Rkzo4rJcCd1S29oOFn81Bm5wswSG/XA85gmBp41t7Fq9hnUow/BLROQGfa87gWZpnI+i4NerOA1Xj
	iG9Fa4UM/11pWgvgAjTNvT+3u0J2qwYxPnB/WLgjMQNaMFv4d//e70mH40uwc5Cf1UV8vPkPyY3Nm
	X0edc1npuok1POdQzExvXYzZLC3uWguP5pVPQlfZgmTJQEmPfQMYet7Nnwm0n4FyV0IkF8jw5XP0d
	Wu5kzO9tKyEiNP6NXVGrYMwVUznkQ8UgVr9883QaZQ17SfPFnyu5iJFSzx5qtbAe9csOB3dVbmPV6
	95qFgL1A==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1ttrAP-0000DN-07;
	Sun, 16 Mar 2025 17:48:49 +0100
Received: from [2a0f:6480:1:600:fc64:4dfc:9829:9e5f] (helo=anderl.linuxhotel.de)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1ttrAP-000MlM-0D;
	Sun, 16 Mar 2025 17:48:48 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	mazziesaccount@gmail.com,
	subhajit.ghosh@tweaklogic.com,
	muditsharma.info@gmail.com,
	arthur.becker@sentec.com,
	ivan.orlov0322@gmail.com,
	ak@it-klinger.de
Subject: [PATCH v2 2/3] iio: light: add support for veml6046x00 RGBIR color sensor
Date: Sun, 16 Mar 2025 17:48:12 +0100
Message-Id: <20250316164813.30291-3-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250316164813.30291-1-ak@it-klinger.de>
References: <20250316164813.30291-1-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27579/Sun Mar 16 09:35:38 2025)

Add Vishay VEML6046X00 high accuracy RGBIR color sensor.

This sensor provides three colour (red, green and blue) as well as one
infrared (IR) channel through I2C.

Support direct and buffered mode.

An optional interrupt for signaling green colour threshold underflow or
overflow is not supported so far.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/light/Kconfig       |  13 +
 drivers/iio/light/Makefile      |   1 +
 drivers/iio/light/veml6046x00.c | 890 ++++++++++++++++++++++++++++++++
 3 files changed, 904 insertions(+)
 create mode 100644 drivers/iio/light/veml6046x00.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index e34e551eef3e..d79bc302afab 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -702,6 +702,19 @@ config VEML6040
 	  To compile this driver as a module, choose M here: the
 	  module will be called veml6040.
 
+config VEML6046X00
+	tristate "VEML6046X00 RGBIR color sensor"
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	depends on I2C
+	help
+	  Say Y here if you want to build a driver for the Vishay VEML6046X00
+	  high accuracy RGBIR color sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called veml6046x00.
+
 config VEML6070
 	tristate "VEML6070 UV A light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 11a4041b918a..14c9dc7813d6 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
 obj-$(CONFIG_VEML3235)		+= veml3235.o
 obj-$(CONFIG_VEML6030)		+= veml6030.o
 obj-$(CONFIG_VEML6040)		+= veml6040.o
+obj-$(CONFIG_VEML6046X00)	+= veml6046x00.o
 obj-$(CONFIG_VEML6070)		+= veml6070.o
 obj-$(CONFIG_VEML6075)		+= veml6075.o
 obj-$(CONFIG_VL6180)		+= vl6180.o
diff --git a/drivers/iio/light/veml6046x00.c b/drivers/iio/light/veml6046x00.c
new file mode 100644
index 000000000000..8e6232e1ab70
--- /dev/null
+++ b/drivers/iio/light/veml6046x00.c
@@ -0,0 +1,890 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * VEML6046X00 High Accuracy RGBIR Color Sensor
+ *
+ * Copyright (c) 2025 Andreas Klinger <ak@it-klinger.de>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <linux/units.h>
+#include <linux/pm_runtime.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+/* Device registers */
+#define VEML6046X00_REG_CONF0       0x00
+#define VEML6046X00_REG_CONF1       0x01
+#define VEML6046X00_REG_THDH_L      0x04
+#define VEML6046X00_REG_THDH_H      0x05
+#define VEML6046X00_REG_THDL_L      0x06
+#define VEML6046X00_REG_THDL_H      0x07
+#define VEML6046X00_REG_R_L         0x10
+#define VEML6046X00_REG_R_H         0x11
+#define VEML6046X00_REG_G_L         0x12
+#define VEML6046X00_REG_G_H         0x13
+#define VEML6046X00_REG_B_L         0x14
+#define VEML6046X00_REG_B_H         0x15
+#define VEML6046X00_REG_IR_L        0x16
+#define VEML6046X00_REG_IR_H        0x17
+#define VEML6046X00_REG_ID_L        0x18
+#define VEML6046X00_REG_ID_H        0x19
+#define VEML6046X00_REG_INT_L       0x1A
+#define VEML6046X00_REG_INT_H       0x1B
+#define VEML6046X00_REG_DATA(ch)    (VEML6046X00_REG_R_L + (ch))
+
+/* Bit masks for specific functionality */
+#define VEML6046X00_CONF0_ON_0      BIT(0)
+#define VEML6046X00_CONF0_INT       BIT(1)
+#define VEML6046X00_CONF0_AF_TRIG   BIT(2)
+#define VEML6046X00_CONF0_AF        BIT(3)
+#define VEML6046X00_CONF0_IT        GENMASK(6, 4)
+#define VEML6046X00_CONF1_CAL       BIT(0)
+#define VEML6046X00_CONF1_PERS      GENMASK(2, 1)
+#define VEML6046X00_CONF1_GAIN      GENMASK(4, 3)
+#define VEML6046X00_CONF1_PD_D2     BIT(6)
+#define VEML6046X00_CONF1_ON_1      BIT(7)
+#define VEML6046X00_INT_TH_H        BIT(1)
+#define VEML6046X00_INT_TH_L        BIT(2)
+#define VEML6046X00_INT_DRDY        BIT(3)
+#define VEML6046X00_INT_MASK        (VEML6046X00_INT_TH_H | \
+				VEML6046X00_INT_TH_L | VEML6046X00_INT_DRDY)
+
+#define	VEML6046X00_GAIN_1          0x0
+#define	VEML6046X00_GAIN_2          0x1
+#define	VEML6046X00_GAIN_0_66       0x2
+#define	VEML6046X00_GAIN_0_5        0x3
+
+/* Autosuspend delay */
+#define VEML6046X00_AUTOSUSPEND_MS  3000
+
+enum veml6046x00_scan {
+	VEML6046X00_SCAN_R,
+	VEML6046X00_SCAN_G,
+	VEML6046X00_SCAN_B,
+	VEML6046X00_SCAN_IR,
+	VEML6046X00_SCAN_TIMESTAMP,
+};
+
+/*
+ * regmap fields
+ */
+struct veml6046x00_rf {
+	struct regmap_field *int_en;
+	struct regmap_field *mode;
+	struct regmap_field *trig;
+	struct regmap_field *it;
+	struct regmap_field *pers;
+};
+
+struct veml6046x00_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct iio_trigger *trig;
+	struct veml6046x00_rf rf;
+};
+
+struct veml6046x00_scan_buf {
+	__le16 chans[4];
+
+	s64 timestamp __aligned(8);
+};
+
+static const int veml6046x00_it[][2] = {
+	{ 0, 3125 },
+	{ 0, 6250 },
+	{ 0, 12500 },
+	{ 0, 25000 },
+	{ 0, 50000 },
+	{ 0, 100000 },
+	{ 0, 200000 },
+	{ 0, 400000 },
+};
+
+static const int veml6046x00_gains[][2] = {
+	{ 0, 250000 },
+	{ 0, 330000 },
+	{ 0, 500000 },
+	{ 0, 660000 },
+	{ 1, 0 },
+	{ 2, 0 },
+};
+
+/*
+ * Persistence = 1/2/4/8 x integration time
+ * Minimum time for which light readings must stay above configured
+ * threshold to assert the interrupt.
+ */
+static const char * const period_values[] = {
+		"0.003125 0.00625 0.0125 0.025",
+		"0.00625 0.0125 0.025 0.05",
+		"0.0125 0.025 0.05 0.1",
+		"0.025 0.050 0.1 0.2",
+		"0.05 0.1 0.2 0.4",
+		"0.1 0.2 0.4 0.8",
+		"0.2 0.4 0.8 1.6",
+		"0.4 0.8 1.6 3.2"
+};
+
+/*
+ * Return list of valid period values in seconds corresponding to
+ * the currently active integration time.
+ */
+static ssize_t in_illuminance_period_available_show(struct device *dev,
+						    struct device_attribute *attr,
+						    char *buf)
+{
+	struct veml6046x00_data *data = iio_priv(dev_to_iio_dev(dev));
+	int ret, reg;
+
+	ret = regmap_field_read(data->rf.it, &reg);
+	if (ret)
+		return ret;
+
+	if (reg < 0 || reg >= ARRAY_SIZE(period_values))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", period_values[reg]);
+}
+
+static IIO_DEVICE_ATTR_RO(in_illuminance_period_available, 0);
+
+static struct attribute *veml6046x00_event_attributes[] = {
+	&iio_dev_attr_in_illuminance_period_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group veml6046x00_event_attr_group = {
+	.attrs = veml6046x00_event_attributes,
+};
+
+/*
+ * Two bits (RGB_ON_0 and RGB_ON_1) must be cleared to power on the device.
+ */
+static int veml6046x00_power_on(struct veml6046x00_data *data)
+{
+	int ret;
+
+	ret = regmap_clear_bits(data->regmap, VEML6046X00_REG_CONF0,
+			VEML6046X00_CONF0_ON_0);
+	if (ret) {
+		dev_err(data->dev, "Failed to set bit for power on %d\n", ret);
+		return ret;
+	}
+
+	return regmap_clear_bits(data->regmap, VEML6046X00_REG_CONF1,
+			VEML6046X00_CONF1_ON_1);
+}
+
+/*
+ * Two bits (RGB_ON_0 and RGB_ON_1) must be set to power off the device.
+ */
+static int veml6046x00_shutdown(struct veml6046x00_data *data)
+{
+	int ret;
+
+	ret = regmap_set_bits(data->regmap, VEML6046X00_REG_CONF0,
+			      VEML6046X00_CONF0_ON_0);
+	if (ret) {
+		dev_err(data->dev, "Failed to set bit for shutdown %d\n", ret);
+		return ret;
+	}
+
+	return regmap_set_bits(data->regmap, VEML6046X00_REG_CONF1,
+			       VEML6046X00_CONF1_ON_1);
+}
+
+static void veml6046x00_shutdown_action(void *data)
+{
+	veml6046x00_shutdown(data);
+}
+
+static const struct iio_chan_spec veml6046x00_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.address = VEML6046X00_REG_R_L,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_RED,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = VEML6046X00_SCAN_R,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	{
+		.type = IIO_LIGHT,
+		.address = VEML6046X00_REG_G_L,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_GREEN,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = VEML6046X00_SCAN_G,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	{
+		.type = IIO_LIGHT,
+		.address = VEML6046X00_REG_B_L,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_BLUE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = VEML6046X00_SCAN_B,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	{
+		.type = IIO_LIGHT,
+		.address = VEML6046X00_REG_IR_L,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_IR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = VEML6046X00_SCAN_IR,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(VEML6046X00_SCAN_TIMESTAMP),
+};
+
+static const struct regmap_config veml6046x00_regmap_config = {
+	.name = "veml6046x00_regmap",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = VEML6046X00_REG_INT_H,
+};
+
+static const struct reg_field veml6046x00_rf_int_en =
+	REG_FIELD(VEML6046X00_REG_CONF0, 1, 1);
+
+static const struct reg_field veml6046x00_rf_trig =
+	REG_FIELD(VEML6046X00_REG_CONF0, 2, 2);
+
+static const struct reg_field veml6046x00_rf_mode =
+	REG_FIELD(VEML6046X00_REG_CONF0, 3, 3);
+
+static const struct reg_field veml6046x00_rf_it =
+	REG_FIELD(VEML6046X00_REG_CONF0, 4, 6);
+
+static const struct reg_field veml6046x00_rf_pers =
+	REG_FIELD(VEML6046X00_REG_CONF1, 1, 2);
+
+static int veml6046x00_regfield_init(struct veml6046x00_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	struct device *dev = data->dev;
+	struct regmap_field *rm_field;
+	struct veml6046x00_rf *rf = &data->rf;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6046x00_rf_int_en);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->int_en = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6046x00_rf_mode);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->mode = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6046x00_rf_trig);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->trig = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6046x00_rf_it);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->it = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6046x00_rf_pers);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->pers = rm_field;
+
+	return 0;
+}
+
+static int veml6046x00_get_it_usec(struct veml6046x00_data *data, int *it_usec)
+{
+	int ret, reg;
+
+	ret = regmap_field_read(data->rf.it, &reg);
+	if (ret)
+		return ret;
+
+	switch (reg) {
+	case 0:
+		*it_usec = 3125;
+		break;
+	case 1:
+		*it_usec = 6250;
+		break;
+	case 2:
+		*it_usec = 12500;
+		break;
+	case 3:
+		*it_usec = 25000;
+		break;
+	case 4:
+		*it_usec = 50000;
+		break;
+	case 5:
+		*it_usec = 100000;
+		break;
+	case 6:
+		*it_usec = 200000;
+		break;
+	case 7:
+		*it_usec = 400000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int veml6046x00_set_it(struct iio_dev *iio, int val, int val2)
+{
+	struct veml6046x00_data *data = iio_priv(iio);
+	int ret, new_it;
+
+	if (val)
+		return -EINVAL;
+
+	switch (val2) {
+	case 3125:
+		new_it = 0x00;
+		break;
+	case 6250:
+		new_it = 0x01;
+		break;
+	case 12500:
+		new_it = 0x02;
+		break;
+	case 25000:
+		new_it = 0x03;
+		break;
+	case 50000:
+		new_it = 0x04;
+		break;
+	case 100000:
+		new_it = 0x05;
+		break;
+	case 200000:
+		new_it = 0x06;
+		break;
+	case 400000:
+		new_it = 0x07;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_field_write(data->rf.it, new_it);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int veml6046x00_set_scale(struct iio_dev *iio, int val, int val2)
+{
+	struct veml6046x00_data *data = iio_priv(iio);
+	int new_scale;
+
+	if (val == 0 && val2 == 250000) {
+		new_scale = FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_0_5) |
+					VEML6046X00_CONF1_PD_D2;
+	} else if (val == 0 && val2 == 330000) {
+		new_scale = FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_0_66) |
+					VEML6046X00_CONF1_PD_D2;
+	} else if (val == 0 && val2 == 500000) {
+		new_scale = FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_0_5);
+	} else if (val == 0 && val2 == 660000) {
+		new_scale = FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_0_66);
+	} else if (val == 1 && val2 == 0) {
+		new_scale = FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_1);
+	} else if (val == 2 && val2 == 0) {
+		new_scale = FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_2);
+	} else {
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(data->regmap, VEML6046X00_REG_CONF1,
+				 VEML6046X00_CONF1_GAIN |
+				 VEML6046X00_CONF1_PD_D2,
+				 new_scale);
+}
+
+static int veml6046x00_get_scale(struct veml6046x00_data *data,
+				 int *val, int *val2)
+{
+	int ret, reg;
+
+	ret = regmap_read(data->regmap, VEML6046X00_REG_CONF1, &reg);
+	if (ret)
+		return ret;
+
+	switch (FIELD_GET(VEML6046X00_CONF1_GAIN, reg)) {
+	case 0:
+		*val = 1;
+		*val2 = 0;
+		break;
+	case 1:
+		*val = 2;
+		*val2 = 0;
+		break;
+	case 2:
+		*val = 0;
+		*val2 = 660000;
+		break;
+	case 3:
+		*val = 0;
+		*val2 = 500000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (reg & VEML6046X00_CONF1_PD_D2)
+		*val2 /= 2;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int veml6046x00_set_mode(struct veml6046x00_data *data, bool state)
+{
+	return regmap_field_write(data->rf.mode, state);
+}
+
+static int veml6046x00_set_trig(struct veml6046x00_data *data, bool state)
+{
+	return regmap_field_write(data->rf.trig, state);
+}
+
+static int veml6046x00_wait_data_available(struct iio_dev *iio, int usecs)
+{
+	struct veml6046x00_data *data = iio_priv(iio);
+	int ret, reg;
+	int cnt = 2;
+	int i;
+
+	for (i = 0; i < cnt; i++) {
+		ret = regmap_read(data->regmap, VEML6046X00_REG_INT_H, &reg);
+		if (ret) {
+			dev_err(data->dev,
+					"Failed to read interrupt register %d\n", ret);
+			return -EIO;
+		}
+
+		if (reg & VEML6046X00_INT_DRDY)
+			return 1;
+
+		if (i < cnt)
+			fsleep(usecs);
+	}
+
+	return 0;
+}
+
+static int veml6046x00_single_read(struct iio_dev *iio,
+					enum iio_modifier modifier, int *val)
+{
+	struct veml6046x00_data *data = iio_priv(iio);
+	int addr, it_usec, ret;
+	uint8_t reg[2];
+
+	switch (modifier) {
+	case IIO_MOD_LIGHT_RED:
+		addr = VEML6046X00_REG_R_L;
+	break;
+	case IIO_MOD_LIGHT_GREEN:
+		addr = VEML6046X00_REG_G_L;
+	break;
+	case IIO_MOD_LIGHT_BLUE:
+		addr = VEML6046X00_REG_B_L;
+	break;
+	case IIO_MOD_LIGHT_IR:
+		addr = VEML6046X00_REG_IR_L;
+	break;
+	default:
+		return -EINVAL;
+	}
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret)
+		return ret;
+
+	ret = veml6046x00_get_it_usec(data, &it_usec);
+	if (ret < 0)
+		return ret;
+
+	veml6046x00_set_mode(data, 1);
+
+	veml6046x00_set_trig(data, 1);
+
+	/* integration time + 10 % to ensure completion */
+	fsleep(it_usec + (it_usec / 10));
+
+	ret = veml6046x00_wait_data_available(iio, it_usec * 10);
+	if (ret == 1) {
+		dev_dbg(data->dev, "data ready\n");
+	} else {
+		dev_warn(data->dev, "no data ready ret: %d\n", ret);
+		goto no_data;
+	}
+
+	ret = iio_device_claim_direct_mode(iio);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(data->regmap, addr, reg, sizeof(reg));
+	iio_device_release_direct_mode(iio);
+	if (ret)
+		return ret;
+
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+
+	*val = reg[1] << 8 | reg[0];
+
+	return IIO_VAL_INT;
+
+no_data:
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+
+	return -EINVAL;
+}
+
+static int veml6046x00_read_raw(struct iio_dev *iio,
+				struct iio_chan_spec const *chan, int *val,
+				int *val2, long mask)
+{
+	struct veml6046x00_data *data = iio_priv(iio);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type != IIO_LIGHT)
+			return -EINVAL;
+		return veml6046x00_single_read(iio, chan->channel2, val);
+	case IIO_CHAN_INFO_INT_TIME:
+		*val = 0;
+		return veml6046x00_get_it_usec(data, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return veml6046x00_get_scale(data, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6046x00_read_avail(struct iio_dev *iio,
+				  struct iio_chan_spec const *chan,
+				  const int **vals, int *type, int *length,
+				  long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*vals = (int *)&veml6046x00_it;
+		*length = 2 * ARRAY_SIZE(veml6046x00_it);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)&veml6046x00_gains;
+		*length = 2 * ARRAY_SIZE(veml6046x00_gains);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6046x00_write_raw(struct iio_dev *iio,
+				 struct iio_chan_spec const *chan,
+				 int val, int val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		return veml6046x00_set_it(iio, val, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return veml6046x00_set_scale(iio, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info veml6046x00_info_no_irq = {
+	.read_raw = veml6046x00_read_raw,
+	.read_avail = veml6046x00_read_avail,
+	.write_raw = veml6046x00_write_raw,
+};
+
+static int veml6046x00_buffer_preenable(struct iio_dev *iio)
+{
+	struct veml6046x00_data *data = iio_priv(iio);
+	struct device *dev = data->dev;
+	int ret;
+
+	ret = veml6046x00_set_mode(data, 0);
+	if (ret)
+		dev_err(data->dev, "Failed to set mode %d\n", ret);
+
+	ret = veml6046x00_set_trig(data, 0);
+	if (ret)
+		dev_err(data->dev, "Failed to set trigger %d\n", ret);
+
+	return pm_runtime_resume_and_get(dev);
+}
+
+static int veml6046x00_buffer_postdisable(struct iio_dev *iio)
+{
+	struct veml6046x00_data *data = iio_priv(iio);
+	struct device *dev = data->dev;
+	int ret;
+
+	ret = veml6046x00_set_mode(data, 1);
+	if (ret)
+		dev_err(data->dev, "Failed to set mode %d\n", ret);
+
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops veml6046x00_buffer_setup_ops = {
+	.preenable = veml6046x00_buffer_preenable,
+	.postdisable = veml6046x00_buffer_postdisable,
+};
+
+static irqreturn_t veml6046x00_trig_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio = pf->indio_dev;
+	struct veml6046x00_data *data = iio_priv(iio);
+	int ret;
+	struct veml6046x00_scan_buf scan;
+
+	memset(&scan, 0, sizeof(scan));
+
+	ret = regmap_bulk_read(data->regmap, VEML6046X00_REG_R_L, &scan.chans,
+						sizeof(scan.chans));
+	if (ret)
+		goto done;
+
+	iio_push_to_buffers_with_timestamp(iio, &scan, iio_get_time_ns(iio));
+
+done:
+	iio_trigger_notify_done(iio->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int veml6046x00_validate_part_id(struct veml6046x00_data *data)
+{
+	int part_id, ret;
+	__le16 reg;
+
+	ret = regmap_bulk_read(data->regmap, VEML6046X00_REG_ID_L, &reg, sizeof(reg));
+	if (ret) {
+		dev_info(data->dev, "Failed to read ID\n");
+		return -EIO;
+	}
+
+	part_id = le16_to_cpu(reg);
+	if (part_id != 0x0001)
+		dev_info(data->dev, "Unknown ID %#02x\n", part_id);
+
+	return 0;
+}
+
+static int veml6046x00_setup_device(struct iio_dev *iio)
+{
+	struct veml6046x00_data *data = iio_priv(iio);
+	struct device *dev = data->dev;
+	int ret, val;
+	__le16 reg16;
+	uint8_t reg[2];
+
+	reg[0] = VEML6046X00_CONF0_AF;
+	reg[1] = 0x00;
+	ret = regmap_bulk_write(data->regmap, VEML6046X00_REG_CONF0, reg, sizeof(reg));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set configuration\n");
+
+	reg16 = cpu_to_le16(0);
+	ret = regmap_bulk_write(data->regmap, VEML6046X00_REG_THDL_L, &reg16, sizeof(reg16));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
+
+	reg16 = cpu_to_le16(U16_MAX);
+	ret = regmap_bulk_write(data->regmap, VEML6046X00_REG_THDH_L, &reg16, sizeof(reg16));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set high threshold\n");
+
+	ret = regmap_read(data->regmap, VEML6046X00_REG_INT_H, &val);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to clear interrupts\n");
+
+	return 0;
+}
+
+static int veml6046x00_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct veml6046x00_data *data;
+	struct iio_dev *iio;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(i2c, &veml6046x00_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to set regmap\n");
+
+	iio = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!iio)
+		return -ENOMEM;
+
+	data = iio_priv(iio);
+	i2c_set_clientdata(i2c, iio);
+	data->dev = dev;
+	data->regmap = regmap;
+
+	ret = veml6046x00_regfield_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init regfield\n");
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
+
+	ret = devm_add_action_or_reset(dev, veml6046x00_shutdown_action, data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add shut down action\n");
+
+	ret = pm_runtime_set_active(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to activate PM runtime\n");
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable PM runtime\n");
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_autosuspend_delay(dev, VEML6046X00_AUTOSUSPEND_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	ret = veml6046x00_validate_part_id(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to validate device ID\n");
+
+	iio->name = i2c->name;
+	iio->channels = veml6046x00_channels;
+	iio->num_channels = ARRAY_SIZE(veml6046x00_channels);
+	iio->modes = INDIO_DIRECT_MODE;
+
+	iio->info = &veml6046x00_info_no_irq;
+
+	ret = veml6046x00_setup_device(iio);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(dev, iio, NULL,
+					      veml6046x00_trig_handler,
+					      &veml6046x00_buffer_setup_ops);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register triggered buffer");
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	ret = devm_iio_device_register(dev, iio);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register iio device");
+
+	return 0;
+}
+
+static int veml6046x00_runtime_suspend(struct device *dev)
+{
+	struct veml6046x00_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return veml6046x00_shutdown(data);
+}
+
+static int veml6046x00_runtime_resume(struct device *dev)
+{
+	struct veml6046x00_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return veml6046x00_power_on(data);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(veml6046x00_pm_ops, veml6046x00_runtime_suspend,
+				 veml6046x00_runtime_resume, NULL);
+
+static const struct of_device_id veml6046x00_of_match[] = {
+	{
+		.compatible = "vishay,veml6046x00",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, veml6046x00_of_match);
+
+static const struct i2c_device_id veml6046x00_id[] = {
+	{ "veml6046x00" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, veml6046x00_id);
+
+static struct i2c_driver veml6046x00_driver = {
+	.driver = {
+		.name = "veml6046x00",
+		.of_match_table = veml6046x00_of_match,
+		.pm = pm_ptr(&veml6046x00_pm_ops),
+	},
+	.probe = veml6046x00_probe,
+	.id_table = veml6046x00_id,
+};
+module_i2c_driver(veml6046x00_driver);
+
+MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
+MODULE_DESCRIPTION("VEML6046X00 RGBIR Color Sensor");
+MODULE_LICENSE("GPL");
-- 
2.39.5


