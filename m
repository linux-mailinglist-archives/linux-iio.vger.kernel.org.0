Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBA012807A
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2019 17:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfLTQRt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 20 Dec 2019 11:17:49 -0500
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17158 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfLTQRt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Dec 2019 11:17:49 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576858600; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=gckRibb8Afdchjm61CYCqdHZ8cfB2NnAqgCHgJF61VMGulncfInULGvtTltC8Fo2Z5rO7WsxyO4IJF4H4iAlydUdBoRbJ51HFARaF28LW17On/oiGin2Y2eD+i1Lt1tyxmwL3Vs+oFtFsRSAh0RL7W7blPaPT4Ficuj6C3fKiFI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1576858600; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=9oGsK/VE1d5EJ2EKa+QIda+UxgjxEvV/nclu3dPCbmM=; 
        b=BdTIdYDzsLK+pOMlSdwjb610bnS1WGNTpHalptGFzCZHzS4VFVfq23aHxvJswbE1e1iwb/ZBd+aRTKzGtBDyPAiCmeINfhtI76YAyKpzUlTWsOHqyg+5LX1Z8Jpna1AsoYSoAD0RQBmTKC4lgskBqXtD/+Um31Vu3BzwxjjY/WA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 1576858599026967.3364096978336; Fri, 20 Dec 2019 08:16:39 -0800 (PST)
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
Message-ID: <20191220160051.26321-4-dan@dlrobertson.com>
Subject: [PATCH v8 3/3] iio: (bma400) basic regulator support
Date:   Fri, 20 Dec 2019 16:00:51 +0000
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220160051.26321-1-dan@dlrobertson.com>
References: <20191220160051.26321-1-dan@dlrobertson.com>
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
 drivers/iio/accel/bma400.h      |  4 ++++
 drivers/iio/accel/bma400_core.c | 39 ++++++++++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 5 deletions(-)

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
diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 15c0e307d2c4..5ad10db9819f 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -86,6 +86,10 @@
 #define BMA400_SCALE_MIN            38357
 #define BMA400_SCALE_MAX            306864
 
+#define BMA400_NUM_REGULATORS       2
+#define BMA400_VDD_REGULATOR        0
+#define BMA400_VDDIO_REGULATOR      1
+
 extern const struct regmap_config bma400_regmap_config;
 
 int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index e7ba01e79d2c..61eb676e46be 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include "bma400.h"
 
@@ -53,6 +54,7 @@ struct bma400_sample_freq {
 struct bma400_data {
 	struct device *dev;
 	struct regmap *regmap;
+	struct regulator_bulk_data regulators[BMA400_NUM_REGULATORS];
 	struct mutex mutex; /* data register lock */
 	struct iio_mount_matrix orientation;
 	enum bma400_power_mode power_mode;
@@ -573,17 +575,38 @@ static int bma400_init(struct bma400_data *data)
 		goto out;
 	}
 
+	data->regulators[BMA400_VDD_REGULATOR].supply = "vdd";
+	data->regulators[BMA400_VDDIO_REGULATOR].supply = "vddio";
+	ret = devm_regulator_bulk_get(data->dev,
+				      ARRAY_SIZE(data->regulators),
+				      data->regulators);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(data->dev,
+				"Failed to get regulators: %d\n",
+				ret);
+
+		goto out;
+	}
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
+				    data->regulators);
+	if (ret) {
+		dev_err(data->dev, "Failed to enable regulators: %d\n",
+			ret);
+		goto out;
+	}
+
 	ret = bma400_get_power_mode(data);
 	if (ret) {
 		dev_err(data->dev, "Failed to get the initial power-mode\n");
-		goto out;
+		goto err_reg_disable;
 	}
 
 	if (data->power_mode != POWER_MODE_NORMAL) {
 		ret = bma400_set_power_mode(data, POWER_MODE_NORMAL);
 		if (ret) {
 			dev_err(data->dev, "Failed to wake up the device\n");
-			goto out;
+			goto err_reg_disable;
 		}
 		/*
 		 * TODO: The datasheet waits 1500us here in the example, but
@@ -596,15 +619,15 @@ static int bma400_init(struct bma400_data *data)
 
 	ret = bma400_get_accel_output_data_rate(data);
 	if (ret)
-		goto out;
+		goto err_reg_disable;
 
 	ret = bma400_get_accel_oversampling_ratio(data);
 	if (ret)
-		goto out;
+		goto err_reg_disable;
 
 	ret = bma400_get_accel_scale(data);
 	if (ret)
-		goto out;
+		goto err_reg_disable;
 
 	/*
 	 * Once the interrupt engine is supported we might use the
@@ -614,6 +637,9 @@ static int bma400_init(struct bma400_data *data)
 	 */
 	return regmap_write(data->regmap, BMA400_ACC_CONFIG2_REG, 0x00);
 
+err_reg_disable:
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
+			       data->regulators);
 out:
 	return ret;
 }
@@ -809,6 +835,9 @@ int bma400_remove(struct device *dev)
 	ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
 	mutex_unlock(&data->mutex);
 
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
+			       data->regulators);
+
 	iio_device_unregister(indio_dev);
 
 	return ret;


