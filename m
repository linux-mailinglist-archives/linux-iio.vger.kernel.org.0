Return-Path: <linux-iio+bounces-18513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F73A971BB
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 17:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3A23B7379
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A9228FFDE;
	Tue, 22 Apr 2025 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1N9O3zc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4D27BF7F;
	Tue, 22 Apr 2025 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337215; cv=none; b=cjbFC96WORW0pI52AZd4VFUDIaXbO+UjF/L2tM+qKP7thyKETkn1Nf+aTHeG/Y24Kb1AQsQPBBBwA2gq5eK87y2bM4KuCB2WZk0lU/7xJeZ0ijiX4OaYs9AdXCVRFnvOrmkzu4Gbjw4YCqVHDzcyUgHD2TgR8in6qoFO2zqFSZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337215; c=relaxed/simple;
	bh=0aQOyyRxYCEr2s9SJt75kvYfXG74Cr3hcQRfAnAoGuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwFeGYG6mwuAbktIw8Jd0/IDlF7o3MXbgei8z8z3IcQQ1FyIlGNEdxLpy9qm8ouLF7F+2PIwF6+D0TAVzYqF5iMno3yR6tG9rnCBHVNO/uCQxe3gN6kqpGtIgxph06VLZw2acYbRBT8YLoOgLeHSJT65GhKAvwcD2Xc9pwG9VbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1N9O3zc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22d95f0dda4so19476795ad.2;
        Tue, 22 Apr 2025 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745337213; x=1745942013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqkjywyoxeSMHH077dPe8bMeYa2zqvjvXQaRB0tvP3k=;
        b=i1N9O3zcEmOrkSCHQmYVuPigIxmIuxe4KVsmaWx9CR3AzpithNgCZbbkWmTwSEbSNN
         UKfyS3NyhOB/jnNIhDW3kySIWKZI51MwGLX6KI88yGaUor/C3/0TStcaY365KAlU3rNY
         mQXYpNf/Yqq8/RuE0N7HnIe9XZs/7R4njBKM86BPplGUA22b45ILkvx+uUm5KIdw3tkF
         vZwDTdd/a9iCaAg3DiWjCXKnWHeirprzUJGxHbdJUeDD2e0mUaD4yw0UdFP6LE2L7DUO
         1ZkRr9iHheDxJU2wFEzzGdZYm/RU5ba9jFsxf4zi3WyTJCwKhAVLQeGuASf0mWXKX04x
         CWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337213; x=1745942013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqkjywyoxeSMHH077dPe8bMeYa2zqvjvXQaRB0tvP3k=;
        b=nXyZMyhdQ5EVu88LMN5f3FBn8ixGuPsicnJx2niuETaNXlWXEBCu7lfvmS1t9je64n
         47qBS/oLLRmB5wnCIXdzw6xB8IGD55FXRGfEGRqYlc9sP0x/GfSX1d6ukk+zvmXe3T0k
         MQybc7VGN36tRc4Ck/bxH4LTCiWW3YWG0128UYyzL6iI430grE7SZVrNL4OCwsyRgU7K
         TczEAu5BGQjWnP+kkC5BnAkOhhEJBvYHm1IuvWdemEg8NLUTrgU0mgCLLxB7qqnwey67
         OqZ6BsgyfNjUZlWheU+fd4ozOjLOAvk1s5/ydFdkSyj8DmOMFZHGKc4OqQVVDwh/lR0/
         ytQw==
X-Forwarded-Encrypted: i=1; AJvYcCWqTHUQo4NQJHdFojTFSOPiYwMRFX73HVh20If+RgDnPnbToJRodkGXQy07Hta4phWBIySojrhYhea8@vger.kernel.org, AJvYcCXbGrY5Ua6/2FUwGmR+utYyOQhBcROYHEAawKkeb1UXZGBFY30YFLOl9ml4uhw//yMkuW9BhwzlABWa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8oGEwnliCXvVCZFQvB9etvcxthP5743hHCmZwn4Eg/u/Xxrit
	YckzO+3IDlDhlgWc/f425Q4dxEIoUK4usPCfEVbFt6dY44TDd33W
X-Gm-Gg: ASbGncv/s4WJqAINaZX2WlCrMP9VtohyXUe173lBmhsuvfwNCZV3QDKBx5Xodxx06wK
	lV3xio6t0R2FrSiA68Ou+G4LNG8ZFDwOJwRROsNMcLLOswBIZ4RyU5O0s6uYkly76Vv78HLbWHO
	iLZiQYcww/66Uh6Tz4uUoBUuKoze3Msca0SmtcE2W2RFpwV8gWeWKwgUn8K/Dsti8zUpRuzB6vp
	VzNtZWILzc3Ic4O7Of9+OQ6xmN96HNWBSH5AOhPaVhD7RsgRvOVgqbVYMT0vaeS7g/FAPWd9Aqt
	RaxxW2ILJl8TceJTGS/fbVTxtTb24Un/8c+WavlpOCG3qPs=
X-Google-Smtp-Source: AGHT+IGNtk+2/9krYNb6AA1N5cgIKqba4QXTWenWyksYXkZ75nC6DDSVeuRxgwdQrs+ASVCsEj3K0g==
X-Received: by 2002:a17:902:ea07:b0:224:7a4:b2a with SMTP id d9443c01a7336-22c5357a664mr223882245ad.11.1745337212845;
        Tue, 22 Apr 2025 08:53:32 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22c50bdda46sm87078705ad.3.2025.04.22.08.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 08:53:32 -0700 (PDT)
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
Subject: [PATCH v5 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
Date: Wed, 23 Apr 2025 00:53:01 +0900
Message-Id: <20250422155302.669960-4-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422155302.669960-1-gye976@gmail.com>
References: <20250422155302.669960-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for winsen MHZ19B CO2 sensor.

Datasheet: https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/chemical/Kconfig  |  10 ++
 drivers/iio/chemical/Makefile |   1 +
 drivers/iio/chemical/mhz19b.c | 311 ++++++++++++++++++++++++++++++++++
 3 files changed, 322 insertions(+)
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
index 000000000000..61dc94c0dd06
--- /dev/null
+++ b/drivers/iio/chemical/mhz19b.c
@@ -0,0 +1,311 @@
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
+		if (!in_range(ppm, 1000, 4001)) {
+			dev_dbg(&indio_dev->dev,
+				"span point ppm should be between 1000 and 5000 inclusive.");
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


