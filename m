Return-Path: <linux-iio+bounces-17848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BCDA81B41
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 04:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90DD1B8189B
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 02:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF481ADC6D;
	Wed,  9 Apr 2025 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvS0gz61"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E419E96D;
	Wed,  9 Apr 2025 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744166704; cv=none; b=fUqn9NlDr+eNY1Hna3+TWQ9gxqmrmQN1GbUVNR/+TzrKWgmxHyVG0oUmKk7xkM8SNR2OvUK9lHB7k+ta6D/SI9RoIHlLOho7kh39knnUSPdDR5yjeTjRJ47lAdzDeq9IHBKm/OhT5zZ365TpA6KhRcQ9Qd+eksu6250f3ZkWQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744166704; c=relaxed/simple;
	bh=bKLkOGUwqCdmPkcWqIjwvGcivH7dFMI7MfFhT8W9KUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j5/g8WO5tltxEFT95Q2x1IIiJxlusBibm2Ofgz19JExHs2BZKbjkR8ZsIhqTtrfGKu52o05lD73gx1o5ZQZBuvIrByhpiaBeQqG9dCt0Zuf14GQjdZbe+3UAMVvOvb4mgyXoxHxFGDPFaX2fkpdebp641idpATxvrfm2HrAjidE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvS0gz61; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736bfa487c3so5336305b3a.1;
        Tue, 08 Apr 2025 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744166701; x=1744771501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0c9N0c2if6tASPIExhW8nPuwQDHso6Huz4Iz3nGTbM=;
        b=hvS0gz61WFfibhgf7Q69qBIrXAbQ+xpEno4R9iujFd4aGKd8JRCNfbOCd50vVB0w89
         TcRaNXM1w828JBeiBs67E6GbXPEPYl3tG4j+aptENlsgwzxhOlOxbF0HxhlbAs4WpiRe
         8s97JtZcncnMfi0VDNGcc9f6o9xT6Z178wyT+s71PiQV/eO86dY2tgnQONxUt7gYn6RR
         jU6eOQlXKu5hjdTDLMjDGlzNIfHJSnVyhqlBgQSpxEQCexIQiN9xfJ00XPcKXn+uk9aY
         x7/GtMl1z5RK9wIX11wacQZyhd5NzRYpaI7+1S7cG9krJlcdT34eqBxwcytApc8MUIIJ
         lA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744166701; x=1744771501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0c9N0c2if6tASPIExhW8nPuwQDHso6Huz4Iz3nGTbM=;
        b=F1CqW8gikASDWFVkgO1g/JJW2RWpWFTZsRFnXJ1gaKNlYTCQ9BEC0wiFDZZnbM8iKq
         GwI7LM5NHTaonPbByALP8WbP/iw1FBuWtn/K6eit4vwroXgxez9UgAc0Epd65/RNJ9gk
         7y6Jeh7Es+Bxtv6rfXhcOW51LdYCwrm+YEAxLjQXLziYOuM9NPv4JdsDZ/wlS6ImqM5u
         3b+4Z/F38F3EAb2HPItH2oohLny3rZsiLI8eaAUI2IDuMk6aotML1PKU9lNY2wRRIcxp
         sY2XoOvrOt6WUEpeDKK6VKRZ0sOc+f4m9T0Wm3o1+XtiGNvgL2XA7DKRkO4Kn4G7eqhn
         GU1A==
X-Forwarded-Encrypted: i=1; AJvYcCVC5OUZpHxM78TUr2z0agXXw4Z9ZMB2UhKfoKqM/0w92KCJhzyMOpDk2UVHL0qSdLDDTQNUeH5drrUR@vger.kernel.org, AJvYcCVEFjopkWOdJhsNSvaBvVbdFTS/oy611KE/DUwC122/b+/qcqRn5FgrLAgVnE4+BfGJyDcLp1oduK7y@vger.kernel.org
X-Gm-Message-State: AOJu0YzCsZX+NXJpK6La17el0I71thtX2LIZrMG5TZ9n+wYQixCSh/I4
	43ewpNaT/dwCpYO+ELIu3ywg+OZ61cUdHWVHYoKFOdeu/oQTEnFV
X-Gm-Gg: ASbGncul6Jhqsdg6NKJzQSJrVnZ+qU1u9QUyqiY1AIm77lcwqsZ+6NGy40BNx1ccObf
	TuiIOhSxatF0SBdQr4qFp/cO7wOzxj+cgNeGVW7e1dj+8SWTkbYdDAem2WVE6FuKBAkZDjpf11e
	K+b5DuJQBDloAUTdwUT6nlf6fqF6nnNXq3pOASg4R1onWEK61C66Q1y5vqt0+anvi1/qRq3k/VN
	yDKMUgH9R/IhB+ZuLD1SCUcxzisU9LhcoJ9hA9rF7gje52aLgmqptSFwQL8fVAJnC3h0fg5jwTt
	4WQ7bmoLRe1IRQLlA0MeEqIWik3vuNafFfnPeQofqeglH6IgiA==
X-Google-Smtp-Source: AGHT+IH/ep6f1TPzA9TZ9s4GBeBQQafX90m1Bcpf3jI5wwYl3ZV8u7r4An9RbX9L6cDkQOwtoKcMeQ==
X-Received: by 2002:a05:6a21:4a4c:b0:1f5:8153:93fb with SMTP id adf61e73a8af0-2015aec733dmr1150995637.10.1744166701546;
        Tue, 08 Apr 2025 19:45:01 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([61.108.38.194])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b02a2d3abffsm114028a12.48.2025.04.08.19.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 19:45:01 -0700 (PDT)
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
Subject: [PATCH v3 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
Date: Wed,  9 Apr 2025 11:43:10 +0900
Message-Id: <20250409024311.19466-5-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409024311.19466-1-gye976@gmail.com>
References: <20250409024311.19466-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for winsen MHZ19B CO2 sensor.

Datasheet:
https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/chemical/Kconfig  |  10 +
 drivers/iio/chemical/Makefile |   1 +
 drivers/iio/chemical/mhz19b.c | 347 ++++++++++++++++++++++++++++++++++
 3 files changed, 358 insertions(+)
 create mode 100644 drivers/iio/chemical/mhz19b.c

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 330fe0af946f..641bf9b35915 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -237,4 +237,14 @@ config VZ89X
 	  Sensortech MiCS VZ89X VOC (Volatile Organic Compounds)
 	  sensors

+config WINSEN_MHZ19B
+	tristate "Winsen MHZ19B CO2 sensor"
+	depends on SERIAL_DEV_BUS
+	help
+	  Say Y here to build Serdev interface support for the Winsen
+	  MHZ19B CO2 sensor.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called mhz19b.
+
 endmenu
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 4866db06bdc9..deed437dd396 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -27,3 +27,4 @@ obj-$(CONFIG_SPS30) += sps30.o
 obj-$(CONFIG_SPS30_I2C) += sps30_i2c.o
 obj-$(CONFIG_SPS30_SERIAL) += sps30_serial.o
 obj-$(CONFIG_VZ89X)		+= vz89x.o
+obj-$(CONFIG_WINSEN_MHZ19B) += mhz19b.o
diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
new file mode 100644
index 000000000000..d9a16e022b36
--- /dev/null
+++ b/drivers/iio/chemical/mhz19b.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mh-z19b co2 sensor driver
+ *
+ * Copyright (c) 2025 Gyeyoung Baek <gye976@gmail.com>
+ *
+ * Datasheet:
+ * https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
+ */
+
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/serdev.h>
+#include <linux/unaligned.h>
+
+struct mhz19b_state {
+	struct serdev_device *serdev;
+	struct regulator *vin;
+
+	/*
+	 * serdev receive buffer.
+	 * When data is received from the MH-Z19B,
+	 * the 'mhz19b_receive_buf' callback function is called and fills this buffer.
+	 */
+	char buf[9];
+	int buf_idx;
+
+	/* must wait the 'buf' is filled with 9 bytes.*/
+	struct completion buf_ready;
+};
+
+/*
+ * commands have following format:
+ *
+ * +------+------+-----+------+------+------+------+------+-------+
+ * | 0xFF | 0x01 | cmd | arg0 | arg1 | 0x00 | 0x00 | 0x00 | cksum |
+ * +------+------+-----+------+------+------+------+------+-------+
+ */
+#define MHZ19B_CMD_SIZE 9
+
+#define MHZ19B_ABC_LOGIC_CMD		0x79
+#define MHZ19B_READ_CO2_CMD		0x86
+#define MHZ19B_SPAN_POINT_CMD		0x88
+#define MHZ19B_ZERO_POINT_CMD		0x87
+
+#define MHZ19B_ABC_LOGIC_OFF_CKSUM	0x86
+#define MHZ19B_ABC_LOGIC_ON_CKSUM	0xE6
+#define MHZ19B_READ_CO2_CKSUM		0x79
+#define MHZ19B_ZERO_POINT_CKSUM	0x78
+
+/* ABC logic in MHZ19B means auto calibration. */
+
+#define MHZ19B_SERDEV_TIMEOUT	msecs_to_jiffies(100)
+
+static uint8_t mhz19b_get_checksum(uint8_t *packet)
+{
+	uint8_t i, checksum = 0;
+
+	for (i = 1; i < 8; i++)
+		checksum += packet[i];
+
+	checksum = 0xff - checksum;
+	checksum += 1;
+
+	return checksum;
+}
+
+static int mhz19b_serdev_cmd(struct iio_dev *indio_dev,
+	int cmd, void *arg)
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
+	uint8_t cmd_buf[MHZ19B_CMD_SIZE] = {
+		0xFF, 0x01, cmd,
+	};
+
+	switch (cmd) {
+	case MHZ19B_ABC_LOGIC_CMD: {
+		bool enable = *((bool *)arg);
+
+		if (enable) {
+			cmd_buf[3] = 0xA0;
+			cmd_buf[8] = MHZ19B_ABC_LOGIC_ON_CKSUM;
+		} else {
+			cmd_buf[3] = 0;
+			cmd_buf[8] = MHZ19B_ABC_LOGIC_OFF_CKSUM;
+		}
+		break;
+	} case MHZ19B_READ_CO2_CMD: {
+		cmd_buf[8] = MHZ19B_READ_CO2_CKSUM;
+		break;
+	} case MHZ19B_SPAN_POINT_CMD: {
+		uint16_t ppm = *((uint16_t *)arg);
+
+		put_unaligned_be16(ppm, &cmd_buf[3]);
+		cmd_buf[MHZ19B_CMD_SIZE - 1] = mhz19b_get_checksum(cmd_buf);
+		break;
+	} case MHZ19B_ZERO_POINT_CMD: {
+		cmd_buf[8] = MHZ19B_ZERO_POINT_CKSUM;
+		break;
+	} default:
+		break;
+	}
+
+	/* write buf to uart ctrl syncronously */
+	ret = serdev_device_write(serdev, cmd_buf, MHZ19B_CMD_SIZE, 0);
+	if (ret != MHZ19B_CMD_SIZE) {
+		dev_err(dev, "write err, %d bytes written", ret);
+		return -EINVAL;
+	}
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
+		ret = mhz19b_get_checksum(st->buf);
+		if (st->buf[MHZ19B_CMD_SIZE - 1] != mhz19b_get_checksum(st->buf)) {
+			dev_err(dev, "checksum err");
+			return -EINVAL;
+		}
+
+		ret = get_unaligned_be16(&st->buf[2]);
+		return ret;
+	default:
+		/* no response commands. */
+		return 0;
+	}
+}
+
+static int mhz19b_read_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan,
+	int *val, int *val2, long mask)
+{
+	int ret = mhz19b_serdev_cmd(indio_dev, MHZ19B_READ_CO2_CMD, NULL);
+
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+	return IIO_VAL_INT;
+}
+
+/*
+ * MHZ19B only supports writing configuration values.
+ *
+ * echo 0 > calibration_auto_enable : ABC logic off
+ * echo 1 > calibration_auto_enable : ABC logic on
+ *
+ * echo 0 > calibration_forced_value : zero point calibration
+ *	(make sure the sensor had been worked under 400ppm for over 20 minutes.)
+ * echo [1000 1 5000] > calibration_forced_value : span point calibration
+ *	(make sure the sensor had been worked under a certain level co2 for over 20 minutes.)
+ */
+static ssize_t calibration_auto_enable_store(struct device *dev,
+	struct device_attribute *attr,
+	const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	bool enable;
+	int ret = kstrtobool(buf, &enable);
+
+	if (ret)
+		return ret;
+
+	ret = mhz19b_serdev_cmd(indio_dev, MHZ19B_ABC_LOGIC_CMD, &enable);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+static IIO_DEVICE_ATTR_WO(calibration_auto_enable, 0);
+
+static ssize_t calibration_forced_value_store(struct device *dev,
+	struct device_attribute *attr,
+	const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	uint16_t ppm;
+	int cmd, ret;
+
+	ret = kstrtou16(buf, 10, &ppm);
+	if (ret)
+		return ret;
+
+	/* at least 1000ppm */
+	if (ppm) {
+		if (ppm < 1000 || ppm > 5000) {
+			dev_dbg(&indio_dev->dev,
+				"span point ppm should be 1000~5000");
+			return -EINVAL;
+		}
+
+		cmd = MHZ19B_SPAN_POINT_CMD;
+	} else {
+		cmd = MHZ19B_ZERO_POINT_CMD;
+	}
+
+	ret = mhz19b_serdev_cmd(indio_dev, cmd, &ppm);
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
+	const u8 *data, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
+	struct mhz19b_state *st = iio_priv(indio_dev);
+
+	for (int i = 0; i < len; i++)
+		st->buf[st->buf_idx++] = data[i];
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
+
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret)
+		return ret;
+
+	ret = serdev_device_set_baudrate(serdev, 9600);
+	if (ret < 0)
+		return ret;
+
+	serdev_device_set_flow_control(serdev, false);
+
+	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret < 0)
+		return ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct mhz19b_state));
+	if (!indio_dev)
+		return ret;
+	dev_set_drvdata(dev, indio_dev);
+
+	st = iio_priv(indio_dev);
+	st->serdev = serdev;
+
+	init_completion(&st->buf_ready);
+
+	st->vin = devm_regulator_get(dev, "vin");
+	if (IS_ERR(st->vin))
+		return PTR_ERR(st->vin);
+
+	ret = regulator_enable(st->vin);
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
+static void mhz19b_remove(struct serdev_device *serdev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
+	struct mhz19b_state *st = iio_priv(indio_dev);
+
+	regulator_disable(st->vin);
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
+	.remove = mhz19b_remove,
+};
+module_serdev_device_driver(mhz19b_driver);
+
+MODULE_AUTHOR("Gyeyoung Baek");
+MODULE_DESCRIPTION("MH-Z19B CO2 sensor driver using serdev interface");
+MODULE_LICENSE("GPL");
--
2.34.1


