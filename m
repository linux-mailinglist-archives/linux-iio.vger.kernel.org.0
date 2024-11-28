Return-Path: <linux-iio+bounces-12793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301FA9DBC88
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 20:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7A8164815
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B801C32E4;
	Thu, 28 Nov 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dcw+s2W3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015841C1F09;
	Thu, 28 Nov 2024 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822383; cv=none; b=jmh8FHaQ0m4euKYaFmpLkaOlyNFZYKlnXA1rTyORDxajMH8WPoRNYv/dRp48X459O7HDl/Mn5nShxvTCiNQDCW0PH+PC+39JqvUECu0ku41qY7n6ldlVr0E5Vkd6wXrx/LETWtwFmwjy05p9z5T3Vec/EVjZqczlSmPz3Qm74PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822383; c=relaxed/simple;
	bh=/m9HeDXiP/oB9/XvTvogLY7ZIwfwYb5+QuxqDX5TU/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6sRVRmpStDllXZnvAlP04bAe8FUiVwFAqiVTCAvupdnZ7l9Stfk6Z7tsOzZWMlxKeEZRHiUM4FF9AQxhTQC0260xq0C/56cYHnjCG2FR3Y3qYGBUsm0nJ2qqYYmNvfmFY5WlnP0Oa6kHWD44MgNMRTSjJ2V8wx1cL0rI8gbf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dcw+s2W3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso6800575e9.2;
        Thu, 28 Nov 2024 11:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732822380; x=1733427180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAJrfEjJg33vVGYrhY1CVICVyJ/+01G/75xDcBakREo=;
        b=Dcw+s2W3ghEWOmLjhbcA4MDsAKHKDi+AIs9VWqCAsN6E/ESTIJLZ7oNWYY3VhVczOV
         ECJxeQSYemzjzOce10oweR+Qj8yiHYo5+WF36AHdsrEHX+aogUfgOoKzXBYkh6OQ8FXX
         872LeCjtbdReh7cPiKLdrW+HMLKlpkOAmCW6/KcZQHNtbDy+3C3+kibyhyTqhfperhNf
         BDtkiwnKxcuuaDB5j7n07xnpgBg7AfAviTMb2lR+tUL7I7QwWyB8KrW2Rfkf7dwJUifN
         hj+GVPhmEuJpB8cgBlVawMcqD7AXfKZ917iq4/WZcAOa3/0DQfVBP42EQrD4jRgLPz55
         GJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732822380; x=1733427180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAJrfEjJg33vVGYrhY1CVICVyJ/+01G/75xDcBakREo=;
        b=rD/KNAJPtZDhZStQVLd49bOVnlL/kt8uD1JVxiUGFeujLuiNTv97htaGodNnpEqutS
         h0BoP5j0i0OjHWmUhReZq0noeji0kvxe4pnYrj0hNePtJBUAQndGMmdrW08iw0hQ4Hes
         hyVd0JFh7ZPjv0nUc0Wf/1ezMk7IdxnMM6p5qs+JYKnPgZYC1VTQ4SVqM9r+v/1PchgX
         V628q1odDn7gk8MRSeqWO1NhCS/OCBLpxIiqwkTmOXhmNn3BwtB+axnGrEONz1ulbE88
         vQqgPQBl/nWyWg/tHYoiCusj7oHhLNmXAhEh5h1GxeL5xuymwkxz1q0aF+bdhfchC0MB
         YJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvUqqo/NSHBQtOJIu8ujQy/M/Tuv7yMjbdhzZZ8SwPVGb9Lbwor6FrqgI6RpX/SaMWOf6zhDFjhjTj@vger.kernel.org, AJvYcCWpLBmSnroglacTyP865KgwwDlK6rNjUpuwe9/dBKknMV2l2zobVC1U4VAF/a+y8Hjw33IzxmlXqO5iiIu+@vger.kernel.org, AJvYcCXdRZh2W6iRVxPtXm+PQxMS78bTNgI3XwrLdq8W+jyfHnmZ7zX4Ntn0FiC+u9OayNwkqhAaPdl18vtF@vger.kernel.org
X-Gm-Message-State: AOJu0YwXZI3AcOWT2pz5jNfsEUz+t7oetJFTylo58ztJRY0EHFp5yh4m
	DtpigoZXj1WBDB2UrnEWBxYWJF3cZf/PrQnlG/3Q3jPCJGkdvjLO
X-Gm-Gg: ASbGncsgWJvGmq6x97zKnkgEOOYEkb3PUpQIDLcJWaDrBlsa8EHL7RBRt8zTx474dS1
	A4vzvxPgdvaoIXRiO80S0Vm2vWndL1oM6B+78UTeOPVBzQamj2ynUPKznDq5kQpRBQvyMSWi5Z9
	7K5LejUZwe3qGp7oRuO2JINDi9sU+uiMr+S5yNuLF8P9N+eIhOYP2BxMebVMXCh3K1TLydBDaIi
	w1UkqB2NIJCfnr3K017yHFvUUjEKzi5H2xJQ4QIDC9/d1vtSDBrlApK/ar4V7I=
X-Google-Smtp-Source: AGHT+IGDnOOPuGuYzWM9ViiWDOjr9dB+6Uyu6arbTRdE2B1cf8VrLdo+XAEgOxKIlKQnHuV+1D1Xmg==
X-Received: by 2002:a05:600c:3b16:b0:434:a4fe:cd6d with SMTP id 5b1f17b1804b1-434a9dc02c5mr79969465e9.12.1732822380287;
        Thu, 28 Nov 2024 11:33:00 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:a8c6:c7bb:87d7:66dd])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434b0dbe40csm30557855e9.10.2024.11.28.11.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 11:32:59 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] iio: chemical: bme680: add power management
Date: Thu, 28 Nov 2024 20:32:46 +0100
Message-ID: <20241128193246.24572-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128193246.24572-1-vassilisamir@gmail.com>
References: <20241128193246.24572-1-vassilisamir@gmail.com>
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
 drivers/iio/chemical/bme680_core.c | 104 +++++++++++++++++++++++++++--
 drivers/iio/chemical/bme680_i2c.c  |   1 +
 drivers/iio/chemical/bme680_spi.c  |   1 +
 4 files changed, 101 insertions(+), 7 deletions(-)

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
index 186e0a6cc2d7..b7a1896a2f11 100644
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
 
@@ -822,9 +824,9 @@ static int bme680_read_gas(struct bme680_data *data, int *comp_gas_res)
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
@@ -937,14 +939,30 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
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
+	pm_runtime_get_sync(dev);
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
 
@@ -989,6 +1007,22 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
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
+	pm_runtime_get_sync(dev);
+	ret = __bme680_write_raw(indio_dev, chan, val, val2, mask);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
 static const char bme680_oversampling_ratio_show[] = "1 2 4 8 16";
 
 static IIO_CONST_ATTR(oversampling_ratio_available,
@@ -1089,6 +1123,30 @@ static irqreturn_t bme680_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int bme680_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct bme680_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+
+	pm_runtime_get_sync(dev);
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
@@ -1162,15 +1220,47 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
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


