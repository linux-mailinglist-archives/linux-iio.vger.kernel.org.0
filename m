Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD67332F1B
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 20:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhCITgh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 14:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhCITg2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 14:36:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B34C06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 11:36:28 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t9so1418377pjl.5
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 11:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pge5VYtg+VvMl3nT1wvj9pXilaxvLvZYxGCzU4bb8Rs=;
        b=lijRWxtnQdLc+slDUO+utjjtvoW2jNStvn7NKj78zyKqYZ2P41W20apoLI1XqmzL5+
         fi1wAGm8EGbaMdD0lQuN6mu21x5QFiticfGVBHsCobOQ5bNLWEkfwiEPmhc81peX65Fp
         CjhTAO6hXvpn295CSdtHlmPO79CsLgcBYj8S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pge5VYtg+VvMl3nT1wvj9pXilaxvLvZYxGCzU4bb8Rs=;
        b=cJpEH3OJDGi+QMwrScSMk7rQfEzH/QaM2Uggc3FF1+kD03vT02ucRrWUDGyD4avyac
         qWfaqUhgNTZRp17ay7W4By3ZEM4odZibbwCY8OC9CVUl4qC47fwejyMtwokQsFctW+Dd
         JkpMOYNNXxqG1pW7uGh2kgtCiDOECMmy+7qnwGuLaaoFJRnFgpH7S0FfgzObDGUgARiY
         oTtf/o5oki5QdlScli7Az8T1q1J1uyrSpbN8bOtJEEuQlwUsqF+h8ok8eGMauhpKZndU
         HqS7zW+pYeQsBKoplVtQ55vIPhSHea50R3fjC7EhDCAZ72Bg1TXTuafyA0WbjkgpakZu
         GYXQ==
X-Gm-Message-State: AOAM533Fw330Qg7Omdb3D+68UzjwQQVKFUhNlG24PVRNSgcAFG+CxlGB
        CpabF7itBwUeHgo64RLVYcPiwQ==
X-Google-Smtp-Source: ABdhPJx/r935z2G6Wd3PBcuDfpU0+6wKC+AxFmLd3UXjSmPBw0IlOZ6rielgVL1KDnrbs9QfhWnM3w==
X-Received: by 2002:a17:903:184:b029:e5:ea3b:2e68 with SMTP id z4-20020a1709030184b02900e5ea3b2e68mr22764205plg.39.1615318587583;
        Tue, 09 Mar 2021 11:36:27 -0800 (PST)
Received: from localhost ([2620:15c:202:201:98f9:3cff:c504:d44b])
        by smtp.gmail.com with UTF8SMTPSA id v126sm14021725pfv.163.2021.03.09.11.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:36:27 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 2/8] iio: fix devm_iio_trigger_alloc with parent.cocci
Date:   Tue,  9 Mar 2021 11:36:14 -0800
Message-Id: <20210309193620.2176163-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210309193620.2176163-1-gwendal@chromium.org>
References: <20210309193620.2176163-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use cocci semantic patch:
@@
expression trigger, P;
@@
   trigger = devm_iio_trigger_alloc(P, ...);
   ...
-  trigger->dev.parent = P;

To remove trigger->dev.parent, since it is set by default.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v4.

Changes in v3:
Added a private driver (sx932x) by mistake, removed.

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
 drivers/iio/proximity/sx9500.c         | 1 -
 30 files changed, 33 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 8ba1453b8dbf4..9c9a896a872a0 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1236,8 +1236,6 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 
 		st->dready_trig->ops = &adxl372_trigger_ops;
 		st->peak_datardy_trig->ops = &adxl372_peak_data_trigger_ops;
-		st->dready_trig->dev.parent = dev;
-		st->peak_datardy_trig->dev.parent = dev;
 		iio_trigger_set_drvdata(st->dready_trig, indio_dev);
 		iio_trigger_set_drvdata(st->peak_datardy_trig, indio_dev);
 		ret = devm_iio_trigger_register(dev, st->dready_trig);
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 7e425ebcd7ea8..2d1b46746db77 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1472,7 +1472,6 @@ static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
 			break;
 		}
 
-		t->indio_trig->dev.parent = dev;
 		t->indio_trig->ops = &bmc150_accel_trigger_ops;
 		t->intr = bmc150_accel_triggers[i].intr;
 		t->data = data;
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 2fadafc860fd6..45c1faa6ea9d4 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1413,7 +1413,6 @@ static int kxcjk1013_probe(struct i2c_client *client,
 			goto err_poweroff;
 		}
 
-		data->dready_trig->dev.parent = &client->dev;
 		data->dready_trig->ops = &kxcjk1013_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 		indio_dev->trig = data->dready_trig;
@@ -1422,7 +1421,6 @@ static int kxcjk1013_probe(struct i2c_client *client,
 		if (ret)
 			goto err_poweroff;
 
-		data->motion_trig->dev.parent = &client->dev;
 		data->motion_trig->ops = &kxcjk1013_trigger_ops;
 		iio_trigger_set_drvdata(data->motion_trig, indio_dev);
 		ret = iio_trigger_register(data->motion_trig);
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index b0176d936423d..12dd7c292504a 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1465,7 +1465,6 @@ static int mma8452_trigger_setup(struct iio_dev *indio_dev)
 	if (!trig)
 		return -ENOMEM;
 
-	trig->dev.parent = &data->client->dev;
 	trig->ops = &mma8452_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
 
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 0f8fd687866d4..fb3cbaa62bd87 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -450,7 +450,6 @@ static int mxc4005_probe(struct i2c_client *client,
 			return ret;
 		}
 
-		data->dready_trig->dev.parent = &client->dev;
 		data->dready_trig->ops = &mxc4005_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 		indio_dev->trig = data->dready_trig;
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 3b59887a8581b..7c3b70eb3f2db 100644
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
index 3ead378b02c9b..bf0368ce46e18 100644
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
index ee7b108688b33..0af0bb4d5a7fe 100644
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
index b6b6765be7b49..829a3426f2351 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -253,7 +253,6 @@ static int ad7766_probe(struct spi_device *spi)
 			return -ENOMEM;
 
 		ad7766->trig->ops = &ad7766_trigger_ops;
-		ad7766->trig->dev.parent = &spi->dev;
 		iio_trigger_set_drvdata(ad7766->trig, ad7766);
 
 		ret = devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 5c0cbee032308..c945f1349623f 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -631,7 +631,6 @@ static int ad7768_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st->trig->ops = &ad7768_trigger_ops;
-	st->trig->dev.parent = &spi->dev;
 	iio_trigger_set_drvdata(st->trig, indio_dev);
 	ret = devm_iio_trigger_register(&spi->dev, st->trig);
 	if (ret)
diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index ca1dff3924ff9..e3c8ec107722d 100644
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
index 60dd87e96f5f8..886e96496dbf7 100644
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
index 4d0d798c7cd34..261c277ac4a59 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -646,7 +646,6 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
 		return -ENOMEM;
 	}
 
-	trig->dev.parent = dev;
 	trig->ops = &scd30_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
 
diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index c45d8226cc2b1..cec5e1f17c22a 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -593,7 +593,6 @@ static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
 	if (!st->dready_trig)
 		return -ENOMEM;
 
-	st->dready_trig->dev.parent = &st->spi->dev;
 	st->dready_trig->ops = &adxrs290_trigger_ops;
 	iio_trigger_set_drvdata(st->dready_trig, indio_dev);
 
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 029ef4c346046..b11ebd9bb7a41 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -1148,14 +1148,12 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
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
index 129eead8febc0..1a20c6b88e7db 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -875,7 +875,6 @@ static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
 	if (ret < 0)
 		return ret;
 
-	data->dready_trig->dev.parent = dev;
 	data->dready_trig->ops = &fxas21002c_trigger_ops;
 	iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 
diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 38734e4ce3605..1fa8d51d50806 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -531,7 +531,6 @@ static int afe4403_probe(struct spi_device *spi)
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
 
 		afe->trig->ops = &afe4403_trigger_ops;
-		afe->trig->dev.parent = afe->dev;
 
 		ret = iio_trigger_register(afe->trig);
 		if (ret) {
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 61fe4932d81d0..e1476bf79fe2a 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -538,7 +538,6 @@ static int afe4404_probe(struct i2c_client *client,
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
 
 		afe->trig->ops = &afe4404_trigger_ops;
-		afe->trig->dev.parent = afe->dev;
 
 		ret = iio_trigger_register(afe->trig);
 		if (ret) {
diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 95e56917677fa..f29692b9d2db0 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -135,7 +135,6 @@ int hts221_allocate_trigger(struct iio_dev *iio_dev)
 
 	iio_trigger_set_drvdata(hw->trig, iio_dev);
 	hw->trig->ops = &hts221_trigger_ops;
-	hw->trig->dev.parent = hw->dev;
 	iio_dev->trig = iio_trigger_get(hw->trig);
 
 	return devm_iio_trigger_register(hw->dev, hw->trig);
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 4377047d503ab..fc5a60fcfec05 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1268,7 +1268,6 @@ static struct iio_trigger *kmx61_trigger_setup(struct kmx61_data *data,
 	if (!trig)
 		return ERR_PTR(-ENOMEM);
 
-	trig->dev.parent = &data->client->dev;
 	trig->ops = &kmx61_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
 
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 31224a33bade3..033578f444e4a 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -990,7 +990,6 @@ static int rpr0521_probe(struct i2c_client *client,
 			ret = -ENOMEM;
 			goto err_pm_disable;
 		}
-		data->drdy_trigger0->dev.parent = indio_dev->dev.parent;
 		data->drdy_trigger0->ops = &rpr0521_trigger_ops;
 		indio_dev->available_scan_masks = rpr0521_available_scan_masks;
 		iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index b304801c79163..9b5c99823943a 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1247,7 +1247,6 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
 	if (!trig)
 		return -ENOMEM;
 
-	trig->dev.parent = &client->dev;
 	trig->ops = &si1145_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
 
diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index 1055594b22764..41a2ce5a2d538 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -210,7 +210,6 @@ static int st_uvis25_allocate_trigger(struct iio_dev *iio_dev)
 		return -ENOMEM;
 
 	iio_trigger_set_drvdata(hw->trig, iio_dev);
-	hw->trig->dev.parent = dev;
 
 	return devm_iio_trigger_register(dev, hw->trig);
 }
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index fff4b36b8b58d..2f7916f95689e 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1002,7 +1002,6 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
 	if (!trigger)
 		return -ENOMEM;
 
-	trigger->dev.parent = &client->dev;
 	trigger->ops = &vcnl4010_trigger_ops;
 	iio_trigger_set_drvdata(trigger, indio_dev);
 
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 73a28e30dddcc..ae87740d9cef2 100644
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
index b2f3129e1b4f3..00f9766bad5c5 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -922,7 +922,6 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 			goto err_poweroff;
 		}
 
-		data->dready_trig->dev.parent = dev;
 		data->dready_trig->ops = &bmc150_magn_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 		ret = iio_trigger_register(data->dready_trig);
diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 7242897a05e95..dd811da9cb6db 100644
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
index 2cecbe0adb3f3..70adff62cd209 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -1413,7 +1413,6 @@ static int zpa2326_init_managed_trigger(struct device          *parent,
 		return -ENOMEM;
 
 	/* Basic setup. */
-	trigger->dev.parent = parent;
 	trigger->ops = &zpa2326_trigger_ops;
 
 	private->trigger = trigger;
diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 37fd0b65a0140..394c2afe0f233 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1453,7 +1453,6 @@ static int sx9310_probe(struct i2c_client *client)
 		if (!data->trig)
 			return -ENOMEM;
 
-		data->trig->dev.parent = dev;
 		data->trig->ops = &sx9310_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
 
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index acb821cbad46f..bb42aa5d596ef 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -950,7 +950,6 @@ static int sx9500_probe(struct i2c_client *client,
 		if (!data->trig)
 			return -ENOMEM;
 
-		data->trig->dev.parent = &client->dev;
 		data->trig->ops = &sx9500_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
 
-- 
2.30.1.766.gb4fecdf3b7-goog

