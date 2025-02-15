Return-Path: <linux-iio+bounces-15549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1C3A36D58
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 11:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE271893401
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 10:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E01E1AD3E0;
	Sat, 15 Feb 2025 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGHK8eMW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5D1A9B3F;
	Sat, 15 Feb 2025 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739615552; cv=none; b=OIWtnnypKdbHnVEKypNTwXb7pMRVutJbJ6N/NiYUGSJK2IOuaEy3q7GYosYpzxyGv2IvJYi1Xl7QU0LyxbVCX9co2PjCeSyd0K+a79iCaE+jaLc9KD8KQItNxW/maEE556UMiiSI2U3xKwopBzK99L/tJ7KZb/i2XTR6H+D3w9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739615552; c=relaxed/simple;
	bh=LGVjYUkMQDOPthsr8tOTOWNoXQs6WjwfI7U95zx9NdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9b0o1P1YMdWoFrPs5kX60xvRBDakaK4Sd/Sy6n28ZpL/JYNdsnj2DgYIGfnFrxkuukgKyeBq1ExAdxRukdXd5l4BSQv/lhywWL/5eqoIkErKv8Shh+6lt7voJ2/kf/aflRE+2wdfMOIeEeVnVrngN74cAwkFQUUQO9iJOs8Rjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGHK8eMW; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30613802a59so29400201fa.0;
        Sat, 15 Feb 2025 02:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739615548; x=1740220348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CjkOeOXdka2nPTzOO+UtlyLZFLmBueiASwPgEOvlGo=;
        b=iGHK8eMWbp65Y94j/TSZuhJTKofFqG+62+zm0hQTiIdFqRFWnHMIfiNsOiam83UN16
         7YJtycf0phuqkRc4UwBPsr6/uCvTZsMW5lIX0gVIbIo/ZWJbYJp7PgBzgX/QZojlDDsk
         UJPfhK13aPT546huPLhrudV07vpar1wbE5o+pLw7DQmNpjoMgEpE2FwyR2Q9Uf8f8boV
         6Mdl3Zl7m2PquZfk/2OyL53kts6TpNTuDUJbp4y6uBrK8fhWXlGQkbUFpGvzx7qqf6KH
         Y1E6j+aZNu2SWbYju9fkpxgtozOJeMTbcUmdn7xA3PPdwiGGUobQNDaiTL7Qoociznmp
         q5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739615548; x=1740220348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CjkOeOXdka2nPTzOO+UtlyLZFLmBueiASwPgEOvlGo=;
        b=SfRLU6Rkp1Dg9IHMky3q9m8AMzE/GxVsRId9au3oqhJjHTqdkORGMohva5h51aYcIl
         54YsaZe0j2xpET0GR4qmPcieV6faoCYl0CShouMatLYu4OE70rJtSFEm13Mo9cN1O5rZ
         m9upMl7yJC7ACYUZorJsHH4CILkSib5EfMXMz3zktXul5cN843fqqUtScEXXhjQdu1Ct
         IxGDlvSaSBuND8HHSD73P368t/JamYSG1OmVthHUgaD3URHPl29ilwTQKhDILI9HpTSz
         Cu+FA2oGZcVVcZ1quFClcWl2xQP6hF8Ay9dGJclFy+J3yqij3R9izppkBzp3HSwN8yum
         48KQ==
X-Forwarded-Encrypted: i=1; AJvYcCU73cO8OxpJQDiUKHsT8CP60izgHpaNR0Mx9JN8jRVgoSUGt/LIg8/so9bibfN55vFDqzncbWrZcNRKAcjM@vger.kernel.org, AJvYcCWLyD9GuGKMxcIoTRzpS/+6t2EbjKVmKblnKPEEP96MMPJlb9iG8f7QdH/kwscII8MKOmk/fEVgDQ8AmrY=@vger.kernel.org, AJvYcCXThZReK/DZ5KOOp5ZweJ5w8ZuQNjgTzhsn1SaZsaaMEd69B3yYZ/YDivJdc+wt0mBOFO4Qjs/fQKcJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLfPE6nWecDkq/uyqQsa5Z//27kmLDWelmeALwHqZc93jfNnV
	WC/fbSPkY5liUevtcGHVu4mpYFzZjHyonQWoVQrYt+VCHSJFP195
X-Gm-Gg: ASbGncvntjnLDW1LzaosCA38hCjjglQl+2eYvG+CCQXYDXSqBsu0qv6pL8SXFJHDTyg
	C7yYTn9gQK2lq5lE8DzkHTuRx6KZrW+4ipUKsr7cx4qWnaI0EiPy7RiNxVSDUNc56FwS/QuzMGK
	0MNALoG8nEfhBDHivXJHtIOvtE4bb3HmZSbDKa6K3wH2CNtZIOWtoA2/YL3jGhhIbb0FBCKghvJ
	ZzitzN0AmI7j73THuqjbimcR5RN0LK0dzI210wk41NtXjXce0oOHCQ4Coimr4BoinaSoQQIIzMc
	SzkCeTk=
X-Google-Smtp-Source: AGHT+IFB7eV3KMYrlSFxfQD7fjB+0YFkm+p91wBN5jmQB8fD+z8c9sV2RU/y8s1u7YvWj/slknRnvg==
X-Received: by 2002:a2e:bc0e:0:b0:309:1774:b279 with SMTP id 38308e7fff4ca-30927afe14fmr10780241fa.31.1739615547964;
        Sat, 15 Feb 2025 02:32:27 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309298dc5eesm2201571fa.95.2025.02.15.02.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 02:32:27 -0800 (PST)
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
Subject: [PATCH v2 2/3] iio: light: Add support for AL3000a illuminance sensor
Date: Sat, 15 Feb 2025 12:31:58 +0200
Message-ID: <20250215103159.106343-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215103159.106343-1-clamor95@gmail.com>
References: <20250215103159.106343-1-clamor95@gmail.com>
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
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/Kconfig   |  10 ++
 drivers/iio/light/Makefile  |   1 +
 drivers/iio/light/al3000a.c | 221 ++++++++++++++++++++++++++++++++++++
 3 files changed, 232 insertions(+)
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
index 000000000000..58d4336dd081
--- /dev/null
+++ b/drivers/iio/light/al3000a.c
@@ -0,0 +1,221 @@
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
+#include <linux/iio/sysfs.h>
+
+#define AL3000A_DRV_NAME		"al3000a"
+#define AL3000A_REG_SYSTEM		0x00
+#define AL3000A_REG_DATA		0x05
+
+#define AL3000A_CONFIG_ENABLE		0x00
+#define AL3000A_CONFIG_DISABLE		0x0b
+#define AL3000A_CONFIG_RESET		0x0f
+#define AL3000A_GAIN_MASK		GENMASK(5, 0)
+
+/*
+ * This are pre-calculated lux values based on possible output of sensor
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
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static int al3000a_set_pwr(struct al3000a_data *data, bool pwr)
+{
+	struct device *dev = regmap_get_device(data->regmap);
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
+	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, val);
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
+	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_RESET);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_ENABLE);
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
+	int ret, gain;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(data->regmap, AL3000A_REG_DATA, &gain);
+		if (ret < 0)
+			return ret;
+
+		*val = lux_table[gain & AL3000A_GAIN_MASK];
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info al3000a_info = {
+	.read_raw	= al3000a_read_raw,
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
+	indio_dev->name = AL3000A_DRV_NAME;
+	indio_dev->channels = al3000a_channels;
+	indio_dev->num_channels = ARRAY_SIZE(al3000a_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = al3000a_init(data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to init ALS\n");
+
+	ret = devm_add_action_or_reset(dev, al3000a_set_pwr_off, data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to add action\n");
+
+	return devm_iio_device_register(dev, indio_dev);
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


