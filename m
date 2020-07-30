Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947E3233097
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jul 2020 12:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgG3Kwz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jul 2020 06:52:55 -0400
Received: from mailout07.rmx.de ([94.199.90.95]:37478 "EHLO mailout07.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgG3Kwy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Jul 2020 06:52:54 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout07.rmx.de (Postfix) with ESMTPS id 4BHS1B65sXzBxsN;
        Thu, 30 Jul 2020 12:52:46 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BHS0F737gz2TTMh;
        Thu, 30 Jul 2020 12:51:57 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.117) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 30 Jul
 2020 12:51:02 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Christian Eggers" <ceggers@arri.de>
Subject: [PATCH v3 2/2] iio: light: as73211: New driver
Date:   Thu, 30 Jul 2020 12:49:46 +0200
Message-ID: <20200730104946.39148-3-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200730104946.39148-1-ceggers@arri.de>
References: <20200730104946.39148-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.117]
X-RMX-ID: 20200730-125205-4BHS0F737gz2TTMh-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Support for AMS AS73211 JENCOLOR(R) Digital XYZ Sensor.

This driver has no built-in trigger. In order for making triggered
measurements, an external (software) trigger driver like
iio-trig-hrtimer or iio-trig-sysfs is required.

The sensor supports single and continuous measurement modes. The latter
is not used by design as this would require tight timing synchronization
between hardware and driver without much benefit.

Datasheet: https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf/a65474c0-b302-c2fd-e30a-c98df87616df
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 MAINTAINERS                 |   7 +
 drivers/iio/light/Kconfig   |  15 +
 drivers/iio/light/Makefile  |   1 +
 drivers/iio/light/as73211.c | 748 ++++++++++++++++++++++++++++++++++++
 4 files changed, 771 insertions(+)
 create mode 100644 drivers/iio/light/as73211.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 068d6e94122b..673570414147 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -934,6 +934,13 @@ S:	Supported
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 F:	drivers/net/ethernet/amd/xgbe/
 
+AMS AS73211 DRIVER
+M:	Christian Eggers <ceggers@arri.de>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
+F:	drivers/iio/light/as73211.c
+
 ANALOG DEVICES INC AD5686 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 182bd18c4bb2..cade6dc0305b 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -86,6 +86,21 @@ config APDS9960
 	  To compile this driver as a module, choose M here: the
 	  module will be called apds9960
 
+config AS73211
+	tristate "AMS AS73211 XYZ color sensor"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	 If you say yes here you get support for the AMS AS73211
+	 JENCOLOR(R) Digital XYZ Sensor.
+
+	 For triggered measurements, you will need an additional trigger driver
+	 like IIO_HRTIMER_TRIGGER or IIO_SYSFS_TRIGGER.
+
+	 This driver can also be built as a module.  If so, the module
+	 will be called as73211.
+
 config BH1750
 	tristate "ROHM BH1750 ambient light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index d1c8aa30b9a8..ea376deaca54 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_AL3010)		+= al3010.o
 obj-$(CONFIG_AL3320A)		+= al3320a.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
 obj-$(CONFIG_APDS9960)		+= apds9960.o
+obj-$(CONFIG_AS73211)		+= as73211.o
 obj-$(CONFIG_BH1750)		+= bh1750.o
 obj-$(CONFIG_BH1780)		+= bh1780.o
 obj-$(CONFIG_CM32181)		+= cm32181.o
diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
new file mode 100644
index 000000000000..20304b6c6eed
--- /dev/null
+++ b/drivers/iio/light/as73211.c
@@ -0,0 +1,748 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Support for AMS AS73211 JENCOLOR(R) Digital XYZ Sensor
+ *
+ * Author: Christian Eggers <ceggers@arri.de>
+ *
+ * Copyright (c) 2020 ARRI Lighting
+ *
+ * Color light sensor with 16-bit channels for x, y, z and temperature);
+ * 7-bit I2C slave address 0x74 .. 0x77.
+ *
+ * Datasheet: https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf/a65474c0-b302-c2fd-e30a-c98df87616df
+ */
+
+#include <linux/bitfield.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define AS73211_DRV_NAME "as73211"
+
+/* AS73211 configuration registers */
+#define AS73211_REG_OSR    0x0
+#define AS73211_REG_AGEN   0x2
+#define AS73211_REG_CREG1  0x6
+#define AS73211_REG_CREG2  0x7
+#define AS73211_REG_CREG3  0x8
+
+/* AS73211 output register bank */
+#define AS73211_OUT_OSR_STATUS    0
+#define AS73211_OUT_TEMP          1
+#define AS73211_OUT_MRES1         2
+#define AS73211_OUT_MRES2         3
+#define AS73211_OUT_MRES3         4
+
+#define AS73211_OSR_SS            BIT(7)
+#define AS73211_OSR_PD            BIT(6)
+#define AS73211_OSR_SW_RES        BIT(3)
+#define AS73211_OSR_DOS_MASK      GENMASK(2, 0)
+#define AS73211_OSR_DOS_CONFIG    FIELD_PREP(AS73211_OSR_DOS_MASK, 0x2)
+#define AS73211_OSR_DOS_MEASURE   FIELD_PREP(AS73211_OSR_DOS_MASK, 0x3)
+
+#define AS73211_AGEN_DEVID_MASK   GENMASK(7, 4)
+#define AS73211_AGEN_DEVID(x)     FIELD_PREP(AS73211_AGEN_DEVID_MASK, (x))
+#define AS73211_AGEN_MUT_MASK     GENMASK(3, 0)
+#define AS73211_AGEN_MUT(x)       FIELD_PREP(AS73211_AGEN_MUT_MASK, (x))
+
+#define AS73211_CREG1_GAIN_MASK   GENMASK(7, 4)
+#define AS73211_CREG1_TIME_MASK   GENMASK(3, 0)
+
+#define AS73211_CREG3_CCLK_MASK   GENMASK(1, 0)
+
+#define AS73211_OSR_STATUS_OUTCONVOF  BIT(15)
+#define AS73211_OSR_STATUS_MRESOF     BIT(14)
+#define AS73211_OSR_STATUS_ADCOF      BIT(13)
+#define AS73211_OSR_STATUS_LDATA      BIT(12)
+#define AS73211_OSR_STATUS_NDATA      BIT(11)
+#define AS73211_OSR_STATUS_NOTREADY   BIT(10)
+
+/**
+ * struct as73211_data - Instance data for one AS73211
+ * @client: I2C client.
+ * @osr:    Cached Operational State Register.
+ * @creg1:  Cached Configuration Register 1.
+ * @creg2:  Cached Configuration Register 2.
+ * @creg3:  Cached Configuration Register 3.
+ * @buffer: Buffer for triggered measurements.
+ * @mutex:  Keeps cached registers in synch with the device.
+ * @completion: Completion to wait for interrupt.
+ */
+struct as73211_data {
+	struct i2c_client *client;
+	u8 osr;
+	u8 creg1;
+	u8 creg2;
+	u8 creg3;
+	struct mutex mutex;
+	struct completion completion;
+};
+
+#define AS73211_COLOR_CHANNEL(_color, _si, _addr) { \
+	.type = IIO_INTENSITY, \
+	.modified = 1, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_type = \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+		BIT(IIO_CHAN_INFO_HARDWAREGAIN) | \
+		BIT(IIO_CHAN_INFO_INT_TIME), \
+	.channel2 = IIO_MOD_##_color, \
+	.address = _addr, \
+	.scan_index = _si, \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 16, \
+		.storagebits = 16, \
+		.endianness = IIO_LE, \
+	}, \
+}
+
+#define AS73211_SCALE_X 277071108  /* nW/m^2 */
+#define AS73211_SCALE_Y 298384270  /* nW/m^2 */
+#define AS73211_SCALE_Z 160241927  /* nW/m^2 */
+
+/* Channel order MUST match devices result register order */
+#define AS73211_SCAN_INDEX_TEMP 0
+#define AS73211_SCAN_INDEX_X    1
+#define AS73211_SCAN_INDEX_Y    2
+#define AS73211_SCAN_INDEX_Z    3
+#define AS73211_SCAN_INDEX_TS   4
+
+#define AS73211_SCAN_MASK_COLOR \
+	(BIT(AS73211_SCAN_INDEX_X) | BIT(AS73211_SCAN_INDEX_Y) | BIT(AS73211_SCAN_INDEX_Z))
+#define AS73211_SCAN_MASK_ALL (BIT(AS73211_SCAN_INDEX_TEMP) | AS73211_SCAN_MASK_COLOR)
+
+static const struct iio_chan_spec as73211_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.address = AS73211_OUT_TEMP,
+		.scan_index = AS73211_SCAN_INDEX_TEMP,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		}
+	},
+	AS73211_COLOR_CHANNEL(X, AS73211_SCAN_INDEX_X, AS73211_OUT_MRES1),
+	AS73211_COLOR_CHANNEL(Y, AS73211_SCAN_INDEX_Y, AS73211_OUT_MRES2),
+	AS73211_COLOR_CHANNEL(Z, AS73211_SCAN_INDEX_Z, AS73211_OUT_MRES3),
+	IIO_CHAN_SOFT_TIMESTAMP(AS73211_SCAN_INDEX_TS),
+};
+
+static unsigned int as73211_integration_time_cycles(struct as73211_data *data)
+{
+	return BIT(data->creg1 & AS73211_CREG1_TIME_MASK);
+}
+
+static unsigned int as73211_integration_time_us(struct as73211_data *data)
+{
+	/* Integration time has 15 steps, the step size depends on the clock. */
+	unsigned int mul = BIT(3 - (data->creg3 & GENMASK(1, 0)));
+
+	return as73211_integration_time_cycles(data) * 125 * mul;
+}
+
+static unsigned int as73211_gain(struct as73211_data *data)
+{
+	return BIT(0xb - FIELD_GET(AS73211_CREG1_GAIN_MASK, data->creg1));
+}
+
+/* must be called with as73211_data::mutex held. */
+static int as73211_req_data(struct as73211_data *data)
+{
+	struct device *dev = &data->client->dev;
+	unsigned int time_us = as73211_integration_time_us(data);
+	int ret;
+	union i2c_smbus_data smbus_data;
+	u16 osr_status;
+
+	if (data->client->irq)
+		reinit_completion(&data->completion);
+
+	/*
+	 * During measurement, there should be no traffic on the i2c bus as the
+	 * electrical noise would disturb the measurement process.
+	 */
+	i2c_lock_bus(data->client->adapter, I2C_LOCK_SEGMENT);
+
+	data->osr &= ~AS73211_OSR_DOS_MASK;
+	data->osr |= AS73211_OSR_DOS_MEASURE | AS73211_OSR_SS;
+
+	smbus_data.byte = data->osr;
+	ret = __i2c_smbus_xfer(data->client->adapter, data->client->addr,
+			data->client->flags, I2C_SMBUS_WRITE,
+			AS73211_REG_OSR, I2C_SMBUS_BYTE_DATA, &smbus_data);
+	if (ret) {
+		i2c_unlock_bus(data->client->adapter, I2C_LOCK_SEGMENT);
+		return ret;
+	}
+
+	/*
+	 * Reset AS73211_OSR_SS (is self clearing) in order to avoid unintentional
+	 * triggering of further measurements later.
+	 */
+	data->osr &= ~AS73211_OSR_SS;
+
+	/* Add some extra margin for the timeout. sensor timing is not as precise
+	 * as our one ...
+	 */
+	time_us += time_us / 8;
+	if (data->client->irq) {
+		dev_dbg(dev, "Waiting for completion...\n");
+		ret = wait_for_completion_timeout(&data->completion,
+					2 + usecs_to_jiffies(time_us));
+		if (!ret) {
+			dev_err(dev, "timeout waiting for READY IRQ\n");
+			i2c_unlock_bus(data->client->adapter, I2C_LOCK_SEGMENT);
+			return -ETIMEDOUT;
+		}
+	} else {
+		/* Wait integration time */
+		dev_dbg(dev, "Sleeping %d us\n", time_us);
+		usleep_range(time_us, time_us + 100000);
+	}
+
+	i2c_unlock_bus(data->client->adapter, I2C_LOCK_SEGMENT);
+
+	ret = i2c_smbus_read_word_data(data->client, AS73211_OUT_OSR_STATUS);
+	if (ret < 0)
+		return ret;
+
+	osr_status = (u16)ret;
+	dev_dbg(dev, "osr_status = 0x%04x\n", osr_status);
+	if (osr_status != (AS73211_OSR_DOS_MEASURE | AS73211_OSR_STATUS_NDATA)) {
+		if (osr_status & AS73211_OSR_SS) {
+			dev_warn(dev, "%s() Measurement has not stopped\n", __func__);
+			return -ETIME;
+		}
+		if (osr_status & AS73211_OSR_STATUS_NOTREADY) {
+			dev_warn(dev, "%s() Data is not ready\n", __func__);
+			return -ENODATA;
+		}
+		if (!(osr_status & AS73211_OSR_STATUS_NDATA)) {
+			dev_warn(dev, "%s() New new data available\n", __func__);
+			return -ENODATA;
+		}
+		if (osr_status & AS73211_OSR_STATUS_LDATA) {
+			dev_warn(dev, "%s() Result buffer overrun\n", __func__);
+			return -ENOBUFS;
+		}
+		if (osr_status & AS73211_OSR_STATUS_ADCOF) {
+			dev_warn(dev, "%s() ADC overflow\n", __func__);
+			return -EOVERFLOW;
+		}
+		if (osr_status & AS73211_OSR_STATUS_MRESOF) {
+			dev_warn(dev, "%s() Measurement result overflow\n", __func__);
+			return -EOVERFLOW;
+		}
+		if (osr_status & AS73211_OSR_STATUS_OUTCONVOF) {
+			dev_warn(dev, "%s() Timer overflow\n", __func__);
+			return -EOVERFLOW;
+		}
+		dev_warn(dev, "%s() Unexpected status value\n", __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct as73211_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+	{
+		int ret = iio_device_claim_direct_mode(indio_dev);
+
+		if (ret)
+			return ret;
+		ret = as73211_req_data(data);
+		if (ret < 0) {
+			iio_device_release_direct_mode(indio_dev);
+			return ret;
+		}
+		ret = i2c_smbus_read_word_data(data->client, chan->address);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SCALE:
+	{
+		unsigned int scale;
+
+		switch (chan->channel2) {
+		case IIO_MOD_X:
+			scale = AS73211_SCALE_X;
+			break;
+		case IIO_MOD_Y:
+			scale = AS73211_SCALE_Y;
+			break;
+		case IIO_MOD_Z:
+			scale = AS73211_SCALE_Z;
+			break;
+		default:
+			return -EINVAL;
+		}
+		scale /= as73211_gain(data);
+		scale /= as73211_integration_time_cycles(data);
+		*val = scale;
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = BIT(data->creg3 & GENMASK(1, 0)) * 1024 * 1000;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		*val = as73211_gain(data);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_INT_TIME:
+	{
+		unsigned int time_us;
+
+		mutex_lock(&data->mutex);
+		time_us = as73211_integration_time_us(data);
+		mutex_unlock(&data->mutex);
+		*val = time_us / 1000000;
+		*val2 = time_us % 1000000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	}}
+
+	return -EINVAL;
+}
+
+static int _as73211_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan __always_unused,
+			       int val, int val2, long mask)
+{
+	struct as73211_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+	{
+		int reg_bits, freq_kHz = val / 1000;  /* 1024, 2048, ... */
+
+		if (val < 0 || (freq_kHz * 1000) != val || val2)
+			return -EINVAL;
+		if (!is_power_of_2(freq_kHz))
+			return -EINVAL;
+		reg_bits = ilog2(freq_kHz) - 10;
+		if (reg_bits & ~AS73211_CREG3_CCLK_MASK)
+			return -EINVAL;
+
+		data->creg3 &= ~AS73211_CREG3_CCLK_MASK;
+		data->creg3 |= reg_bits;
+		return i2c_smbus_write_byte_data(data->client, AS73211_REG_CREG3, data->creg3);
+	}
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+	{
+		unsigned int reg_bits;
+
+		if (val < 0 || !is_power_of_2(val) || val2)
+			return -EINVAL;
+		reg_bits = FIELD_PREP(AS73211_CREG1_GAIN_MASK, 0xb - ilog2(val));
+
+		if (reg_bits != (reg_bits & AS73211_CREG1_GAIN_MASK))
+			return -EINVAL;
+		data->creg1 &= ~AS73211_CREG1_GAIN_MASK;
+		data->creg1 |= reg_bits;
+
+		return i2c_smbus_write_byte_data(data->client, AS73211_REG_CREG1, data->creg1);
+	}
+	case IIO_CHAN_INFO_INT_TIME:
+	{
+		int time_us = val * 1000000 + val2, time_ms;
+		int reg_bits;
+
+		/*
+		 * Integration time has 15 steps, the step size depends on the clock.
+		 * 1 = 1.024 MHz, 2 = 2.048 MHz ..
+		 */
+		int mul = BIT(data->creg3 & AS73211_CREG3_CCLK_MASK);
+
+		time_ms = (time_us * mul) / 1000;  /* 1 ms, 2 ms, ... (power of two) */
+		if (time_ms < 0 || !is_power_of_2(time_ms) || time_ms > 16384)
+			return -EINVAL;
+		reg_bits = FIELD_PREP(AS73211_CREG1_TIME_MASK, ilog2(time_ms));
+		data->creg1 &= ~AS73211_CREG1_TIME_MASK;
+		data->creg1 |= reg_bits;
+
+		return i2c_smbus_write_byte_data(data->client, AS73211_REG_CREG1, data->creg1);
+	}}
+
+	return -EINVAL;
+}
+
+static int as73211_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	int ret;
+	struct as73211_data *data = iio_priv(indio_dev);
+
+	/* Need to switch to config mode ... */
+	mutex_lock(&data->mutex);
+
+	if ((data->osr & AS73211_OSR_DOS_MASK) != AS73211_OSR_DOS_CONFIG) {
+		data->osr &= ~AS73211_OSR_DOS_MASK;
+		data->osr |= AS73211_OSR_DOS_CONFIG;
+
+		dev_dbg(&indio_dev->dev, "Switching to configuration state...");
+		ret = i2c_smbus_write_byte_data(data->client, AS73211_REG_OSR, data->osr);
+		if (ret)
+			goto error_release;
+	}
+
+	ret = _as73211_write_raw(indio_dev, chan, val, val2, mask);
+
+error_release:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static irqreturn_t as73211_ready_handler(int irq __always_unused, void *priv)
+{
+	struct iio_dev *indio_dev = priv;
+	struct as73211_data *data = iio_priv(indio_dev);
+
+	complete(&data->completion);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct as73211_data *data = iio_priv(indio_dev);
+	struct {
+		__le16 chan[4];
+		s64 ts __aligned(8);
+	} scan;
+	int data_result, ret;
+
+	mutex_lock(&data->mutex);
+
+	data_result = as73211_req_data(data);
+
+	/* Optimization for reading all (color + temperature) channels */
+	if (*indio_dev->active_scan_mask == AS73211_SCAN_MASK_ALL) {
+		u8 addr = as73211_channels[0].address;
+		struct i2c_msg msgs[] = {
+			{
+				.addr = data->client->addr,
+				.flags = 0,
+				.len = 1,
+				.buf = &addr
+			},
+			{
+				.addr = data->client->addr,
+				.flags = I2C_M_RD,
+				.len = sizeof(scan.chan),
+				.buf = (u8 *)&scan.chan
+			},
+		};
+		ret = i2c_transfer(data->client->adapter, msgs, ARRAY_SIZE(msgs));
+		if (ret < 0)
+			goto done;
+	}
+	/* Optimization for reading only color channels */
+	else {
+		/* AS73211 starts reading at address 2 */
+		ret = i2c_master_recv(data->client,
+				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
+		if (ret < 0)
+			goto done;
+	}
+
+	if (data_result) {
+		/*
+		 * Saturate all channels (useful for overflows). Temperature channel
+		 * is not affected by overflows.
+		 */
+		scan.chan[1] = cpu_to_le16(U16_MAX);
+		scan.chan[2] = cpu_to_le16(U16_MAX);
+		scan.chan[3] = cpu_to_le16(U16_MAX);
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
+
+done:
+	mutex_unlock(&data->mutex);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t as73211_show_samp_freq_available(struct device *dev __always_unused,
+						 struct device_attribute *attr __always_unused,
+						 char *buf)
+{
+	size_t len = 0;
+	int i;
+
+	for (i = 0; i < 4; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%lu ", BIT(i + 10) * 1000);
+
+	/* replace trailing space by newline */
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static ssize_t as73211_show_int_time_available(struct device *dev,
+						struct device_attribute *attr __always_unused,
+						char *buf)
+{
+	struct as73211_data *data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
+	size_t len = 0;
+	int i;
+
+	/* Integration time has 15 steps, the step size depends on the clock. */
+	int mul = BIT(3 - (data->creg3 & 0b11));  /* 8 = 1.024 MHz, 4 = 2.048 MHz ...*/
+
+	for (i = 0; i < 15; i++) {
+		int time_us = mul * BIT(i) * 125;
+
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
+			time_us / 1000000, time_us % 1000000);
+	}
+
+	/* replace trailing space by newline */
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static ssize_t as73211_show_hardwaregain_available(struct device *dev __always_unused,
+						    struct device_attribute *attr __always_unused,
+						    char *buf)
+{
+	size_t len = 0;
+	int i;
+
+	for (i = 0; i < 12; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%lu ", BIT(i));
+
+	/* replace trailing space by newline */
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(as73211_show_samp_freq_available);
+static IIO_DEV_ATTR_INT_TIME_AVAIL(as73211_show_int_time_available);
+static IIO_DEVICE_ATTR(hardwaregain_available, S_IRUGO,
+		as73211_show_hardwaregain_available, NULL, 0);
+static IIO_CONST_ATTR_TEMP_OFFSET("-66.9");
+static IIO_CONST_ATTR_TEMP_SCALE("0.05");
+
+static struct attribute *as73211_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_integration_time_available.dev_attr.attr,
+	&iio_dev_attr_hardwaregain_available.dev_attr.attr,
+	&iio_const_attr_in_temp_offset.dev_attr.attr,
+	&iio_const_attr_in_temp_scale.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group as73211_attribute_group = {
+	.attrs = as73211_attributes,
+};
+
+static const struct iio_info as73211_info = {
+	.read_raw = as73211_read_raw,
+	.write_raw = as73211_write_raw,
+	.attrs = &as73211_attribute_group,
+};
+
+static int as73211_power(struct iio_dev *indio_dev, bool state)
+{
+	struct as73211_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+
+	if (state)
+		data->osr &= ~AS73211_OSR_PD;
+	else
+		data->osr |= AS73211_OSR_PD;
+
+	ret = i2c_smbus_write_byte_data(data->client, AS73211_REG_OSR, data->osr);
+
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int as73211_probe(struct i2c_client *client)
+{
+	struct as73211_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (indio_dev == NULL)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	mutex_init(&data->mutex);
+	init_completion(&data->completion);
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &as73211_info;
+	indio_dev->name = AS73211_DRV_NAME;
+	indio_dev->channels = as73211_channels;
+	indio_dev->num_channels = ARRAY_SIZE(as73211_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_OSR);
+	if (ret < 0)
+		return ret;
+	data->osr = ret;
+
+	/* reset device */
+	data->osr |= AS73211_OSR_SW_RES;
+	ret = i2c_smbus_write_byte_data(data->client, AS73211_REG_OSR, data->osr);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_OSR);
+	if (ret < 0)
+		return ret;
+	data->osr = ret;
+
+	/*
+	 * Reading AGEN is only possible after reset (AGEN is not available if
+	 * device is in measurement mode).
+	 */
+	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_AGEN);
+	if (ret < 0)
+		return ret;
+
+	/* At the time of writing this driver, only DEVID 2 and MUT 1 is known. */
+	if ((ret & AS73211_AGEN_DEVID_MASK) != AS73211_AGEN_DEVID(2)
+			|| (ret & AS73211_AGEN_MUT_MASK) != AS73211_AGEN_MUT(1))
+		return -ENODEV;
+
+	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_CREG1);
+	if (ret < 0)
+		return ret;
+	data->creg1 = ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_CREG2);
+	if (ret < 0)
+		return ret;
+	data->creg2 = ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_CREG3);
+	if (ret < 0)
+		return ret;
+	data->creg3 = ret;
+
+	/* enable device */
+	ret = as73211_power(indio_dev, true);
+	if (ret < 0)
+		return ret;
+
+	ret = iio_triggered_buffer_setup(indio_dev, NULL, as73211_trigger_handler, NULL);
+	if (ret < 0)
+		goto powerdown;
+
+	if (client->irq) {
+		ret = request_threaded_irq(client->irq,
+				NULL,
+				as73211_ready_handler,
+				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				client->name, indio_dev);
+		if (ret)
+			goto buffer_cleanup;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto free_irq;
+
+	return 0;
+
+free_irq:
+	if (client->irq)
+		free_irq(client->irq, indio_dev);
+buffer_cleanup:
+	iio_triggered_buffer_cleanup(indio_dev);
+powerdown:
+	as73211_power(indio_dev, false);
+	return ret;
+}
+
+static int as73211_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	if (client->irq)
+		free_irq(client->irq, indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	as73211_power(indio_dev, false);
+
+	return 0;
+}
+
+static int __maybe_unused as73211_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+
+	return as73211_power(indio_dev, false);
+}
+
+static int __maybe_unused as73211_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+
+	return as73211_power(indio_dev, true);
+}
+
+static SIMPLE_DEV_PM_OPS(as73211_pm_ops, as73211_suspend, as73211_resume);
+
+static const struct of_device_id as73211_of_match[] = {
+	{ .compatible = "ams,as73211" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, as73211_of_match);
+
+static const struct i2c_device_id as73211_id[] = {
+	{ "as73211", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, as73211_id);
+
+static struct i2c_driver as73211_driver = {
+	.driver = {
+		.name           = AS73211_DRV_NAME,
+		.of_match_table = as73211_of_match,
+		.pm             = &as73211_pm_ops,
+	},
+	.probe_new  = as73211_probe,
+	.remove     = as73211_remove,
+	.id_table   = as73211_id,
+};
+module_i2c_driver(as73211_driver);
+
+MODULE_AUTHOR("Christian Eggers <ceggers@arri.de>");
+MODULE_DESCRIPTION("AS73211 XYZ True Color Sensor driver");
+MODULE_LICENSE("GPL");
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

