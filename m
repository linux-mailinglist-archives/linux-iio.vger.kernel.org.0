Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C57FC125A48
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2019 05:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfLSE2I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 18 Dec 2019 23:28:08 -0500
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17121 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfLSE2H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 23:28:07 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576729615; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RwnpuCFesic3Li0hn+0cxAGihVSnu39yKU1ZyvL5DCqPscrlhXkpaPF//GQeZ+iknBcwf9G788nAEnuk6KUnHgqdK7baPDP3eHf5u46janRfqqY9Xl1u/WTurCdW700ueLx9obFwpS88yhbHELseV7HRjEiLJCrZ96R3X2whX04=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1576729615; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=mxrF6LKpQc4itYv2bwtRZBYVjJdn7+CfPSNURUcVeE0=; 
        b=Vz7me6C0papve4WBalL31ZoaNTUN/lkM17awqL3ZkPn8Wv2jNMleyBVf+isLjkdG4Z208/iohs4wyqOCRruXJGcnLYMZDYvigYQUVD3AOp5XJDoRIm5Cqy6T8JsZsKQm3YYa+lqkAU9fzQkAbu0+F3hYCSbqpmpV22ybN+zTIpY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1576729614288559.068600152658; Wed, 18 Dec 2019 20:26:54 -0800 (PST)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dan Robertson <dan@dlrobertson.com>
Message-ID: <20191219041039.23396-4-dan@dlrobertson.com>
Subject: [PATCH v7 3/3] iio: (bma400) basic regulator support
Date:   Thu, 19 Dec 2019 04:10:39 +0000
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219041039.23396-1-dan@dlrobertson.com>
References: <20191219041039.23396-1-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for the VDD and VDDIO regulators using the regulator
framework.

Signed-off-by: Dan Robertson <dan@dlrobertson.com>
---
 drivers/iio/accel/Kconfig       |  1 +
 drivers/iio/accel/bma400_core.c | 49 +++++++++++++++++++++++++++++----
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 670e60568033..9cfe9c790190 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -116,6 +116,7 @@ config BMA400
 	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
 	select REGMAP
 	select BMA400_I2C if I2C
+	select REGULATOR
 	help
 	  Say Y here if you want to build a driver for the Bosch BMA400
 	  triaxial acceleration sensor.
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index b97b8ea7fbb7..dd1edecc46f6 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include "bma400.h"
 
@@ -53,6 +54,8 @@ struct bma400_sample_freq {
 struct bma400_data {
 	struct device *dev;
 	struct regmap *regmap;
+	struct regulator *vdd_supply;
+	struct regulator *vddio_supply;
 	struct mutex mutex; /* data register lock */
 	struct iio_mount_matrix orientation;
 	enum bma400_power_mode power_mode;
@@ -574,17 +577,46 @@ static int bma400_init(struct bma400_data *data)
 		goto out;
 	}
 
+	data->vdd_supply = devm_regulator_get(data->dev, "vdd");
+	if (IS_ERR(data->vdd_supply)) {
+		ret = PTR_ERR(data->vdd_supply);
+		if (ret != -EPROBE_DEFER)
+			dev_err(data->dev, "Failed to get VDD regulator %d\n",
+				ret);
+		goto out;
+	}
+	ret = regulator_enable(data->vdd_supply);
+	if (ret) {
+		dev_err(data->dev, "Failed to enable VDD regulator: %d\n", ret);
+		goto err_vdd;
+	}
+
+	data->vddio_supply = devm_regulator_get(data->dev, "vddio");
+	if (IS_ERR(data->vddio_supply)) {
+		ret = PTR_ERR(data->vddio_supply);
+		if (ret != -EPROBE_DEFER)
+			dev_err(data->dev, "Failed to get VDDIO regulator %d\n",
+				ret);
+		goto err_vdd;
+	}
+	ret = regulator_enable(data->vddio_supply);
+	if (ret) {
+		dev_err(data->dev, "Failed to enable VDDIO regulator: %d\n",
+			ret);
+		goto err_vdd;
+	}
+
 	ret = bma400_get_power_mode(data);
 	if (ret < 0) {
 		dev_err(data->dev, "Failed to get the initial power-mode\n");
-		goto out;
+		goto err_vddio;
 	}
 
 	if (data->power_mode != POWER_MODE_NORMAL) {
 		ret = bma400_set_power_mode(data, POWER_MODE_NORMAL);
 		if (ret < 0) {
 			dev_err(data->dev, "Failed to wake up the device\n");
-			goto out;
+			goto err_vddio;
 		}
 		/*
 		 * TODO: The datasheet waits 1500us here in the example, but
@@ -597,15 +629,15 @@ static int bma400_init(struct bma400_data *data)
 
 	ret = bma400_get_accel_output_data_rate(data);
 	if (ret < 0)
-		goto out;
+		goto err_vddio;
 
 	ret = bma400_get_accel_oversampling_ratio(data);
 	if (ret < 0)
-		goto out;
+		goto err_vddio;
 
 	ret = bma400_get_accel_scale(data);
 	if (ret < 0)
-		goto out;
+		goto err_vddio;
 
 	/*
 	 * Once the interrupt engine is supported we might use the
@@ -615,6 +647,10 @@ static int bma400_init(struct bma400_data *data)
 	 */
 	return regmap_write(data->regmap, BMA400_ACC_CONFIG2_REG, 0x00);
 
+err_vddio:
+	regulator_disable(data->vddio_supply);
+err_vdd:
+	regulator_disable(data->vdd_supply);
 out:
 	return ret;
 }
@@ -810,6 +846,9 @@ int bma400_remove(struct device *dev)
 	ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
 	mutex_unlock(&data->mutex);
 
+	regulator_disable(data->vddio_supply);
+	regulator_disable(data->vdd_supply);
+
 	iio_device_unregister(indio_dev);
 
 	return ret;


