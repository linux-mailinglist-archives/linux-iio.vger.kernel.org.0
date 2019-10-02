Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A045C4A18
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 10:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfJBI6N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 04:58:13 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44453 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbfJBI6N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 04:58:13 -0400
Received: by mail-wr1-f46.google.com with SMTP id z9so5530229wrl.11
        for <linux-iio@vger.kernel.org>; Wed, 02 Oct 2019 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TokpQlwvSqpKkJFZGdtc9HARS2+18tCQ00roLJNHSjE=;
        b=0KTmOrvJGb/kvJhFEHmI147y/JEhksandLOU7BETHCxeloeAoPaQ+We2xWfZpPogOd
         sVzS8/3pvXN/45MiOmCZt2adIFBI87jWXV7vD6cIbepg+/M199IsR2Md0MQ7Vo32Ffnm
         4msE1rgqB+vQg2icDBxFRcHVvT8OfJQzqst5898uR7UMa+aEm52Do/sv582nnGM3DGOD
         zn3PI/4W8F6EWarlzJBKdshHi/NE/KuxHt18T353ftQqGVMrM2lwT+83tgDdxXQu2TA4
         t9OcrfxV4CqsdIUqE/MqtJXlIZhixTnkYp2etY2uh/VBaZmCQBPvvWFd1Y6oLl8yMx8r
         ackQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TokpQlwvSqpKkJFZGdtc9HARS2+18tCQ00roLJNHSjE=;
        b=aWfyCuyfVJ/vd6P4JmSKEsl8bbrdoX+zL2ZqIPTt8kvLp9qrqlX0t60P08Qc5yE/zM
         HUg2/WYHJ0ybNSEmbUV2ysnlyASn+l5+MDeKTDVzy+dTZ8QK78jpg9tXKLNhd2uc2V28
         UVVfoPoi8gnB4aRvr9Oo4yEcJGMDaCxt7QoQyOpp9rO9xdHemodPH2s0fr+wD7OPFeoF
         POxDVT6M9iEGo3u1aV5jp2Beg2xbS4YaFX2ft5IQtt5EA7TD6le2N6fc0DUx0i0wBgcx
         4dO0kn5uMfL4zjx5+fSpvOzodgU+SyNNaTLlFMLX450lycG8pxdmWxunH37EtkqHbIKs
         t9nQ==
X-Gm-Message-State: APjAAAX/7WnaeYq9Hz7BGpALbiV8Iob7uJWxmoSEMoQXAwq7yoE88dkF
        nOvQf9zCm0UOd5D4R2VhQSFP3g==
X-Google-Smtp-Source: APXvYqyOeBaGiNRxsEsHbImQj+4rli4gayNlC87TTjtS3z+QlYpiLbVQ9JvNWA5RvGn6USh6Q58xSg==
X-Received: by 2002:adf:8444:: with SMTP id 62mr1738370wrf.202.1570006691012;
        Wed, 02 Oct 2019 01:58:11 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b186sm10115616wmd.16.2019.10.02.01.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 01:58:10 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/4] iio: pressure: bmp280: use devm action and remove labels from probe
Date:   Wed,  2 Oct 2019 10:57:59 +0200
Message-Id: <20191002085759.13337-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002085759.13337-1-brgl@bgdev.pl>
References: <20191002085759.13337-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We can drop some duplicate code if we use devm_action for disabling
regulators and pm. This allows us to completely remove all remove()
callbacks from both i2c and spi code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/pressure/bmp280-core.c | 61 +++++++++++++++---------------
 drivers/iio/pressure/bmp280-i2c.c  |  6 ---
 drivers/iio/pressure/bmp280-spi.c  |  6 ---
 drivers/iio/pressure/bmp280.h      |  1 -
 4 files changed, 30 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fdbd3bc27921..79254dd26dfd 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -984,6 +984,22 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 	return 0;
 }
 
+static void bmp280_pm_disable(void *data)
+{
+	struct device *dev = data;
+
+	pm_runtime_get_sync(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_disable(dev);
+}
+
+static void bmp280_regulators_disable(void *data)
+{
+	struct regulator_bulk_data *supplies = data;
+
+	regulator_bulk_disable(BMP280_NUM_SUPPLIES, supplies);
+}
+
 int bmp280_common_probe(struct device *dev,
 			struct regmap *regmap,
 			unsigned int chip,
@@ -1055,6 +1071,11 @@ int bmp280_common_probe(struct device *dev,
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(dev, bmp280_regulators_disable,
+				       data->supplies);
+	if (ret)
+		return ret;
+
 	/* Wait to make sure we started up properly */
 	usleep_range(data->start_up_time, data->start_up_time + 100);
 
@@ -1069,17 +1090,16 @@ int bmp280_common_probe(struct device *dev,
 	data->regmap = regmap;
 	ret = regmap_read(regmap, BMP280_REG_ID, &chip_id);
 	if (ret < 0)
-		goto out_disable_regulators;
+		return ret;
 	if (chip_id != chip) {
 		dev_err(dev, "bad chip id: expected %x got %x\n",
 			chip, chip_id);
-		ret = -EINVAL;
-		goto out_disable_regulators;
+		return -EINVAL;
 	}
 
 	ret = data->chip_info->chip_config(data);
 	if (ret < 0)
-		goto out_disable_regulators;
+		return ret;
 
 	dev_set_drvdata(dev, indio_dev);
 
@@ -1093,14 +1113,14 @@ int bmp280_common_probe(struct device *dev,
 		if (ret < 0) {
 			dev_err(data->dev,
 				"failed to read calibration coefficients\n");
-			goto out_disable_regulators;
+			return ret;
 		}
 	} else if (chip_id == BMP280_CHIP_ID || chip_id == BME280_CHIP_ID) {
 		ret = bmp280_read_calib(data, &data->calib.bmp280, chip_id);
 		if (ret < 0) {
 			dev_err(data->dev,
 				"failed to read calibration coefficients\n");
-			goto out_disable_regulators;
+			return ret;
 		}
 	}
 
@@ -1112,7 +1132,7 @@ int bmp280_common_probe(struct device *dev,
 	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
 		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
 		if (ret)
-			goto out_disable_regulators;
+			return ret;
 	}
 
 	/* Enable runtime PM */
@@ -1127,35 +1147,14 @@ int bmp280_common_probe(struct device *dev,
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_put(dev);
 
-	ret = devm_iio_device_register(dev, indio_dev);
+	ret = devm_add_action_or_reset(dev, bmp280_pm_disable, dev);
 	if (ret)
-		goto out_runtime_pm_disable;
-
-	return 0;
+		return ret;
 
-out_runtime_pm_disable:
-	pm_runtime_get_sync(data->dev);
-	pm_runtime_put_noidle(data->dev);
-	pm_runtime_disable(data->dev);
-out_disable_regulators:
-	regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
-	return ret;
+	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL(bmp280_common_probe);
 
-int bmp280_common_remove(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct bmp280_data *data = iio_priv(indio_dev);
-
-	pm_runtime_get_sync(data->dev);
-	pm_runtime_put_noidle(data->dev);
-	pm_runtime_disable(data->dev);
-	regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
-	return 0;
-}
-EXPORT_SYMBOL(bmp280_common_remove);
-
 #ifdef CONFIG_PM
 static int bmp280_runtime_suspend(struct device *dev)
 {
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index acd9a3784fb4..3109c8e2cc11 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -38,11 +38,6 @@ static int bmp280_i2c_probe(struct i2c_client *client,
 				   client->irq);
 }
 
-static int bmp280_i2c_remove(struct i2c_client *client)
-{
-	return bmp280_common_remove(&client->dev);
-}
-
 static const struct acpi_device_id bmp280_acpi_i2c_match[] = {
 	{"BMP0280", BMP280_CHIP_ID },
 	{"BMP0180", BMP180_CHIP_ID },
@@ -82,7 +77,6 @@ static struct i2c_driver bmp280_i2c_driver = {
 		.pm = &bmp280_dev_pm_ops,
 	},
 	.probe		= bmp280_i2c_probe,
-	.remove		= bmp280_i2c_remove,
 	.id_table	= bmp280_i2c_id,
 };
 module_i2c_driver(bmp280_i2c_driver);
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 9d57b7a3b134..625b86878ad8 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -86,11 +86,6 @@ static int bmp280_spi_probe(struct spi_device *spi)
 				   spi->irq);
 }
 
-static int bmp280_spi_remove(struct spi_device *spi)
-{
-	return bmp280_common_remove(&spi->dev);
-}
-
 static const struct of_device_id bmp280_of_spi_match[] = {
 	{ .compatible = "bosch,bmp085", },
 	{ .compatible = "bosch,bmp180", },
@@ -118,7 +113,6 @@ static struct spi_driver bmp280_spi_driver = {
 	},
 	.id_table = bmp280_spi_id,
 	.probe = bmp280_spi_probe,
-	.remove = bmp280_spi_remove,
 };
 module_spi_driver(bmp280_spi_driver);
 
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index eda50ef65706..57ba0e85db91 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -112,7 +112,6 @@ int bmp280_common_probe(struct device *dev,
 			unsigned int chip,
 			const char *name,
 			int irq);
-int bmp280_common_remove(struct device *dev);
 
 /* PM ops */
 extern const struct dev_pm_ops bmp280_dev_pm_ops;
-- 
2.23.0

