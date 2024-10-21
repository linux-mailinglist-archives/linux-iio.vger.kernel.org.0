Return-Path: <linux-iio+bounces-10905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2359D9A9062
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA9B1F218EF
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835A1FF7A9;
	Mon, 21 Oct 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtNGBkUk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1CB1FF60F;
	Mon, 21 Oct 2024 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540430; cv=none; b=CY75RzZWvoZgffRgoeF1EU2LX73BRRHZDiQYrzMQ9QlN4Lyj+/NOf3RjO4KvYdTG59zCSbxDP1id0UnNBnriklaZWrYm/Z2qoDzSl5zQ8wK9Jm+6xuHdAfhLCrWe8Q8vEMh73r3lKUD5dG3ttrURjqNMQ9SFzxD3Zydec1xUp0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540430; c=relaxed/simple;
	bh=ir/Bq8Lb5t5AQjSoKh6DEHHLB/egS69QJTdjSonWAMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1WWLaHob4eiQGdBWCUwpgsMLxjqJd5SN9kH67p+QEPNlG58+PTw6SCZPdp90MFn8BvO0e8dsEtFlVqLkKH8Yx3ig+F36+Z8EJq9BjVRNmORnxcmTGWBDK8Yyf+PT64N1G6wKzL8sfQgtuolZM3TetCsHDine+5SirwDjqUMb5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtNGBkUk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so4962945a12.3;
        Mon, 21 Oct 2024 12:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540427; x=1730145227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uZsh6bS907gxcHV3Ix/1vvyLEzvTd1yKdYjYRuiPt4=;
        b=YtNGBkUkVodjjEYtcQf50Vz7k907dTVMYStC/dqDR2vxXLcJDKJkzDehDFlSaOtIpW
         jNAcnVr4ymp0YKzEUGUGXgcFTY6R2v5ZEWNNdGK9GNnR2NWMvaTe9pc8DYXQFwAJ36yJ
         p/XUhT7h2gEp8ZTxKjSJU0eW8lBZoQukeTY3QxLt2uxrHlj1rayDtSc3eypAOjASpBcD
         oQAQSF8emXCLLWf9m68xeaNGYwnzMXih20wII4oYJOh0RcX9Bh1yuao5GYTDUqdWPKiT
         OjQfZcPFBh9WLRcx3bBKTomJZ/0RUV1/fK0e4nQBuixkmmg2lmoOtCcPnOSeI6IToc8r
         lrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540427; x=1730145227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uZsh6bS907gxcHV3Ix/1vvyLEzvTd1yKdYjYRuiPt4=;
        b=eY+1Y2NAfWCsVCejLBz9QgmWBYcnsh/KkkZ+BPxy4zy+yU0A2OyONky5hsPMM9T1nW
         fQiC0yNTKYh4C9OawqffMTfg3pe4R5jkxQK4Z91aOGq4qHsSQuFdZnbY+9OwXD7WmHQO
         TlmbYqO5+pts0YsV9fmP8EqPmE5T7mWQFGoSJAXxAscFnYw1IL8pQ4TLbWFxnaURSSDs
         68c+dMA6sHRgUGWp+Cbn+mNXrf7gR1DQj+bI5gEwXn72kVNsww29qwR2GCOPjsXHp1/L
         qW9GihtCdz3nlYvhZpzyyRAinJqTk+OytulxBlhoX4M0qE5ZydB1+MlmzMzrmwnlYAy2
         vVJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgO6KJPOz00d/VQ2m9f9+fSciV2oKWcsYIvCVzy3iCpsz6atxnojx5LqriactQO4Xm38PR01svVynCmwcs@vger.kernel.org, AJvYcCVym8RLd+Sy9GZEU30L8ntRir42d6H1MCBtoArGiG/XG68crJ3C1q/32DTTQaGIza4e1fksBw9sVsSE@vger.kernel.org, AJvYcCX5Lq+W/niPkoarEjUsQEPMfbfz6WBRpAnjZ77fkj4cuhF3eKs5/xjj1isIuO2v7NHFiswVPlkBUXQS@vger.kernel.org
X-Gm-Message-State: AOJu0YzyJUevhFoIH40X9ZxbexlavhtJ2qX08gM9WE0EDukt1au2FsG7
	QhuDqLJv2XGhlwAKwUhwheDBou4Pr0BczpLsGFaKWDMJUZ1wZ0H3
X-Google-Smtp-Source: AGHT+IH7Y1XsktRICQK0ugPMuzy6DYxdiopCFaD26zm8aWrwnm4IuC31cQcFO0QYcwOk2i0AOCpD/A==
X-Received: by 2002:a05:6402:440c:b0:5ca:db8:8cd with SMTP id 4fb4d7f45d1cf-5ca0db80a5fmr10977051a12.20.1729540427076;
        Mon, 21 Oct 2024 12:53:47 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:9cf6:f1e5:ce2b:ea6b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b12dsm2338702a12.77.2024.10.21.12.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:45 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/13] iio: chemical: bme680: add power management
Date: Mon, 21 Oct 2024 21:53:16 +0200
Message-ID: <20241021195316.58911-14-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021195316.58911-1-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add runtime power management to the device. To facilitate this, add also
a struct dev* inside the bme680_data structure to have the device
accesible from the data structure.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |   2 +
 drivers/iio/chemical/bme680_core.c | 126 +++++++++++++++++++++++++++--
 2 files changed, 121 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index e5d82a6d5b59..74e97e35e35a 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -2,6 +2,7 @@
 #ifndef BME680_H_
 #define BME680_H_
 
+#include <linux/pm.h>
 #include <linux/regmap.h>
 
 #define BME680_REG_CHIP_ID			0xD0
@@ -82,6 +83,7 @@
 #define BME680_CALIB_RANGE_3_LEN               5
 
 extern const struct regmap_config bme680_regmap_config;
+extern const struct dev_pm_ops bme680_dev_pm_ops;
 
 int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		      const char *name);
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 2d9d20f203aa..803aa4f14b37 100644
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
 
@@ -823,9 +825,9 @@ static int bme680_read_gas(struct bme680_data *data, int *comp_gas_res)
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
@@ -1091,6 +1125,39 @@ static irqreturn_t bme680_trigger_handler(int irq, void *p)
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
+static void bme680_pm_disable(void *data)
+{
+	struct device *dev = data;
+
+	pm_runtime_get_sync(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_disable(dev);
+}
+
 int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		      const char *name)
 {
@@ -1164,15 +1231,60 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      bme680_trigger_handler,
-					      NULL);
+					      &bme680_buffer_setup_ops);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "iio triggered buffer setup failed\n");
 
+	/* Enable runtime PM */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_autosuspend_delay(dev, BME680_STARTUP_TIME_US * 100);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_put(dev);
+
+	ret = devm_add_action_or_reset(dev, bme680_pm_disable, dev);
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
+	return regulator_bulk_disable(BME680_NUM_SUPPLIES, data->supplies);
+}
+
+static int bme680_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bme680_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = regulator_bulk_enable(BME680_NUM_SUPPLIES, data->supplies);
+	if (ret)
+		return ret;
+
+	fsleep(BME680_STARTUP_TIME_US);
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
-- 
2.43.0


