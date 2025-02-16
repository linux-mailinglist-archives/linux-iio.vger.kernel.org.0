Return-Path: <linux-iio+bounces-15584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13822A375B6
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383073A14A5
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDC519D886;
	Sun, 16 Feb 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rrh+K+HL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D59819C54C;
	Sun, 16 Feb 2025 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723268; cv=none; b=LJS8aP05zjiCI/fAvA50LfPMZjxHWiLfBFGy6h3Bg5DmgwkucOaRMDitNeSH4iZct2EBa3twVuT2247NbLNkSGq0hU+ZwDTquzgCPMW+Aninjn1nhpbYnj05M2MahRg7ua78hMsv6DqzhY6nRn8JJn+kPLDxcbKGY6hJVVJdOjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723268; c=relaxed/simple;
	bh=SqRuN4nPpK1Jrs2Ur/NfN9E0ibl/CtmVE2MTYRKQZfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyrWnmdLHrrkOHZv3hxzpcibNe8NgPACnDemS0MFhUyKWuLTBTfSbuqCs1QZedAkwh5i6ph+5pt6am6Rw8c76KWpmJLN0TUQwvugurUOGye2WF1VcoPOxm3+1mRHWB4i+NCMDSfxj0hD8JX0g9DFVTsO1c1LD4Z1KkL0biCeLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rrh+K+HL; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5452e6f2999so2330350e87.3;
        Sun, 16 Feb 2025 08:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739723264; x=1740328064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoKBID6eSvgle5yFrCRKBBd0f5CeSDfOXm5LCgLPXGA=;
        b=Rrh+K+HL9jxt2oW2Q/FAYGa4VGI6e1pEDEKCUwsEXpR6KmBCJovQyfa6SIVf/nzYrD
         kDqn/Twho6KI/Ez2qmNR9FGPRLw6hYIU7V8iIzsYwOA/IBe7YSvssa47c5wPPaPnm/ky
         ZgUegGartITmNADhYC5SjPYHVcuW7XexZJHiybrN59E812KmvmKvFCMw49UzuUQfbPwd
         /QFE+FHvRYLH2cSM9Riq+O5mLtnbcuXjvcDwTpcKOUzyojD86PDrEKlrnk9rFV0EgKPH
         X6o8uq+eHuNhi3gKiN2/xwsVbbNd96l62P78hmtHGjjzf4bWDOwLbv+j4SFTzI5ypmaj
         fYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739723264; x=1740328064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoKBID6eSvgle5yFrCRKBBd0f5CeSDfOXm5LCgLPXGA=;
        b=DskcGw+errBHP+HV73bdaz1EXbjNtScCyvvsfgQ0IoxCGj5HF76vq3Fm7S+cfDgkLp
         5k/kuw/tA5zSzQc+jsUQM+Nf9lCNFElYPNtDB/1tXvPZo6cTRqmX7xTUadkoSp6vv7e4
         jmeAyvBtKy+u8zyas5dPwG/2iC2Ii7YfairqVbC1x/lQEdcZs4FB+8C4r5kObUvnewMr
         Nb2Ce+3NyY5d0ubZW9mXxpJFjYABxQJmMJd+u6Eu9OX9dzsk2Yi4QKnFw35KL1ZCwrCe
         Dcdm6jMpi4OfMvyy89NL8XsQyIuZX4ox1y1MVcFwHNPm4lVSwMvpA7kNDoQ9FyZp/JWA
         Yd6g==
X-Forwarded-Encrypted: i=1; AJvYcCUV80d5coh7PiQRHK4kJn8SPYndoekNlfVF7dJVy0Lmn9e++H5K80qhh8zVPGjDy34pKQtvSazx1TWAUtI=@vger.kernel.org, AJvYcCUWTQYUdLFfJqiDx+WoNednZzJh3Zy8+xMyFLklwSQWpzUt9npjiKP+q8KLwk4n/XkrCodS26+KGC9SttrI@vger.kernel.org, AJvYcCV9UqUDT5dHyl2aBDz6h6fa7wXj2tqXYRIvVpIxecv8VHHUGxgrKRRCExXUDyzPCHlwPRF1BVHKGmv2@vger.kernel.org
X-Gm-Message-State: AOJu0YzGzW4SKVFiS9d6Ruu7D9Dc2EGBXDlj3Ssctvvrl31yA/SFKJR0
	YEw+EmTq/0KcdDDSzT5H3BIAPDLCPtKgO9ZZ1egNcnL0NkwsyVjPGuVUXQ==
X-Gm-Gg: ASbGncsb165NMohMPSd84UEXlkSk79eqdda+sRx0Cl7AFdmx/HhPKJDpYH4tJnSKdHd
	u71WEmthb9wxamIlmbkXfhrYHNH1U4poEn6CNLIFfxWNkbqguu7r/DKP7EazQfRs7h8kcOp2UTQ
	sF/WZdTUFc14vomattsu0bqgTpqlKjK902a9FRNpR2xuH5D/nNL+dun5PaqQAs3zD/ChdR9lP0V
	kwsl8Rt3cxWMot5UdG/a4Og5A9XLFl/1+prwsA+lxalMS15hIfgZOKr8N0x64VgeFtIeipr68wx
	TF5tYA==
X-Google-Smtp-Source: AGHT+IEiUD8yT8spipQblR6kTffgJtIc0e9Z/UlYzPUEBONj0OXbJILF819skZhF9j8ElyyiWKQunA==
X-Received: by 2002:a05:6512:3dab:b0:545:114a:5618 with SMTP id 2adb3069b0e04-5452fe263eamr2139330e87.7.1739723263815;
        Sun, 16 Feb 2025 08:27:43 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5456468c28csm481835e87.122.2025.02.16.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:27:43 -0800 (PST)
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
Subject: [PATCH v3 2/3] iio: light: Add support for AL3000a illuminance sensor
Date: Sun, 16 Feb 2025 18:27:20 +0200
Message-ID: <20250216162721.124834-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216162721.124834-1-clamor95@gmail.com>
References: <20250216162721.124834-1-clamor95@gmail.com>
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
 drivers/iio/light/al3000a.c | 223 ++++++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+)
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
index 000000000000..bc7fd122b218
--- /dev/null
+++ b/drivers/iio/light/al3000a.c
@@ -0,0 +1,223 @@
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
+	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_ENABLE);
+	if (ret) {
+		dev_err(dev, "failed to write system register\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void al3000a_set_pwr_off(void *_data)
+{
+	struct al3000a_data *data = _data;
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_DISABLE);
+	if (ret) {
+		dev_err(dev, "failed to write system register\n");
+		return;
+	}
+
+	ret = regulator_disable(data->vdd_supply);
+	if (ret) {
+		dev_err(dev, "failed to disable vdd power supply\n");
+		return;
+	}
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
+	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_ENABLE);
+	if (ret)
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
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = regmap_read(data->regmap, AL3000A_REG_DATA, &gain);
+		if (ret < 0)
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
+	{"al3000a", },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, al3010_id);
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


