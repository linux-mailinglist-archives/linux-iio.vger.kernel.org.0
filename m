Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EF060015F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJPQeZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJPQeY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D6F10EF
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46E7060C33
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38E8C433B5;
        Sun, 16 Oct 2022 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938061;
        bh=I6kO8QX788l7Rz80CbdDhcJOZMsEb0uAk6BVIifOpx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQaYHNL73/9YTQF5HIXH154V/+3s7ICTwI+RXwPd78F4NgGx6uwuusUe2BKpQcU4D
         6VO1N8G6j2HRZ+3UcrqdZQFxJRht4vX2pRe7RXEQdOW1s968gwHEo49m/y6jTE23GW
         JSsiTmBxJG8RK+x/dAU93pUlAnN/3A8b8HE6USkR38NHqfry0qxjO7NreB47fagVPU
         bWlvJJ0AK84/OfcCVJZF0VmWHf23TunIAHIPKms/Ujn+tEwa3tqlKxEZE1AUKzWoWW
         6Yz5Ps4ZCFL8n6oyLXXCoHqvCpyojtNOzdj6wvAGzlVasT3b6hv5sriNH8ak0RaNJ1
         8Gcad3mp3Q9DA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/14] iio: st_sensors: core and lsm9ds0 switch to devm_regulator_bulk_get_enable()
Date:   Sun, 16 Oct 2022 17:34:02 +0100
Message-Id: <20221016163409.320197-8-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221016163409.320197-1-jic23@kernel.org>
References: <20221016163409.320197-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These drivers only turns the power on at probe and off via a custom
devm_add_action_or_reset() callback. The two regulators were handled
separately so also switch to bulk registration.
The new devm_regulator_bulk_get_enable() replaces all this boilerplate
code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---

An alternative here would be to also refactor st_sensors_power_enable()
to take the struct dev of the parent device (I2C or SPI).

Then we could use the same function for st_lsm9d0_probe().
My view is it isn't worth the churn.
---
 .../iio/common/st_sensors/st_sensors_core.c   | 39 ++---------
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c  | 65 ++-----------------
 include/linux/iio/common/st_sensors.h         |  4 --
 3 files changed, 14 insertions(+), 94 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 35720c64fea8..c77d7bdcc121 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -219,47 +219,22 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
 }
 EXPORT_SYMBOL_NS(st_sensors_set_axis_enable, IIO_ST_SENSORS);
 
-static void st_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
 
 int st_sensors_power_enable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *pdata = iio_priv(indio_dev);
+	static const char * const regulator_names[] = { "vdd", "vddio" };
 	struct device *parent = indio_dev->dev.parent;
 	int err;
 
 	/* Regulators not mandatory, but if requested we should enable them. */
-	pdata->vdd = devm_regulator_get(parent, "vdd");
-	if (IS_ERR(pdata->vdd))
-		return dev_err_probe(&indio_dev->dev, PTR_ERR(pdata->vdd),
-				     "unable to get Vdd supply\n");
-
-	err = regulator_enable(pdata->vdd);
-	if (err != 0) {
-		dev_warn(&indio_dev->dev,
-			 "Failed to enable specified Vdd supply\n");
-		return err;
-	}
-
-	err = devm_add_action_or_reset(parent, st_reg_disable, pdata->vdd);
+	err = devm_regulator_bulk_get_enable(parent,
+					     ARRAY_SIZE(regulator_names),
+					     regulator_names);
 	if (err)
-		return err;
+		return dev_err_probe(&indio_dev->dev, err,
+				     "unable to enable supplies\n");
 
-	pdata->vdd_io = devm_regulator_get(parent, "vddio");
-	if (IS_ERR(pdata->vdd_io))
-		return dev_err_probe(&indio_dev->dev, PTR_ERR(pdata->vdd_io),
-				     "unable to get Vdd_IO supply\n");
-
-	err = regulator_enable(pdata->vdd_io);
-	if (err != 0) {
-		dev_warn(&indio_dev->dev,
-			 "Failed to enable specified Vdd_IO supply\n");
-		return err;
-	}
-
-	return devm_add_action_or_reset(parent, st_reg_disable, pdata->vdd_io);
+	return 0;
 }
 EXPORT_SYMBOL_NS(st_sensors_power_enable, IIO_ST_SENSORS);
 
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
index ae7bc815382f..e887b45cdbcd 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
@@ -18,58 +18,6 @@
 
 #include "st_lsm9ds0.h"
 
-static int st_lsm9ds0_power_enable(struct device *dev, struct st_lsm9ds0 *lsm9ds0)
-{
-	int ret;
-
-	/* Regulators not mandatory, but if requested we should enable them. */
-	lsm9ds0->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(lsm9ds0->vdd))
-		return dev_err_probe(dev, PTR_ERR(lsm9ds0->vdd),
-				     "unable to get Vdd supply\n");
-
-	ret = regulator_enable(lsm9ds0->vdd);
-	if (ret) {
-		dev_warn(dev, "Failed to enable specified Vdd supply\n");
-		return ret;
-	}
-
-	lsm9ds0->vdd_io = devm_regulator_get(dev, "vddio");
-	if (IS_ERR(lsm9ds0->vdd_io)) {
-		regulator_disable(lsm9ds0->vdd);
-		return dev_err_probe(dev, PTR_ERR(lsm9ds0->vdd_io),
-				     "unable to get Vdd_IO supply\n");
-	}
-	ret = regulator_enable(lsm9ds0->vdd_io);
-	if (ret) {
-		dev_warn(dev, "Failed to enable specified Vdd_IO supply\n");
-		regulator_disable(lsm9ds0->vdd);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void st_lsm9ds0_power_disable(void *data)
-{
-	struct st_lsm9ds0 *lsm9ds0 = data;
-
-	regulator_disable(lsm9ds0->vdd_io);
-	regulator_disable(lsm9ds0->vdd);
-}
-
-static int devm_st_lsm9ds0_power_enable(struct st_lsm9ds0 *lsm9ds0)
-{
-	struct device *dev = lsm9ds0->dev;
-	int ret;
-
-	ret = st_lsm9ds0_power_enable(dev, lsm9ds0);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, st_lsm9ds0_power_disable, lsm9ds0);
-}
-
 static int st_lsm9ds0_probe_accel(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap)
 {
 	const struct st_sensor_settings *settings;
@@ -92,8 +40,6 @@ static int st_lsm9ds0_probe_accel(struct st_lsm9ds0 *lsm9ds0, struct regmap *reg
 	data->sensor_settings = (struct st_sensor_settings *)settings;
 	data->irq = lsm9ds0->irq;
 	data->regmap = regmap;
-	data->vdd = lsm9ds0->vdd;
-	data->vdd_io = lsm9ds0->vdd_io;
 
 	return st_accel_common_probe(lsm9ds0->accel);
 }
@@ -120,19 +66,22 @@ static int st_lsm9ds0_probe_magn(struct st_lsm9ds0 *lsm9ds0, struct regmap *regm
 	data->sensor_settings = (struct st_sensor_settings *)settings;
 	data->irq = lsm9ds0->irq;
 	data->regmap = regmap;
-	data->vdd = lsm9ds0->vdd;
-	data->vdd_io = lsm9ds0->vdd_io;
 
 	return st_magn_common_probe(lsm9ds0->magn);
 }
 
 int st_lsm9ds0_probe(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap)
 {
+	struct device *dev = lsm9ds0->dev;
+	static const char * const regulator_names[] = { "vdd", "vddio" };
 	int ret;
 
-	ret = devm_st_lsm9ds0_power_enable(lsm9ds0);
+	/* Regulators not mandatory, but if requested we should enable them. */
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
+					     regulator_names);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret,
+				     "unable to enable Vdd supply\n");
 
 	/* Setup accelerometer device */
 	ret = st_lsm9ds0_probe_accel(lsm9ds0, regmap);
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index db4a1b260348..f5f3ee57bc70 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -224,8 +224,6 @@ struct st_sensor_settings {
  * @mount_matrix: The mounting matrix of the sensor.
  * @sensor_settings: Pointer to the specific sensor settings in use.
  * @current_fullscale: Maximum range of measure by the sensor.
- * @vdd: Pointer to sensor's Vdd power supply
- * @vdd_io: Pointer to sensor's Vdd-IO power supply
  * @regmap: Pointer to specific sensor regmap configuration.
  * @enabled: Status of the sensor (false->off, true->on).
  * @odr: Output data rate of the sensor [Hz].
@@ -244,8 +242,6 @@ struct st_sensor_data {
 	struct iio_mount_matrix mount_matrix;
 	struct st_sensor_settings *sensor_settings;
 	struct st_sensor_fullscale_avl *current_fullscale;
-	struct regulator *vdd;
-	struct regulator *vdd_io;
 	struct regmap *regmap;
 
 	bool enabled;
-- 
2.37.2

