Return-Path: <linux-iio+bounces-24847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B435BC446D
	for <lists+linux-iio@lfdr.de>; Wed, 08 Oct 2025 12:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD89400E15
	for <lists+linux-iio@lfdr.de>; Wed,  8 Oct 2025 10:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E002F617A;
	Wed,  8 Oct 2025 10:17:03 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D62EC55E;
	Wed,  8 Oct 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759918623; cv=none; b=H28JY2xjtXnJILd6GWQW744NDujyYUDoQkIquY+9M9UD7VyQJupOkcXSiSMOjGVVD11bpgaSmmZghpcdQQkqLVDbN1LJMJ74L0V61N7kA52Z+unzjBbtYndHUAY1i0DfA9eL6c4O/F2w6gu/xaISVVXw4sXlAExwBdzsceTlSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759918623; c=relaxed/simple;
	bh=VlDle1txfwPo/0Xg+7szilp9AdWEVcZJo8udsKWiFSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QyvxGSsdrCLzv09TD66cdNn8rNv/+5RPrpHOYxsN3UTS5v/NCUX5sbgCqnzvPs0PI7dOJPt3jqVaxZ7M4VK9MpVmMm04CkhbTfoThuKj1CnuN8zdRdjb8ddnZAkgWkhbLMGTF+hjQ/wHRNTzsY7XUpBSY8RKsFlBM9mmOrQ5y8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0996A2015E6;
	Wed,  8 Oct 2025 12:07:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B369201673;
	Wed,  8 Oct 2025 12:07:22 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CA068180221C;
	Wed,  8 Oct 2025 18:07:20 +0800 (+08)
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	peterz@infradead.org,
	jstephan@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: [PATCH v4 2/2] iio: temperature: Add driver for NXP P3T175x temperature sensor
Date: Wed,  8 Oct 2025 15:37:13 +0530
Message-Id: <20251008100713.1198461-3-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251008100713.1198461-1-lakshay.piplani@nxp.com>
References: <20251008100713.1198461-1-lakshay.piplani@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add support for the NXP P3T175x (P3T1750/P3T1755) family of temperature
sensor devices. These devices communicates via both I2C or I3C interfaces.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
---
V3 -> V4: Changes since V3
	  - Added cover letter for the first time in the series.
          - Replaced wildcard driver name `p3t175x_i2c` with specific part number `p3t1755_i2c`.
          - Removed unnecessary cast in `p3t1755_free_ibi()` (void * to struct i3c_device *).
          - Dropped error print for `devm_add_action_or_reset()` as only -ENOMEM is expected.
V2 -> V3: Changes since V2:
          - Dropped nxp,interrupt-mode and nxp,fault-queue from driver and YAML (not suitable for DT)
          - Removed trigger_one_shot sysfs attribute and its ABI doc
          - Applied IWYU principle: cleaned up unused headers
          - Fixed sampling frequency handling
          - Removed dev_err/dev_dbg statements wherever not necessary
V1 -> V2: Changes since V1:
          - Added endian-safe handling for register read (__be16 conversion)
          - Replaced manual bit masking with FIELD_GET bit extraction
          - Dropped sysfs attributes for fault queue length and thermostat mode (comparator or interrupt)
          - Added ABI doc: Documentation/ABI/testing/sysfs-bus-iio-temperature-p3t1755 describing
            trigger_one_shot attribute
          - Updated Kconfig to allow building both I2C and I3C drivers simultaneously
          - I3C: switched to device_property_* from of_property_*
          - Added devm_add_action_or_reset() for IBI disable/free

 drivers/iio/temperature/Kconfig            |   2 +
 drivers/iio/temperature/p3t/Kconfig        |  28 ++
 drivers/iio/temperature/p3t/Makefile       |   5 +
 drivers/iio/temperature/p3t/p3t1755.h      |  45 +++
 drivers/iio/temperature/p3t/p3t1755_core.c | 363 +++++++++++++++++++++
 drivers/iio/temperature/p3t/p3t1755_i2c.c  |  67 ++++
 drivers/iio/temperature/p3t/p3t1755_i3c.c  | 108 ++++++
 7 files changed, 618 insertions(+)
 create mode 100644 drivers/iio/temperature/p3t/Kconfig
 create mode 100644 drivers/iio/temperature/p3t/Makefile
 create mode 100644 drivers/iio/temperature/p3t/p3t1755.h
 create mode 100644 drivers/iio/temperature/p3t/p3t1755_core.c
 create mode 100644 drivers/iio/temperature/p3t/p3t1755_i2c.c
 create mode 100644 drivers/iio/temperature/p3t/p3t1755_i3c.c

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 1244d8e17d50..d249721c1ea1 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -182,4 +182,6 @@ config MCP9600
 	  This driver can also be built as a module. If so, the module
 	  will be called mcp9600.
 
+source "drivers/iio/temperature/p3t/Kconfig"
+
 endmenu
diff --git a/drivers/iio/temperature/p3t/Kconfig b/drivers/iio/temperature/p3t/Kconfig
new file mode 100644
index 000000000000..0cfd881e065b
--- /dev/null
+++ b/drivers/iio/temperature/p3t/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config IIO_P3T1755
+	tristate
+	depends on (I2C || I3C)
+
+config IIO_P3T1755_I2C
+	tristate "NXP P3T1755 temperature sensor I2C driver"
+	select IIO_P3T1755
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for NXP P3T1755 I2C temperature
+	  sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called p3t1755_i2c
+
+config IIO_P3T1755_I3C
+	tristate "NXP P3T1755 temperature sensor I3C driver"
+	select IIO_P3T1755
+	select REGMAP_I3C
+	depends on I3C
+	help
+	  Say yes here to build support for NXP P3T1755 I3C temperature
+	  sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called p3t1755_i3c
diff --git a/drivers/iio/temperature/p3t/Makefile b/drivers/iio/temperature/p3t/Makefile
new file mode 100644
index 000000000000..7d33b507f1f1
--- /dev/null
+++ b/drivers/iio/temperature/p3t/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_IIO_P3T1755) += p3t1755_core.o
+obj-$(CONFIG_IIO_P3T1755_I2C) += p3t1755_i2c.o
+obj-$(CONFIG_IIO_P3T1755_I3C) += p3t1755_i3c.o
diff --git a/drivers/iio/temperature/p3t/p3t1755.h b/drivers/iio/temperature/p3t/p3t1755.h
new file mode 100644
index 000000000000..29bf57e4ce89
--- /dev/null
+++ b/drivers/iio/temperature/p3t/p3t1755.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP P3T175x Temperature Sensor Driver
+ *
+ * Copyright 2025 NXP
+ */
+#ifndef P3T1755_H
+#define P3T1755_H
+
+#include <linux/bits.h>
+#include <linux/iio/iio.h>
+
+#define P3T1755_REG_TEMP	0x0
+#define P3T1755_REG_CFGR	0x1
+#define P3T1755_REG_LOW_LIM	0x2
+#define P3T1755_REG_HIGH_LIM	0x3
+
+#define P3T1755_SHUTDOWN_BIT	BIT(0)
+#define P3T1755_TM_BIT	BIT(1)
+
+#define P3T1755_CONVERSION_TIME_BITS	GENMASK(6, 5)
+
+#define MICRO 1000000
+
+struct p3t1755_info {
+	const char *name;
+	const struct iio_chan_spec *channels;
+	int num_channels;
+};
+
+struct p3t1755_data {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+extern const struct p3t1755_info p3t1750_channels_info;
+extern const struct p3t1755_info p3t1755_channels_info;
+
+int p3t1755_probe(struct device *dev, const struct p3t1755_info *chip,
+		  struct regmap *regmap, int irq);
+int p3t1755_get_temp_and_limits(struct p3t1755_data *data,
+				int *temp_raw, int *thigh_raw, int *tlow_raw);
+void p3t1755_push_thresh_event(struct iio_dev *indio_dev);
+
+#endif /* P3T1755_H */
diff --git a/drivers/iio/temperature/p3t/p3t1755_core.c b/drivers/iio/temperature/p3t/p3t1755_core.c
new file mode 100644
index 000000000000..c7216e3fab06
--- /dev/null
+++ b/drivers/iio/temperature/p3t/p3t1755_core.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP P3T175x Temperature Sensor Driver
+ *
+ * Copyright 2025 NXP
+ */
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+
+#include "p3t1755.h"
+
+static const u32 p3t1755_samp_freqs_uhz[] = {
+	36363636,
+	18181818,
+	9090909,
+	4545454
+};
+
+int p3t1755_get_temp_and_limits(struct p3t1755_data *data,
+				int *temp_raw, int *thigh_raw, int *tlow_raw)
+{
+	__be16 be;
+	int ret;
+	int raw12;
+
+	ret = regmap_bulk_read(data->regmap, P3T1755_REG_TEMP, &be, sizeof(be));
+	if (ret)
+		return ret;
+
+	raw12 = sign_extend32(be16_to_cpu(be) >> 4, 11);
+	*temp_raw = raw12;
+
+	ret = regmap_bulk_read(data->regmap, P3T1755_REG_HIGH_LIM, &be, sizeof(be));
+	if (ret)
+		return ret;
+
+	raw12 = sign_extend32(be16_to_cpu(be) >> 4, 11);
+	*thigh_raw = raw12;
+
+	ret = regmap_bulk_read(data->regmap, P3T1755_REG_LOW_LIM, &be, sizeof(be));
+	if (ret)
+		return ret;
+
+	raw12 = sign_extend32(be16_to_cpu(be) >> 4, 11);
+	*tlow_raw = raw12;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(p3t1755_get_temp_and_limits, IIO_P3T1755);
+
+void p3t1755_push_thresh_event(struct iio_dev *indio_dev)
+{
+	struct p3t1755_data *data = iio_priv(indio_dev);
+	int ret, temp, thigh, tlow;
+	unsigned int cfgr;
+
+	/*
+	 * Read CFGR register to check device mode and implicitly clear the ALERT latch.
+	 * As per Datasheet: "Any register read will clear the interrupt"
+	 */
+	ret = regmap_read(data->regmap, P3T1755_REG_CFGR, &cfgr);
+	if (ret) {
+		dev_err(data->dev, "Failed to read CFGR register: %d\n", ret);
+		return;
+	}
+
+	if (FIELD_GET(P3T1755_SHUTDOWN_BIT, cfgr)) {
+		dev_dbg(data->dev, "Device is in shutdown mode, skipping event push\n");
+		return;
+	}
+
+	ret = p3t1755_get_temp_and_limits(data, &temp, &thigh, &tlow);
+	if (ret) {
+		dev_err(data->dev, "Failed to get temperature and limits: %d\n", ret);
+		return;
+	}
+
+	if (temp >= thigh || temp <= tlow) {
+		dev_dbg(data->dev, "Threshold event: DIR_EITHER (T=%d, TH=%d, TL=%d)\n",
+			temp, thigh, tlow);
+
+		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_TEMP, 0, IIO_NO_MOD,
+							     IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
+			       iio_get_time_ns(indio_dev));
+	} else {
+		dev_dbg(data->dev, "Temperature within limits: no event triggered (T=%d, TH=%d, TL=%d)\n",
+			temp, thigh, tlow);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(p3t1755_push_thresh_event, IIO_P3T1755);
+
+static int p3t1755_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *channel, int *val,
+			    int *val2, long mask)
+{
+	struct p3t1755_data *data = iio_priv(indio_dev);
+	unsigned int cfgr;
+	__be16 be;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_bulk_read(data->regmap, P3T1755_REG_TEMP, &be, sizeof(be));
+		if (ret)
+			return ret;
+
+		*val = sign_extend32(be16_to_cpu(be) >> 4, 11);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = 625;
+		*val2 = 10000;
+
+		return IIO_VAL_FRACTIONAL;
+
+	case IIO_CHAN_INFO_ENABLE:
+		ret = regmap_read(data->regmap, P3T1755_REG_CFGR, &cfgr);
+		if (ret)
+			return ret;
+
+		*val = !FIELD_GET(P3T1755_SHUTDOWN_BIT, cfgr);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		unsigned int freq_uhz;
+		u8 sel;
+
+		ret = regmap_read(data->regmap, P3T1755_REG_CFGR, &cfgr);
+		if (ret)
+			return ret;
+
+		sel = FIELD_GET(P3T1755_CONVERSION_TIME_BITS, cfgr);
+		if (sel >= ARRAY_SIZE(p3t1755_samp_freqs_uhz))
+			return -EINVAL;
+
+		freq_uhz = p3t1755_samp_freqs_uhz[sel];
+
+		*val = freq_uhz / MICRO;
+		*val2 = freq_uhz % MICRO;
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int p3t1755_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct p3t1755_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_ENABLE:
+		ret = regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
+					 P3T1755_SHUTDOWN_BIT,
+					 val == 0 ? P3T1755_SHUTDOWN_BIT : 0);
+		if (ret)
+			return ret;
+
+		return 0;
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		unsigned int i;
+		u32 regbits;
+		u64 input_uhz;
+
+		input_uhz = (u64)val * MICRO + val2;
+
+		for (i = 0; i < ARRAY_SIZE(p3t1755_samp_freqs_uhz); i++) {
+			if (p3t1755_samp_freqs_uhz[i] == input_uhz)
+				break;
+		}
+
+		if (i == ARRAY_SIZE(p3t1755_samp_freqs_uhz))
+			return -EINVAL;
+
+		regbits = FIELD_PREP(P3T1755_CONVERSION_TIME_BITS, i);
+
+		return regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
+					  P3T1755_CONVERSION_TIME_BITS,
+					  regbits);
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int p3t1755_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int *val,
+				    int *val2)
+{
+	struct p3t1755_data *data = iio_priv(indio_dev);
+	unsigned int reg;
+	__be16 be;
+	int ret, raw;
+
+	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	reg = (dir == IIO_EV_DIR_RISING) ? P3T1755_REG_HIGH_LIM :
+	       P3T1755_REG_LOW_LIM;
+
+	ret = regmap_bulk_read(data->regmap, reg, &be, sizeof(be));
+	if (ret)
+		return ret;
+
+	raw = sign_extend32(be16_to_cpu(be) >> 4, 11);
+	*val = DIV_ROUND_CLOSEST(raw * 125, 2);
+
+	return IIO_VAL_INT;
+}
+
+static int p3t1755_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
+{
+	struct p3t1755_data *data = iio_priv(indio_dev);
+	unsigned int reg;
+	__be16 be;
+	int raw;
+
+	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	if (val2)
+		return -EINVAL;
+
+	reg = (dir == IIO_EV_DIR_RISING) ? P3T1755_REG_HIGH_LIM :
+	       P3T1755_REG_LOW_LIM;
+
+	raw = DIV_ROUND_CLOSEST(val * 2, 125);
+
+	if (raw < -2048 || raw > 2047)
+		return -ERANGE;
+
+	be = cpu_to_be16((u16)(raw << 4));
+
+	/* Use raw_write to ensure 16-bit value is written exactly as formatted */
+	return regmap_raw_write(data->regmap, reg, &be, sizeof(be));
+}
+
+static const struct iio_event_spec p3t1755_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
+static const struct iio_chan_spec p3t1755_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_ENABLE) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = p3t1755_events,
+		.num_event_specs = ARRAY_SIZE(p3t1755_events),
+	},
+};
+
+const struct p3t1755_info p3t1755_channels_info = {
+	.name = "p3t1755",
+	.channels = p3t1755_channels,
+	.num_channels = ARRAY_SIZE(p3t1755_channels),
+};
+EXPORT_SYMBOL_NS(p3t1755_channels_info, IIO_P3T1755);
+
+const struct p3t1755_info p3t1750_channels_info = {
+	.name = "p3t1750",
+	.channels = p3t1755_channels,
+	.num_channels = ARRAY_SIZE(p3t1755_channels),
+};
+EXPORT_SYMBOL_NS(p3t1750_channels_info, IIO_P3T1755);
+
+static const struct iio_info p3t1755_info = {
+	.read_raw = p3t1755_read_raw,
+	.write_raw = p3t1755_write_raw,
+	.read_event_value = p3t1755_read_event_value,
+	.write_event_value = p3t1755_write_event_value,
+};
+
+static irqreturn_t p3t1755_irq_handler(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+
+	dev_dbg(&indio_dev->dev, "IRQ triggered, processing threshold event\n");
+
+	p3t1755_push_thresh_event(indio_dev);
+
+	return IRQ_HANDLED;
+}
+
+int p3t1755_probe(struct device *dev, const struct p3t1755_info *chip,
+		  struct regmap *regmap, int irq)
+{
+	struct p3t1755_data *data;
+	struct iio_dev *iio_dev;
+	int ret;
+
+	iio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(iio_dev);
+	data->dev = dev;
+	data->regmap = regmap;
+
+	iio_dev->name = chip->name;
+	iio_dev->modes = INDIO_DIRECT_MODE;
+	iio_dev->info = &p3t1755_info;
+	iio_dev->channels = chip->channels;
+	iio_dev->num_channels = chip->num_channels;
+
+	ret = regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
+				 P3T1755_TM_BIT, P3T1755_TM_BIT);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Failed to update TM bit\n");
+
+	ret = devm_iio_device_register(dev, iio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Temperature sensor failed to register\n");
+
+	if (irq > 0) {
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						p3t1755_irq_handler, IRQF_ONESHOT,
+						"p3t1755dp", iio_dev);
+		if (ret)
+			dev_err_probe(dev, ret, "Failed to request IRQ: %d\n", ret);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(p3t1755_probe, IIO_P3T1755);
+
+MODULE_AUTHOR("Lakshay Piplani <lakshay.piplani@nxp.com>");
+MODULE_DESCRIPTION("NXP P3T1750/P3T1755 Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/temperature/p3t/p3t1755_i2c.c b/drivers/iio/temperature/p3t/p3t1755_i2c.c
new file mode 100644
index 000000000000..8d45fd7125dd
--- /dev/null
+++ b/drivers/iio/temperature/p3t/p3t1755_i2c.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP P3T175x Temperature Sensor Driver
+ *
+ * Copyright 2025 NXP
+ */
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "p3t1755.h"
+
+static const struct regmap_config p3t1755_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct of_device_id p3t1755_i2c_of_match[] = {
+	{ .compatible = "nxp,p3t1750dp", .data = &p3t1750_channels_info },
+	{ .compatible = "nxp,p3t1755dp", .data = &p3t1755_channels_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, p3t1755_i2c_of_match);
+
+static const struct i2c_device_id p3t1755_i2c_id_table[] = {
+	{ "p3t1750", (kernel_ulong_t)&p3t1750_channels_info },
+	{ "p3t1755", (kernel_ulong_t)&p3t1755_channels_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, p3t1755_i2c_id_table);
+
+static int p3t1755_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	const struct p3t1755_info *chip;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(client, &p3t1755_i2c_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "regmap init failed\n");
+
+	chip = i2c_get_match_data(client);
+
+	ret = p3t1755_probe(dev, chip, regmap, client->irq);
+	if (ret)
+		return dev_err_probe(dev, ret, "p3t175x probe failed: %d\n", ret);
+
+	return 0;
+}
+
+static struct i2c_driver p3t1755_driver = {
+	.driver = {
+		.name = "p3t1755_i2c",
+		.of_match_table = p3t1755_i2c_of_match,
+	},
+	.probe = p3t1755_i2c_probe,
+	.id_table = p3t1755_i2c_id_table,
+};
+module_i2c_driver(p3t1755_driver);
+
+MODULE_AUTHOR("Lakshay Piplani <lakshay.piplani@nxp.com>");
+MODULE_DESCRIPTION("NXP P3T1750/P3T1755 I2C Driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_P3T1755);
diff --git a/drivers/iio/temperature/p3t/p3t1755_i3c.c b/drivers/iio/temperature/p3t/p3t1755_i3c.c
new file mode 100644
index 000000000000..09810557391e
--- /dev/null
+++ b/drivers/iio/temperature/p3t/p3t1755_i3c.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP P3T175x Temperature Sensor Driver
+ *
+ * Copyright 2025 NXP
+ */
+#include <linux/i3c/device.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/events.h>
+
+#include "p3t1755.h"
+
+static const struct regmap_config p3t1755_i3c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static void p3t1755_ibi_handler(struct i3c_device *dev,
+				const struct i3c_ibi_payload *payload)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(&dev->dev);
+
+	p3t1755_push_thresh_event(indio_dev);
+}
+
+/*
+ * Both P3T1755 and P3T1750 share the same I3C PID (0x011B:0x152A),
+ * making runtime differentiation impossible, so using "p3t1755" as
+ * name in sysfs and IIO for I3C based instances.
+ */
+static const struct i3c_device_id p3t1755_i3c_ids[] = {
+	I3C_DEVICE(0x011B, 0x152A, &p3t1755_channels_info),
+	{ }
+};
+MODULE_DEVICE_TABLE(i3c, p3t1755_i3c_ids);
+
+static void p3t1755_disable_ibi(void *data)
+{
+	i3c_device_disable_ibi(data);
+}
+
+static void p3t1755_free_ibi(void *data)
+{
+	i3c_device_free_ibi(data);
+}
+
+static int p3t1755_i3c_probe(struct i3c_device *i3cdev)
+{
+	const struct i3c_device_id *id = i3c_device_match_id(i3cdev, p3t1755_i3c_ids);
+	const struct p3t1755_info *chip;
+	struct device *dev = &i3cdev->dev;
+	struct i3c_ibi_setup ibi_setup;
+	struct regmap *regmap;
+	int ret;
+
+	chip = id ? id->data : NULL;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &p3t1755_i3c_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&i3cdev->dev, PTR_ERR(regmap),
+				     "Failed to register I3C regmap %ld\n", PTR_ERR(regmap));
+
+	ret = p3t1755_probe(dev, chip, regmap, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "p3t175x probe failed: %d\n", ret);
+
+	ibi_setup = (struct i3c_ibi_setup) {
+		.handler = p3t1755_ibi_handler,
+		.num_slots = 4,
+		.max_payload_len = 0,
+	};
+
+	ret = i3c_device_request_ibi(i3cdev, &ibi_setup);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request IBI\n");
+
+	ret = devm_add_action_or_reset(dev, p3t1755_free_ibi, i3cdev);
+	if (ret)
+		return ret;
+
+	ret = i3c_device_enable_ibi(i3cdev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable IBI\n");
+
+	ret = devm_add_action_or_reset(dev, p3t1755_disable_ibi, i3cdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct i3c_driver p3t1755_driver = {
+	.driver = {
+		.name = "p3t1755_i3c",
+	},
+	.probe = p3t1755_i3c_probe,
+	.id_table = p3t1755_i3c_ids,
+};
+module_i3c_driver(p3t1755_driver);
+
+MODULE_AUTHOR("Lakshay Piplani <lakshay.piplani@nxp.com>");
+MODULE_DESCRIPTION("NXP P3T1750/P3T1755 I3C Driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_P3T1755);
-- 
2.25.1


