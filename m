Return-Path: <linux-iio+bounces-17571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC10AA79B59
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 07:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CBC1706BE
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 05:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF3519E7F8;
	Thu,  3 Apr 2025 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSZgG3gF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5319CCEC;
	Thu,  3 Apr 2025 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658472; cv=none; b=jxMOxbUdZEsgmFhSpOcBBAM7B6lpqeMfI6zMvwK+uWmEbyaTqqgcTqAjP35DF0Ph4aq1rh2iJJGzKsTcU6hZA0DU6daM4V+4wEEEiIaVnyWy6KHi0/SqpYu0V7grppa+VdOm4AtS9GmjxciYEmBq6KDjzhbWWNB3pY5vDaLKddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658472; c=relaxed/simple;
	bh=WNIRl26+O5kxmjd0m6LZCxP0N0yO4ju9Ezqa36Iqo2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PKGd7I9Tq/DiBV/TZgMY7N9SCju19Fb6aJbxAa79H5pn0isG9uV9Sp7SuiZok4ee2aIadKb3lou8E/sf68aN/gQgQj+1x9knQDnQgxqvUNUuatMWB8i41iSgShebW5IGKkSxSZmACv8ESUaJgo6zjPAcpYpd+sIqhTJ1UBW2Zvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSZgG3gF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af980595952so352831a12.2;
        Wed, 02 Apr 2025 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743658469; x=1744263269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFq1wJF1n23kC7u4lYR6eyLevB5PSh5c/AAzXL0/UZg=;
        b=PSZgG3gF3veKjcSV3L5XjAXGtoc6G/jhevQr6ybbUtU+bZaZ2hAG2umj9h3N2+VnmL
         tkRIrQVY7lSaYMr0M8pj9vm70cIsCzCD0PE+EyIerP7ROziYjxUNmHZU/XqpaXImthx4
         wos6Lga7GF1jtvQdxQaLnj+ZAvFeI8/iX6LXunc+3ceEUYvbEFm+iHrpSDQCD++xZpqM
         1pS/AH/QWRZKq+x3zll6vYjdpXu9o2p7KmSOZYN1JGojLWE4U1Rhuh+C6ptTOL5VygkT
         /8+m/3kwCKGSN2cWJtR2IP29zgaA58SFneog8mAdIDNMgXG4+lWETX1T2IVwvDPIl+zc
         7j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743658469; x=1744263269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFq1wJF1n23kC7u4lYR6eyLevB5PSh5c/AAzXL0/UZg=;
        b=cCEZwC0H2bHv8xRcjFAtOUjoURqmA602s24Zem+dkImKxzafqGK0oOPFp3kl7IZZwi
         irtMZk9yIyvMEpfmYLQlnh3tHY7WNR3Dr4E8y2nQIs01SHSMnFMyw9kEbv/P34Qvq4uq
         X+t3a3MMHybBt2KHMTVMpebqudVkqMzWgmnE+el4/TFkQzo4/qbjRLB225B2l1GMvbmY
         u6NKx+nyOlQmX2Q9bHtxfY11xsJ3itH3f7mIDAE3TrbfJzaPeFP2rC+8iXr/1Gl37Nv5
         JJyshk1uZLf71iKIRWWcLOgCnZYBKEWurofqeKn6N1fH6i6J2eUWuAG/uuM9OqEUR9PZ
         RfCg==
X-Forwarded-Encrypted: i=1; AJvYcCVGVZSMhjf2ijt1V9ZNnHhL1AnfN2gVVePkC6BmapDV4P/oLdzjpxalWFJlLY/bGa6PlUh8jNtntNfj@vger.kernel.org, AJvYcCVYp1XrPnsN2DEUVuUcW0Hm66zbVVtzMZZtXlhPPhE5WfysJNid7GRb9jZLQUwUALmyl+J6qzM9Kfsi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8U18K0pvNV0N8h92JHcQEcMOexA+TyuDlqYqC+rcELQGWLaf3
	lQp5N7rV2fpiW9dqEqdqRLO7y72G6HGmE5xSt3OfixZyadVi6QI8
X-Gm-Gg: ASbGncu5QQbUNkVSt45Duow/ZOcQG159c60R7q1GKkA/OUv7yuuKHQokuuhR+16ZL0P
	YThi+5XvS90h9j47c3Sa3wxQWGlY6BIHsDku2CRN12+1w0kRZEbeByvMZx/vpneSn8Kjc/QzxWD
	TC6LnYSK7KSGIgOsLdNtS/p5j+nbCHfSpK2hoMRpErTgFdrMCBulrhiEoDrc+sQO3YA6ett1lb5
	A2klzoRfEt8gKrbBkwL7vY45ynMyAqcvH6lyZHPc9clh6mB7RvYQe/24jNlMlh9yolvVJ7STpfz
	JIw7hhmKefoHuhyeMKud/I8/nVo7UknirfY5Ov5QYWxgH/JnaejemW2m4Ifr
X-Google-Smtp-Source: AGHT+IFI3xqQ04DJCr4fgt2rkNczBgrRuMF+XjrYZsiEycCD9KwV5NY8qm74Z7rXWrRLuu0VvRLwNQ==
X-Received: by 2002:a17:903:2450:b0:215:acb3:3786 with SMTP id d9443c01a7336-2292f95da05mr276017305ad.19.1743658469355;
        Wed, 02 Apr 2025 22:34:29 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([61.108.38.194])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22978776601sm5537575ad.237.2025.04.02.22.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 22:34:29 -0700 (PDT)
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
Subject: [PATCH v1 4/5] iio: chemical: add support for winsen MHZ19B CO2 sensor
Date: Thu,  3 Apr 2025 14:32:24 +0900
Message-Id: <20250403053225.298308-5-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403053225.298308-1-gye976@gmail.com>
References: <20250403053225.298308-1-gye976@gmail.com>
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
 drivers/iio/chemical/mhz19b.c | 386 ++++++++++++++++++++++++++++++++++
 3 files changed, 397 insertions(+)
 create mode 100644 drivers/iio/chemical/mhz19b.c

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 330fe0af946f..bb4dfe3986f6 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -108,6 +108,16 @@ config IAQCORE
 	  iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
 	  sensors

+config MHZ19B
+	tristate "MHZ19B CO2 sensor"
+	depends on SERIAL_DEV_BUS
+	help
+	  Say Y here to build Serdev binterface support for the MHZ19B
+	  CO2 sensor.
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
index 000000000000..f8f06c01623f
--- /dev/null
+++ b/drivers/iio/chemical/mhz19b.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mh-z19b co2 sensor driver
+ *
+ * Copyright (c) 2025 Gyeyoung Baek <gye976@gmail.com>
+ *
+ * Datasheet:
+ * https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
+ *
+ * TODO:
+ *  - vin supply regulator
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
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+#include <linux/serdev.h>
+#include <linux/unaligned.h>
+
+struct mhz19b_state {
+	struct serdev_device *serdev;
+
+	/* TO DO, nothing for now.*/
+	struct regulator *vin_supply;
+
+	/* serdev receive buffer.
+	 * When data is received from the MH-Z19B,
+	 * the 'mhz19b_receive_buf' callback function is called and fills this buffer.
+	 */
+	char buf[9];
+	int buf_idx;
+
+	/* must wait the 'buf' is filled with 9 bytes.*/
+	struct completion buf_ready;
+
+	/* protect access to mhz19b_state */
+	struct mutex lock;
+};
+
+/*
+ * commands have following format:
+ *
+ * +------+------+-----+------+------+------+------+------+-------+
+ * | 0xFF | 0x01 | cmd | arg0 | arg1 | 0x00 | 0x00 | 0x00 | cksum |
+ * +------+------+-----+------+------+------+------+------+-------+
+ *
+ * The following commands are defined in the datasheet.
+ * https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
+ */
+#define MHZ19B_CMD_SIZE 9
+
+/* ABC logic in MHZ19B means auto calibration.
+ */
+#define MHZ19B_ABC_LOGIC_CMD		0x79
+#define MHZ19B_READ_CO2_CMD		0x86
+#define MHZ19B_ZERO_POINT_CMD		0x87
+#define MHZ19B_SPAN_POINT_CMD		0x88
+#define MHZ19B_DETECTION_RANGE_CMD	0x99
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
+	int ret = 0;
+	struct mhz19b_state *st = iio_priv(indio_dev);
+	struct serdev_device *serdev = st->serdev;
+	struct device *dev = &indio_dev->dev;
+
+	/* commands format is described above. */
+	uint8_t cmd_buf[MHZ19B_CMD_SIZE] = {
+		0xFF, 0x01, cmd,
+	};
+
+	switch (cmd) {
+	case MHZ19B_ABC_LOGIC_CMD: {
+		bool enable = *((bool *)arg);
+
+		cmd_buf[3] = enable ? 0xA0 : 0x00;
+		break;
+	} case MHZ19B_SPAN_POINT_CMD: {
+		uint16_t ppm = *((uint16_t *)arg);
+
+		put_unaligned_be16(ppm, &cmd_buf[3]);
+		break;
+	} case MHZ19B_DETECTION_RANGE_CMD: {
+		uint16_t range = *((uint16_t *)arg);
+
+		put_unaligned_be16(range, &cmd_buf[3]);
+		break;
+	} default:
+		break;
+	}
+	cmd_buf[MHZ19B_CMD_SIZE - 1] = mhz19b_get_checksum(cmd_buf);
+
+	scoped_guard(mutex, &st->lock) {
+		/* write buf to uart ctrl syncronously */
+		ret = serdev_device_write(serdev, cmd_buf, MHZ19B_CMD_SIZE, 0);
+		if (ret != MHZ19B_CMD_SIZE) {
+			dev_err(dev, "write err, %d bytes written", ret);
+			return -EINVAL;
+		}
+
+		switch (cmd) {
+		case MHZ19B_READ_CO2_CMD:
+			ret = wait_for_completion_interruptible_timeout(&st->buf_ready,
+				MHZ19B_SERDEV_TIMEOUT);
+			if (ret < 0)
+				return ret;
+			if (!ret)
+				return -ETIMEDOUT;
+
+			ret = mhz19b_get_checksum(st->buf);
+			if (st->buf[MHZ19B_CMD_SIZE - 1] != mhz19b_get_checksum(st->buf)) {
+				dev_err(dev, "checksum err");
+				return -EINVAL;
+			}
+
+			ret = get_unaligned_be16(&st->buf[2]);
+			return ret;
+		default:
+			/* no response commands. */
+			return 0;
+		}
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
+/* MHZ19B only supports writing configuration values. */
+
+static ssize_t calibration_auto_enable_store(struct device *dev,
+	struct device_attribute *attr,
+	const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	bool enable;
+
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
+/* write 0		: zero point calibration_auto_enable
+ *	(make sure the sensor had been worked under 400ppm for over 20 minutes.)
+ *
+ * write 1000-5000	: span point calibration:
+ *	(make sure the sensor had been worked under a certain level co2 for over 20 minutes.)
+ */
+static ssize_t calibration_forced_value_store(struct device *dev,
+	struct device_attribute *attr,
+	const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	uint16_t ppm;
+	int cmd;
+
+	int ret = kstrtou16(buf, 10, &ppm);
+
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
+static IIO_CONST_ATTR(calibration_forced_value_available,
+	"0 1000-5000");
+static IIO_DEVICE_ATTR_WO(calibration_forced_value, 0);
+
+/* MH-Z19B supports a measurement range adjustment feature.
+ * It can measure up to 2000 ppm or up to 5000 ppm.
+ */
+static ssize_t co2_range_store(struct device *dev,
+	struct device_attribute *attr,
+	const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	int ret;
+	uint16_t range;
+
+	ret = kstrtou16(buf, 10, &range);
+	if (ret)
+		return ret;
+
+	/* Detection Range should be 2000 or 5000 */
+	if (!(range == 2000 || range == 5000)) {
+		dev_dbg(&indio_dev->dev, "detection range should be 2000 or 5000");
+		return -EINVAL;
+	}
+
+
+	ret = mhz19b_serdev_cmd(indio_dev, MHZ19B_DETECTION_RANGE_CMD, &range);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+static IIO_CONST_ATTR(co2_range_available,
+	"2000 5000");
+static IIO_DEVICE_ATTR_WO(co2_range, 0);
+
+static struct attribute *mhz19b_attrs[] = {
+	&iio_const_attr_calibration_forced_value_available.dev_attr.attr,
+	&iio_const_attr_co2_range_available.dev_attr.attr,
+	&iio_dev_attr_calibration_auto_enable.dev_attr.attr,
+	&iio_dev_attr_calibration_forced_value.dev_attr.attr,
+	&iio_dev_attr_co2_range.dev_attr.attr,
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
+static size_t mhz19b_receive_buf(struct serdev_device *serdev, const u8 *data, size_t len)
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
+/* The 'serdev_device_write' function returns -EINVAL if the 'write_wakeup' member is NULL,
+ * so it must be mandatory.
+ */
+static void mhz19b_write_wakeup(struct serdev_device *serdev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
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
+	/* void type func, no return */
+	serdev_device_set_flow_control(serdev, false);
+
+	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret < 0)
+		return ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct mhz19b_state));
+	if (indio_dev == NULL)
+		return ret;
+	dev_set_drvdata(dev, indio_dev);
+
+	st = iio_priv(indio_dev);
+	st->serdev = serdev;
+
+	init_completion(&st->buf_ready);
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	/* TO DO:
+	 *  - vin supply
+	 */
+
+	indio_dev->name = "mh-z19b";
+	indio_dev->channels = mhz19b_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mhz19b_channels);
+	indio_dev->info = &mhz19b_info;
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return 0;
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
+MODULE_LICENSE("GPL v2");
--
2.34.1


