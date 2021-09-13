Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CAB408605
	for <lists+linux-iio@lfdr.de>; Mon, 13 Sep 2021 10:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbhIMIDV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Sep 2021 04:03:21 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:36188 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbhIMIDO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Sep 2021 04:03:14 -0400
Received: from ert768.prtnl (ert768.prtnl [192.168.224.11])
        by sparta.prtnl (Postfix) with ESMTP id BDA1244A0250;
        Mon, 13 Sep 2021 10:01:11 +0200 (CEST)
From:   Roan van Dijk <roan@protonic.nl>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>,
        Roan van Dijk <roan@protonic.nl>
Subject: [PATCH v2 3/4] drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor
Date:   Mon, 13 Sep 2021 10:00:19 +0200
Message-Id: <20210913080020.1265027-4-roan@protonic.nl>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913080020.1265027-1-roan@protonic.nl>
References: <20210913080020.1265027-1-roan@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a driver for the SCD4x CO2 sensor from Sensirion. The sensor is
able to measure CO2 concentration, temperature and relative humdity.
The sensor uses a photoacoustic principle for measuring CO2 concentration.
An I2C interface is supported by this driver in order to communicate with
the sensor.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Roan van Dijk <roan@protonic.nl>
---
 drivers/iio/chemical/Kconfig  |  13 +
 drivers/iio/chemical/Makefile |   1 +
 drivers/iio/chemical/scd4x.c  | 682 ++++++++++++++++++++++++++++++++++
 3 files changed, 696 insertions(+)
 create mode 100644 drivers/iio/chemical/scd4x.c

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index c03667e62732..f4d2fcb1b9ac 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -118,6 +118,19 @@ config SCD30_SERIAL
 	  To compile this driver as a module, choose M here: the module will
 	  be called scd30_serial.
 
+config SCD4X
+	tristate "SCD4X carbon dioxide sensor driver"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	depends on I2C
+	select CRC8
+	help
+	  Say Y here to build support for the Sensirion SCD4X sensor with cabon
+	  dioxide, relative humidity and temperature sensing capabilities
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called scd4x.
+
 config SENSIRION_SGP30
 	tristate "Sensirion SGPxx gas sensors"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index d07af581f234..81b29d9eb6a2 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PMS7003) += pms7003.o
 obj-$(CONFIG_SCD30_CORE) += scd30_core.o
 obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
 obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
+obj-$(CONFIG_SCD4X) += scd4x.o
 obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
 obj-$(CONFIG_SENSIRION_SGP40)	+= sgp40.o
 obj-$(CONFIG_SPS30) += sps30.o
diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
new file mode 100644
index 000000000000..8f795c972a93
--- /dev/null
+++ b/drivers/iio/chemical/scd4x.c
@@ -0,0 +1,682 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sensirion SCD4X carbon dioxide sensor i2c driver
+ *
+ * Copyright (C) 2021 Protonic Holland
+ * Author: Roan van Dijk <roan@protonic.nl>
+ *
+ * I2C slave address: 0x62
+ *
+ * Datasheets:
+ * https://www.sensirion.com/file/datasheet_scd4x
+ */
+
+#include <asm/unaligned.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/types.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#define SCD4X_CRC8_POLYNOMIAL 0x31
+#define SCD4X_TIMEOUT_ERR 1000
+#define SCD4X_READ_BUF_SIZE 9
+#define SCD4X_COMMAND_BUF_SIZE 2
+#define SCD4X_WRITE_BUF_SIZE 5
+#define SCD4X_FRC_MIN_PPM 400
+#define SCD4X_FRC_MAX_PPM 2000
+#define SCD4X_READY_MASK 0x01
+
+/*Commands SCD4X*/
+enum scd4x_cmd {
+	CMD_START_MEAS          = 0x21b1,
+	CMD_READ_MEAS           = 0xec05,
+	CMD_STOP_MEAS           = 0x3f86,
+	CMD_SET_TEMP_OFFSET     = 0x241d,
+	CMD_GET_TEMP_OFFSET     = 0x2318,
+	CMD_FRC                 = 0x362f,
+	CMD_SET_ASC             = 0x2416,
+	CMD_GET_ASC             = 0x2313,
+	CMD_GET_DATA_READY      = 0xe4b8,
+};
+
+enum scd4x_channel_idx {
+	SCD4X_CO2,
+	SCD4X_TEMP,
+	SCD4X_HR,
+};
+
+struct scd4x_state {
+	struct i2c_client *client;
+	/* maintain access to device, to prevent concurrent reads/writes */
+	struct mutex lock;
+	struct regulator *vdd;
+};
+
+DECLARE_CRC8_TABLE(scd4x_crc8_table);
+
+static int scd4x_i2c_xfer(struct scd4x_state *state, char *txbuf, int txsize,
+				char *rxbuf, int rxsize)
+{
+	struct i2c_client *client = state->client;
+	int ret;
+
+	ret = i2c_master_send(client, txbuf, txsize);
+
+	if (ret < 0)
+		return ret;
+	if (ret != txsize)
+		return -EIO;
+
+	if (rxsize == 0)
+		return 0;
+
+	ret = i2c_master_recv(client, rxbuf, rxsize);
+	if (ret < 0)
+		return ret;
+	if (ret != rxsize)
+		return -EIO;
+
+	return 0;
+}
+
+static int scd4x_send_command(struct scd4x_state *state, enum scd4x_cmd cmd)
+{
+	char buf[SCD4X_COMMAND_BUF_SIZE];
+	int ret;
+
+	/*
+	 * Measurement needs to be stopped before sending commands.
+	 * Except stop and start command.
+	 */
+	if ((cmd != CMD_STOP_MEAS) && (cmd != CMD_START_MEAS)) {
+
+		ret = scd4x_send_command(state, CMD_STOP_MEAS);
+		if (ret)
+			return ret;
+
+		/* execution time for stopping measurement */
+		msleep_interruptible(500);
+	}
+
+	put_unaligned_be16(cmd, buf);
+	ret = scd4x_i2c_xfer(state, buf, 2, buf, 0);
+	if (ret)
+		return ret;
+
+	if ((cmd != CMD_STOP_MEAS) && (cmd != CMD_START_MEAS)) {
+		ret = scd4x_send_command(state, CMD_START_MEAS);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int scd4x_read(struct scd4x_state *state, enum scd4x_cmd cmd,
+			void *response, int byte_cnt)
+{
+	struct i2c_client *client = state->client;
+	char buf[SCD4X_READ_BUF_SIZE];
+	char *rsp = response;
+	int i, ret;
+	char crc;
+
+	/*
+	 * Measurement needs to be stopped before sending commands.
+	 * Except for reading measurement and data ready command.
+	 */
+	if ((cmd != CMD_GET_DATA_READY) && (cmd != CMD_READ_MEAS)) {
+		ret = scd4x_send_command(state, CMD_STOP_MEAS);
+		if (ret)
+			return ret;
+
+		/* execution time for stopping measurement */
+		msleep_interruptible(500);
+	}
+
+	put_unaligned_be16(cmd, buf);
+	ret = scd4x_i2c_xfer(state, buf, 2, buf, byte_cnt);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < byte_cnt; i += 3) {
+		crc = crc8(scd4x_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
+		if (crc != buf[i + 2]) {
+			dev_err(&client->dev, "CRC error\n");
+			return -EIO;
+		}
+
+		*rsp++ = buf[i];
+		*rsp++ = buf[i + 1];
+	}
+
+	/* start measurement */
+	if ((cmd != CMD_GET_DATA_READY) && (cmd != CMD_READ_MEAS)) {
+		ret = scd4x_send_command(state, CMD_START_MEAS);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int scd4x_write(struct scd4x_state *state, enum scd4x_cmd cmd, uint16_t arg)
+{
+	char buf[SCD4X_WRITE_BUF_SIZE];
+	int ret;
+	char crc;
+
+	put_unaligned_be16(cmd, buf);
+	put_unaligned_be16(arg, buf + 2);
+
+	crc = crc8(scd4x_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
+	buf[4] = crc;
+
+	/* measurement needs to be stopped before sending commands */
+	ret = scd4x_send_command(state, CMD_STOP_MEAS);
+	if (ret)
+		return ret;
+
+	/* execution time */
+	msleep_interruptible(500);
+
+	ret = scd4x_i2c_xfer(state, buf, SCD4X_WRITE_BUF_SIZE, buf, 0);
+	if (ret)
+		return ret;
+
+	/* start measurement, except for forced calibration command */
+	if (cmd != CMD_FRC) {
+		ret = scd4x_send_command(state, CMD_START_MEAS);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int scd4x_write_and_fetch(struct scd4x_state *state, enum scd4x_cmd cmd,
+				uint16_t arg, void *response, int byte_cnt)
+{
+	struct i2c_client *client = state->client;
+	char buf[SCD4X_READ_BUF_SIZE];
+	char *rsp = response;
+	int i, ret;
+	char crc;
+
+	ret = scd4x_write(state, CMD_FRC, arg);
+	if (ret)
+		goto err;
+
+	/* Execution time */
+	msleep_interruptible(400);
+
+	ret = i2c_master_recv(client, buf, byte_cnt);
+	if (ret < 0)
+		goto err;
+	if (ret != byte_cnt) {
+		ret = -EIO;
+		goto err;
+	}
+
+	for (i = 0; i < byte_cnt; i += 3) {
+		crc = crc8(scd4x_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
+		if (crc != buf[i + 2]) {
+			dev_err(&client->dev, "CRC error\n");
+			ret = -EIO;
+			goto err;
+		}
+
+		*rsp++ = buf[i];
+		*rsp++ = buf[i + 1];
+	}
+
+	return scd4x_send_command(state, CMD_START_MEAS);
+
+err:
+	/*
+	 * on error try to start the measurement,
+	 * puts sensor back into continuous measurement
+	 */
+	scd4x_send_command(state, CMD_START_MEAS);
+
+	return ret;
+}
+
+static int scd4x_read_meas(struct scd4x_state *state, uint16_t *meas)
+{
+	int i, ret;
+	uint16_t buf[3];
+
+	ret = scd4x_read(state, CMD_READ_MEAS, buf, 9);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(buf); i++)
+		meas[i] = be16_to_cpu(buf[i]);
+
+	return 0;
+}
+
+static int scd4x_wait_meas_poll(struct scd4x_state *state)
+{
+	struct i2c_client *client = state->client;
+	int tries = 6;
+	int ret;
+
+	do {
+		uint16_t val;
+
+		ret = scd4x_read(state, CMD_GET_DATA_READY, &val, 3);
+		if (ret)
+			return -EIO;
+		val = be16_to_cpu(val);
+
+		/* new measurement available */
+		if (val & 0x7FF)
+			return 0;
+
+		msleep_interruptible(1000);
+	} while (--tries);
+
+	/* try to start sensor on timeout */
+	ret = scd4x_send_command(state, CMD_START_MEAS);
+	if (ret)
+		dev_err(&client->dev, "failed to start measurement: %d\n", ret);
+
+	return -ETIMEDOUT;
+}
+
+static int scd4x_read_poll(struct scd4x_state *state, uint16_t *buf)
+{
+	int ret;
+
+	ret = scd4x_wait_meas_poll(state);
+	if (ret)
+		return ret;
+
+	return scd4x_read_meas(state, buf);
+}
+
+static int scd4x_read_channel(struct scd4x_state *state, int chan)
+{
+	int ret;
+	uint16_t buf[3];
+
+	ret = scd4x_read_poll(state, buf);
+	if (ret)
+		return ret;
+
+	return buf[chan];
+}
+static int scd4x_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan, int *val,
+			int *val2, long mask)
+{
+	struct scd4x_state *state = iio_priv(indio_dev);
+	int ret;
+	uint16_t tmp;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		mutex_lock(&state->lock);
+		ret = scd4x_read_channel(state, chan->address);
+		mutex_unlock(&state->lock);
+
+		iio_device_release_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_TEMP) {
+			*val = 175000;
+			*val2 = 65536;
+			return IIO_VAL_FRACTIONAL;
+		} else if (chan->type == IIO_HUMIDITYRELATIVE) {
+			*val = 100000;
+			*val2 = 65536;
+			return IIO_VAL_FRACTIONAL;
+		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = -16852;
+		*val2 = 114286;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		mutex_lock(&state->lock);
+		ret = scd4x_read(state, CMD_GET_TEMP_OFFSET, &tmp, 3);
+		mutex_unlock(&state->lock);
+		if (ret)
+			return ret;
+
+		*val = 175000 * be16_to_cpu(tmp) / 65536;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int scd4x_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+				int val, int val2, long mask)
+{
+	struct scd4x_state *state = iio_priv(indio_dev);
+	int ret = 0;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		val = val * 65536 / 175000;
+
+		mutex_lock(&state->lock);
+		ret = scd4x_write(state, CMD_SET_TEMP_OFFSET, val);
+		mutex_unlock(&state->lock);
+
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t calibration_auto_enable_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct scd4x_state *state = iio_priv(indio_dev);
+	int ret;
+	uint16_t val;
+
+	mutex_lock(&state->lock);
+	ret = scd4x_read(state, CMD_GET_ASC, &val, 3);
+	mutex_unlock(&state->lock);
+	if (ret) {
+		dev_err(dev, "failed to read automatic calibration");
+		return ret;
+	}
+
+	val = be16_to_cpu(val) & SCD4X_READY_MASK;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t calibration_auto_enable_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct scd4x_state *state = iio_priv(indio_dev);
+	bool val;
+	int ret;
+	uint16_t value;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	value = val;
+
+	mutex_lock(&state->lock);
+	ret = scd4x_write(state, CMD_SET_ASC, value);
+	mutex_unlock(&state->lock);
+	if (ret)
+		dev_err(dev, "failed to set automatic calibration");
+
+	return ret ?: len;
+}
+
+static ssize_t calibration_forced_value_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct scd4x_state *state = iio_priv(indio_dev);
+	uint16_t val, arg;
+	int ret;
+
+	ret = kstrtou16(buf, 0, &arg);
+	if (ret)
+		return ret;
+
+	if (arg < SCD4X_FRC_MIN_PPM || arg > SCD4X_FRC_MAX_PPM)
+		return -EINVAL;
+
+	mutex_lock(&state->lock);
+	ret = scd4x_write_and_fetch(state, CMD_FRC, arg, &val, 3);
+	mutex_unlock(&state->lock);
+
+	if (val == 0xff) {
+		dev_err(dev, "forced calibration has failed");
+		return -EINVAL;
+	}
+
+	return ret ?: len;
+}
+
+static IIO_DEVICE_ATTR_RW(calibration_auto_enable, 0);
+static IIO_DEVICE_ATTR_WO(calibration_forced_value, 0);
+
+static struct attribute *scd4x_attrs[] = {
+	&iio_dev_attr_calibration_auto_enable.dev_attr.attr,
+	&iio_dev_attr_calibration_forced_value.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group scd4x_attr_group = {
+	.attrs = scd4x_attrs,
+};
+static const struct iio_info scd4x_info = {
+	.attrs = &scd4x_attr_group,
+	.read_raw = scd4x_read_raw,
+	.write_raw = scd4x_write_raw,
+};
+
+static const struct iio_chan_spec scd4x_channels[] = {
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_CO2,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.address = SCD4X_CO2,
+		.scan_index = SCD4X_CO2,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		},
+	},
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					BIT(IIO_CHAN_INFO_SCALE) |
+					BIT(IIO_CHAN_INFO_OFFSET) |
+					BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.address = SCD4X_TEMP,
+		.scan_index = SCD4X_TEMP,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		},
+	},
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					BIT(IIO_CHAN_INFO_SCALE),
+		.address = SCD4X_HR,
+		.scan_index = SCD4X_HR,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		},
+	},
+};
+
+static int __maybe_unused scd4x_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct scd4x_state *state  = iio_priv(indio_dev);
+	int ret;
+
+	ret = scd4x_send_command(state, CMD_STOP_MEAS);
+	if (ret)
+		return ret;
+
+	return regulator_disable(state->vdd);
+}
+
+static int __maybe_unused scd4x_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct scd4x_state *state = iio_priv(indio_dev);
+	int ret;
+
+	ret = regulator_enable(state->vdd);
+	if (ret)
+		return ret;
+
+	return scd4x_send_command(state, CMD_START_MEAS);
+}
+
+static __maybe_unused SIMPLE_DEV_PM_OPS(scd4x_pm_ops, scd4x_suspend, scd4x_resume);
+
+static void scd4x_stop_meas(void *state)
+{
+	scd4x_send_command(state, CMD_STOP_MEAS);
+}
+
+static void scd4x_disable_regulator(void *data)
+{
+	struct scd4x_state *state = data;
+
+	regulator_disable(state->vdd);
+}
+
+static irqreturn_t scd4x_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct scd4x_state *state = iio_priv(indio_dev);
+	struct {
+		uint16_t data[3];
+		int64_t ts __aligned(8);
+	} scan;
+	int ret;
+	uint16_t buf[3];
+
+	mutex_lock(&state->lock);
+	ret = scd4x_read_poll(state, buf);
+	mutex_unlock(&state->lock);
+	if (ret)
+		goto out;
+
+	memset(&scan, 0, sizeof(scan));
+	memcpy(scan.data, buf, sizeof(buf));
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static int scd4x_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	static const unsigned long scd4x_scan_masks[] = { 0x07, 0x00 };
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct scd4x_state *state;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	state = iio_priv(indio_dev);
+	mutex_init(&state->lock);
+	state->client = client;
+	crc8_populate_msb(scd4x_crc8_table, SCD4X_CRC8_POLYNOMIAL);
+
+	indio_dev->info = &scd4x_info;
+	indio_dev->name = client->name;
+	indio_dev->channels = scd4x_channels;
+	indio_dev->num_channels = ARRAY_SIZE(scd4x_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
+	indio_dev->available_scan_masks = scd4x_scan_masks;
+
+	state->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(state->vdd))
+		return dev_err_probe(dev, PTR_ERR(state->vdd), "failed to get regulator\n");
+
+	ret = regulator_enable(state->vdd);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, scd4x_disable_regulator, state);
+	if (ret)
+		return ret;
+
+	ret = scd4x_send_command(state, CMD_STOP_MEAS);
+	if (ret) {
+		dev_err(dev, "failed to stop measurement: %d\n", ret);
+		return ret;
+	}
+
+	/* execution time */
+	msleep_interruptible(500);
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL, scd4x_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	ret = scd4x_send_command(state, CMD_START_MEAS);
+	if (ret) {
+		dev_err(dev, "failed to start measurement: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, scd4x_stop_meas, state);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id scd4x_dt_ids[] = {
+	{ .compatible = "sensirion,scd40" },
+	{ .compatible = "sensirion,scd41" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, scd4x_dt_ids);
+
+static struct i2c_driver scd4x_i2c_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = scd4x_dt_ids,
+		.pm = &scd4x_pm_ops
+	},
+	.probe = scd4x_probe,
+};
+module_i2c_driver(scd4x_i2c_driver);
+
+MODULE_AUTHOR("Roan van Dijk <roan@protonic.nl>");
+MODULE_DESCRIPTION("Sensirion SCD4X carbon dioxide sensor core driver");
+MODULE_LICENSE("GPL v2");
-- 
2.30.2

