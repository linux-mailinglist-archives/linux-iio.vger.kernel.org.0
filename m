Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0490C2D6901
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 21:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392420AbgLJUnF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Dec 2020 15:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgLJUnF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2020 15:43:05 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D5FC0613D6
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:42:24 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id f9so5234282pfc.11
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OC6QSm7+4W/GxFtfVZnRXmO+23W3Kn8aZ2OPLvK/OhU=;
        b=Fe7oFkJ2T0tLSA+eQiQV4kMfzoJg5rMebqLhoZKt1Vdxiz/0fyGqV20ML1CJE9m273
         IDsbdHdtPuw5n16cpx1TE72spPHBPdQ44nCXH0A31qEEUWy6uxDTB6En+xC//2r4UFMj
         kv2E9+N224/ulNWHyGIa+2CPWcXMhX6aBvFFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OC6QSm7+4W/GxFtfVZnRXmO+23W3Kn8aZ2OPLvK/OhU=;
        b=aIPKirKds6lnzRlln7ymvpLsJg2dux9v7POdK6UGa0r4FdO4lNL5vfUql0elQhqUS8
         GL/uPBpos34zy11yQ32MlsluADXvLW0nJusVjObSmaRqfNQyUiEhFa2RfFFIAARlk9OE
         Q4LScXVQ5e+B9RbGScwzwiP++p44LAVXmy7+zQUp+Joe+qFflao75dC4583CAw4Vi1Fi
         Y5coLpM5m5HZrtL6x3n2oPJ5TN8uDSR3GLtxCU0RgACWyepKq2+pN0+9LwjEq5HNpWHC
         IWy4D8njT4pjlmREjV2BRck4nzBH9T83kN3PbvaqXy1FcRCoxhDU+b980MP/ED0MUGU1
         v9Fw==
X-Gm-Message-State: AOAM531MPplghw5K4DSkSZXbp41NYZooBjAwAMayf+Ixj4giy/hj8N2M
        vLvjhO/3mccODaFit1m1x/l84A==
X-Google-Smtp-Source: ABdhPJz6rPwFX9DSey2lOpF3Ohuj+7MArg6N+y8WIvJAAAjuK8DAV4zoeqkhwFDUH4D4NegzbZdqDg==
X-Received: by 2002:a17:90b:3011:: with SMTP id hg17mr9592172pjb.22.1607632944429;
        Thu, 10 Dec 2020 12:42:24 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id f29sm7673431pfk.32.2020.12.10.12.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 12:42:23 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 2/7] iio: fix devm_iio_trigger_alloc with parent.cocci
Date:   Thu, 10 Dec 2020 12:42:06 -0800
Message-Id: <20201210204211.967018-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210204211.967018-1-gwendal@chromium.org>
References: <20201210204211.967018-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use cocci semantic patch:
@@
expression trigger, P, name;
@@
   trigger = devm_iio_trigger_alloc(P, ...);
   ...
-  trigger->dev.parent = P;

To remove trigger->dev.parent, since it is set by default.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/accel/adxl372.c            | 2 --
 drivers/iio/accel/bmc150-accel-core.c  | 1 -
 drivers/iio/accel/kxcjk-1013.c         | 2 --
 drivers/iio/accel/mma8452.c            | 1 -
 drivers/iio/accel/mxc4005.c            | 1 -
 drivers/iio/accel/stk8312.c            | 1 -
 drivers/iio/accel/stk8ba50.c           | 1 -
 drivers/iio/adc/ad7606.c               | 1 -
 drivers/iio/adc/ad7766.c               | 1 -
 drivers/iio/adc/ad7768-1.c             | 1 -
 drivers/iio/adc/max1027.c              | 1 -
 drivers/iio/chemical/ccs811.c          | 1 -
 drivers/iio/chemical/scd30_core.c      | 1 -
 drivers/iio/gyro/adxrs290.c            | 1 -
 drivers/iio/gyro/bmg160_core.c         | 2 --
 drivers/iio/gyro/fxas21002c_core.c     | 1 -
 drivers/iio/health/afe4403.c           | 1 -
 drivers/iio/health/afe4404.c           | 1 -
 drivers/iio/humidity/hts221_buffer.c   | 1 -
 drivers/iio/imu/kmx61.c                | 1 -
 drivers/iio/light/rpr0521.c            | 1 -
 drivers/iio/light/si1145.c             | 1 -
 drivers/iio/light/st_uvis25_core.c     | 1 -
 drivers/iio/light/vcnl4000.c           | 1 -
 drivers/iio/light/vcnl4035.c           | 1 -
 drivers/iio/magnetometer/bmc150_magn.c | 1 -
 drivers/iio/magnetometer/rm3100-core.c | 1 -
 drivers/iio/pressure/zpa2326.c         | 1 -
 drivers/iio/proximity/sx9310.c         | 1 -
 drivers/iio/proximity/sx932x.c         | 1 -
 drivers/iio/proximity/sx9500.c         | 1 -
 31 files changed, 34 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index aed2a4930fb0..f21b1f414271 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1237,8 +1237,6 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 
 		st->dready_trig->ops = &adxl372_trigger_ops;
 		st->peak_datardy_trig->ops = &adxl372_peak_data_trigger_ops;
-		st->dready_trig->dev.parent = dev;
-		st->peak_datardy_trig->dev.parent = dev;
 		iio_trigger_set_drvdata(st->dready_trig, indio_dev);
 		iio_trigger_set_drvdata(st->peak_datardy_trig, indio_dev);
 		ret = devm_iio_trigger_register(dev, st->dready_trig);
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 48435865fdaf..5c97232051df 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1362,7 +1362,6 @@ static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
 			break;
 		}
 
-		t->indio_trig->dev.parent = dev;
 		t->indio_trig->ops = &bmc150_accel_trigger_ops;
 		t->intr = bmc150_accel_triggers[i].intr;
 		t->data = data;
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 560a3373ff20..bb21488febe0 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1385,7 +1385,6 @@ static int kxcjk1013_probe(struct i2c_client *client,
 			goto err_poweroff;
 		}
 
-		data->dready_trig->dev.parent = &client->dev;
 		data->dready_trig->ops = &kxcjk1013_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 		indio_dev->trig = data->dready_trig;
@@ -1394,7 +1393,6 @@ static int kxcjk1013_probe(struct i2c_client *client,
 		if (ret)
 			goto err_poweroff;
 
-		data->motion_trig->dev.parent = &client->dev;
 		data->motion_trig->ops = &kxcjk1013_trigger_ops;
 		iio_trigger_set_drvdata(data->motion_trig, indio_dev);
 		ret = iio_trigger_register(data->motion_trig);
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index bf1d2c8afdbd..2cced843c9e2 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1465,7 +1465,6 @@ static int mma8452_trigger_setup(struct iio_dev *indio_dev)
 	if (!trig)
 		return -ENOMEM;
 
-	trig->dev.parent = &data->client->dev;
 	trig->ops = &mma8452_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
 
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index f877263dc6ef..0f037403181f 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -454,7 +454,6 @@ static int mxc4005_probe(struct i2c_client *client,
 			return ret;
 		}
 
-		data->dready_trig->dev.parent = &client->dev;
 		data->dready_trig->ops = &mxc4005_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 		indio_dev->trig = data->dready_trig;
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 3b59887a8581..7c3b70eb3f2d 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -558,7 +558,6 @@ static int stk8312_probe(struct i2c_client *client,
 			goto err_power_off;
 		}
 
-		data->dready_trig->dev.parent = &client->dev;
 		data->dready_trig->ops = &stk8312_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 		ret = iio_trigger_register(data->dready_trig);
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 3ead378b02c9..bf0368ce46e1 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -454,7 +454,6 @@ static int stk8ba50_probe(struct i2c_client *client,
 			goto err_power_off;
 		}
 
-		data->dready_trig->dev.parent = &client->dev;
 		data->dready_trig->ops = &stk8ba50_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 		ret = iio_trigger_register(data->dready_trig);
diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index ee7b108688b3..0af0bb4d5a7f 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -668,7 +668,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		return -ENOMEM;
 
 	st->trig->ops = &ad7606_trigger_ops;
-	st->trig->dev.parent = dev;
 	iio_trigger_set_drvdata(st->trig, indio_dev);
 	ret = devm_iio_trigger_register(dev, st->trig);
 	if (ret)
diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index b6b6765be7b4..829a3426f235 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -253,7 +253,6 @@ static int ad7766_probe(struct spi_device *spi)
 			return -ENOMEM;
 
 		ad7766->trig->ops = &ad7766_trigger_ops;
-		ad7766->trig->dev.parent = &spi->dev;
 		iio_trigger_set_drvdata(ad7766->trig, ad7766);
 
 		ret = devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 0e93b0766eb4..241c1e0f0cec 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -594,7 +594,6 @@ static int ad7768_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st->trig->ops = &ad7768_trigger_ops;
-	st->trig->dev.parent = &spi->dev;
 	iio_trigger_set_drvdata(st->trig, indio_dev);
 	ret = devm_iio_trigger_register(&spi->dev, st->trig);
 	if (ret)
diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index ca1dff3924ff..e3c8ec107722 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -473,7 +473,6 @@ static int max1027_probe(struct spi_device *spi)
 		}
 
 		st->trig->ops = &max1027_trigger_ops;
-		st->trig->dev.parent = &spi->dev;
 		iio_trigger_set_drvdata(st->trig, indio_dev);
 		ret = devm_iio_trigger_register(&indio_dev->dev,
 						st->trig);
diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 60dd87e96f5f..886e96496dbf 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -497,7 +497,6 @@ static int ccs811_probe(struct i2c_client *client,
 			goto err_poweroff;
 		}
 
-		data->drdy_trig->dev.parent = &client->dev;
 		data->drdy_trig->ops = &ccs811_trigger_ops;
 		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
 		indio_dev->trig = data->drdy_trig;
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 4d0d798c7cd3..261c277ac4a5 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -646,7 +646,6 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
 		return -ENOMEM;
 	}
 
-	trig->dev.parent = dev;
 	trig->ops = &scd30_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
 
diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index ca6fc234076e..15223fc09a46 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -595,7 +595,6 @@ static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
 	if (!st->dready_trig)
 		return -ENOMEM;
 
-	st->dready_trig->dev.parent = &st->spi->dev;
 	st->dready_trig->ops = &adxrs290_trigger_ops;
 	iio_trigger_set_drvdata(st->dready_trig, indio_dev);
 
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 8ddda96455fc..c964355e355b 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -1127,14 +1127,12 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		if (!data->motion_trig)
 			return -ENOMEM;
 
-		data->dready_trig->dev.parent = dev;
 		data->dready_trig->ops = &bmg160_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 		ret = iio_trigger_register(data->dready_trig);
 		if (ret)
 			return ret;
 
-		data->motion_trig->dev.parent = dev;
 		data->motion_trig->ops = &bmg160_trigger_ops;
 		iio_trigger_set_drvdata(data->motion_trig, indio_dev);
 		ret = iio_trigger_register(data->motion_trig);
diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index 129eead8febc..1a20c6b88e7d 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -875,7 +875,6 @@ static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
 	if (ret < 0)
 		return ret;
 
-	data->dready_trig->dev.parent = dev;
 	data->dready_trig->ops = &fxas21002c_trigger_ops;
 	iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 
diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 38734e4ce360..1fa8d51d5080 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -531,7 +531,6 @@ static int afe4403_probe(struct spi_device *spi)
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
 
 		afe->trig->ops = &afe4403_trigger_ops;
-		afe->trig->dev.parent = afe->dev;
 
 		ret = iio_trigger_register(afe->trig);
 		if (ret) {
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 61fe4932d81d..e1476bf79fe2 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -538,7 +538,6 @@ static int afe4404_probe(struct i2c_client *client,
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
 
 		afe->trig->ops = &afe4404_trigger_ops;
-		afe->trig->dev.parent = afe->dev;
 
 		ret = iio_trigger_register(afe->trig);
 		if (ret) {
diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 95e56917677f..f29692b9d2db 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -135,7 +135,6 @@ int hts221_allocate_trigger(struct iio_dev *iio_dev)
 
 	iio_trigger_set_drvdata(hw->trig, iio_dev);
 	hw->trig->ops = &hts221_trigger_ops;
-	hw->trig->dev.parent = hw->dev;
 	iio_dev->trig = iio_trigger_get(hw->trig);
 
 	return devm_iio_trigger_register(hw->dev, hw->trig);
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 61885e99d3fc..b804a58fe8fb 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1272,7 +1272,6 @@ static struct iio_trigger *kmx61_trigger_setup(struct kmx61_data *data,
 	if (!trig)
 		return ERR_PTR(-ENOMEM);
 
-	trig->dev.parent = &data->client->dev;
 	trig->ops = &kmx61_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
 
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index aa2972b04833..7fe14214bb69 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -981,7 +981,6 @@ static int rpr0521_probe(struct i2c_client *client,
 			ret = -ENOMEM;
 			goto err_pm_disable;
 		}
-		data->drdy_trigger0->dev.parent = indio_dev->dev.parent;
 		data->drdy_trigger0->ops = &rpr0521_trigger_ops;
 		indio_dev->available_scan_masks = rpr0521_available_scan_masks;
 		iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index b304801c7916..9b5c99823943 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1247,7 +1247,6 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
 	if (!trig)
 		return -ENOMEM;
 
-	trig->dev.parent = &client->dev;
 	trig->ops = &si1145_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
 
diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index a18a82e6bbf5..10fc5aa8675b 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -210,7 +210,6 @@ static int st_uvis25_allocate_trigger(struct iio_dev *iio_dev)
 		return -ENOMEM;
 
 	iio_trigger_set_drvdata(hw->trig, iio_dev);
-	hw->trig->dev.parent = dev;
 
 	return devm_iio_trigger_register(dev, hw->trig);
 }
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index fff4b36b8b58..2f7916f95689 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1002,7 +1002,6 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
 	if (!trigger)
 		return -ENOMEM;
 
-	trigger->dev.parent = &client->dev;
 	trigger->ops = &vcnl4010_trigger_ops;
 	iio_trigger_set_drvdata(trigger, indio_dev);
 
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 765c44adac57..e732d308ac4e 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -511,7 +511,6 @@ static int vcnl4035_probe_trigger(struct iio_dev *indio_dev)
 	if (!data->drdy_trigger0)
 		return -ENOMEM;
 
-	data->drdy_trigger0->dev.parent = indio_dev->dev.parent;
 	data->drdy_trigger0->ops = &vcnl4035_trigger_ops;
 	iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
 	ret = devm_iio_trigger_register(indio_dev->dev.parent,
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index fc6840f9c1fa..ebe13a5043d4 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -899,7 +899,6 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 			goto err_poweroff;
 		}
 
-		data->dready_trig->dev.parent = dev;
 		data->dready_trig->ops = &bmc150_magn_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 		ret = iio_trigger_register(data->dready_trig);
diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 7242897a05e9..dd811da9cb6d 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -579,7 +579,6 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 		if (!data->drdy_trig)
 			return -ENOMEM;
 
-		data->drdy_trig->dev.parent = dev;
 		ret = devm_iio_trigger_register(dev, data->drdy_trig);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 2cecbe0adb3f..70adff62cd20 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -1413,7 +1413,6 @@ static int zpa2326_init_managed_trigger(struct device          *parent,
 		return -ENOMEM;
 
 	/* Basic setup. */
-	trigger->dev.parent = parent;
 	trigger->ops = &zpa2326_trigger_ops;
 
 	private->trigger = trigger;
diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index ee1b4ff05a37..46947776da09 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1452,7 +1452,6 @@ static int sx9310_probe(struct i2c_client *client)
 		if (!data->trig)
 			return -ENOMEM;
 
-		data->trig->dev.parent = dev;
 		data->trig->ops = &sx9310_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
 
diff --git a/drivers/iio/proximity/sx932x.c b/drivers/iio/proximity/sx932x.c
index 26503348ce85..95ad49e627c6 100644
--- a/drivers/iio/proximity/sx932x.c
+++ b/drivers/iio/proximity/sx932x.c
@@ -1336,7 +1336,6 @@ static int sx932x_probe(struct i2c_client *client,
 		if (!data->trig)
 			return -ENOMEM;
 
-		data->trig->dev.parent = &client->dev;
 		data->trig->ops = &sx932x_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
 
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index acb821cbad46..bb42aa5d596e 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -950,7 +950,6 @@ static int sx9500_probe(struct i2c_client *client,
 		if (!data->trig)
 			return -ENOMEM;
 
-		data->trig->dev.parent = &client->dev;
 		data->trig->ops = &sx9500_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
 
-- 
2.29.2.576.ga3fc446d84-goog

