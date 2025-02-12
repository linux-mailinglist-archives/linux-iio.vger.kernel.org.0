Return-Path: <linux-iio+bounces-15412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E30A31F65
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF533A704B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4F01FF613;
	Wed, 12 Feb 2025 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aiur0MRy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39BD1FF1B8;
	Wed, 12 Feb 2025 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342865; cv=none; b=R6le5m1fcJl/BMlV4ZR5Lt4N5XE0k4+iLLNcl73Vh3KVcx/oSMWS/Rp/nfaGFgGErXaD8/ZFpooTwpvhOiC7qGBsPOnxvLMokbmW8mYPZLk8lVnz+NF4Obc/c87jzqM0GWjedK1tO+V8oKkmo1zL4GQBeJTD6WT639gH1suS3EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342865; c=relaxed/simple;
	bh=+8a2DFXRubLJL//0TcoNXgqtYrfeFWS4Uh25ORpIb3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zr3RTTortU/UOyQorX+ngSd7S89I68dOMKONDGjJpcIxC0UgLl/duiIUgmSWnPxNx8KIzw0yeDn0/PJBmpIaDv+8Njwz4P2McnqTIhBdxlRsa8kpWGlyZXS5LT/cqMOcdig+i4R7X+3AcEVLXmqRSh7EI4UbGuxQTJIJavy2kvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aiur0MRy; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-543e49a10f5so6715566e87.1;
        Tue, 11 Feb 2025 22:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739342861; x=1739947661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7qrE1fgcZB5EvEK2T6Qn/hI/Rdry03rsbNc9mfvuhE=;
        b=Aiur0MRyjw6lGXfZQUTmAnKBK3hYm0VwvekKpr040wQrq+6Dp6uIvMykRr+lI72ff2
         JUpjCkweKka6kfTuosqJSfQbhtokeGCJBU35AE8HUQ3cIg6Hmsj+o1XSc/CWz7QNg8po
         jIpsHvPucdEVPgAANU9uaDJFLBxODpHnNCRPDtW04V9UZ/wPjscww0QIb9sxeI+wWGRQ
         cIY9OFgOojgQMQHXltftqFBO7J3H3ajDRnEiWIp4HeFjSvpV/fYP3RaN1g5XyvtIZXtU
         VT8p4Rmbq994y7UNSErRmHZeO2yfjmHvyVjufy3B8aN2fzdmEUQYwGsMsHGW7pMNcuiQ
         8eJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739342861; x=1739947661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7qrE1fgcZB5EvEK2T6Qn/hI/Rdry03rsbNc9mfvuhE=;
        b=Vm5xAs1y/MSd6mSp6eU3lpfMI+53dq7tVm6fb8E4CTy5xmposYACviaaruRxBBkKS8
         bOcI1XZMN0jqIWyKfC3GAnfeBczaq39Bhjd+zyEhHGrgjr55UmFtc1Yk0aIzl4gEFdHI
         5WlVhwIotYVBrOm5uSl2xDVrEb+o12N2DsIq/wF6wq9VBlVX5kyZ1bUeCJMU0iqzLjQt
         dzUL4A4NFrn/gjoJg9JwAjFsrWbYZ2jt5wyAZQt221kNTUUbKEjHfWphH+JnMKPexdpw
         7GIAKQUVzK4gSXooiziN5FlAlkR245j6+/C90mv8CQAVM7CjBW4IilXOaC54waoZONCF
         btJA==
X-Forwarded-Encrypted: i=1; AJvYcCW8+8vMtYmvXlZHylaKedVn0Eq1pujVngoEccaOFlZoygGTEtvRvJ+dQz9h3CWoWedain0F4pDRJltEgOra@vger.kernel.org, AJvYcCWv5TygnWcgFduqFNKSTH34CMwv2PknN9S6k1gXVZaeSDC84BK/PaYwFdem9fGpD4fvszn1ztig8QGWw4U=@vger.kernel.org, AJvYcCXq8/URBKe0UncUVGxL1ni+ObHh3nAAmQRL1iknIZBqzMaQxOO0apdvtFqCS/Hqnn0OKgKGzKwTPgcu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80PTUq6KHZrA3rfSGrPIAQGPacnUXlKKSAhCCECRZF5Ot2FbD
	ltOckNiLgaoblxlLokvsgkLWbDtUHnDfty9dkrUdSeLkDF3v/JwTWOsn9w==
X-Gm-Gg: ASbGncsGqgLntE31O95/r1yMIjLNvhSId6SeMxV3+FQZpNEOtlMvS2RXUgSplT895BE
	ps9xD1T+Ie3+08TUf4M1M/NGBq+T6FvNUrIgzhUrNOaXZ5aNs+XOz3xdm6NMwO7SAiL9+szpTdL
	UuKg6QQQO0CLCKgLJ7/NdUqQhPBcpraJXCiJkxTKUF/ZjqpubQPOiK8izlIl9o74dpEVOnGjCcL
	vXX0TsjklEurdv+ahKK0sycqPMoC+ITkMdHkWrQT45BQz3t51+vY2F8pWZetaj3bv2QEPURdVxg
	9oDAFkk=
X-Google-Smtp-Source: AGHT+IG/S7EN4w/xlyGaCnuNNkoSsFonWAwS8gNX6hHWUPTfjDWiZ1KV5r5lN1Lxs7+5J2/N834F6g==
X-Received: by 2002:a05:6512:2209:b0:545:109b:a9d4 with SMTP id 2adb3069b0e04-5451816666bmr566672e87.43.1739342860904;
        Tue, 11 Feb 2025 22:47:40 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450e09e9dbsm748600e87.120.2025.02.11.22.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:47:40 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 2/3] iio: light: Add support for AL3000a illuminance sensor
Date: Wed, 12 Feb 2025 08:46:56 +0200
Message-ID: <20250212064657.5683-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212064657.5683-1-clamor95@gmail.com>
References: <20250212064657.5683-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AL3000a is a simple I2C-based ambient light sensor, which is
closely related to AL3010 and AL3320a, but has significantly
different hardware configuration.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/Kconfig   |  10 ++
 drivers/iio/light/Makefile  |   1 +
 drivers/iio/light/al3000a.c | 214 ++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 drivers/iio/light/al3000a.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index e34e551eef3e..142f7f7ef0ec 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -43,6 +43,16 @@ config ADUX1020
 	 To compile this driver as a module, choose M here: the
 	 module will be called adux1020.
 
+config AL3000A
+	tristate "AL3000a ambient light sensor"
+	depends on I2C
+	help
+	  Say Y here if you want to build a driver for the Dyna Image AL3000a
+	  ambient light sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called al3000a.
+
 config AL3010
 	tristate "AL3010 ambient light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 11a4041b918a..17030a4cc340 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_ACPI_ALS)		+= acpi-als.o
 obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
 obj-$(CONFIG_ADUX1020)		+= adux1020.o
+obj-$(CONFIG_AL3000A)		+= al3000a.o
 obj-$(CONFIG_AL3010)		+= al3010.o
 obj-$(CONFIG_AL3320A)		+= al3320a.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al3000a.c
new file mode 100644
index 000000000000..9e1f2ac6a933
--- /dev/null
+++ b/drivers/iio/light/al3000a.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AL3000a - Dyna Image Ambient Light Sensor
+ */
+
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define AL3000A_DRV_NAME		"al3000a"
+#define AL3000A_REG_SYSTEM		0x00
+#define AL3000A_REG_DATA		0x05
+
+#define AL3000A_CONFIG_ENABLE		0x00
+#define AL3000A_CONFIG_DISABLE		0x0b
+#define AL3000A_CONFIG_RESET		0x0f
+
+/*
+ * This are pre-calculated lux values based on possible output
+ * of sensor (range 0x00 - 0x3F)
+ */
+static const u32 lux_table[64] = {
+	1, 1, 1, 2, 2, 2, 3, 4, 4, 5, 6, 7, 9, 11, 13, 16,
+	19, 22, 27, 32, 39, 46, 56, 67, 80, 96, 116, 139,
+	167, 200, 240, 289, 347, 416, 499, 600, 720, 864,
+	1037, 1245, 1495, 1795, 2155, 2587, 3105, 3728,	4475,
+	5373, 6450, 7743, 9296, 11160, 13397, 16084, 19309,
+	23180, 27828, 33408, 40107, 48148, 57803, 69393,
+	83306, 100000
+};
+
+struct al3000a_data {
+	struct i2c_client *client;
+	struct regulator *vdd_supply;
+};
+
+static const struct iio_chan_spec al3000a_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	}
+};
+
+static int al3000a_set_pwr(struct al3000a_data *data, bool pwr)
+{
+	struct device *dev = &data->client->dev;
+	u8 val = pwr ? AL3000A_CONFIG_ENABLE : AL3000A_CONFIG_DISABLE;
+	int ret;
+
+	if (pwr) {
+		ret = regulator_enable(data->vdd_supply);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable vdd power supply\n");
+			return ret;
+		}
+	}
+
+	ret = i2c_smbus_write_byte_data(data->client, AL3000A_REG_SYSTEM, val);
+	if (ret < 0) {
+		dev_err(dev, "failed to write system register\n");
+		return ret;
+	}
+
+	if (!pwr) {
+		ret = regulator_disable(data->vdd_supply);
+		if (ret < 0) {
+			dev_err(dev, "failed to disable vdd power supply\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void al3000a_set_pwr_off(void *_data)
+{
+	struct al3000a_data *data = _data;
+
+	al3000a_set_pwr(data, false);
+}
+
+static int al3000a_init(struct al3000a_data *data)
+{
+	int ret;
+
+	ret = al3000a_set_pwr(data, true);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, AL3000A_REG_SYSTEM,
+					AL3000A_CONFIG_RESET);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, AL3000A_REG_SYSTEM,
+					AL3000A_CONFIG_ENABLE);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int al3000a_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct al3000a_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = i2c_smbus_read_byte_data(data->client,
+					       AL3000A_REG_DATA);
+		if (ret < 0)
+			return ret;
+
+		*val = lux_table[ret & 0x3F];
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1;
+
+		return IIO_VAL_INT;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info al3000a_info = {
+	.read_raw	= al3000a_read_raw,
+};
+
+static int al3000a_probe(struct i2c_client *client)
+{
+	struct al3000a_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_supply))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
+				     "failed to get vdd regulator\n");
+
+	indio_dev->info = &al3000a_info;
+	indio_dev->name = AL3000A_DRV_NAME;
+	indio_dev->channels = al3000a_channels;
+	indio_dev->num_channels = ARRAY_SIZE(al3000a_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = al3000a_init(data);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to init ALS\n");
+
+	ret = devm_add_action_or_reset(&client->dev, al3000a_set_pwr_off,
+				       data);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to add action\n");
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static int al3000a_suspend(struct device *dev)
+{
+	struct al3000a_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return al3000a_set_pwr(data, false);
+}
+
+static int al3000a_resume(struct device *dev)
+{
+	struct al3000a_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return al3000a_set_pwr(data, true);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(al3000a_pm_ops, al3000a_suspend, al3000a_resume);
+
+static const struct of_device_id al3000a_of_match[] = {
+	{ .compatible = "dynaimage,al3000a" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, al3000a_of_match);
+
+static struct i2c_driver al3000a_driver = {
+	.driver = {
+		.name = AL3000A_DRV_NAME,
+		.of_match_table = al3000a_of_match,
+		.pm = pm_sleep_ptr(&al3000a_pm_ops),
+	},
+	.probe = al3000a_probe,
+};
+module_i2c_driver(al3000a_driver);
+
+MODULE_AUTHOR("Svyatolsav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("al3000a Ambient Light Sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


