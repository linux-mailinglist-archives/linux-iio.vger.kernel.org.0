Return-Path: <linux-iio+bounces-18384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72328A948C8
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 20:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715DF3A92B6
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9773020D4F2;
	Sun, 20 Apr 2025 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXNJ4Jap"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C321E98FE;
	Sun, 20 Apr 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745172645; cv=none; b=oO94tXbWRdUEQt3YtospmPVSiPXEeDp5MPHlnyg14HjvKDbIDTd1Bj/KUoZkAuwcJCvdG/xus/xZRKtHr83io4y2viBpA7iA3pLHRXPKEXMwWD+t/tyIxNrEkgonB8x7qTO/SGBxUxkwmNEjJ/oyD3+7J+Fq7krnzmH4KbeHsFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745172645; c=relaxed/simple;
	bh=nKdWDfDOLpx6/KqzJ1067AOw6lvPTBpfp4oQS3K6wS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GG4WENQLi5X0U9eDAa26nlNVw+NjY6VNgtzVS/EkpSQhDhNYF2S+ElUiBj+BWJHSGMCzbyYG5zp3Ns80yr0fAFLXn/TXp9X8TMZZDjGUABGGToKc62LXZdA4cl4WIGh43kFIQjxU62uPAQRFuxSAOmlBl7siUSYdamxm/Q0u1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXNJ4Jap; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so3054827b3a.2;
        Sun, 20 Apr 2025 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745172643; x=1745777443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEh32BOg8QZ7XfY1rHp1uROuEjUUZffESIP251WHwLU=;
        b=iXNJ4JapbaAtPbrh79UF4EoSlcWW/cyifyY7FlGWB0RpFzy/aStusFTnJEvGxPs7ut
         tlmjaClAhdINgsMrE7TCb2cgkXY0AOs3/MYwhkdkhvgy6ZwdkKzmWYgA9BJ6ACgw9fAY
         +WXI/fh35ogS6VuSqV8S4wzlTjLEAKXTlk5h4VFG7HXejWU8Q22197DU0+Ii66mMHupY
         mKkSQGs1RO9T5p1Jm8O8U2oJCD0jWBmCjW1kO8i8qDMFQvqbThHdX9pNc0imy/wLjoIS
         AUnncNJ7W0rpASD56KIx20HUt86iCuE52iqYkK7jd8mLbnBs1YFnfXQlMaRaDeBcLP/y
         rHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745172643; x=1745777443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEh32BOg8QZ7XfY1rHp1uROuEjUUZffESIP251WHwLU=;
        b=O3sYmO495aQpVL3qfIBPSuw/3vYlicEwjiaq0Se5Xh2uuRXyvpTP0SVGrzRaJ7b344
         N19qxR5CTm8O7AygfsootgHcdQ/U+PRjNRidfavvjaQp2f3PcQ3m3ws3CtDsn3J4pAjk
         dy7WZ0JJZwk366UggF9iJ3/AbONSFbeyZvK20E94uCRHpYT0RHEeRzuKHciglSWwKfdg
         yprL52MrDLe6pyT/U3f4cpsVlCrR7dtxKuJRGiCrRdWtQINoTlr6EIAhM0G45fZG/e/g
         XwHHRq/95583bvUSx3kOzdgTgKZXDeOSDK/jiYCHu1j6cFMmoWmBP8qlAP5ZPoVjXUvd
         dSmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV21MfiM7KOMaCJQhOsoc7MPBl8Q2uG6PBE6wvez1Aj8puKuPLyfr7ZYNCmDJ9Rp7fMtaWKIh1lB0ay@vger.kernel.org, AJvYcCVuz2xD3nAXYBJKbqk4rKjast4AE0nnQAuG4L7eWbhOwL6z9bZlqZfUTf+oKYZ/IjdKtQFvkx/rxtvR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmg3OBNqblmnFYLgO9jSwn4C39Nx/yQV6U5PVCx4pcooM8mgL3
	boYoVLuAl2a21KnzTBfdtkTY3fJRBoxzT+YE3Fs3jc0N1cbsKorF
X-Gm-Gg: ASbGncsYm5fs70IHlb2hUD6glrd4BeP5xGsFrt967q8IJn1VpFpaw3Zf9zJJV/8NBU1
	QAw3E8sXAoossxRWSwXCS8/aWXKC63IDdmqT78tPsZwQyvXB3P4eU8LDtYOs9qrmzI7ZhkKNdmC
	NQut+D+V5TN3Yz91DaWErS+6X0ADNRLpY+7AojDjsE/Oa1GpfhVoXPdhm5m71ky1QhYgVfJURzP
	TZDnoI44oqyaLFFth8xAiDJXwR76yhA6yZMT2sa9dTvfqcuZUF+rl9r/AoUmB84l57whOZvcty1
	YSPtMwe2gzfdqH0BO3i8jp1J/RM07fqHpLfrKnBhChMOaTM=
X-Google-Smtp-Source: AGHT+IE1nLSW99O1IxVatLz+ZIHXCMR3nAaZpEYmlxPkKlgw7h9Q5pKrpq4QeE9c8KWDGB3yqDlLRw==
X-Received: by 2002:a05:6a00:32ce:b0:736:3954:d78c with SMTP id d2e1a72fcca58-73dc14a11b9mr11599504b3a.6.1745172642759;
        Sun, 20 Apr 2025 11:10:42 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73dbf8c05b0sm5009347b3a.35.2025.04.20.11.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 11:10:42 -0700 (PDT)
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
Subject: [PATCH v4 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
Date: Mon, 21 Apr 2025 03:10:14 +0900
Message-Id: <20250420181015.492671-4-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250420181015.492671-1-gye976@gmail.com>
References: <20250420181015.492671-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for winsen MHZ19B CO2 sensor.

The datasheet is available at
Link: https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/chemical/Kconfig  |  10 ++
 drivers/iio/chemical/Makefile |   1 +
 drivers/iio/chemical/mhz19b.c | 307 ++++++++++++++++++++++++++++++++++
 3 files changed, 318 insertions(+)
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
index 000000000000..63db82124efa
--- /dev/null
+++ b/drivers/iio/chemical/mhz19b.c
@@ -0,0 +1,307 @@
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
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/serdev.h>
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
+		cmd_buf[3] = (arg) ? 0xA0 : 0;
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
+ *	(make sure the sensor has been worked under 400ppm for over 20 minutes.)
+ * echo [1000 1 5000] > calibration_forced_value : span point calibration
+ *	(make sure the sensor has been worked under a certain level co2 for over 20 minutes.)
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
+				"span point ppm should be 1000~5000");
+			return -EINVAL;
+		}
+
+		cmd = MHZ19B_SPAN_POINT_CMD;
+	} else
+		cmd = MHZ19B_ZERO_POINT_CMD;
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
+				  const u8 *data, size_t len)
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
+
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret)
+		return ret;
+
+	serdev_device_set_baudrate(serdev, 9600);
+
+	serdev_device_set_flow_control(serdev, false);
+
+	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret)
+		return ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return ret;
+	dev_set_drvdata(dev, indio_dev);
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


