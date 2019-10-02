Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE856C4A14
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 10:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfJBI6L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 04:58:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51930 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfJBI6L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 04:58:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so6270697wme.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Oct 2019 01:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=toqSCbDKjKDNRGlIhRc6C/qDd5dUDz6VgJWTVy4eu6w=;
        b=mNaI0NVFqxeuET9HKNSQdq+4dLrjPuaOqsvskqSt8Eyts9NrwJj1cAiwiEMqkY3LuX
         JNb2Lzi37aKP7eef9evUvY+hlnVXMLv12DK+XbWm+5e0JN3k9+d5euPbXQ+JqBeoWRWE
         4W8qHg8p8chBKrmalPnkS22AsyR7cDeYW3Q8PcPEfRELrMoByxgNeUgPk0g5KlhCiC+E
         LyZJR7VZjltjzgsdZlpTWMPNJb4OdT6MNOlAMVeLlZ9XqcWFxZyyhw8V8RrBk4YRypWg
         lqZJz/7qQPlKw2Zckn3HV+HSEp/hNXd0U7Jhpl5CQlDI8N8qLGmpwhrz6s6m0ZZducJJ
         Fxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=toqSCbDKjKDNRGlIhRc6C/qDd5dUDz6VgJWTVy4eu6w=;
        b=VUzA/dw0Le9S098Un0YlaZWWa5hT2Eqhi38fbvpXMWnqrWyH9fVb99vxCiiMUdJ4T1
         Xx+Emdu94ZTbtb6LQXQjLR50fz0AqGxmpTjUaAhFx/iGcRskVKEENUvC8VusOwKtz43O
         ipAeoMCd5q+xbhRmIBX4+A7Ae2NVNhg9VgKC+AXBJ63eQBi8S9T//qXOhHukO9Zzen4S
         S7K0wq/QHVB37ccxQNblunx1w9/7jV2R+8LU+kkUKzg+X0+5HrU3IiZdJcqz8TdUQjTc
         O1yvF1HGVqVO4aU/6wcG9jWYKl99nBdPkKNtTiXwAFFyx+dVLu7tcM7vd8bSu2U3mGBg
         Hg2Q==
X-Gm-Message-State: APjAAAU6v1vNE+uUAqjqgewndKssC+/mqzKUbjXgEpw9mMNXYzDzq/jr
        TyOEIjZPizYmBJclJv+QAhp5zGzVDKY=
X-Google-Smtp-Source: APXvYqz9OH4tpQEQYea+bSGT9Q8PNCBRt6XTtpq4N5s0l0cHZ0LJzdEOZ5ZdpjRV6BidrQ89cScjeQ==
X-Received: by 2002:a7b:c4c7:: with SMTP id g7mr1880636wmk.11.1570006687787;
        Wed, 02 Oct 2019 01:58:07 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b186sm10115616wmd.16.2019.10.02.01.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 01:58:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/4] iio: pressure: bmp280: use bulk regulator ops
Date:   Wed,  2 Oct 2019 10:57:56 +0200
Message-Id: <20191002085759.13337-2-brgl@bgdev.pl>
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

The vddd and vdda supplies are always operated on together. We can
shrink the code a bit by using the bulk regulator helpers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/pressure/bmp280-core.c | 69 +++++++++++++-----------------
 1 file changed, 30 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 8d0f15f27dc5..c21f8ce7b09c 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -74,6 +74,12 @@ struct bmp280_calib {
 	s8  H6;
 };
 
+static const char *const bmp280_supply_names[] = {
+	"vddd", "vdda"
+};
+
+#define BMP280_NUM_SUPPLIES ARRAY_SIZE(bmp280_supply_names)
+
 struct bmp280_data {
 	struct device *dev;
 	struct mutex lock;
@@ -85,8 +91,7 @@ struct bmp280_data {
 		struct bmp180_calib bmp180;
 		struct bmp280_calib bmp280;
 	} calib;
-	struct regulator *vddd;
-	struct regulator *vdda;
+	struct regulator_bulk_data supplies[BMP280_NUM_SUPPLIES];
 	unsigned int start_up_time; /* in microseconds */
 
 	/* log of base 2 of oversampling rate */
@@ -1033,27 +1038,23 @@ int bmp280_common_probe(struct device *dev,
 	}
 
 	/* Bring up regulators */
-	data->vddd = devm_regulator_get(dev, "vddd");
-	if (IS_ERR(data->vddd)) {
-		dev_err(dev, "failed to get VDDD regulator\n");
-		return PTR_ERR(data->vddd);
-	}
-	ret = regulator_enable(data->vddd);
+	regulator_bulk_set_supply_names(data->supplies,
+					bmp280_supply_names,
+					BMP280_NUM_SUPPLIES);
+
+	ret = devm_regulator_bulk_get(dev,
+				      BMP280_NUM_SUPPLIES, data->supplies);
 	if (ret) {
-		dev_err(dev, "failed to enable VDDD regulator\n");
+		dev_err(dev, "failed to get regulators\n");
 		return ret;
 	}
-	data->vdda = devm_regulator_get(dev, "vdda");
-	if (IS_ERR(data->vdda)) {
-		dev_err(dev, "failed to get VDDA regulator\n");
-		ret = PTR_ERR(data->vdda);
-		goto out_disable_vddd;
-	}
-	ret = regulator_enable(data->vdda);
+
+	ret = regulator_bulk_enable(BMP280_NUM_SUPPLIES, data->supplies);
 	if (ret) {
-		dev_err(dev, "failed to enable VDDA regulator\n");
-		goto out_disable_vddd;
+		dev_err(dev, "failed to enable regulators\n");
+		return ret;
 	}
+
 	/* Wait to make sure we started up properly */
 	usleep_range(data->start_up_time, data->start_up_time + 100);
 
@@ -1068,17 +1069,17 @@ int bmp280_common_probe(struct device *dev,
 	data->regmap = regmap;
 	ret = regmap_read(regmap, BMP280_REG_ID, &chip_id);
 	if (ret < 0)
-		goto out_disable_vdda;
+		goto out_disable_regulators;
 	if (chip_id != chip) {
 		dev_err(dev, "bad chip id: expected %x got %x\n",
 			chip, chip_id);
 		ret = -EINVAL;
-		goto out_disable_vdda;
+		goto out_disable_regulators;
 	}
 
 	ret = data->chip_info->chip_config(data);
 	if (ret < 0)
-		goto out_disable_vdda;
+		goto out_disable_regulators;
 
 	dev_set_drvdata(dev, indio_dev);
 
@@ -1092,14 +1093,14 @@ int bmp280_common_probe(struct device *dev,
 		if (ret < 0) {
 			dev_err(data->dev,
 				"failed to read calibration coefficients\n");
-			goto out_disable_vdda;
+			goto out_disable_regulators;
 		}
 	} else if (chip_id == BMP280_CHIP_ID || chip_id == BME280_CHIP_ID) {
 		ret = bmp280_read_calib(data, &data->calib.bmp280, chip_id);
 		if (ret < 0) {
 			dev_err(data->dev,
 				"failed to read calibration coefficients\n");
-			goto out_disable_vdda;
+			goto out_disable_regulators;
 		}
 	}
 
@@ -1111,7 +1112,7 @@ int bmp280_common_probe(struct device *dev,
 	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
 		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
 		if (ret)
-			goto out_disable_vdda;
+			goto out_disable_regulators;
 	}
 
 	/* Enable runtime PM */
@@ -1137,10 +1138,8 @@ int bmp280_common_probe(struct device *dev,
 	pm_runtime_get_sync(data->dev);
 	pm_runtime_put_noidle(data->dev);
 	pm_runtime_disable(data->dev);
-out_disable_vdda:
-	regulator_disable(data->vdda);
-out_disable_vddd:
-	regulator_disable(data->vddd);
+out_disable_regulators:
+	regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
 	return ret;
 }
 EXPORT_SYMBOL(bmp280_common_probe);
@@ -1154,8 +1153,7 @@ int bmp280_common_remove(struct device *dev)
 	pm_runtime_get_sync(data->dev);
 	pm_runtime_put_noidle(data->dev);
 	pm_runtime_disable(data->dev);
-	regulator_disable(data->vdda);
-	regulator_disable(data->vddd);
+	regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
 	return 0;
 }
 EXPORT_SYMBOL(bmp280_common_remove);
@@ -1165,12 +1163,8 @@ static int bmp280_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret;
 
-	ret = regulator_disable(data->vdda);
-	if (ret)
-		return ret;
-	return regulator_disable(data->vddd);
+	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
 }
 
 static int bmp280_runtime_resume(struct device *dev)
@@ -1179,10 +1173,7 @@ static int bmp280_runtime_resume(struct device *dev)
 	struct bmp280_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = regulator_enable(data->vddd);
-	if (ret)
-		return ret;
-	ret = regulator_enable(data->vdda);
+	ret = regulator_bulk_enable(BMP280_NUM_SUPPLIES, data->supplies);
 	if (ret)
 		return ret;
 	usleep_range(data->start_up_time, data->start_up_time + 100);
-- 
2.23.0

