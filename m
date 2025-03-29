Return-Path: <linux-iio+bounces-17328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CD6A75734
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 17:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A1218904FE
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8A51DE2A4;
	Sat, 29 Mar 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5mCF88r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5C13C3C2;
	Sat, 29 Mar 2025 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743267006; cv=none; b=fmJTsLEddnsr4feCaHnAAe+kKrThPtKZDzUd0VxvWUCUxPWSeFVdxfaZXJ68+eB0RwPcO4ADi7g57XfBnyiXCzjidkO9m8Xm8fjZLRVCsYdkHnFPWvCdDCdaAcikvOPiLqVB2gSzTYckYYyD/vEhmXc5irsGRnoPKSfhBlMMsHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743267006; c=relaxed/simple;
	bh=Io7vP41mShDkpq9IpHddHFPNw2pL0+VFdDMCwIagwW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MKl2GGXxB79tcuxd+Y8RxUqpbrEfivRC8lGR1N57KtHnX/E1kl9YNQ2C117Pt0F/kutDe3ZTsVDNAZrv8LY8w4DbRETYtigVs35ObhlXMCxM+XSB6F72Rpd9+Ig0SZ+sbLF8V2AmF0s+VbeE4G3NSfV7ZKBbC/7A4S+bfr1Flx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5mCF88r; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224171d6826so28656735ad.3;
        Sat, 29 Mar 2025 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743267003; x=1743871803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71Np5SPg0AoFK/g+sMzVtj0g8qAJE0RDXtdJ4KQUhws=;
        b=g5mCF88run0BQ5mWUvPZ67AbUJBwT9WxRu87LSSWXm8xPyb8Mj5M4Qtp0/CnVa/Gca
         38dP1oZsaxAVhJGK/2x3eXn2jjMG2dKcojUJMaas9OZsA/8XA/DWByk6vhkCAmcZO9nJ
         bwmW7xHAT/0khfDe0fI9Xxu+5esShXEJS0djfSHUXliQRgV66pwSlVhvv83zkfsq/aH8
         pKZju1TbqZP9Uw0WO5129iWUvkf8zgRHfq5vBYW0nmYeR2QDnswL4afqW3CGkh2RppVj
         t6cWDC3b9RS76IYQViDLiLor0v04YANbWj/gmMMa2fXwgf1Bt8gJb70DpZjo17V4+IY/
         4Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743267003; x=1743871803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71Np5SPg0AoFK/g+sMzVtj0g8qAJE0RDXtdJ4KQUhws=;
        b=d2sGevzwbrhpSAY9q1GXn3hFbnRag5nNhqIHsBCAMZ8c9cO6hUepcCKCYkPfytgiha
         2jKC5qZmWfbeY7TRs5OtvxhLjjqtk+YCWxPiZ72BDhLKvwAyN8NU1ayGlhEw4acelETn
         gu3Jsz5ErfBhTUZeeh6f/SZ2NuLTnOO/WQQ5AcAElFXq5cjv+XkL+GFboAlG4rqAQh08
         e91M+uSbotIW3cppvfQe2DBRxEnCnzwcGQyKXNfSTIQ5/YeQ2+AHVp7ZA3/3nDcVQkkV
         7usmxEwXTdtRogVN78GrOd9uGf9AqzoSuhl2UQtp9/Jx44BKrxCqLd0QrPZprT9cpTK9
         widg==
X-Forwarded-Encrypted: i=1; AJvYcCVfejU3FPIQmxHtzJ4d0T/7qg1CdyHQecUxnuiQOf82AzE9lIi37yRETAvaWmVli5WKBJnWafwf3Enx@vger.kernel.org, AJvYcCXQmBeyVqLH8lNf1dgvOucjcLIaGxda2AhFF+mD73/nF8fJd5UfWItT02nGQ/4KsxVST7hQIDaJPOx3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ra3m42amYm+JUBo0xmdmXDQA9nQMX1qi0pTvF4jTIGmN2UFv
	bDEq3s0i3h5gqVGHOPbs65j93iqqikwrPYuz5a3EeqcZKSPMn3Pp
X-Gm-Gg: ASbGnculhjNYkVij00qkwQZTag6yureN90Wbcg0pN0wYozuAFVQLDECVM3VUGFCi5Jm
	kkstJrwEx7fRa06Ptt75nmyTSDs6kIjNc8jyqJe/sVLbr/jnUpUaaaHsuTLcR30p4S/1uhpuFtd
	PkSfweaa2QHX0GTdKakpPhS3unpPy9vVlDAKlgGf78F7ysAujpFgC3xaDtmVBufK3rKKw/U/H8n
	hcCHd4Ng0eKJXg47DqSw98Dvvzcvootc8fWfFKBg7pFmcSRy7itiRFTEsZLDaBZ75/XGtOx8sCN
	SceQyD8ufImZc456KwqLzD+hnzjalngWd4qYYakzXR8yJx1nZQxdKLqXRQqj7g==
X-Google-Smtp-Source: AGHT+IG73kQVw5sY7LET7IJmP0loG/EZoo/cH3A6ETK76akY6rymFdZsum0mX5uGXTv89QsrLLe+NA==
X-Received: by 2002:a17:902:f70f:b0:220:e1e6:4472 with SMTP id d9443c01a7336-2292f9547b4mr51086755ad.13.1743267003609;
        Sat, 29 Mar 2025 09:50:03 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2291eec6fb2sm38565425ad.26.2025.03.29.09.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 09:50:03 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lars@metafoo.de,
	gustavograzs@gmail.com,
	javier.carrasco.cruz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH 1/3] iio: chemical: add support for winsen MHZ19B CO2 sensor
Date: Sun, 30 Mar 2025 01:49:03 +0900
Message-Id: <20250329164905.632491-2-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250329164905.632491-1-gye976@gmail.com>
References: <20250329164905.632491-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for winsen MHZ19B CO2 sensor.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/chemical/Kconfig  |   6 +
 drivers/iio/chemical/Makefile |   1 +
 drivers/iio/chemical/mhz19b.c | 354 ++++++++++++++++++++++++++++++++++
 3 files changed, 361 insertions(+)
 create mode 100644 drivers/iio/chemical/mhz19b.c

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 330fe0af946f..6b09a9c52f32 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -108,6 +108,12 @@ config IAQCORE
 	  iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
 	  sensors
 
+config MHZ19B
+	tristate "MHZ19B CO2 sensor"
+	depends on SERIAL_DEV_BUS
+	help
+	  Say Y here to build support for the MHZ19B CO2 sensor.
+
+         To compile this driver as a module, choose M here: the module will
+         be called scd4x.
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
index 000000000000..de900131035b
--- /dev/null
+++ b/drivers/iio/chemical/mhz19b.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mh-z19b co2 sensor driver
+ *
+ * Copyright (c) 2025 Gyeyoung Baek <gye976@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/serdev.h>
+#include <linux/of.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/mutex.h>
+#include <linux/cleanup.h>
+
+struct mhz19b_state {
+	struct serdev_device *serdev;
+
+	/* serdev receive buffer */
+	char buf[9];
+	int buf_idx;
+
+	/* protect access to mhz19b_state */
+	struct mutex lock;
+};
+
+/* ABC logig on/off */
+#define MHZ19B_ABC_LOGIC_CMD		0x79
+/* read CO2 concentration */
+#define MHZ19B_READ_CO2_CMD		0x86
+/* calibrate Zero Point */
+#define MHZ19B_ZERO_POINT_CMD		0x87
+/* calibrate Span Point */
+#define MHZ19B_SPAN_POINT_CMD		0x88
+/* set sensor detection range */
+#define MHZ19B_DETECTION_RANGE_CMD	0x99
+
+#define MHZ19B_CMD_SIZE 9
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
+static int mhz19b_serdev_cmd(struct iio_dev *indio_dev, int cmd, const char *str)
+{
+	int ret = 0;
+	struct serdev_device *serdev;
+	struct mhz19b_state *mhz19b;
+	struct device *dev;
+
+	mhz19b = iio_priv(indio_dev);
+	serdev = mhz19b->serdev;
+	dev = &indio_dev->dev;
+
+	/*
+	 * commands have following format:
+	 *
+	 * +------+------+-----+------+------+------+------+------+-------+
+	 * | 0xFF | 0x01 | cmd | arg0 | arg1 | 0x00 | 0x00 | 0x00 | cksum |
+	 * +------+------+-----+------+------+------+------+------+-------+
+	 */
+	uint8_t cmd_buf[MHZ19B_CMD_SIZE] = {
+		0xFF, 0x01, cmd,
+	};
+
+	switch (cmd) {
+	case MHZ19B_ABC_LOGIC_CMD:
+	{
+		bool enable;
+
+		ret = kstrtobool(str, &enable);
+		if (ret)
+			return ret;
+
+		cmd_buf[3] = enable ? 0xA0 : 0x00;
+		break;
+	}
+	case MHZ19B_SPAN_POINT_CMD:
+	{
+		uint16_t ppm;
+
+		ret = kstrtou16(str, 10, &ppm);
+		if (ret)
+			return ret;
+
+		/* at least 1000ppm */
+		if (ppm < 1000 || ppm > 5000) {
+			dev_dbg(&indio_dev->dev, "span point ppm should be 1000~5000");
+			return -EINVAL;
+		}
+
+		cmd_buf[3] = ppm / 256;
+		cmd_buf[4] = ppm % 256;
+		break;
+	}
+	case MHZ19B_DETECTION_RANGE_CMD:
+	{
+		uint16_t range;
+
+		ret = kstrtou16(str, 10, &range);
+		if (ret)
+			return ret;
+
+		/* Detection Range should be 2000 or 5000 */
+		if (!(range == 2000 || range == 5000)) {
+			dev_dbg(&indio_dev->dev, "detection range should be 2000 or 5000");
+			return -EINVAL;
+		}
+
+		cmd_buf[3] = range / 256;
+		cmd_buf[4] = range % 256;
+		break;
+	}
+	default:
+		break;
+	}
+	cmd_buf[MHZ19B_CMD_SIZE - 1] = mhz19b_get_checksum(cmd_buf);
+
+	scoped_guard(mutex, &mhz19b->lock) {
+		ret = serdev_device_write(serdev, cmd_buf, MHZ19B_CMD_SIZE, 0);
+		mhz19b->buf_idx = 0;
+
+		if (ret != MHZ19B_CMD_SIZE) {
+			dev_err(dev, "write err, %d bytes written", ret);
+			return -EINVAL;
+		}
+
+		switch (cmd) {
+		case MHZ19B_READ_CO2_CMD:
+			if (mhz19b->buf[MHZ19B_CMD_SIZE - 1] != mhz19b_get_checksum(mhz19b->buf)) {
+				dev_err(dev, "checksum err");
+				return -EINVAL;
+			}
+
+			ret = (mhz19b->buf[2] << 8) + mhz19b->buf[3];
+			break;
+		default:
+			/* no response commands. */
+			ret = 0;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int mhz19b_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+	int *val, int *val2, long mask)
+{
+	struct mhz19b_state *mhz19b;
+	int ret;
+
+	mhz19b = iio_priv(indio_dev);
+
+	ret = mhz19b_serdev_cmd(indio_dev, MHZ19B_READ_CO2_CMD, NULL);
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+	return IIO_VAL_INT;
+}
+
+static const struct iio_info mhz19b_info = {
+	.read_raw = mhz19b_read_raw,
+};
+
+static ssize_t mhz19b_zero_point_write(struct iio_dev *iiodev,
+	uintptr_t private, const struct iio_chan_spec *chan,
+	const char *buf, size_t len)
+{
+	int ret;
+
+	ret = mhz19b_serdev_cmd(iiodev, MHZ19B_ZERO_POINT_CMD, buf);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static ssize_t mhz19b_span_point_write(struct iio_dev *iiodev,
+	uintptr_t private, const struct iio_chan_spec *chan,
+	const char *buf, size_t len)
+{
+	int ret;
+
+	ret = mhz19b_serdev_cmd(iiodev, MHZ19B_SPAN_POINT_CMD, buf);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static ssize_t mhz19b_abc_logic_write(struct iio_dev *iiodev,
+	uintptr_t private, const struct iio_chan_spec *chan,
+	const char *buf, size_t len)
+{
+	int ret;
+
+	ret = mhz19b_serdev_cmd(iiodev, MHZ19B_ABC_LOGIC_CMD, buf);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+struct iio_chan_spec_ext_info mhz19b_co2_ext_info[] = {
+	{
+		.name = "zero_point",
+		.write = mhz19b_zero_point_write,
+	},
+	{
+		.name = "span_point",
+		.write = mhz19b_span_point_write,
+	},
+	{
+		.name = "abc_logic",
+		.write = mhz19b_abc_logic_write,
+	},
+	{}
+};
+
+static const struct iio_chan_spec mhz19b_channels[] = {
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_CO2,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+
+		.ext_info = mhz19b_co2_ext_info,
+	},
+};
+
+static int mhz19b_core_probe(struct device *dev)
+{
+	int ret;
+
+	struct serdev_device *serdev;
+	struct mhz19b_state *mhz19b;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct mhz19b_state));
+	if (indio_dev == NULL)
+		return ret;
+
+	dev_set_drvdata(dev, indio_dev);
+
+	mhz19b = iio_priv(indio_dev);
+
+	mhz19b->buf_idx = 0;
+	ret = devm_mutex_init(dev, &mhz19b->lock);
+	if (ret)
+		return ret;
+
+	serdev = container_of(dev, struct serdev_device, dev);
+
+	mhz19b->serdev = serdev;
+
+	indio_dev->name = "mh-z19b";
+	indio_dev->channels = mhz19b_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mhz19b_channels);
+	indio_dev->info = &mhz19b_info;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static size_t mhz19b_receive_buf(struct serdev_device *serdev, const u8 *data, size_t len)
+{
+	struct iio_dev *indio_dev;
+	struct mhz19b_state *mhz19b;
+
+	indio_dev = dev_get_drvdata(&serdev->dev);
+	mhz19b = iio_priv(indio_dev);
+
+	for (int i = 0; i < len; i++)
+		mhz19b->buf[mhz19b->buf_idx++] = data[i];
+
+	return len;
+}
+
+static void mhz19b_write_wakeup(struct serdev_device *serdev)
+{
+	struct iio_dev *indio_dev;
+
+	indio_dev = dev_get_drvdata(&serdev->dev);
+
+	dev_dbg(&indio_dev->dev, "mhz19b_write_wakeup");
+}
+
+static const struct serdev_device_ops mhz19b_ops = {
+	.receive_buf = mhz19b_receive_buf,
+	.write_wakeup = mhz19b_write_wakeup,
+};
+
+static int mhz19b_probe(struct serdev_device *serdev)
+{
+	int ret;
+
+	struct device *dev;
+
+	dev = &serdev->dev;
+	serdev_device_set_client_ops(serdev, &mhz19b_ops);
+
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret)
+		return ret;
+
+	serdev_device_set_baudrate(serdev, 9600);
+	serdev_device_set_flow_control(serdev, false);
+	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret < 0)
+		return ret;
+
+	ret = mhz19b_core_probe(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id mhz19b_of_match[] = {
+	{ .compatible = "winsen,mhz19b", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, mhz19b_of_match);
+
+static struct serdev_device_driver mhz19b_driver = {
+	.driver = {
+		.name = "mhz19b",
+		.of_match_table = mhz19b_of_match,
+	},
+	.probe = mhz19b_probe,
+};
+
+module_serdev_device_driver(mhz19b_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gyeyoung Baek");
+MODULE_DESCRIPTION("MH-Z19B CO2 sensor driver using serdev interface");
-- 
2.34.1


