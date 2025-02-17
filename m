Return-Path: <linux-iio+bounces-15670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC0EA38568
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C95E3AB5F3
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F692222A9;
	Mon, 17 Feb 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFXCa5HE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B8D220694;
	Mon, 17 Feb 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801042; cv=none; b=eZQP1vczjQskimFrQf8lgNpZA3HWiJ1fofEWytrlaLtsaFpNW2vB9L8kRJDxYlEuw7BXmT/V61vegsbH4TXwDtwUELUb1Nx9ajUMchbjXCCoZRrIETm7W5mWZ9Jw3CPmsS4q7u/IajVp5IBTXV1LOwZ1BFtZqEi0SwY8qSN6Tnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801042; c=relaxed/simple;
	bh=0ksHcrW0a0bN4zVys9dW2VNKEzLAsD3gnsX/7JJYWOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8sKWE5GfvtwaLPqAhj6COM+gOPdLj+gGWyFKFsueAFYO/ZLpOD9EzmhJSZIZF4kjwVeMzyEAXGHe4mlBV81L5YkbwVOMEVCJXHM6CJUecx1ud8hYK3Sf0ljrlZbukrgiFaR8nx7YwoC0j3dU+GEto+kRDZC/SYDP5yuCDJaeZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFXCa5HE; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30613802a6bso44782511fa.1;
        Mon, 17 Feb 2025 06:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739801039; x=1740405839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX8jM8WpYEYuwJc6UeDNjBzyk4FPMWODOu8Be3Xd/zE=;
        b=NFXCa5HEmFJDatu5wfRs2E7zt9QK0tt9VDdnvvxjXVUZ2f+36qKwq2f2OxedYxInRN
         4uB01wbUYNF5vqCUffj8L/zVN7R69zhjx2FKDc1TgrRxkQePcSonndeR+ZrqT9bNrOVc
         vVJJ9AwPiEvOI/zf4v1HIpjySjD5Ddi/mYabD4YoiJgEz7ey5ldKWEWPjBCCptN2W2hS
         7psqq7GsPdCZ5CAFcXtyD8hPxL+aZdhLFRdisrTWu0eZiYL2Hc5OnB53v0iRCfoUx6wr
         yDehVjLEISN9XA65dImdK4CFmBf/NZk6LbyXyzVnKNosYEfgDSNRp3xxkEikscx0l6vX
         tZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801039; x=1740405839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KX8jM8WpYEYuwJc6UeDNjBzyk4FPMWODOu8Be3Xd/zE=;
        b=BifHWS4qshE9PRq1R5YEeE0E2y0I3bAxkWBt/WlM+l0z37kJ5MpDbqH77sGyW+3j1Y
         oQ7N9kJ98rkNkNXu8cdNomjfKSAWoE0Y91AAxDMemtsIB898DCykuGC7VFS5o32EmQ7q
         yocffqp13ILvvGAyJvcvgtkEXJY6VV6oR8BQRtt1WF2Cp7mqOmvwfHJ+47hLs64ujKzE
         +cq15rRmT5MuE1XqHn9C5C1YLF9HRngGV+D+ahlKdQCvfx5jSGdhu5WegU4fmrYtiS8B
         TWgG2VDjhDuiQfOAcMCJsFtPYivQK7jIv2CJNvFfqYvtbRQ0EnlT0nfqSDDJyU5o0H5b
         JLNg==
X-Forwarded-Encrypted: i=1; AJvYcCV1IwjHrMEDi1dM/HGdYWWLlWy3RovETtPa0mOyPJK9f+OheAvACCEvC7n8OYTs486LNEKPX6SRL4Q8@vger.kernel.org, AJvYcCVtnEEBMaCYAuKOUcUiOC8nwwClUitcA3GoxgQZMDgghCJg3JJ0t5+NiUEzbTNdU58+E5aRYVryUrS9d+g=@vger.kernel.org, AJvYcCWixEZZX5/MDMhl4/iPaWSoT9YtdZKtjd3nWt/icIM0/fFotPA2433UiKQNMvYZZJ3BJd4GXBVYZHR9ZEi5@vger.kernel.org
X-Gm-Message-State: AOJu0YxtW3PuzA/SqA+2sKVchcRRxy2hUbB46C07PTmYqwfhIUwVdTtb
	kyyN71Iwj7RSWX6DldPKdr31rTdw3Fvdg2X//myvJyig1YwC2t8J
X-Gm-Gg: ASbGncsfDqLJyjB6TEoeRt3l05ZIlgNz1iG8T943V4hrL+RpwZb94B7VxoRLwuWL+bZ
	KAuwJ/eotGebJSbKkjBP+PASfPa/WtPYnARLMiKyLicBj0YPmLRb3m8rdtJMEhiPVj3gt5kDYAj
	IctN1Nln7F0rPfGWLlOQzmJpszxMpCixssoAyamwu/DMOkKamzcIotSWtbkurKdaMwoyKyfhNfq
	yKw+DQgcdg2Yh3lKwNq75KdsYFuTBv/4qz7khr7UfR+Dyj3R6/8ZEFkMYONLBVBy/9IMwRfZC/h
	J6QaUeE=
X-Google-Smtp-Source: AGHT+IE1gPZOfiNmPx2rqLvCeSc+6aAmoI3jR/JfErlWOCLFwzwyEG7lUoP090ORw4AyKLC4I85Eqw==
X-Received: by 2002:a2e:a302:0:b0:304:d8e7:7ea1 with SMTP id 38308e7fff4ca-30927ad5151mr25273941fa.23.1739801038556;
        Mon, 17 Feb 2025 06:03:58 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309306d5f48sm8919601fa.57.2025.02.17.06.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:03:57 -0800 (PST)
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
Subject: [PATCH v4 2/3] iio: light: Add support for AL3000a illuminance sensor
Date: Mon, 17 Feb 2025 16:03:35 +0200
Message-ID: <20250217140336.107476-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217140336.107476-1-clamor95@gmail.com>
References: <20250217140336.107476-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AL3000a is a simple I2C-based ambient light sensor, which is
closely related to AL3010 and AL3320a, but has significantly
different way of processing data generated by the sensor.

Tested-by: Robert Eckelmann <longnoserob@gmail.com>
Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/Kconfig   |  10 ++
 drivers/iio/light/Makefile  |   1 +
 drivers/iio/light/al3000a.c | 209 ++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 drivers/iio/light/al3000a.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 29ffa8491927..37f83e1d8893 100644
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
index f14a37442712..03f10786273a 100644
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
index 000000000000..e2fbb1270040
--- /dev/null
+++ b/drivers/iio/light/al3000a.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+
+#define AL3000A_REG_SYSTEM		0x00
+#define AL3000A_REG_DATA		0x05
+
+#define AL3000A_CONFIG_ENABLE		0x00
+#define AL3000A_CONFIG_DISABLE		0x0b
+#define AL3000A_CONFIG_RESET		0x0f
+#define AL3000A_GAIN_MASK		GENMASK(5, 0)
+
+/*
+ * These are pre-calculated lux values based on possible output of sensor
+ * (range 0x00 - 0x3F)
+ */
+static const u32 lux_table[] = {
+	1, 1, 1, 2, 2, 2, 3, 4,					/* 0 - 7 */
+	4, 5, 6, 7, 9, 11, 13, 16,				/* 8 - 15 */
+	19, 22, 27, 32, 39, 46, 56, 67,				/* 16 - 23 */
+	80, 96, 116, 139, 167, 200, 240, 289,			/* 24 - 31 */
+	347, 416, 499, 600, 720, 864, 1037, 1245,		/* 32 - 39 */
+	1495, 1795, 2155, 2587, 3105, 3728, 4475, 5373,		/* 40 - 47 */
+	6450, 7743, 9296, 11160, 13397, 16084, 19309, 23180,	/* 48 - 55 */
+	27828, 33408, 40107, 48148, 57803, 69393, 83306, 100000 /* 56 - 63 */
+};
+
+static const struct regmap_config al3000a_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AL3000A_REG_DATA,
+};
+
+struct al3000a_data {
+	struct regmap *regmap;
+	struct regulator *vdd_supply;
+};
+
+static const struct iio_chan_spec al3000a_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+};
+
+static int al3000a_set_pwr_on(struct al3000a_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = regulator_enable(data->vdd_supply);
+	if (ret) {
+		dev_err(dev, "failed to enable vdd power supply\n");
+		return ret;
+	}
+
+	return regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_ENABLE);
+}
+
+static void al3000a_set_pwr_off(void *_data)
+{
+	struct al3000a_data *data = _data;
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_DISABLE);
+	if (ret)
+		dev_err(dev, "failed to write system register\n");
+
+	ret = regulator_disable(data->vdd_supply);
+	if (ret)
+		dev_err(dev, "failed to disable vdd power supply\n");
+}
+
+static int al3000a_init(struct al3000a_data *data)
+{
+	int ret;
+
+	ret = al3000a_set_pwr_on(data);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_RESET);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_ENABLE);
+}
+
+static int al3000a_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct al3000a_data *data = iio_priv(indio_dev);
+	int ret, gain;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = regmap_read(data->regmap, AL3000A_REG_DATA, &gain);
+		if (ret)
+			return ret;
+
+		*val = lux_table[gain & AL3000A_GAIN_MASK];
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info al3000a_info = {
+	.read_raw = al3000a_read_raw,
+};
+
+static int al3000a_probe(struct i2c_client *client)
+{
+	struct al3000a_data *data;
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+
+	data->regmap = devm_regmap_init_i2c(client, &al3000a_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "cannot allocate regmap\n");
+
+	data->vdd_supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(data->vdd_supply))
+		return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
+				     "failed to get vdd regulator\n");
+
+	indio_dev->info = &al3000a_info;
+	indio_dev->name = "al3000a";
+	indio_dev->channels = al3000a_channels;
+	indio_dev->num_channels = ARRAY_SIZE(al3000a_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = al3000a_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init ALS\n");
+
+	ret = devm_add_action_or_reset(dev, al3000a_set_pwr_off, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add action\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int al3000a_suspend(struct device *dev)
+{
+	struct al3000a_data *data = iio_priv(dev_get_drvdata(dev));
+
+	al3000a_set_pwr_off(data);
+	return 0;
+}
+
+static int al3000a_resume(struct device *dev)
+{
+	struct al3000a_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return al3000a_set_pwr_on(data);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(al3000a_pm_ops, al3000a_suspend, al3000a_resume);
+
+static const struct i2c_device_id al3000a_id[] = {
+	{ "al3000a" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, al3000a_id);
+
+static const struct of_device_id al3000a_of_match[] = {
+	{ .compatible = "dynaimage,al3000a" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, al3000a_of_match);
+
+static struct i2c_driver al3000a_driver = {
+	.driver = {
+		.name = "al3000a",
+		.of_match_table = al3000a_of_match,
+		.pm = pm_sleep_ptr(&al3000a_pm_ops),
+	},
+	.probe = al3000a_probe,
+	.id_table = al3000a_id,
+};
+module_i2c_driver(al3000a_driver);
+
+MODULE_AUTHOR("Svyatolsav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("al3000a Ambient Light Sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


