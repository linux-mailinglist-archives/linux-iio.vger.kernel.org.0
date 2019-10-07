Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A67CDA77
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 04:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfJGClg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 22:41:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37096 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfJGClg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Oct 2019 22:41:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id u20so6137299plq.4
        for <linux-iio@vger.kernel.org>; Sun, 06 Oct 2019 19:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6YCPvkqUEYPdp7Issb3rlEPCn0qCQu25RHzf2YaVvc=;
        b=qLMa5YhyILm6yO8Na5KLscg9DAuCg9v6D6QUckNpATGWtNXINlxvAFEr8EDkVKe/qR
         bQTb6vxps7Of7X4bDSdAasEp+piPWdS5YeumOTPaEvczVzJ3bNPySggN+IBIqwMu5J7g
         dkLNrMMMENSnesQyX+c+AvNNhSO2L9OwX1g28nsyT0wIT55EtrLeXz9xe89a9dd9nH8W
         hza4lsO3870R2hRFuM4DNTh3FFYBCYEAF7BYGFICzb8ntHsa+7LCDiTWc+FAR+uKYJ9r
         FFo9/V1aNdmd2h8W8ywNv/WjEZs9diztFj7CXIaRTi3t7/sXEidSodSKw/phasIQjdVx
         +XUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6YCPvkqUEYPdp7Issb3rlEPCn0qCQu25RHzf2YaVvc=;
        b=f6oFxrzB+G/hAACU0EZBNQFdtRSKECiZnHDgI3beR9p6uqm9c848hQbQ+5ZUnMuM/G
         79MUyPav/xqNeyYyhZqBeMPaiGYDjtWCrtc/Q0knGVsaXs5qGxUCXDO3qQ38elXyzgE4
         XiTYY5mswQL8OUJH2n1I1bEnbhYetXkwxfta40c5EWO9Y0NbObrPR8gYXbw2a3foOMJY
         Kr3j0TnaouWaMj6nhKUGeorRxQ5AcBy5lhVtfOT5NGBIXeK8knFVilhmcD5LtPFXF4WU
         /c/nA6Bl2wFzWNAHtJzcLDfIiQTjJ2JXGxz6PbBkBJBk675/hkjU8cbXcT1FXzn/UAy6
         L1pw==
X-Gm-Message-State: APjAAAXg4KAYRpAeC7+sntlFZ6amH4KZHLAN3E+t5JEgrn593uf7JrW4
        3E/Vcw9xiG5v1ruIGiue7K72lw==
X-Google-Smtp-Source: APXvYqx0eJ2GKQ0KLH9t4w++nwR6ZWbjydgKAz1kNgkUTHi/fax0ACyxrNqhAZbAuGoiWHJ9jT0YvA==
X-Received: by 2002:a17:902:8b89:: with SMTP id ay9mr27184492plb.81.1570416094190;
        Sun, 06 Oct 2019 19:41:34 -0700 (PDT)
Received: from debian-brgl.local (96-95-220-76-static.hfc.comcastbusiness.net. [96.95.220.76])
        by smtp.gmail.com with ESMTPSA id 16sm12444822pfn.35.2019.10.06.19.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 19:41:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2] iio: pressure: bmp280: use devm action and remove labels from probe
Date:   Mon,  7 Oct 2019 04:41:31 +0200
Message-Id: <20191007024131.22708-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We can drop some duplicate code if we use devm_action for disabling
regulators and pm and the managed variant of iio_device_register().

This allows us to completely remove all remove() callbacks from both
i2c and spi code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
v1 -> v2:
- squash the patches using devm_iio_device_register() and devm_action
  to keep the changes bisectable

 drivers/iio/pressure/bmp280-core.c | 62 +++++++++++++++---------------
 drivers/iio/pressure/bmp280-i2c.c  |  6 ---
 drivers/iio/pressure/bmp280-spi.c  |  6 ---
 drivers/iio/pressure/bmp280.h      |  1 -
 4 files changed, 30 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index c2988dbdb1a7..79254dd26dfd 100644
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
@@ -1127,36 +1147,14 @@ int bmp280_common_probe(struct device *dev,
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_put(dev);
 
-	ret = iio_device_register(indio_dev);
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
-	iio_device_unregister(indio_dev);
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

