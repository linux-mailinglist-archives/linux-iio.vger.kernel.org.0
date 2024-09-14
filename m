Return-Path: <linux-iio+bounces-9548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786A89790E8
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 15:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9181C2120C
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983B61CF7BD;
	Sat, 14 Sep 2024 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWCGzEoK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23E1CF5FC;
	Sat, 14 Sep 2024 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726320462; cv=none; b=LIMdZAW72PV2Wpp5Rb8EjRccsuk1Qofy0J6J9KICAqZLUGAq25RjvW8EjS4yYAcLjkE2WDibOhKQI24OvDO7lpQADW4tgfPU8GhwRBNARMq+7rnxymJY3vMGJj96QbMXnIMB6wiVhYRV5Uyz2TkaV3QQg8AcMEASgcpZybBOIBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726320462; c=relaxed/simple;
	bh=CltfCIwmJ9gTdLOuKsqwCDhjQQ668Etn27WjWdq8nFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxRS4WETpphjuqRBc2la4kAkroTN6ccUxE5Yfwoly2fqS2LwebgGpTZf8acrP1KXLdzHMcyCW9p2f4QRqJncKjZwr3Jbs8a3bYZl2+c/yQ2P2qkwYDo1Nz9kWbDQ98d6Br75Ce84JJL+11z950G6VbOr9d8jwUVi0OYdwR4lVVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWCGzEoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780BAC4CEC0;
	Sat, 14 Sep 2024 13:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726320462;
	bh=CltfCIwmJ9gTdLOuKsqwCDhjQQ668Etn27WjWdq8nFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PWCGzEoK249129i3r4OdmbnkEy5kcpSAySANxTBO/f/A21ZlvI58rgtyBahLKRPkf
	 ydncry8qwIX9vuziAO4OFiyS7WYSgBi76ecgXDbQ6T5B8BXPERB5ojRN+U4lS0FWdP
	 HGyOMCgDUiJzNiMzKIPSqbQQttiEjJCbYK6ShDO3pDei2nXWVZ9ZHemxzw4otkxuLw
	 UrLdVQiVIfQ60i/hgRcSWZ7rmSZCfgYoShygo+KaiBONEFt1rHXWLRqyoC8P+7tJG0
	 0Bldn8qAns+Ao9sFFNLozrMLuHpopOuIBbz8UL89KMu/VBYGJlild7uEv5k9U0AFcw
	 SAlChWDs0DTpw==
Date: Sat, 14 Sep 2024 14:27:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jagath Jog J <jagathjog1996@gmail.com>, Ramona
 Gradinariu <ramona.bolboaca13@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: imu: Add i2c driver for bmi270 imu
Message-ID: <20240914142734.4bcf14bc@jic23-huawei>
In-Reply-To: <20240912210749.3080157-3-lanzano.alex@gmail.com>
References: <20240912210749.3080157-1-lanzano.alex@gmail.com>
	<20240912210749.3080157-3-lanzano.alex@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 17:07:19 -0400
Alex Lanzano <lanzano.alex@gmail.com> wrote:

> Add initial i2c support for the Bosch BMI270 6-axis IMU.
> Provides raw read access to acceleration and angle velocity measurements
> via iio channels. Device configuration requires firmware provided by
> Bosch and is requested and load from userspace.
> 
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>

Hi Alex,

A bunch of fairly minor stuff so I've just tweaked it whilst applying rather
than wasting time on going around again.

I also changed a few line wraps to keep lines a bit shorter.
Where it doesn't hurt readability 80 chars is still my preference for IIO.

The diff of the tweaks I made is as follows. Shout if I messed anything up!

Thanks,

Jonathan

diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
index 4af4098d8e82..608b29ea58a3 100644
--- a/drivers/iio/imu/bmi270/bmi270.h
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -3,53 +3,9 @@
 #ifndef BMI270_H_
 #define BMI270_H_
 
-#include <linux/iio/iio.h>
-
-#define BMI270_CHIP_ID_REG                             0x00
-#define BMI270_CHIP_ID_VAL                             0x24
-#define BMI270_CHIP_ID_MSK                             GENMASK(7, 0)
-
-#define BMI270_ACCEL_X_REG                             0x0c
-#define BMI270_ANG_VEL_X_REG                           0x12
-
-#define BMI270_INTERNAL_STATUS_REG                     0x21
-#define BMI270_INTERNAL_STATUS_MSG_MSK                 GENMASK(3, 0)
-#define BMI270_INTERNAL_STATUS_MSG_INIT_OK             0x01
-
-#define BMI270_INTERNAL_STATUS_AXES_REMAP_ERR_MSK      BIT(5)
-#define BMI270_INTERNAL_STATUS_ODR_50HZ_ERR_MSK                BIT(6)
-
-#define BMI270_ACC_CONF_REG                            0x40
-#define BMI270_ACC_CONF_ODR_MSK                                GENMASK(3, 0)
-#define BMI270_ACC_CONF_ODR_100HZ                      0x08
-#define BMI270_ACC_CONF_BWP_MSK                                GENMASK(6, 4)
-#define BMI270_ACC_CONF_BWP_NORMAL_MODE                        0x02
-#define BMI270_ACC_CONF_FILTER_PERF_MSK                        BIT(7)
-
-#define BMI270_GYR_CONF_REG                            0x42
-#define BMI270_GYR_CONF_ODR_MSK                                GENMASK(3, 0)
-#define BMI270_GYR_CONF_ODR_200HZ                      0x09
-#define BMI270_GYR_CONF_BWP_MSK                                GENMASK(5, 4)
-#define BMI270_GYR_CONF_BWP_NORMAL_MODE                        0x02
-#define BMI270_GYR_CONF_NOISE_PERF_MSK                 BIT(6)
-#define BMI270_GYR_CONF_FILTER_PERF_MSK                        BIT(7)
-
-#define BMI270_INIT_CTRL_REG                           0x59
-#define BMI270_INIT_CTRL_LOAD_DONE_MSK                 BIT(0)
-
-#define BMI270_INIT_DATA_REG                           0x5e
-
-#define BMI270_PWR_CONF_REG                            0x7c
-#define BMI270_PWR_CONF_ADV_PWR_SAVE_MSK               BIT(0)
-#define BMI270_PWR_CONF_FIFO_WKUP_MSK                  BIT(1)
-#define BMI270_PWR_CONF_FUP_EN_MSK                     BIT(2)
-
-#define BMI270_PWR_CTRL_REG                            0x7d
-#define BMI270_PWR_CTRL_AUX_EN_MSK                     BIT(0)
-#define BMI270_PWR_CTRL_GYR_EN_MSK                     BIT(1)
-#define BMI270_PWR_CTRL_ACCEL_EN_MSK                   BIT(2)
-#define BMI270_PWR_CTRL_TEMP_EN_MSK                    BIT(3)
+#include <linux/regmap.h>
 
+struct device;
 struct bmi270_data {
        struct device *dev;
        struct regmap *regmap;
iff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 319e5601d9e7..8e45343d6472 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -1,14 +1,60 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 
+#include <linux/bitfield.h>
 #include <linux/firmware.h>
 #include <linux/i2c.h>
-#include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
-#include <linux/bitfield.h>
+
+#include <linux/iio/iio.h>
 
 #include "bmi270.h"
 
+#define BMI270_CHIP_ID_REG                             0x00
+#define BMI270_CHIP_ID_VAL                             0x24
+#define BMI270_CHIP_ID_MSK                             GENMASK(7, 0)
+
+#define BMI270_ACCEL_X_REG                             0x0c
+#define BMI270_ANG_VEL_X_REG                           0x12
+
+#define BMI270_INTERNAL_STATUS_REG                     0x21
+#define BMI270_INTERNAL_STATUS_MSG_MSK                 GENMASK(3, 0)
+#define BMI270_INTERNAL_STATUS_MSG_INIT_OK             0x01
+
+#define BMI270_INTERNAL_STATUS_AXES_REMAP_ERR_MSK      BIT(5)
+#define BMI270_INTERNAL_STATUS_ODR_50HZ_ERR_MSK                BIT(6)
+
+#define BMI270_ACC_CONF_REG                            0x40
+#define BMI270_ACC_CONF_ODR_MSK                                GENMASK(3, 0)
+#define BMI270_ACC_CONF_ODR_100HZ                      0x08
+#define BMI270_ACC_CONF_BWP_MSK                                GENMASK(6, 4)
+#define BMI270_ACC_CONF_BWP_NORMAL_MODE                        0x02
+#define BMI270_ACC_CONF_FILTER_PERF_MSK                        BIT(7)
+
+#define BMI270_GYR_CONF_REG                            0x42
+#define BMI270_GYR_CONF_ODR_MSK                                GENMASK(3, 0)
+#define BMI270_GYR_CONF_ODR_200HZ                      0x09
+#define BMI270_GYR_CONF_BWP_MSK                                GENMASK(5, 4)
+#define BMI270_GYR_CONF_BWP_NORMAL_MODE                        0x02
+#define BMI270_GYR_CONF_NOISE_PERF_MSK                 BIT(6)
+#define BMI270_GYR_CONF_FILTER_PERF_MSK                        BIT(7)
+
+#define BMI270_INIT_CTRL_REG                           0x59
+#define BMI270_INIT_CTRL_LOAD_DONE_MSK                 BIT(0)
+
+#define BMI270_INIT_DATA_REG                           0x5e
+
+#define BMI270_PWR_CONF_REG                            0x7c
+#define BMI270_PWR_CONF_ADV_PWR_SAVE_MSK               BIT(0)
+#define BMI270_PWR_CONF_FIFO_WKUP_MSK                  BIT(1)
+#define BMI270_PWR_CONF_FUP_EN_MSK                     BIT(2)
+
+#define BMI270_PWR_CTRL_REG                            0x7d
+#define BMI270_PWR_CTRL_AUX_EN_MSK                     BIT(0)
+#define BMI270_PWR_CTRL_GYR_EN_MSK                     BIT(1)
+#define BMI270_PWR_CTRL_ACCEL_EN_MSK                   BIT(2)
+#define BMI270_PWR_CTRL_TEMP_EN_MSK                    BIT(3)
+
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"

 enum bmi270_scan {
@@ -35,10 +81,10 @@ static int bmi270_get_data(struct bmi270_data *bmi270_device,
 
        switch (chan_type) {
        case IIO_ACCEL:
-               reg = BMI270_ACCEL_X_REG + (axis - IIO_MOD_X) * sizeof(sample);
+               reg = BMI270_ACCEL_X_REG + (axis - IIO_MOD_X) * 2;
                break;
        case IIO_ANGL_VEL:
-               reg = BMI270_ANG_VEL_X_REG + (axis - IIO_MOD_X) * sizeof(sample);
+               reg = BMI270_ANG_VEL_X_REG + (axis - IIO_MOD_X) * 2;
                break;
        default:
                return -EINVAL;
@@ -82,7 +128,7 @@ static const struct iio_info bmi270_info = {
        .channel2 = IIO_MOD_##_axis,                            \
        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
        .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |  \
-       BIT(IIO_CHAN_INFO_FREQUENCY),                           \
+               BIT(IIO_CHAN_INFO_FREQUENCY),                   \
 }
 
 #define BMI270_ANG_VEL_CHANNEL(_axis) {                                \
@@ -91,7 +137,7 @@ static const struct iio_info bmi270_info = {
        .channel2 = IIO_MOD_##_axis,                            \
        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
        .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |  \
-       BIT(IIO_CHAN_INFO_FREQUENCY),                           \
+               BIT(IIO_CHAN_INFO_FREQUENCY),                   \
 }
 
 static const struct iio_chan_spec bmi270_channels[] = {
@@ -100,7 +146,7 @@ static const struct iio_chan_spec bmi270_channels[] = {
        BMI270_ACCEL_CHANNEL(Z),
        BMI270_ANG_VEL_CHANNEL(X),
        BMI270_ANG_VEL_CHANNEL(Y),
-       BMI270_ANG_VEL_CHANNEL(Z)
+       BMI270_ANG_VEL_CHANNEL(Z),
 };
 
 static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
@@ -115,7 +161,7 @@ static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
                return dev_err_probe(dev, ret, "Failed to read chip id");
 
        if (chip_id != BMI270_CHIP_ID_VAL)
-               return dev_err_probe(dev, -ENODEV, "Invalid chip id 0x%x", chip_id);
+               dev_info(dev, "Unknown chip id 0x%x", chip_id);
 
        return 0;
 }
@@ -128,18 +174,24 @@ static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
        struct device *dev = bmi270_device->dev;
        struct regmap *regmap = bmi270_device->regmap;
 
-       ret = regmap_clear_bits(regmap, BMI270_PWR_CONF_REG, BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
+       ret = regmap_clear_bits(regmap, BMI270_PWR_CONF_REG,
+                               BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
        if (ret)
-               return dev_err_probe(dev, ret, "Failed to write power configuration");
+               return dev_err_probe(dev, ret,
+                                    "Failed to write power configuration");
 
-       /* After disabling advanced power save, all registers are accessible after a 450us delay
-        * This delay is specified in table A of the datasheet.
+       /*
+        * After disabling advanced power save, all registers are accessible
+        * after a 450us delay. This delay is specified in table A of the
+        * datasheet.
         */
        usleep_range(450, 1000);
 
-       ret = regmap_clear_bits(regmap, BMI270_INIT_CTRL_REG, BMI270_INIT_CTRL_LOAD_DONE_MSK);
+       ret = regmap_clear_bits(regmap, BMI270_INIT_CTRL_REG,
+                               BMI270_INIT_CTRL_LOAD_DONE_MSK);
        if (ret)
-               return dev_err_probe(dev, ret, "Failed to prepare device to load init data");
+               return dev_err_probe(dev, ret,
+                                    "Failed to prepare device to load init data");
 
        ret = request_firmware(&init_data, BMI270_INIT_DATA_FILE, dev);
        if (ret)
@@ -151,11 +203,14 @@ static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
        if (ret)
                return dev_err_probe(dev, ret, "Failed to write init data");
 
-       ret = regmap_set_bits(regmap, BMI270_INIT_CTRL_REG, BMI270_INIT_CTRL_LOAD_DONE_MSK);
+       ret = regmap_set_bits(regmap, BMI270_INIT_CTRL_REG,
+                             BMI270_INIT_CTRL_LOAD_DONE_MSK);
        if (ret)
-               return dev_err_probe(dev, ret, "Failed to stop device initialization");
+               return dev_err_probe(dev, ret,
+                                    "Failed to stop device initialization");
 
-       /* Wait at least 140ms for the device to complete configuration.
+       /*
+        * Wait at least 140ms for the device to complete configuration.
         * This delay is specified in table C of the datasheet.
         */
        usleep_range(140000, 160000);
@@ -231,7 +286,7 @@ int bmi270_core_probe(struct device *dev, struct regmap *regmap)
        struct bmi270_data *bmi270_device;
        struct iio_dev *indio_dev;
 
-       indio_dev = devm_iio_device_alloc(dev, sizeof(struct bmi270_data *));
+       indio_dev = devm_iio_device_alloc(dev, sizeof(*bmi270_device));
        if (!indio_dev)
                return -ENOMEM;

> diff --git a/drivers/iio/imu/bmi270/Makefile b/drivers/iio/imu/bmi270/Makefile
> new file mode 100644
> index 000000000000..ab4acaaee6d2
> --- /dev/null
> +++ b/drivers/iio/imu/bmi270/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for Bosch BMI270 IMU
> +#
> +obj-$(CONFIG_BMI270) += bmi270_core.o
> +obj-$(CONFIG_BMI270_I2C) += bmi270_i2c.o
> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
> new file mode 100644
> index 000000000000..4af4098d8e82
> --- /dev/null
> +++ b/drivers/iio/imu/bmi270/bmi270.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef BMI270_H_
> +#define BMI270_H_
> +
> +#include <linux/iio/iio.h>
no obvious reason for this.  Headers should only include things
they need.

However you do need some forward definitions for
struct device;
and an include of regmap.h for the regmap_config.

> +
> +#define BMI270_CHIP_ID_REG				0x00
> +#define BMI270_CHIP_ID_VAL				0x24
> +#define BMI270_CHIP_ID_MSK				GENMASK(7, 0)
> +
> +#define BMI270_ACCEL_X_REG				0x0c
> +#define BMI270_ANG_VEL_X_REG				0x12
> +
> +#define BMI270_INTERNAL_STATUS_REG			0x21
> +#define BMI270_INTERNAL_STATUS_MSG_MSK			GENMASK(3, 0)
> +#define BMI270_INTERNAL_STATUS_MSG_INIT_OK		0x01
> +
> +#define BMI270_INTERNAL_STATUS_AXES_REMAP_ERR_MSK	BIT(5)
> +#define BMI270_INTERNAL_STATUS_ODR_50HZ_ERR_MSK		BIT(6)
> +
> +#define BMI270_ACC_CONF_REG				0x40
> +#define BMI270_ACC_CONF_ODR_MSK				GENMASK(3, 0)
> +#define BMI270_ACC_CONF_ODR_100HZ			0x08
> +#define BMI270_ACC_CONF_BWP_MSK				GENMASK(6, 4)
> +#define BMI270_ACC_CONF_BWP_NORMAL_MODE			0x02
> +#define BMI270_ACC_CONF_FILTER_PERF_MSK			BIT(7)
> +
> +#define BMI270_GYR_CONF_REG				0x42
> +#define BMI270_GYR_CONF_ODR_MSK				GENMASK(3, 0)
> +#define BMI270_GYR_CONF_ODR_200HZ			0x09
> +#define BMI270_GYR_CONF_BWP_MSK				GENMASK(5, 4)
> +#define BMI270_GYR_CONF_BWP_NORMAL_MODE			0x02
> +#define BMI270_GYR_CONF_NOISE_PERF_MSK			BIT(6)
> +#define BMI270_GYR_CONF_FILTER_PERF_MSK			BIT(7)
> +
> +#define BMI270_INIT_CTRL_REG				0x59
> +#define BMI270_INIT_CTRL_LOAD_DONE_MSK			BIT(0)
> +
> +#define BMI270_INIT_DATA_REG				0x5e
> +
> +#define BMI270_PWR_CONF_REG				0x7c
> +#define BMI270_PWR_CONF_ADV_PWR_SAVE_MSK		BIT(0)
> +#define BMI270_PWR_CONF_FIFO_WKUP_MSK			BIT(1)
> +#define BMI270_PWR_CONF_FUP_EN_MSK			BIT(2)
> +
> +#define BMI270_PWR_CTRL_REG				0x7d
> +#define BMI270_PWR_CTRL_AUX_EN_MSK			BIT(0)
> +#define BMI270_PWR_CTRL_GYR_EN_MSK			BIT(1)
> +#define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
> +#define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
Currently all these defines are just used in the core c file.
So I'd move them there for now. We can drag them back into the header
if the spi bus driver needs them.

> +
> +struct bmi270_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +};
> +
> +extern const struct regmap_config bmi270_regmap_config;
> +
> +int bmi270_core_probe(struct device *dev, struct regmap *regmap);
> +
> +#endif  /* BMI270_H_ */
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> new file mode 100644
> index 000000000000..319e5601d9e7
> --- /dev/null
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +#include <linux/firmware.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/bitfield.h>
> +
> +#include "bmi270.h"
> +
> +#define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
> +
> +enum bmi270_scan {
> +	BMI270_SCAN_ACCEL_X,
> +	BMI270_SCAN_ACCEL_Y,
> +	BMI270_SCAN_ACCEL_Z,
> +	BMI270_SCAN_GYRO_X,
> +	BMI270_SCAN_GYRO_Y,
> +	BMI270_SCAN_GYRO_Z,
> +};
> +
> +const struct regmap_config bmi270_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +EXPORT_SYMBOL_NS_GPL(bmi270_regmap_config, IIO_BMI270);
> +
> +static int bmi270_get_data(struct bmi270_data *bmi270_device,
> +			   int chan_type, int axis, int *val)
> +{
> +	__le16 sample;
> +	int reg;
> +	int ret;
> +
> +	switch (chan_type) {
> +	case IIO_ACCEL:
> +		reg = BMI270_ACCEL_X_REG + (axis - IIO_MOD_X) * sizeof(sample);
> +		break;
> +	case IIO_ANGL_VEL:
> +		reg = BMI270_ANG_VEL_X_REG + (axis - IIO_MOD_X) * sizeof(sample);

This only works because they are 1 byte registers which isn't obvious here
So I don't think sizeof(sample) is very useful vs 2.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_bulk_read(bmi270_device->regmap, reg, &sample, sizeof(sample));
> +	if (ret)
> +		return ret;
> +
> +	*val = sign_extend32(le16_to_cpu(sample), 15);
> +
> +	return 0;
> +}
> +

> +
> +#define BMI270_ACCEL_CHANNEL(_axis) {				\
> +	.type = IIO_ACCEL,					\
> +	.modified = 1,						\
> +	.channel2 = IIO_MOD_##_axis,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +	BIT(IIO_CHAN_INFO_FREQUENCY),				\

Probably good to indent this last item by one more tab to help
with reability.

> +}
> +
> +#define BMI270_ANG_VEL_CHANNEL(_axis) {				\
> +	.type = IIO_ANGL_VEL,					\
> +	.modified = 1,						\
> +	.channel2 = IIO_MOD_##_axis,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +	BIT(IIO_CHAN_INFO_FREQUENCY),				\
> +}
> +./v4_20240912_lanzano_alex_add_i2c_driver_for_bosch_bmi270_imu.mbx
> +static const struct iio_chan_spec bmi270_channels[] = {
> +	BMI270_ACCEL_CHANNEL(X),
> +	BMI270_ACCEL_CHANNEL(Y),
> +	BMI270_ACCEL_CHANNEL(Z),
> +	BMI270_ANG_VEL_CHANNEL(X),
> +	BMI270_ANG_VEL_CHANNEL(Y),
> +	BMI270_ANG_VEL_CHANNEL(Z)
Add a trailing comma as we may well have additional channels in future
that come after this.

> +};
> +
> +static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
> +{
> +	int chip_id;
> +	int ret;
> +	struct device *dev = bmi270_device->dev;
> +	struct regmap *regmap = bmi270_device->regmap;
> +
> +	ret = regmap_read(regmap, BMI270_CHIP_ID_REG, &chip_id);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read chip id");
> +
> +	if (chip_id != BMI270_CHIP_ID_VAL)
> +		return dev_err_probe(dev, -ENODEV, "Invalid chip id 0x%x", chip_id);
A failure to match on a ID register should not result in a failure to probe.
The reason for this is Device tree fallback compatibles.
Those allow for a future device that is compatible (it may have a superset of
features) with this part to use a dt-binding that includes the compatible
for this one despite having a different ID register value.

As such this should print an information message to say it's an unknown
device ID but return success.
	
> +
> +	return 0;
> +}
> +
> +static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
> +{
> +	int ret;
> +	int status = 0;
> +	const struct firmware *init_data;
> +	struct device *dev = bmi270_device->dev;
> +	struct regmap *regmap = bmi270_device->regmap;
> +
> +	ret = regmap_clear_bits(regmap, BMI270_PWR_CONF_REG, BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write power configuration");
> +
> +	/* After disabling advanced power save, all registers are accessible after a 450us delay
All IIO multiline comments are

	/* 
	 * After...


> +	 * This delay is specified in table A of the datasheet.
> +	 */
> +	usleep_range(450, 1000);
> +
> +	ret = regmap_clear_bits(regmap, BMI270_INIT_CTRL_REG, BMI270_INIT_CTRL_LOAD_DONE_MSK);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to prepare device to load init data");
> +
> +	ret = request_firmware(&init_data, BMI270_INIT_DATA_FILE, dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to load init data file");
> +
> +	ret = regmap_bulk_write(regmap, BMI270_INIT_DATA_REG,
> +				init_data->data, init_data->size);
> +	release_firmware(init_data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write init data");
> +
> +	ret = regmap_set_bits(regmap, BMI270_INIT_CTRL_REG, BMI270_INIT_CTRL_LOAD_DONE_MSK);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to stop device initialization");
> +
> +	/* Wait at least 140ms for the device to complete configuration.
> +	 * This delay is specified in table C of the datasheet.
> +	 */
> +	usleep_range(140000, 160000);
> +
> +	ret = regmap_read(regmap, BMI270_INTERNAL_STATUS_REG, &status);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read internal status");
> +
> +	if (status != BMI270_INTERNAL_STATUS_MSG_INIT_OK)
> +		return dev_err_probe(dev, -ENODEV, "Device failed to initialize");
> +
> +	return 0;
> +}


