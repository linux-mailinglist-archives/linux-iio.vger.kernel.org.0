Return-Path: <linux-iio+bounces-12971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5121F9E0CD6
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 21:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5426B3CC28
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18171DE3C0;
	Mon,  2 Dec 2024 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb4KHrce"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997A1DE882;
	Mon,  2 Dec 2024 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167430; cv=none; b=WSs/MPXrZc+HaO60fXML1JPjODA++YulpB0+D5enALEOEZ8PvPa4AjzNEeTtDXmipr8LJVYy5QDzhBW6DcRT28rSEgzPhj1EFpw42aM6lvtgCcIe2/db+xv+6JT7iInHY1I7fyOwkg67Q9gv0DCOHSImUSEIjNWMZ3l9+jfUsw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167430; c=relaxed/simple;
	bh=bY/vG50WctqTDmTpVFD7dslkumbhjAiWmYZ0wXQJnEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1T2ubXrLaZZPjRWTa62nQHJ1OK6q4yMBaYnatnlWajUgd17wiJLW7aUYZpY7o/Qnq5lPt3D+vF4ozS4IGj8IQb8kM0TRlHSSe6iN2Iu/c3408ZJmfMppd+y9PN+TdRniKp6jEQHHMOFDIYezO7bSmOOEcA90HNG2nfpVcnv4MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cb4KHrce; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e2880606so2863855f8f.3;
        Mon, 02 Dec 2024 11:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733167427; x=1733772227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laYRgFy7BwtjSJ4ddK5TZ+HdOeiOWp/2L5sL/4prUhk=;
        b=Cb4KHrceSdafL8F8C95Tu2+TwQtSwMGqScVNUzyR4rRnwlatkPGMDrRj8Dt7BhXgdR
         2PCom6ggo4ct408zK0SHUBGETJd4vt1y0xKgXRSt1Bum1Gl7Tw+vjBKPBiNGru4yndT0
         cRljIF9gjzuewm0Qrkq2hdaQhZQm/PBWjNg07JLCS3Q8NgjdaeU997hBNOE1OCBUJXMs
         qeXtzL0FUaaEE7r5EPHSeqXs8w/+5LkYRUMQrIkNwPju2n41LxgkMDjGzxcw1zh9zz4N
         SvOBK2M43eb3WqaGm9HcF6KbWwcyPvjxb2CsBEXmuzpxnzvWWIJeLTRk0w/1J4vexwES
         J2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167427; x=1733772227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laYRgFy7BwtjSJ4ddK5TZ+HdOeiOWp/2L5sL/4prUhk=;
        b=Mh3MOwO76m2y2AXRYqkLKJPTlhqoQJLkqkTE2Zexko3t4WGr+9AaSEuj2LsmV2VG3N
         bNEMDoaLcJxXCJGxhNcbML42ZCA8JEDYxAT4rOHVOHlqNEHWTiQE02j6Y5mBnN+0mxrw
         1o4dD1bjPIKlxiuLjLT7MOL3cfK9CaMQmP++wNMkbtoaa5Jct971l2kw68R7zZMBywCB
         GkY8G5ahO4l1ejaykMUBs2DlhArCSDgSDVWc8NhMxtvHna9WxPUVQViv1N7AujdvL6xu
         MwKk2Q7elPW2I7VB7sxz23KPCHs3LxV39zAHNDgB1hpjcEFPEgvfNxVnSUR/dR765EyM
         EbVw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Q6mHes5F/t5mHRfhuJaYNDuPmeHHY3KQgtaJgEywJKNVDDEH3B4qik1X7ZJl8If/M512GMzbHaUt@vger.kernel.org, AJvYcCWfelvlcs83i9/1U2MQO4IBg5vmzlImNrVAfbqtcR1SVDK1EskpbaWMKEAgAbBc/O37zQZzFnYQsZhk@vger.kernel.org, AJvYcCXbozq0m3uJRV04jA+McjiaBh9VGhxskTWLmNAXnsNZ+fHdcZC10fI+ghoHAy9J1a7lgsVs4Q5KLWeZYg2k@vger.kernel.org
X-Gm-Message-State: AOJu0YxigEpSIX2IzWDG9bJgxGG7BXyWuU78mbmyhXrYhXRQkWEiPFiD
	vuTQvFDRYzp4pydz0GdA5j18GhsnZG1C0MU+gyq0ee2uXjvKPOWd
X-Gm-Gg: ASbGncuhIxDZbkfwpUiKwZERBzRfA60Eu3SeK+ehGhdg8PAcuI/xr15Zl39GlNDIsLF
	B8CredhjStj/W+A6lXn3r3eAXA3rnwtOWTOF6Cx8zvi1DoVuNEJEx7tc2pHk5wySvsuzBnOHCk1
	69LQibjcIT7NdFxyGpZ6FifE3cKx836zwC3CZXIwk/36GiFtdqP61SFvRWvADr9FOSaZFn3WVfh
	rh6+mT+ga0gLqlf4nXUyYulxRPFn7MBult97PGaTCneWr/F3+BZ3fNLR5xyNow=
X-Google-Smtp-Source: AGHT+IHyM3Jh4m2wvzkhhpLMW3hCPU12pVl9WUsQNg/aQ6BQhxzMtjFbmnHJIc23Rzouhb865LYcaw==
X-Received: by 2002:a05:6000:1a87:b0:385:f6f4:f8e with SMTP id ffacd0b85a97d-385f6f4143dmr4174921f8f.50.1733167427015;
        Mon, 02 Dec 2024 11:23:47 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:ea8a:93ec:a066:eb25])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385faec0c9dsm832609f8f.20.2024.12.02.11.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:23:46 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] iio: chemical: bme680: add power management
Date: Mon,  2 Dec 2024 20:23:41 +0100
Message-ID: <20241202192341.33187-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202192341.33187-1-vassilisamir@gmail.com>
References: <20241202192341.33187-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add runtime power management to the device.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |   2 +
 drivers/iio/chemical/bme680_core.c | 114 +++++++++++++++++++++++++++--
 drivers/iio/chemical/bme680_i2c.c  |   1 +
 drivers/iio/chemical/bme680_spi.c  |   1 +
 4 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 00ab89b3138b..7d86ed8b02e6 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -2,6 +2,7 @@
 #ifndef BME680_H_
 #define BME680_H_
 
+#include <linux/pm.h>
 #include <linux/regmap.h>
 
 #define BME680_REG_CHIP_ID			0xD0
@@ -80,6 +81,7 @@
 #define BME680_CALIB_RANGE_3_LEN               5
 
 extern const struct regmap_config bme680_regmap_config;
+extern const struct dev_pm_ops bme680_dev_pm_ops;
 
 int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		      const char *name);
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index bcf84c0a1a59..f5f22a83ad5b 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -14,6 +14,8 @@
 #include <linux/device.h>
 #include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -820,9 +822,9 @@ static int bme680_read_gas(struct bme680_data *data, int *comp_gas_res)
 	return 0;
 }
 
-static int bme680_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2, long mask)
+static int __bme680_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
 {
 	struct bme680_data *data = iio_priv(indio_dev);
 	int chan_val, ret;
@@ -935,14 +937,33 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int bme680_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct bme680_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = __bme680_read_raw(indio_dev, chan, val, val2, mask);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
 static bool bme680_is_valid_oversampling(int rate)
 {
 	return (rate > 0 && rate <= 16 && is_power_of_2(rate));
 }
 
-static int bme680_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
+static int __bme680_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
 {
 	struct bme680_data *data = iio_priv(indio_dev);
 
@@ -987,6 +1008,25 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int bme680_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct bme680_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = __bme680_write_raw(indio_dev, chan, val, val2, mask);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
 static const char bme680_oversampling_ratio_show[] = "1 2 4 8 16";
 
 static IIO_CONST_ATTR(oversampling_ratio_available,
@@ -1087,6 +1127,34 @@ static irqreturn_t bme680_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int bme680_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct bme680_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int bme680_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct bme680_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops bme680_buffer_setup_ops = {
+	.preenable = bme680_buffer_preenable,
+	.postdisable = bme680_buffer_postdisable,
+};
+
 int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		      const char *name)
 {
@@ -1160,15 +1228,47 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      bme680_trigger_handler,
-					      NULL);
+					      &bme680_buffer_setup_ops);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "iio triggered buffer setup failed\n");
 
+	/* Enable runtime PM */
+	pm_runtime_set_autosuspend_delay(dev, BME680_STARTUP_TIME_US);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(bme680_core_probe, IIO_BME680);
 
+static int bme680_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bme680_data *data = iio_priv(indio_dev);
+
+	return bme680_set_mode(data, BME680_MODE_SLEEP);
+}
+
+static int bme680_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bme680_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = bme680_chip_config(data);
+	if (ret)
+		return ret;
+
+	return bme680_gas_config(data);
+}
+
+EXPORT_RUNTIME_DEV_PM_OPS(bme680_dev_pm_ops, bme680_runtime_suspend,
+			  bme680_runtime_resume, NULL);
+
 MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
 MODULE_DESCRIPTION("Bosch BME680 Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index 7c4224d75955..9998d7fa3e98 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -51,6 +51,7 @@ static struct i2c_driver bme680_i2c_driver = {
 	.driver = {
 		.name			= "bme680_i2c",
 		.of_match_table		= bme680_of_i2c_match,
+		.pm = pm_ptr(&bme680_dev_pm_ops),
 	},
 	.probe = bme680_i2c_probe,
 	.id_table = bme680_i2c_id,
diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index 7c54bd17d4b0..43d59544d903 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -154,6 +154,7 @@ static struct spi_driver bme680_spi_driver = {
 	.driver = {
 		.name			= "bme680_spi",
 		.of_match_table		= bme680_of_spi_match,
+		.pm = pm_ptr(&bme680_dev_pm_ops),
 	},
 	.probe = bme680_spi_probe,
 	.id_table = bme680_spi_id,
-- 
2.43.0


