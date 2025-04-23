Return-Path: <linux-iio+bounces-18581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C80A998C0
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 21:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308801B85AA7
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 19:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F986293B42;
	Wed, 23 Apr 2025 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JetA679W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E6291170;
	Wed, 23 Apr 2025 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437292; cv=none; b=pJ4+Z+XgwV1DcrmIXn0JK7jaFBwDdt1OCw8WWpgtGDpgStURjZeCxXuBo9acVtHjd8SyFlHw59jXnYwVtJYMi8/4fLJ9oasqGedhpEKEqlw88P+eKSyzlgujDGyRVwjYdg2iHB2lVOfJ+HDEv9n5BQL//AAxkOFA0KBEhRvhrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437292; c=relaxed/simple;
	bh=hbbrz8GbJk9bfYDpYMNjtCOa9WxCryMVjQFIu/+y7DU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvNwLldNDQENOg2qaZaOcS0FbYmrxMIFgnotdT2HTSSJE9YHl1/clnMI0PzczSPFHhqhcL8VFJPcr6nrAaQHveADEpG16HR2qgDYnCD3teJNj627y0t5VI53DGqYNw3mkV4V24SqChb7cph6qO4y0h/071laQFSanm3pXbCQRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JetA679W; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7376dd56eccso176974b3a.0;
        Wed, 23 Apr 2025 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745437290; x=1746042090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SPnWwmUxshK7be/c7DVVjj57FX5UpZV/lHuwqnlYdc=;
        b=JetA679Wg+NPvGa/9wrwuadmUWF2rfdcr5JHoAdHUyEJNJaWOxL9nu7H4I//ZHGVhQ
         hd8FOSB651+DFZqTG7W9Um7d6+VV9PbCNtMPUWV5kTRjclN+hCbVweKy+4MrlIiz7f6V
         FxWcARJqQH25mDo8G39U1L4HxOmeKJ4g2UNoNE++G11z6RaLNDfe68NMJissTOvWc4aw
         KAyDXPVuOE6JpKxIeeCIaUb9/5y03o/b7eCJK/QcnuDcBCTpJR0okGi7Tqq/1KJMa/zI
         0X1NVPKFluBw+lmHABXgXBVVwT2rD9j/RFiZuSS72kut3A43zsXnwp+Hvf9P9LGec2q2
         oIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745437290; x=1746042090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SPnWwmUxshK7be/c7DVVjj57FX5UpZV/lHuwqnlYdc=;
        b=HN4rLAzr0NLwLids+HZLq3NoodCbwmvkJGtEOdRY62b9/tGcuM9TEEc5/qaB3PDZaC
         sA9S3psKLEyghD8SW9Y+qKFYyM0rWRSb3nwka7SL+KzJ9Ib0+3UyPc+iANKLWGJPORoE
         FzxsZjkUFh5KsmqMFEtGtxucipYoQAzriTa5RtnbcU/5gM0LcKADIOPP1PUttTWvyX4D
         UiA9t41wLqqlGqKGz/SJ8Matt4URdoDQI5W2B2LxMEYd/q63tjgVPriuZWJksaYqXSYE
         FJupdJ1jKowN+OweWHQUwUiTzOP6atKzKZYm2K9tdARq784586MOndJmVOW96zkI9piP
         10Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXP66hUlSCwkFeiEEqlIqJkHYjR53mOGi/QV2gH3adIC5VVkUpnt5oxZYDi9619OJ9pyArWCEN6IYNZ@vger.kernel.org, AJvYcCXnhDr2M84Ve2p0eERtg1fXqO82oB4Ue3u2eTI7miaK4Fp1l7TB6Q2FPmL9lDAWmVpDzoVnfcTGu0Yc@vger.kernel.org
X-Gm-Message-State: AOJu0YwCKJ+6/xc9PeXrSU5n4zmv7fKp1NP9oD/87wDOHhTNI1PgZ+kl
	MyTI92LWwgDGS0htTI2+ca68GTxo04AG42HXk7UkcjuX4cd//8Gk
X-Gm-Gg: ASbGncvT99xF7qSfNTq3nflWjJuO/CxZX9fjbOpmhNR8DZmPdld+9rsL8j4zrwyBMGq
	fumI1w+vU3E3OsYa20x42JPUwnaMCauR0QR0Ni6UhC4sNyPg/h+XbV3m/73sSCUOcGtFc0dzNe0
	6U30Vbncd4Zf4Z9LnMwyBqYDHgAYppnM2B2YSI2k3AfdEK+8vM/XKP0gFWH3BfZo5AtQb3Kzwgq
	lhxTeAWxbxLdHrgPX+6Gsx/+u1J+IZUVNBcmUADPJa/4GB3QDcIYStEddAAm8p9XKT/iS5Y2Z5j
	TC5LRIYJUmhFYAStBb/FzkdhCZMXJPLlsrcy8gSy6INbxgU=
X-Google-Smtp-Source: AGHT+IGmkuO0XlR9Pbf3Hw1AV8qpamb48IV4NZYdkpfGj8SSLNRX2NoB3kHf4Pnls9ADOEWNl5f8Hg==
X-Received: by 2002:a05:6a20:ce44:b0:1f6:2d39:8713 with SMTP id adf61e73a8af0-203cbc72d98mr27335040637.19.1745437289662;
        Wed, 23 Apr 2025 12:41:29 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73dbf6a2dbesm10938291b3a.0.2025.04.23.12.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:41:29 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH v6 3/4] iio: chemical: Add support for Winsen MHZ19B CO2 sensor
Date: Thu, 24 Apr 2025 04:40:59 +0900
Message-Id: <20250423194100.53934-4-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423194100.53934-1-gye976@gmail.com>
References: <20250423194100.53934-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for Winsen MHZ19B CO2 sensor.

Datasheet: https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/chemical/Kconfig  |  10 ++
 drivers/iio/chemical/Makefile |   1 +
 drivers/iio/chemical/mhz19b.c | 316 ++++++++++++++++++++++++++++++++++
 3 files changed, 327 insertions(+)
 create mode 100644 drivers/iio/chemical/mhz19b.c

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 330fe0af946f..7742de3f9cdb 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -108,6 +108,16 @@ config IAQCORE
 	  iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
 	  sensors

+config MHZ19B
+	tristate "Winsen MHZ19B CO2 sensor"
+	depends on SERIAL_DEV_BUS
+	help
+	  Say Y here to build Serdev interface support for the Winsen
+	  MHZ19B CO2 sensor.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called mhz19b.
+
 config PMS7003
 	tristate "Plantower PMS7003 particulate matter sensor"
 	depends on SERIAL_DEV_BUS
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 4866db06bdc9..c63daebf39ac 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ENS160) += ens160_core.o
 obj-$(CONFIG_ENS160_I2C) += ens160_i2c.o
 obj-$(CONFIG_ENS160_SPI) += ens160_spi.o
 obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
+obj-$(CONFIG_MHZ19B) += mhz19b.o
 obj-$(CONFIG_PMS7003) += pms7003.o
 obj-$(CONFIG_SCD30_CORE) += scd30_core.o
 obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
new file mode 100644
index 000000000000..c0052ba3ac6c
--- /dev/null
+++ b/drivers/iio/chemical/mhz19b.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mh-z19b CO₂ sensor driver
+ *
+ * Copyright (c) 2025 Gyeyoung Baek <gye976@gmail.com>
+ *
+ * Datasheet:
+ * https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/jiffies.h>
+#include <linux/kstrtox.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/serdev.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+/*
+ * Commands have following format:
+ *
+ * +------+------+-----+------+------+------+------+------+-------+
+ * | 0xFF | 0x01 | cmd | arg0 | arg1 | 0x00 | 0x00 | 0x00 | cksum |
+ * +------+------+-----+------+------+------+------+------+-------+
+ */
+#define MHZ19B_CMD_SIZE 9
+
+/* ABC logic in MHZ19B means auto calibration. */
+#define MHZ19B_ABC_LOGIC_CMD		0x79
+#define MHZ19B_READ_CO2_CMD		0x86
+#define MHZ19B_SPAN_POINT_CMD		0x88
+#define MHZ19B_ZERO_POINT_CMD		0x87
+
+#define MHZ19B_SPAN_POINT_PPM_MIN	1000
+#define MHZ19B_SPAN_POINT_PPM_MAX	5000
+
+#define MHZ19B_SERDEV_TIMEOUT msecs_to_jiffies(100)
+
+struct mhz19b_state {
+	struct serdev_device *serdev;
+
+	/* Must wait until the 'buf' is filled with 9 bytes.*/
+	struct completion buf_ready;
+
+	u8 buf_idx;
+	/*
+	 * Serdev receive buffer.
+	 * When data is received from the MH-Z19B,
+	 * the 'mhz19b_receive_buf' callback function is called and fills this buffer.
+	 */
+	u8 buf[MHZ19B_CMD_SIZE] __aligned(IIO_DMA_MINALIGN);
+};
+
+static u8 mhz19b_get_checksum(u8 *cmd_buf)
+{
+	u8 i, checksum = 0;
+
+/*
+ * +------+------+-----+------+------+------+------+------+-------+
+ * | 0xFF | 0x01 | cmd | arg0 | arg1 | 0x00 | 0x00 | 0x00 | cksum |
+ * +------+------+-----+------+------+------+------+------+-------+
+ *	     i:1    2      3      4      5      6      7
+ *
+ *  Sum all cmd_buf elements from index 1 to 7.
+ */
+	for (i = 1; i < 8; i++)
+		checksum += cmd_buf[i];
+
+	return -checksum;
+}
+
+static int mhz19b_serdev_cmd(struct iio_dev *indio_dev, int cmd, u16 arg)
+{
+	struct mhz19b_state *st = iio_priv(indio_dev);
+	struct serdev_device *serdev = st->serdev;
+	struct device *dev = &indio_dev->dev;
+	int ret;
+
+	/*
+	 * cmd_buf[3,4] : arg0,1
+	 * cmd_buf[8]	: checksum
+	 */
+	u8 cmd_buf[MHZ19B_CMD_SIZE] = {
+		0xFF, 0x01, cmd,
+	};
+
+	switch (cmd) {
+	case MHZ19B_ABC_LOGIC_CMD:
+		cmd_buf[3] = arg ? 0xA0 : 0;
+		break;
+	case MHZ19B_SPAN_POINT_CMD:
+		put_unaligned_be16(arg, &cmd_buf[3]);
+		break;
+	default:
+		break;
+	}
+	cmd_buf[8] = mhz19b_get_checksum(cmd_buf);
+
+	/* Write buf to uart ctrl synchronously */
+	ret = serdev_device_write(serdev, cmd_buf, MHZ19B_CMD_SIZE, 0);
+	if (ret < 0)
+		return ret;
+	if (ret != MHZ19B_CMD_SIZE)
+		return -EIO;
+
+	switch (cmd) {
+	case MHZ19B_READ_CO2_CMD:
+		ret = wait_for_completion_interruptible_timeout(&st->buf_ready,
+			MHZ19B_SERDEV_TIMEOUT);
+		if (ret < 0)
+			return ret;
+		if (!ret)
+			return -ETIMEDOUT;
+
+		if (st->buf[8] != mhz19b_get_checksum(st->buf)) {
+			dev_err(dev, "checksum err");
+			return -EINVAL;
+		}
+
+		return get_unaligned_be16(&st->buf[2]);
+	default:
+		/* No response commands. */
+		return 0;
+	}
+}
+
+static int mhz19b_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	int ret;
+
+	ret = mhz19b_serdev_cmd(indio_dev, MHZ19B_READ_CO2_CMD, 0);
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+	return IIO_VAL_INT;
+}
+
+/*
+ * echo 0 > calibration_auto_enable : ABC logic off
+ * echo 1 > calibration_auto_enable : ABC logic on
+ */
+static ssize_t calibration_auto_enable_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+
+	ret = mhz19b_serdev_cmd(indio_dev, MHZ19B_ABC_LOGIC_CMD, enable);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+static IIO_DEVICE_ATTR_WO(calibration_auto_enable, 0);
+
+/*
+ * echo 0 > calibration_forced_value		 : zero point calibration
+ *	(make sure the sensor has been working under 400ppm for over 20 minutes.)
+ * echo [1000 1 5000] > calibration_forced_value : span point calibration
+ *	(make sure the sensor has been working under a certain level CO₂ for over 20 minutes.)
+ */
+static ssize_t calibration_forced_value_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	u16 ppm;
+	int cmd, ret;
+
+	ret = kstrtou16(buf, 0, &ppm);
+	if (ret)
+		return ret;
+
+	if (ppm) {
+		if (!in_range(ppm, MHZ19B_SPAN_POINT_PPM_MIN,
+			MHZ19B_SPAN_POINT_PPM_MAX - MHZ19B_SPAN_POINT_PPM_MIN + 1)) {
+			dev_dbg(&indio_dev->dev,
+				"span point ppm should be in a range [%d-%d]\n",
+				MHZ19B_SPAN_POINT_PPM_MIN, MHZ19B_SPAN_POINT_PPM_MAX);
+			return -EINVAL;
+		}
+
+		cmd = MHZ19B_SPAN_POINT_CMD;
+	} else {
+		cmd = MHZ19B_ZERO_POINT_CMD;
+	}
+
+	ret = mhz19b_serdev_cmd(indio_dev, cmd, ppm);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+static IIO_DEVICE_ATTR_WO(calibration_forced_value, 0);
+
+static struct attribute *mhz19b_attrs[] = {
+	&iio_dev_attr_calibration_auto_enable.dev_attr.attr,
+	&iio_dev_attr_calibration_forced_value.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group mhz19b_attr_group = {
+	.attrs = mhz19b_attrs,
+};
+
+static const struct iio_info mhz19b_info = {
+	.attrs = &mhz19b_attr_group,
+	.read_raw = mhz19b_read_raw,
+};
+
+static const struct iio_chan_spec mhz19b_channels[] = {
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_CO2,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	},
+};
+
+static size_t mhz19b_receive_buf(struct serdev_device *serdev,
+			      const u8 *data, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
+	struct mhz19b_state *st = iio_priv(indio_dev);
+
+	memcpy(st->buf + st->buf_idx, data, len);
+	st->buf_idx += len;
+
+	if (st->buf_idx == MHZ19B_CMD_SIZE) {
+		st->buf_idx = 0;
+		complete(&st->buf_ready);
+	}
+
+	return len;
+}
+
+static const struct serdev_device_ops mhz19b_ops = {
+	.receive_buf = mhz19b_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+static int mhz19b_probe(struct serdev_device *serdev)
+{
+	int ret;
+	struct device *dev = &serdev->dev;
+	struct iio_dev *indio_dev;
+	struct mhz19b_state *st;
+
+	serdev_device_set_client_ops(serdev, &mhz19b_ops);
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret)
+		return ret;
+	serdev_device_set_baudrate(serdev, 9600);
+	serdev_device_set_flow_control(serdev, false);
+	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret)
+		return ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return ret;
+	serdev_device_set_drvdata(serdev, indio_dev);
+
+	st = iio_priv(indio_dev);
+	st->serdev = serdev;
+
+	init_completion(&st->buf_ready);
+
+	ret = devm_regulator_get_enable(dev, "vin");
+	if (ret)
+		return ret;
+
+	indio_dev->name = "mh-z19b";
+	indio_dev->channels = mhz19b_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mhz19b_channels);
+	indio_dev->info = &mhz19b_info;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id mhz19b_of_match[] = {
+	{ .compatible = "winsen,mhz19b", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mhz19b_of_match);
+
+static struct serdev_device_driver mhz19b_driver = {
+	.driver = {
+		.name = "mhz19b",
+		.of_match_table = mhz19b_of_match,
+	},
+	.probe = mhz19b_probe,
+};
+module_serdev_device_driver(mhz19b_driver);
+
+MODULE_AUTHOR("Gyeyoung Baek");
+MODULE_DESCRIPTION("MH-Z19B CO2 sensor driver using serdev interface");
+MODULE_LICENSE("GPL");
--
2.34.1


