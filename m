Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB62398AFB
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 15:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhFBNsY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 09:48:24 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:40805 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFBNsY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 09:48:24 -0400
Received: by mail-ej1-f47.google.com with SMTP id jt22so3946375ejb.7
        for <linux-iio@vger.kernel.org>; Wed, 02 Jun 2021 06:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACHDSFMKbDR2EeyZMuk2KWFELLGvy//ly0BUo6eFPto=;
        b=P8CyWYM9KVhqtiWz6mGD/N/vOoY+zm6zHxntREAzPL4xxmkkXvTpRA3pRXON2QqLjn
         jH284CVK+A3ddGWsEfGMyB+pgcLpcwbC2ADJNOnrjLu7Ka1a7FvlGjblzwM5SPqyP8q9
         t94oJxcUjv4zIEjyoOsXuF0NxW7ubieJFnm9YJ4eMPmyEMH4tTGbSbRAWi1zbynhyZmu
         u1FxX3sv/kEW/fr5H0aIL1EiZNZKtfTJd+6iYFhHIZICtg9zGPmsrg0V4ByDI370K9BC
         uATUyMWXvNl7Dgb3GM5sbF4wbXH3/SQsTQ19cdAhFisSehCW3IIhkkjaBoARaSe+CQxI
         WcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACHDSFMKbDR2EeyZMuk2KWFELLGvy//ly0BUo6eFPto=;
        b=nsocgFHAnx8zbiKRmMA3z5shborrEdaU4qw6VJ38KTwxxLr9FBLv3TtSPau07/xxiH
         wng7dj0pRgS+t/o9Mrf3J1vEVijRZgrj9VZXKa12QIa2oDJ1yiEw4vep4l6PJqCJWzRB
         61BeWafEF5aacdW5C3nBv63kP9L90l7mM/bQiPgMpZaNu0FLm64/ePwk2RH4oW2Bu+Fz
         NmzEF1E37SIwPC5sc3GvMdpYDTyd9RhZl5oSMIoW1yrowSt6hVe1rohwg0xjd9RT576J
         sC3/m4a21hqcZOdeD/h6obnv+RkDEISkxXGNJxddQyNa1+LRgaGvX6tl2wfV2d25t9rf
         5Y1A==
X-Gm-Message-State: AOAM531CmfZkRYC1cWeQW86tHWYH5MkjJ3TQozftVCs1GdDGSOxsPeEZ
        82J6aj20YONriFt+bF1ss/8=
X-Google-Smtp-Source: ABdhPJxHGBSgYMkOd/v1pgvN5uB3bqHcT0I4sVcz5Vhta6XVuQhjmeVzgGQDTe335KHvl1xz7AGoMg==
X-Received: by 2002:a17:906:8394:: with SMTP id p20mr31500221ejx.170.1622641526969;
        Wed, 02 Jun 2021 06:45:26 -0700 (PDT)
Received: from mars.fritz.box ([2a02:8070:b9d:f200:bee0:f4e2:68f9:3d11])
        by smtp.googlemail.com with ESMTPSA id n2sm1372305edi.32.2021.06.02.06.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 06:45:26 -0700 (PDT)
From:   Christoph Fritz <chf.fritz@googlemail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: light: Add support for Intersil isl76683 sensor
Date:   Wed,  2 Jun 2021 15:45:11 +0200
Message-Id: <20210602134512.193186-2-chf.fritz@googlemail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210602134512.193186-1-chf.fritz@googlemail.com>
References: <20210602134512.193186-1-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds support for Intersil isl76683 light sensor.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/iio/light/Kconfig    |  12 +
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/isl76683.c | 604 +++++++++++++++++++++++++++++++++++
 3 files changed, 617 insertions(+)
 create mode 100644 drivers/iio/light/isl76683.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 917f9becf9c7..822e519728a0 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -253,6 +253,18 @@ config ISL29125
 	  To compile this driver as a module, choose M here: the module will be
 	  called isl29125.
 
+config ISL76683
+	tristate "Intersil ISL76683 light sensor"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here if you want to build a driver for the Intersil ISL76683
+	  light sensor for I2C.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called isl76683.
+
 config HID_SENSOR_ALS
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index ea376deaca54..cde09577e2c1 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_IQS621_ALS)	+= iqs621-als.o
 obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
 obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
 obj-$(CONFIG_ISL29125)		+= isl29125.o
+obj-$(CONFIG_ISL76683)		+= isl76683.o
 obj-$(CONFIG_JSA1212)		+= jsa1212.o
 obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
 obj-$(CONFIG_LTR501)		+= ltr501.o
diff --git a/drivers/iio/light/isl76683.c b/drivers/iio/light/isl76683.c
new file mode 100644
index 000000000000..8f10b69841b9
--- /dev/null
+++ b/drivers/iio/light/isl76683.c
@@ -0,0 +1,604 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/util_macros.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define ISL76683_REG_CMD		0x00
+#define ISL76683_REG_CTRL		0x01
+#define ISL76683_REG_THR_HI		0x02
+#define ISL76683_REG_THR_LO		0x03
+#define ISL76683_REG_SENSOR_LSB		0x04
+#define ISL76683_REG_SENSOR_MSB		0x05
+#define ISL76683_REG_CLEAR_INT		0x40
+#define ISL76683_REGMAP_MAX		0x40
+
+#define ISL76683_CMD_ENABLE		BIT(7)
+#define ISL76683_CMD_PWRDWN		BIT(6)
+#define ISL76683_PHOTOD_SHFT		2
+#define ISL76683_PHOTOD_MASK		GENMASK(3, ISL76683_PHOTOD_SHFT)
+#define ISL76683_INTPERS_MASK		0x3
+#define ISL76683_LUXRANGE_SHFT		2
+#define ISL76683_LUXRANGE_MASK		(0x3 << ISL76683_LUXRANGE_SHFT)
+#define ISL76683_LUXRANGE_STR		"1000 4000 16000 64000"
+#define ISL76683_RESOLUTION_SHFT	0
+#define ISL76683_RESOLUTION_MASK	(0x3 << ISL76683_RESOLUTION_SHFT)
+
+enum isl76683_dmode {
+	ISL76683_DIODE_0 = 0,
+	ISL76683_DIODE_IR,
+	ISL76683_DIODE_DIFF,
+};
+
+enum isl76683_lux_range {
+	ISL76683_LUX_1000 = 0,
+	ISL76683_LUX_4000,
+	ISL76683_LUX_16000,
+	ISL76683_LUX_64000,
+};
+
+enum isl76683_resolution {
+	ISL76683_RES_16 = 0,
+	ISL76683_RES_12,
+	ISL76683_RES_8,
+	ISL76683_RES_4,
+};
+
+static const int isl76683_lux_ranges_available[] = {
+	1000, 4000, 16000, 64000};
+
+#define ISL76683_LUX_RANGE_DEFAULT	ISL76683_LUX_1000
+#define ISL76683_DIODE_DEFAULT		ISL76683_DIODE_0
+#define ISL76683_RESOLUTION_DEFAULT	ISL76683_RES_16
+#define ISL76683_INTPERS_DEFAULT	0x0
+#define ISL76683_THR_DEFAULT		0x7f
+
+struct isl76683_chip {
+	enum isl76683_lux_range		luxrange;
+	enum isl76683_dmode		photodiode;
+	struct i2c_client		*client;
+	struct regmap			*rmp;
+	struct completion		irq_complete;
+	struct iio_trigger		*trig;
+	bool				trig_enabled;
+	struct mutex			lock;
+	s64				time_ns;
+};
+
+static bool isl76683_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ISL76683_REG_CMD:
+	case ISL76683_REG_CTRL:
+	case ISL76683_REG_THR_HI:
+	case ISL76683_REG_THR_LO:
+	case ISL76683_REG_SENSOR_LSB:
+	case ISL76683_REG_SENSOR_MSB:
+	case ISL76683_REG_CLEAR_INT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool isl76683_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ISL76683_REG_CMD:
+	case ISL76683_REG_CTRL:
+	case ISL76683_REG_THR_HI:
+	case ISL76683_REG_THR_LO:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool isl76683_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ISL76683_REG_SENSOR_LSB:
+	case ISL76683_REG_SENSOR_MSB:
+	case ISL76683_REG_CLEAR_INT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config isl76683_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = ISL76683_REGMAP_MAX,
+	.readable_reg = isl76683_readable_reg,
+	.writeable_reg = isl76683_writeable_reg,
+	.volatile_reg = isl76683_is_volatile_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int isl76683_get_sensordata(struct isl76683_chip *chip, int *val)
+{
+	unsigned int sensor_data;
+	__le16 sensor_raw;
+	int ret;
+
+	ret = regmap_bulk_read(chip->rmp, ISL76683_REG_SENSOR_LSB,
+				&sensor_raw, sizeof(sensor_raw));
+	if (ret)
+		return ret;
+
+	sensor_data = le16_to_cpu(sensor_raw);
+
+	*val = sensor_data;
+
+	return 0;
+}
+
+static inline int isl76683_start_measurement(struct isl76683_chip *chip)
+{
+	int dummy;
+
+	/* dummy read is clearing irq and triggers new measurement */
+	return regmap_read(chip->rmp, ISL76683_REG_CLEAR_INT, &dummy);
+}
+
+static int isl76683_singleshot_conversion(struct isl76683_chip *chip, int *val)
+{
+	long timeout;
+	int ret;
+
+	ret = isl76683_start_measurement(chip);
+	if (ret < 0)
+		return ret;
+
+	/* wait for measurement to complete */
+	timeout = wait_for_completion_interruptible_timeout(
+			&chip->irq_complete,
+			msecs_to_jiffies(5000));
+	if (timeout == 0) {
+		dev_err(&chip->client->dev, "measurement timed out\n");
+		return -ETIMEDOUT;
+	} else if (timeout < 0) {
+		dev_err(&chip->client->dev, "wait for measurement failed\n");
+		return -EINTR;
+	}
+
+	ret = isl76683_get_sensordata(chip, val);
+	if (ret) {
+		dev_err(&chip->client->dev, "%s: Error %d reading lux\n",
+				__func__, ret);
+		return ret;
+	}
+
+	return IIO_VAL_INT;
+}
+
+
+static int isl76683_set_config(struct isl76683_chip *chip)
+{
+	int dummy, ret;
+	bool changed;
+
+	ret = regmap_update_bits(chip->rmp, ISL76683_REG_CTRL,
+				ISL76683_LUXRANGE_MASK | ISL76683_INTPERS_MASK,
+				(chip->luxrange << ISL76683_LUXRANGE_SHFT) |
+				ISL76683_INTPERS_DEFAULT);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits_check(chip->rmp, ISL76683_REG_CMD,
+				ISL76683_PHOTOD_MASK | ISL76683_RESOLUTION_MASK,
+				(chip->photodiode << ISL76683_PHOTOD_SHFT) |
+				ISL76683_RESOLUTION_DEFAULT, &changed);
+	if (ret < 0)
+		return ret;
+
+	/* to get sane result after changing diode, dummy read is necessary */
+	if (changed) {
+		ret = isl76683_singleshot_conversion(chip, &dummy);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = regmap_write(chip->rmp, ISL76683_REG_THR_HI,
+				ISL76683_THR_DEFAULT);
+	if (ret < 0)
+		return ret;
+
+	return regmap_write(chip->rmp, ISL76683_REG_THR_LO,
+				ISL76683_THR_DEFAULT);
+}
+
+static int isl76683_power(struct isl76683_chip *chip, bool on)
+{
+	int ret;
+
+	ret = regmap_update_bits(chip->rmp, ISL76683_REG_CMD,
+				ISL76683_CMD_ENABLE | ISL76683_CMD_PWRDWN,
+				0x0);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(chip->rmp, ISL76683_REG_CMD,
+				ISL76683_CMD_ENABLE | ISL76683_CMD_PWRDWN,
+				on ? ISL76683_CMD_ENABLE : ISL76683_CMD_PWRDWN);
+	if (ret < 0)
+		return ret;
+
+	return on ? isl76683_set_config(chip) : 0;
+}
+
+static void isl76683_power_disable(void *data)
+{
+	struct isl76683_chip *chip = data;
+
+	isl76683_power(chip, false);
+}
+
+static int isl76683_reset(struct isl76683_chip *chip)
+{
+	int ret;
+
+	ret = isl76683_power(chip, false);
+	if (ret < 0)
+		return ret;
+
+	return isl76683_power(chip, true);
+}
+
+static irqreturn_t isl76683_interrupt_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct isl76683_chip *chip = iio_priv(indio_dev);
+
+	chip->time_ns = iio_get_time_ns(indio_dev);
+
+	if (chip->trig_enabled)
+		iio_trigger_poll(chip->trig);
+
+	if (!completion_done(&chip->irq_complete))
+		complete(&chip->irq_complete);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t isl76683_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct isl76683_chip *chip = iio_priv(indio_dev);
+	struct {
+		__le16 sensor;
+		s64 ts __aligned(8);
+	} scan;
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = regmap_bulk_read(chip->rmp, ISL76683_REG_SENSOR_LSB,
+			       (u8 *)&scan.sensor, sizeof(scan.sensor));
+	if (ret)
+		goto done;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, chip->time_ns);
+
+	ret = isl76683_start_measurement(chip);
+	if (ret < 0)
+		goto done;
+
+done:
+	mutex_unlock(&chip->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static int isl76683_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct isl76683_chip *chip = iio_priv(indio_dev);
+	int ret;
+
+	if (test_bit(2, indio_dev->active_scan_mask))
+		chip->photodiode = ISL76683_DIODE_DIFF;
+	else if (test_bit(1, indio_dev->active_scan_mask))
+		chip->photodiode = ISL76683_DIODE_IR;
+	else
+		chip->photodiode = ISL76683_DIODE_0;
+
+	ret = isl76683_set_config(chip);
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops isl76683_buffer_setup_ops = {
+	.preenable = &isl76683_buffer_preenable,
+	.validate_scan_mask = &iio_validate_scan_mask_onehot,
+};
+
+static int isl76683_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct isl76683_chip *chip = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		switch (chan->channel2) {
+		case IIO_MOD_LIGHT_BOTH:
+			chip->photodiode = ISL76683_DIODE_DIFF;
+			break;
+		case IIO_MOD_LIGHT_IR:
+			chip->photodiode = ISL76683_DIODE_IR;
+			break;
+		default:
+			chip->photodiode = ISL76683_DIODE_0;
+		}
+		ret = isl76683_set_config(chip);
+		if (ret) {
+			iio_device_release_direct_mode(indio_dev);
+			return ret;
+		}
+		ret = isl76683_singleshot_conversion(chip, val);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SCALE:
+		*val = isl76683_lux_ranges_available[chip->luxrange];
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int isl76683_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct isl76683_chip *chip = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		mutex_lock(&chip->lock);
+		chip->luxrange = find_closest(val,
+			isl76683_lux_ranges_available,
+			ARRAY_SIZE(isl76683_lux_ranges_available));
+		ret = isl76683_set_config(chip);
+		mutex_unlock(&chip->lock);
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
+static IIO_CONST_ATTR(in_illuminance_scale_available,
+		ISL76683_LUXRANGE_STR);
+
+static struct attribute *isl76683_attributes[] = {
+	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group isl76683_attribute_group = {
+	.attrs = isl76683_attributes,
+};
+
+#define ISL76683_CHANNEL(_ch2, _si) { \
+	.type = IIO_LIGHT, \
+	.modified = 1, \
+	.channel2 = _ch2, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+	.scan_index = _si, \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 16, \
+		.storagebits = 16, \
+		.endianness = IIO_LE, \
+	}, \
+}
+
+static const struct iio_chan_spec isl76683_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	ISL76683_CHANNEL(IIO_MOD_LIGHT_IR, 1),
+	ISL76683_CHANNEL(IIO_MOD_LIGHT_BOTH, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static const struct iio_info isl76683_info = {
+	.read_raw = isl76683_read_raw,
+	.write_raw = isl76683_write_raw,
+	.attrs = &isl76683_attribute_group,
+};
+
+static int isl76683_set_trigger_state(struct iio_trigger *trig, bool enable)
+{
+	struct isl76683_chip *chip = iio_trigger_get_drvdata(trig);
+	int ret;
+
+	if (enable) {
+		chip->trig_enabled = true;
+		ret = isl76683_start_measurement(chip);
+		if (ret < 0)
+			return ret;
+	} else
+		chip->trig_enabled = false;
+
+	return 0;
+}
+
+static const struct iio_trigger_ops isl76683_trigger_ops = {
+	.set_trigger_state = isl76683_set_trigger_state,
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static int isl76683_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct isl76683_chip *chip;
+	struct iio_dev *indio_dev;
+	int v, ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	chip = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	chip->client = client;
+
+	chip->luxrange = ISL76683_LUX_RANGE_DEFAULT;
+	chip->photodiode = ISL76683_DIODE_DEFAULT;
+
+	chip->rmp = devm_regmap_init_i2c(client, &isl76683_regmap_config);
+	if (IS_ERR(chip->rmp)) {
+		ret = PTR_ERR(chip->rmp);
+		dev_err(dev, "%s: Error %d initializing regmap\n",
+			__func__, ret);
+		return ret;
+	}
+
+	mutex_init(&chip->lock);
+	init_completion(&chip->irq_complete);
+
+	if (!client->irq) {
+		dev_err(dev, "no interrupt configured\n");
+		return -EINVAL;
+	}
+
+	indio_dev->dev.parent = dev;
+	indio_dev->info = &isl76683_info;
+	indio_dev->channels = isl76683_channels;
+	indio_dev->num_channels = ARRAY_SIZE(isl76683_channels);
+	indio_dev->name = chip->client->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	chip->trig_enabled = false;
+	chip->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+			indio_dev->name, indio_dev->id);
+	if (!chip->trig)
+		return -ENOMEM;
+
+	chip->trig->ops = &isl76683_trigger_ops;
+	chip->trig->dev.parent = dev;
+	iio_trigger_set_drvdata(chip->trig, chip);
+
+	ret = devm_request_irq(dev, client->irq,
+			isl76683_interrupt_handler,
+			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			"isl76683_event", indio_dev);
+	if (ret) {
+		dev_err(dev, "irq request error\n");
+		return ret;
+	}
+
+	ret = devm_iio_trigger_register(dev, chip->trig);
+	if (ret) {
+		dev_err(dev, "iio_trigger register error\n");
+		return ret;
+	}
+
+	ret = isl76683_reset(chip);
+	if (ret) {
+		dev_err(dev, "reset failed\n");
+		return ret;
+	}
+
+	ret = isl76683_get_sensordata(chip, &v);
+	if (ret) {
+		dev_err(dev, "initial dummy readout failed\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, isl76683_power_disable, chip);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+			&isl76683_trigger_handler, &isl76683_buffer_setup_ops);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret) {
+		dev_err(dev, "%s(): iio registration failed with error %d\n",
+			__func__, ret);
+	}
+
+	return ret;
+}
+
+static int __maybe_unused isl76683_suspend(struct device *dev)
+{
+	struct isl76683_chip *chip =
+		iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = isl76683_power(chip, false);
+	regcache_mark_dirty(chip->rmp);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static int __maybe_unused isl76683_resume(struct device *dev)
+{
+	struct isl76683_chip *chip =
+		iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = isl76683_power(chip, true);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(isl76683_pm_ops, isl76683_suspend, isl76683_resume);
+
+static const struct of_device_id isl76683_of_match[] = {
+	{ .compatible = "isil,isl76683", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, isl76683_of_match);
+
+static const struct i2c_device_id isl76683_id[] = {
+	{"isl76683", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, isl76683_id);
+
+static struct i2c_driver isl76683_driver = {
+	.driver  = {
+		.name = "isl76683",
+		.of_match_table = isl76683_of_match,
+		.pm = &isl76683_pm_ops,
+	},
+	.probe_new = isl76683_probe,
+	.id_table = isl76683_id,
+};
+module_i2c_driver(isl76683_driver);
+
+MODULE_AUTHOR("Christoph Fritz <chf.fritz@googlemail.com>");
+MODULE_DESCRIPTION("ISL76683 Ambient Light Sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.29.2

